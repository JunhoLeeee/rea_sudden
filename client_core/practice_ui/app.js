'use strict';
(() => {
const $ = id => document.getElementById(id);
const canvas = $('view'), effects = $('effects'), ctx = effects.getContext('2d');
const token = location.hash.slice(1);
const keys = new Set();
let snapshot, arena, cell, pending = [], lookX = 0, lookY = 0, mouseDown = false;
let fireQueued = false, jumpQueued = false;
let lastShot = 0, flashUntil = 0, eventUntil = 0, previousEvent = '', previousState = '';
let lastResponse = performance.now(), stopped = false;
const gl = canvas.getContext('webgl', {antialias: true, alpha: false});
if (!gl) {
  $('connection').textContent = 'WebGL을 사용할 수 없습니다. 브라우저의 그래픽 가속 설정을 확인하세요.';
  $('connection').hidden = false;
  return;
}
function shader(type, source) {
  const result = gl.createShader(type);
  gl.shaderSource(result, source); gl.compileShader(result);
  if (!gl.getShaderParameter(result, gl.COMPILE_STATUS)) throw Error(gl.getShaderInfoLog(result));
  return result;
}
const program = gl.createProgram();
gl.attachShader(program, shader(gl.VERTEX_SHADER, `
attribute vec3 aPosition; attribute vec3 aColor;
uniform vec3 uEye; uniform vec4 uAngles; uniform float uAspect;
varying vec3 vColor; varying float vDistance;
void main(){
 vec3 r=aPosition-uEye;
 float forward=r.x*uAngles.x+r.y*uAngles.y;
 float right=-r.x*uAngles.y+r.y*uAngles.x;
 float up=r.z*uAngles.z-forward*uAngles.w;
 float depth=forward*uAngles.z+r.z*uAngles.w;
 float f=1.428148;
 gl_Position=vec4(right*f/uAspect,up*f,1.001668*depth-0.1000834,depth);
 vColor=aColor; vDistance=length(r);
}`));
gl.attachShader(program, shader(gl.FRAGMENT_SHADER, `
precision mediump float; varying vec3 vColor; varying float vDistance;
void main(){float fog=clamp(vDistance/55.0,0.0,.78);
gl_FragColor=vec4(mix(vColor,vec3(.055,.085,.11),fog),1.0);}`));
gl.linkProgram(program);
if (!gl.getProgramParameter(program, gl.LINK_STATUS)) throw Error(gl.getProgramInfoLog(program));
gl.useProgram(program); gl.enable(gl.DEPTH_TEST);
const position = gl.getAttribLocation(program, 'aPosition');
const color = gl.getAttribLocation(program, 'aColor');
const eyeLocation = gl.getUniformLocation(program, 'uEye');
const anglesLocation = gl.getUniformLocation(program, 'uAngles');
const aspectLocation = gl.getUniformLocation(program, 'uAspect');
const staticBuffer = gl.createBuffer(), dynamicBuffer = gl.createBuffer();
let staticCount = 0;
function box(out, x, y, z, width, depth, height, rgb) {
  const p = [[x,y,z],[x+width,y,z],[x+width,y+depth,z],[x,y+depth,z],
    [x,y,z+height],[x+width,y,z+height],[x+width,y+depth,z+height],[x,y+depth,z+height]];
  const faces = [[0,1,5,4,.68],[1,2,6,5,.86],[2,3,7,6,.76],[3,0,4,7,.9],[4,5,6,7,1],[3,2,1,0,.5]];
  for (const [a,b,c,d,shade] of faces) {
    for (const index of [a,b,c,a,c,d]) out.push(...p[index], ...rgb.map(v=>v*shade));
  }
}
function buildArena() {
  const data=[];
  arena.forEach((row,y)=>[...row].forEach((tile,x)=>{
    const base=(x+y)%2 ? [.15,.19,.22] : [.17,.21,.24];
    box(data,x*cell,y*cell,-.12,cell,cell,.12,base);
    if(tile==='#') {
      box(data,x*cell,y*cell,0,cell,cell,3,[.29,.36,.4]);
      box(data,x*cell-.008,y*cell-.008,1.05,cell+.016,cell+.016,.09,[.53,.65,.3]);
    }
  }));
  gl.bindBuffer(gl.ARRAY_BUFFER,staticBuffer);
  gl.bufferData(gl.ARRAY_BUFFER,new Float32Array(data),gl.STATIC_DRAW);
  staticCount=data.length/6;
}
function drawBuffer(buffer,count) {
  gl.bindBuffer(gl.ARRAY_BUFFER,buffer);
  gl.enableVertexAttribArray(position); gl.enableVertexAttribArray(color);
  gl.vertexAttribPointer(position,3,gl.FLOAT,false,24,0);
  gl.vertexAttribPointer(color,3,gl.FLOAT,false,24,12);
  gl.drawArrays(gl.TRIANGLES,0,count);
}
function resize() {
  const ratio=Math.min(devicePixelRatio||1,1.5);
  const width=Math.round(innerWidth*ratio),height=Math.round(innerHeight*ratio);
  if(canvas.width!==width||canvas.height!==height){
    canvas.width=effects.width=width; canvas.height=effects.height=height;
    gl.viewport(0,0,width,height);
  }
  ctx.setTransform(ratio,0,0,ratio,0,0);
}
function render(now) {
  resize();
  gl.clearColor(.055,.085,.11,1); gl.clear(gl.COLOR_BUFFER_BIT|gl.DEPTH_BUFFER_BIT);
  ctx.clearRect(0,0,innerWidth,innerHeight);
  if(snapshot && arena){
    const p=snapshot.player, yaw=p.yaw, pitch=p.pitch;
    gl.uniform3f(eyeLocation,p.x,p.y,p.eye);
    gl.uniform4f(anglesLocation,Math.cos(yaw),Math.sin(yaw),Math.cos(pitch),Math.sin(pitch));
    gl.uniform1f(aspectLocation,canvas.width/canvas.height);
    drawBuffer(staticBuffer,staticCount);
    const data=[];
    for(const t of snapshot.targets){
      if(t.health<=0)continue;
      const brightness=.65+.35*t.health/100;
      box(data,t.x-.32,t.y-.32,0,.64,.64,1.4,[.85*brightness,.31*brightness,.13]);
      box(data,t.x-.32,t.y-.32,1.4,.64,.64,.45,[.96,.67,.3]);
      box(data,t.x-.325,t.y-.325,1.0,.65,.65,.09,[.17,.19,.2]);
    }
    gl.bindBuffer(gl.ARRAY_BUFFER,dynamicBuffer);
    gl.bufferData(gl.ARRAY_BUFFER,new Float32Array(data),gl.DYNAMIC_DRAW);
    drawBuffer(dynamicBuffer,data.length/6);
    if(snapshot.state==='playing') drawEffects(now);
  }
  requestAnimationFrame(render);
}
function drawEffects(now){
  const cx=innerWidth/2,cy=innerHeight/2;
  // Reticle coordinates match the perspective camera's centre ray.
  ctx.strokeStyle='#e7f4db'; ctx.lineWidth=1;
  ctx.beginPath(); for(const [x,y,dx,dy] of [[-9,0,-4,0],[9,0,4,0],[0,-9,0,-4],[0,9,0,4]]){
    ctx.moveTo(cx+x,cy+y);ctx.lineTo(cx+x+dx,cy+y+dy);
  }ctx.stroke();
  const marker=snapshot.marker;
  if(marker&&marker.visible){
    ctx.save();ctx.translate(cx,cy);ctx.rotate(marker.rotation_requested_degrees*Math.PI/180);
    ctx.globalAlpha=marker.alpha/255;ctx.fillStyle='#'+marker.rgb.toString(16).padStart(6,'0');
    for(const [x,y,w,h] of marker.rectangles_before_rotation)ctx.fillRect(x,y,w,h);
    ctx.restore();
  }
  // A simple authored weapon silhouette keeps camera and ammo feedback readable.
  const kick=now<flashUntil?10:0;
  const gx=cx+innerWidth*.14, gy=innerHeight;
  ctx.fillStyle='#171f25';ctx.beginPath();ctx.moveTo(gx-55,gy);ctx.lineTo(gx-35,gy-125+kick);
  ctx.lineTo(gx+5,gy-180+kick);ctx.lineTo(gx+38,gy-180+kick);ctx.lineTo(gx+58,gy);ctx.fill();
  ctx.fillStyle='#33424a';ctx.fillRect(gx+3,gy-180+kick,33,112);
  ctx.fillStyle='#8c9c72';ctx.fillRect(gx+10,gy-183+kick,18,5);
  if(now<flashUntil){
    ctx.fillStyle='#ffd77b';ctx.beginPath();ctx.moveTo(gx+20,gy-230);ctx.lineTo(gx+7,gy-190);
    ctx.lineTo(gx-14,gy-214);ctx.lineTo(gx+10,gy-180);ctx.lineTo(gx+42,gy-190);ctx.fill();
  }
  // Minimap shows authored geometry and currently live practice targets.
  const scale=4,ox=25,oy=205;
  ctx.fillStyle='#0c141ac9';ctx.fillRect(ox-8,oy-8,arena[0].length*cell*scale+16,arena.length*cell*scale+16);
  arena.forEach((row,y)=>[...row].forEach((tile,x)=>{
    if(tile==='#'){ctx.fillStyle='#596a73';ctx.fillRect(ox+x*cell*scale,oy+y*cell*scale,cell*scale-1,cell*scale-1);}
  }));
  for(const t of snapshot.targets)if(t.health>0){ctx.fillStyle='#e7924b';ctx.fillRect(ox+t.x*scale-2,oy+t.y*scale-2,4,4);}
  const p=snapshot.player;
  ctx.save();ctx.translate(ox+p.x*scale,oy+p.y*scale);ctx.rotate(p.yaw);
  ctx.fillStyle='#d2fa79';ctx.beginPath();ctx.moveTo(6,0);ctx.lineTo(-3,-3);ctx.lineTo(-3,3);ctx.fill();ctx.restore();
  if(now>eventUntil)$('event').textContent='';
}
function update(next){
  snapshot=next;lastResponse=performance.now();
  if(next.shot_id!==lastShot){flashUntil=performance.now()+65;lastShot=next.shot_id;}
  if(next.last_event!==previousEvent||performance.now()<flashUntil){
    previousEvent=next.last_event;
    if(!['READY','MISS','RELOADING'].includes(next.last_event)){
      $('event').textContent=next.last_event;eventUntil=performance.now()+650;
    }
  }
  $('kills').innerHTML=String(next.kills).padStart(2,'0')+' <small>/ 10</small>';
  const seconds=Math.ceil(next.remaining);
  $('time').textContent=String(Math.floor(seconds/60)).padStart(2,'0')+':'+String(seconds%60).padStart(2,'0');
  $('accuracy').textContent=next.shots?next.accuracy+'%':'—';
  $('ammo').innerHTML=next.ammo+' <small>/ '+next.reserve+'</small>';
  $('weapon-name').textContent=next.weapon_name;
  $('reload').style.display=next.reload_left?'block':'none';
  $('reload').querySelector('i').style.transform='scaleX('+(1-next.reload_left/next.reload_duration)+')';
  if(next.state!==previousState){
    previousState=next.state;
    $('overlay').hidden=next.state==='playing';
    $('pause').hidden=next.state!=='playing';
    if(next.state!=='playing'){
      clearInput();if(document.pointerLockElement)document.exitPointerLock();
      const paused=next.state==='paused', finished=next.state==='finished';
      $('title').innerHTML=paused?'TAKE A<br><em>BREATH.</em>':finished?'DRILL<br><em>COMPLETE.</em>':'LOCAL<br><em>TRAINING.</em>';
      $('description').innerHTML=paused?'연습이 일시정지되었습니다.<br>준비되면 이어서 플레이하세요.':finished?(next.kills>=next.goal?'목표 달성. 다음 기록에 도전하세요.':'시간 종료. 다시 조준을 가다듬어 보세요.'):'90초, 표적 10개.<br>조준하고, 움직이고, 다음 사격을 준비하세요.';
      $('start').innerHTML=(paused?'계속하기':finished?'다시 도전':'연습 시작')+' <span>↗</span>';
      $('menu').hidden=next.state==='menu';
      $('result').textContent=finished?`${next.kills} 처치 · ${next.hits}/${next.shots} 명중 · 정확도 ${next.accuracy}%`:'';
    }
  }
}
function clearInput(){keys.clear();mouseDown=fireQueued=jumpQueued=false;lookX=lookY=0;}
function queue(action){pending.push({action});}
async function request(path,body){
  const response=await fetch(path,{method:body?'POST':'GET',headers:{'X-Practice-Token':token,'Content-Type':'application/json'},
    body:body?JSON.stringify(body):undefined,signal:AbortSignal.timeout(4000)});
  if(!response.ok)throw Error('HTTP '+response.status);
  return response.json();
}
async function poll(){
  if(stopped)return;
  try{
    const message=pending.shift()||{};
    message.controls={forward:keys.has('KeyW'),back:keys.has('KeyS'),left:keys.has('KeyA'),right:keys.has('KeyD'),
      walk:keys.has('ShiftLeft')||keys.has('ShiftRight'),crouch:keys.has('ControlLeft')||keys.has('ControlRight'),
      jump:keys.has('Space')||jumpQueued,fire:mouseDown||fireQueued,turn_left:keys.has('ArrowLeft'),turn_right:keys.has('ArrowRight'),
      look_x:lookX,look_y:lookY};lookX=lookY=0;fireQueued=jumpQueued=false;
    update(await request('/api/input',message));
    $('connection').hidden=true;
  }catch(error){
    clearInput();stopped=true;
    if(document.pointerLockElement)document.exitPointerLock();
    $('connection').hidden=false;
  }
  if(!stopped)setTimeout(poll,24);
}
$('start').addEventListener('click',()=>{
  clearInput();queue(snapshot.state==='paused'?'resume':'start');
  $('start').blur();canvas.focus({preventScroll:true});
  try{const result=canvas.requestPointerLock();if(result&&result.catch)result.catch(()=>{});}catch(_){}
});
$('menu').addEventListener('click',()=>queue('menu'));
$('pause').addEventListener('click',()=>queue('pause'));
$('style').addEventListener('change',()=>pending.push({style:Number($('style').value)}));
canvas.addEventListener('mousedown',event=>{
  if(event.button!==0||snapshot?.state!=='playing')return;
  if(document.pointerLockElement!==canvas){
    try{const result=canvas.requestPointerLock();if(result&&result.catch)result.catch(()=>{});}catch(_){}
  }
  mouseDown=true;fireQueued=true;
});
window.addEventListener('mouseup',()=>{mouseDown=false;});
document.addEventListener('mousemove',event=>{
  if(document.pointerLockElement===canvas&&snapshot?.state==='playing'){
    lookX+=event.movementX*.002;lookY-=event.movementY*.002;
  }
});
document.addEventListener('pointerlockchange',()=>{
  if(!document.pointerLockElement&&snapshot?.state==='playing'){clearInput();queue('pause');}
});
window.addEventListener('keydown',event=>{
  if(event.target.matches('select,button,input'))return;
  if(['Space','ArrowLeft','ArrowRight','ControlLeft','ControlRight'].includes(event.code))event.preventDefault();
  keys.add(event.code);
  if(event.repeat)return;
  if(event.code==='Space')jumpQueued=true;
  if(event.code==='Escape'&&snapshot?.state==='playing')queue('pause');
  if(event.code==='KeyR')queue('reload');
  if(event.code==='Digit1')queue('rifle');if(event.code==='Digit2')queue('pistol');
});
window.addEventListener('keyup',event=>keys.delete(event.code));
window.addEventListener('blur',()=>{clearInput();if(snapshot?.state==='playing')queue('pause');});
document.addEventListener('visibilitychange',()=>{if(document.hidden){clearInput();if(snapshot?.state==='playing')queue('pause');}});
canvas.addEventListener('contextmenu',event=>event.preventDefault());
request('/api/bootstrap').then(data=>{
  arena=data.arena;cell=data.cell;buildArena();
  for(const value of data.styles){const option=document.createElement('option');option.value=value;option.textContent=String(value);$('style').append(option);}
  $('style').value=data.snapshot.style;update(data.snapshot);poll();requestAnimationFrame(render);
}).catch(()=>{$('connection').hidden=false;});
// Read-only diagnostics for local browser smoke checks.
window.practiceDiagnostics=()=>({state:snapshot?.state,kills:snapshot?.kills,shots:snapshot?.shots,
  ammo:snapshot?.ammo,player:snapshot?.player,connected:!stopped,lastResponse,webgl:!gl.isContextLost()});
})();
