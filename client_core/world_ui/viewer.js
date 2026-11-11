'use strict';
(() => {
const $ = id => document.getElementById(id), canvas = $('view');
const gl = canvas.getContext('webgl2', {alpha:false, antialias:true}) || canvas.getContext('webgl', {alpha:false, antialias:true});
const fail = message => {$('error').hidden=false;$('error').textContent=message;};
if(!gl){fail('WebGL을 사용할 수 없습니다. 브라우저의 그래픽 가속 설정을 확인하세요.');return;}
const modern = typeof WebGL2RenderingContext !== 'undefined' && gl instanceof WebGL2RenderingContext;
const prefix=modern?'#version 300 es\n':'';
function shader(type,source){const s=gl.createShader(type);gl.shaderSource(s,prefix+source);gl.compileShader(s);if(!gl.getShaderParameter(s,gl.COMPILE_STATUS))throw Error(gl.getShaderInfoLog(s));return s;}
let program;
try{
 program=gl.createProgram();
 gl.attachShader(program,shader(gl.VERTEX_SHADER,`
${modern?'in':'attribute'} vec3 aPosition;
${modern?'in':'attribute'} vec2 aUV;
${modern?'in':'attribute'} vec4 aColor;
${modern?'in':'attribute'} vec3 aNormal;
${modern?'in':'attribute'} vec2 aLightmapUV;
uniform vec3 uEye,uForward,uRight,uUp;uniform float uAspect;
${modern?'out':'varying'} vec2 vUV;${modern?'out':'varying'} vec4 vColor;
${modern?'out':'varying'} vec3 vNormal;${modern?'out':'varying'} float vY;
${modern?'out':'varying'} vec2 vLightmapUV;
void main(){vec3 r=aPosition-uEye;float d=dot(r,uForward);float f=1.569686;
 gl_Position=vec4(dot(r,uRight)*f/uAspect,dot(r,uUp)*f,1.0002*d-10.001,d);
 vUV=aUV;vColor=aColor;vNormal=aNormal;vY=aPosition.y;vLightmapUV=aLightmapUV;gl_PointSize=7.0;}`));
 gl.attachShader(program,shader(gl.FRAGMENT_SHADER,`
precision mediump float;
${modern?'in':'varying'} vec2 vUV;${modern?'in':'varying'} vec4 vColor;
${modern?'in':'varying'} vec3 vNormal;${modern?'in':'varying'} float vY;
${modern?'in':'varying'} vec2 vLightmapUV;
uniform sampler2D uTexture;uniform int uMode;uniform bool uFlip,uClip;uniform float uHeight;
uniform sampler2D uLightmap;uniform bool uHasLightmap;
${modern?'out vec4 finalColor;':''}
void main(){if(uClip&&vY>uHeight)discard;vec2 uv=vec2(vUV.x,uFlip?1.0-vUV.y:vUV.y);
 vec4 color=${modern?'texture':'texture2D'}(uTexture,uv);
 if(uMode==1)color*=vColor;
 if(uMode==2)color=vec4(normalize(vNormal)*.5+.5,1.0);
 if(uMode==3)color=vec4(.68,.8,.85,1.0);
 if(uMode==4)color=vec4(.95,.56,.2,1.0);
 if(uMode==5||uMode==6||uMode==7){vec3 light=uHasLightmap?${modern?'texture':'texture2D'}(uLightmap,vLightmapUV).rgb:vColor.rgb;
  // The installed lightmap texture pass selects DESTCOLOR/SRCCOLOR when
  // Saturate is nonzero: source*destination + destination*source.
  // Gouraud_Texture stage 0 also selects MODULATE/MODULATE2X from Saturate.
  float gain=uMode==7?2.0:1.0;
  if(uMode==5)color=vec4(light,color.a);else{
   color.rgb=clamp(color.rgb*light*gain,0.0,1.0);
   if(!uHasLightmap)color.a*=vColor.a;}}
 if(color.a<.001)discard;${modern?'finalColor':'gl_FragColor'}=color;}`));
 gl.linkProgram(program);if(!gl.getProgramParameter(program,gl.LINK_STATUS))throw Error(gl.getProgramInfoLog(program));
}catch(error){fail(error.message);return;}
gl.useProgram(program);gl.enable(gl.DEPTH_TEST);gl.disable(gl.CULL_FACE);
gl.enable(gl.BLEND);gl.blendFunc(gl.SRC_ALPHA,gl.ONE_MINUS_SRC_ALPHA);
const attrs=Object.fromEntries(['Position','UV','Color','Normal','LightmapUV'].map(name=>[name,gl.getAttribLocation(program,'a'+name)]));
const uniforms=Object.fromEntries(['Eye','Forward','Right','Up','Aspect','Texture','Mode','Flip','Clip','Height','Lightmap','HasLightmap'].map(name=>[name,gl.getUniformLocation(program,'u'+name)]));
const textureCache=new Map(),lightmapCache=new Map();let scene,worlds=[],groups=[],pointBuffer;
let target=[0,0,0],yaw=.8,elevation=.7,distance=3300,drag=null,ready=false;
let renderedTriangles=0,textureFailures=0,unsupportedWrapping=0;
let lightmapFormat='21',lightmapGeneration=0;
const normalize=v=>{const n=Math.hypot(...v)||1;return v.map(x=>x/n);};
function makeTexture(image,levels,clamp=false){
 const t=gl.createTexture();gl.bindTexture(gl.TEXTURE_2D,t);
 if(image)gl.texImage2D(gl.TEXTURE_2D,0,gl.RGBA,gl.RGBA,gl.UNSIGNED_BYTE,image);
 else gl.texImage2D(gl.TEXTURE_2D,0,gl.RGBA,1,1,0,gl.RGBA,gl.UNSIGNED_BYTE,new Uint8Array([180,185,190,255]));
 const pot=!image||((image.width&(image.width-1))===0&&(image.height&(image.height-1))===0);
 const repeat=!clamp&&(modern||pot);
 if(!clamp&&!repeat)unsupportedWrapping++;
 gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_WRAP_S,repeat?gl.REPEAT:gl.CLAMP_TO_EDGE);
 gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_WRAP_T,repeat?gl.REPEAT:gl.CLAMP_TO_EDGE);
 gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_MIN_FILTER,gl.LINEAR);
 gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_MAG_FILTER,gl.LINEAR);
 if(levels&&modern){
  levels.forEach((level,index)=>gl.texImage2D(gl.TEXTURE_2D,index,gl.RGBA,gl.RGBA,gl.UNSIGNED_BYTE,level));
  gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_BASE_LEVEL,0);
  gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_MAX_LEVEL,levels.length-1);
  gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_MIN_FILTER,gl.LINEAR_MIPMAP_LINEAR);
 }
 return t;
}
const fallback=makeTexture(null);
function loadImage(url){return new Promise((resolve,reject)=>{const image=new Image();image.onload=()=>resolve(image);image.onerror=()=>reject(Error('PNG '+url));image.src=url;});}
function makeUploadedLightmap(row,code,bytes){
 const pixelCount=row.width*row.height,view=new Uint8Array(bytes);
 const stride=code===20?3:code===21||code===22?4:2;
 if(view.length!==pixelCount*stride)throw Error('라이트맵 업로드 크기 불일치');
 const t=gl.createTexture();
 gl.bindTexture(gl.TEXTURE_2D,t);gl.pixelStorei(gl.UNPACK_ALIGNMENT,1);
 if(stride===2){
  const input=new DataView(bytes),packed=new Uint16Array(pixelCount);
  for(let i=0;i<pixelCount;i++){
   const word=input.getUint16(i*2,true);
   // D3D 1555 -> GL 5551 rearranges bit positions, retaining channel values.
   packed[i]=code===23?word:((word&0x7fff)<<1)|(word>>>15);
  }
  const format=code===23?gl.RGB:gl.RGBA;
  const internal=modern?(code===23?gl.RGB565:gl.RGB5_A1):format;
  gl.texImage2D(gl.TEXTURE_2D,0,internal,row.width,row.height,0,format,
   code===23?gl.UNSIGNED_SHORT_5_6_5:gl.UNSIGNED_SHORT_5_5_5_1,packed);
 }else{
  const rgba=new Uint8Array(pixelCount*4);
  for(let i=0;i<pixelCount;i++){
   rgba[i*4]=view[i*stride+2];rgba[i*4+1]=view[i*stride+1];rgba[i*4+2]=view[i*stride];
   rgba[i*4+3]=stride===4?view[i*stride+3]:255;
  }
  gl.texImage2D(gl.TEXTURE_2D,0,gl.RGBA,row.width,row.height,0,gl.RGBA,gl.UNSIGNED_BYTE,rgba);
 }
 gl.pixelStorei(gl.UNPACK_ALIGNMENT,4);
 gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_WRAP_S,gl.CLAMP_TO_EDGE);
 gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_WRAP_T,gl.CLAMP_TO_EDGE);
 gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_MIN_FILTER,gl.LINEAR);
 gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_MAG_FILTER,gl.LINEAR);
 const error=gl.getError();if(error!==gl.NO_ERROR){gl.deleteTexture(t);throw Error('Lightmap WebGL '+error);}
 return t;
}
async function changeLightmapFormat(){
 const generation=++lightmapGeneration,requested=$('lightmap-format').value,next=new Map();
 const results=await Promise.allSettled(scene.lightmap_uploads.map(async row=>{
  const response=await fetch(row.formats[requested]);if(!response.ok)throw Error('Lightmap HTTP '+response.status);
  next.set(row.url,makeUploadedLightmap(row,Number(requested),await response.arrayBuffer()));
 }));
 const rejected=results.find(result=>result.status==='rejected');
 if(generation!==lightmapGeneration||rejected){
  for(const texture of next.values())gl.deleteTexture(texture);
  if(generation===lightmapGeneration){$('lightmap-format').value=lightmapFormat;fail(rejected.reason.message);}
  return;
 }
 for(const texture of lightmapCache.values())gl.deleteTexture(texture);
 lightmapCache.clear();for(const [url,texture] of next)lightmapCache.set(url,texture);
 lightmapFormat=requested;document.body.dataset.lightmapFormat=requested;
}
async function loadTexture(row){
 try{const images=await Promise.all(row.levels.map(level=>loadImage(level.url)));
  textureCache.set(row.key,makeTexture(images[0],images));
 }catch(_){textureFailures++;}
}
function buffer(targetType,data){const b=gl.createBuffer();gl.bindBuffer(targetType,b);gl.bufferData(targetType,data,gl.STATIC_DRAW);return b;}
function buildGroup(world){
 const batches=[];
 for(const block of world.blocks){
  if(block.vertices.length>65535)throw Error('이 검증 뷰어의 uint16 인덱스 범위를 넘었습니다.');
  const links=scene.lightmap_links.find(row=>row.world===world.name&&row.block===block.index);
  const pairs=new Map((links?.exact_triangle_pairs||[]).map(row=>[row.diffuse_triangle,row]));
  for(const section of block.sections){
   // Code 2 is a separate lightmap pass; drawing it here would duplicate geometry.
   if(section.shader_code===2)continue;
   if(![1,4].includes(section.shader_code))throw Error('미해석 셰이더 코드 '+section.shader_code);
   const parts=new Map();
   for(let triangle=section.triangle_start;triangle<section.triangle_start+section.triangle_count;triangle++){
    const tri=block.triangles[triangle],pair=pairs.get(triangle),lmSection=pair?.lightmap_section??-1;
    if(section.shader_code===4&&!pair)throw Error('검증된 lightmap 대응이 없습니다.');
    if(!parts.has(lmSection))parts.set(lmSection,{data:[],indices:[],lines:[]});
    const part=parts.get(lmSection),base=part.data.length/14;
    for(let corner=0;corner<3;corner++){
     const v=block.vertices[tri[corner]],argb=v[7]>>>0;
     const lm=pair?block.vertices[pair.lightmap_vertices_in_diffuse_order[corner]]:null;
     part.data.push(v[0],v[1],v[2],v[3],v[4],((argb>>>16)&255)/255,((argb>>>8)&255)/255,(argb&255)/255,((argb>>>24)&255)/255,v[8],v[9],v[10],lm?lm[3]:0,lm?lm[4]:0);
    }
    part.indices.push(base,base+1,base+2);part.lines.push(base,base+1,base+1,base+2,base+2,base);
   }
   for(const [lmSection,part] of parts){
    if(part.data.length/14>65535)throw Error('Derived paired batch exceeds uint16 index range');
    batches.push({vertex:buffer(gl.ARRAY_BUFFER,new Float32Array(part.data)),
     indices:buffer(gl.ELEMENT_ARRAY_BUFFER,new Uint16Array(part.indices)),
     lines:buffer(gl.ELEMENT_ARRAY_BUFFER,new Uint16Array(part.lines)),count:part.indices.length,lineCount:part.lines.length,
     texture:section.textures[0].replace(/\\/g,'/').toLowerCase(),shader:section.shader_code,
     lightmap:lmSection>=0?block.sections[lmSection].lightmap.url:null,
     sourceBlock:block.index,sourceSection:section.index});
   }
  }
 }
 return batches;
}
function bindVertex(b){
 gl.bindBuffer(gl.ARRAY_BUFFER,b);
 for(const [name,size,offset] of [['Position',3,0],['UV',2,12],['Color',4,20],['Normal',3,36],['LightmapUV',2,48]]){
  gl.enableVertexAttribArray(attrs[name]);gl.vertexAttribPointer(attrs[name],size,gl.FLOAT,false,56,offset);
 }
}
function bounds(world){
 const low=[Infinity,Infinity,Infinity],high=[-Infinity,-Infinity,-Infinity];
 for(const b of world.blocks)for(const v of b.vertices)for(let i=0;i<3;i++){low[i]=Math.min(low[i],v[i]);high[i]=Math.max(high[i],v[i]);}
 return {low,high};
}
function reset(){
 const b=bounds(worlds[Number($('model').value)||0]);target=b.low.map((v,i)=>(v+b.high[i])/2);
 const span=Math.max(...b.low.map((v,i)=>b.high[i]-v));distance=Math.max(100,span*.85);yaw=.8;elevation=.7;
 $('height').min=Math.floor(b.low[1]);$('height').max=Math.ceil(b.high[1]);$('height').value=Math.min(b.high[1],target[1]+120);
 $('start').value='';
}
function updateStats(){
 const model=Number($('model').value)||0,w=worlds[model];
 const vertices=w.blocks.reduce((n,b)=>n+b.vertices.length,0);
 const triangles=groups[model].reduce((n,b)=>n+b.count/3,0);
 $('stats').textContent=`${w.name}\n${w.blocks.length} blocks · ${vertices.toLocaleString()} vertices\n${triangles.toLocaleString()} diffuse triangles\n${scene.textures.length} original textures · ${scene.starts.length} starts`;
 $('status').textContent=ready?`원본 리소스 로드 완료 · ${scene.textures.reduce((n,t)=>n+t.levels.length,0)} native mips · 누락 ${scene.missing_diffuse_textures.length} · 실패 ${textureFailures}`:'텍스처 로드 중…';
 $('source').textContent='DAT SHA-256\n'+scene.source_sha256;
}
function render(){
 const ratio=Math.min(devicePixelRatio||1,1.5),width=Math.round(innerWidth*ratio),height=Math.round(innerHeight*ratio);
 if(canvas.width!==width||canvas.height!==height){canvas.width=width;canvas.height=height;gl.viewport(0,0,width,height);}
 gl.clearColor(.075,.095,.12,1);gl.clear(gl.COLOR_BUFFER_BIT|gl.DEPTH_BUFFER_BIT);
 if(scene){
  const eye=[target[0]+distance*Math.cos(elevation)*Math.cos(yaw),target[1]+distance*Math.sin(elevation),target[2]+distance*Math.cos(elevation)*Math.sin(yaw)];
  const forward=normalize(target.map((v,i)=>v-eye[i]));const right=normalize([-forward[2],0,forward[0]]);
  const up=[right[1]*forward[2]-right[2]*forward[1],right[2]*forward[0]-right[0]*forward[2],right[0]*forward[1]-right[1]*forward[0]];
  gl.uniform3fv(uniforms.Eye,eye);gl.uniform3fv(uniforms.Forward,forward);gl.uniform3fv(uniforms.Right,right);gl.uniform3fv(uniforms.Up,up);
  gl.uniform1f(uniforms.Aspect,width/height);gl.uniform1i(uniforms.Flip,$('flip').checked);gl.uniform1i(uniforms.Clip,$('clip').checked);
  gl.uniform1f(uniforms.Height,Number($('height').value));gl.uniform1i(uniforms.Texture,0);
  gl.uniform1i(uniforms.Lightmap,1);
  const mode=$('shading').value,wire=mode==='wire';
  gl.uniform1i(uniforms.Mode,mode==='vertex'?1:mode==='normal'?2:wire?3:mode==='lightmap'?5:mode==='comparison'?6:mode==='saturate'?7:0);renderedTriangles=0;
  for(const b of groups[Number($('model').value)||0]){
   bindVertex(b.vertex);gl.activeTexture(gl.TEXTURE0);gl.bindTexture(gl.TEXTURE_2D,textureCache.get(b.texture)||fallback);
   gl.activeTexture(gl.TEXTURE1);gl.bindTexture(gl.TEXTURE_2D,lightmapCache.get(b.lightmap)||fallback);
   gl.uniform1i(uniforms.HasLightmap,Boolean(b.lightmap));
   gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER,wire?b.lines:b.indices);gl.drawElements(wire?gl.LINES:gl.TRIANGLES,wire?b.lineCount:b.count,gl.UNSIGNED_SHORT,0);
   renderedTriangles+=b.count/3;
  }
  if($('spawns').checked&&Number($('model').value)===0){
   bindVertex(pointBuffer);gl.uniform1i(uniforms.Mode,4);gl.disable(gl.DEPTH_TEST);gl.drawArrays(gl.POINTS,0,scene.starts.length);gl.enable(gl.DEPTH_TEST);
  }
 }
 requestAnimationFrame(render);
}
canvas.addEventListener('pointerdown',event=>{canvas.focus();canvas.setPointerCapture(event.pointerId);drag={x:event.clientX,y:event.clientY};});
canvas.addEventListener('pointerup',()=>{drag=null;});canvas.addEventListener('pointercancel',()=>{drag=null;});
canvas.addEventListener('pointermove',event=>{
 if(!drag)return;const dx=event.clientX-drag.x,dy=event.clientY-drag.y;drag={x:event.clientX,y:event.clientY};
 if(event.shiftKey){const scale=distance*.001;target[0]+=(-Math.sin(yaw)*dx+Math.cos(yaw)*dy)*scale;target[2]+=(Math.cos(yaw)*dx+Math.sin(yaw)*dy)*scale;}
 else{yaw-=dx*.006;elevation=Math.max(-1.45,Math.min(1.45,elevation+dy*.006));}
});
canvas.addEventListener('wheel',event=>{event.preventDefault();distance=Math.max(30,Math.min(30000,distance*Math.exp(event.deltaY*.001)));},{passive:false});
$('reset').addEventListener('click',reset);
$('lightmap-format').addEventListener('change',()=>changeLightmapFormat().catch(error=>fail(error.message)));
$('model').addEventListener('change',()=>{reset();updateStats();});
$('start').addEventListener('change',()=>{
 if($('start').value==='')return;const start=scene.starts[Number($('start').value)];
 $('model').value='0';target=start.position.slice();distance=1100;elevation=.55;updateStats();
});
fetch('/api/scene').then(response=>{if(!response.ok)throw Error('Scene HTTP '+response.status);return response.json();}).then(async data=>{
 scene=data;worlds=[scene.render.world,...scene.render.world.models];
 worlds.forEach((w,i)=>{const option=document.createElement('option');option.value=i;option.textContent=w.name;$('model').append(option);});
 scene.starts.forEach((s,i)=>{const option=document.createElement('option');option.value=i;option.textContent=`${s.team} · ${s.name}`;$('start').append(option);});
 groups=worlds.map(buildGroup);
 const points=[];for(const s of scene.starts)points.push(...s.position,0,0,1,1,1,1,0,1,0,0,0);
 pointBuffer=buffer(gl.ARRAY_BUFFER,new Float32Array(points));reset();updateStats();requestAnimationFrame(render);
 const lightmaps=worlds.flatMap(w=>w.blocks.flatMap(b=>b.sections.map(s=>s.lightmap.url).filter(Boolean)));
 await Promise.all([...scene.textures.map(loadTexture),...lightmaps.map(async url=>{
  try{lightmapCache.set(url,makeTexture(await loadImage(url),null,true));}catch(_){textureFailures++;}
 })]);ready=true;updateStats();document.body.dataset.ready='true';
 $('lightmap-format').disabled=false;document.body.dataset.lightmapFormat=lightmapFormat;
 if(textureFailures||scene.missing_diffuse_textures.length)fail(`원본 텍스처 연결 문제: 누락 ${scene.missing_diffuse_textures.length}, 로드 실패 ${textureFailures}`);
}).catch(error=>fail(error.message));
window.worldViewerDiagnostics=()=>({ready,worlds:worlds.length,renderedTriangles,texturesLoaded:textureCache.size,
 nativeMipLevels:scene?.textures.reduce((n,t)=>n+t.levels.length,0),nativeMipSampling:modern,
 lightmapsLoaded:lightmapCache.size,lightmapFormat,
 textureFailures,unsupportedWrapping,source:scene?.source_sha256,webgl:modern?2:1});
})();
