# 설치본 정점 로딩과 셰이더 후보 선택

2026-11-12. 원본 EXE SHA-256:
`7e37a8098930836fc4ebcfd6e3cded7a616b789f162af68be6e34287c568b0d8`.
원본 EXE/DLL은 실행하지 않았다. 이 문서의 새 JSON은 직접 파일 바이트/Capstone 관찰이며,
REA 인증 Evidence ID를 임의로 부여하지 않았다.

## DAT 44바이트와 런타임 68바이트의 연결

`evidence/engine-render-vertex-loader-v1.json`에 다음 경로를 보존했다.

| 주소 | 확인한 동작 |
|---|---|
| `0x14017c490` / `0x14017cac0` | 스트림의 DWORD를 읽고 unsigned >=85이면 `0x1403e78d0`에 버전을 저장 |
| `0x1401edf90`의 `0x1401ee5e9..0x1401ee65b` | 정점 개수 읽기, count*0x44(68) 할당, 같은 stride로 `0x1401ea230` 반복 호출 |
| `0x1401ea230` | position 12, UV0/UV1 4*4, color 4, normal 12 = 총44바이트 읽기 |
| `0x1401ea2be` 이후 | 전역 버전이86 이상이면 +44와 +56에 각각12바이트 추가 읽기 |
| `0x140215350` | Gouraud output16: position + color DWORD 복사 |
| `0x140215760` | Gouraud_Texture output36: position + normal + color DWORD + UV0 복사 |

즉 0x44는 런타임 stride의 **16진수68**이고, DAT85 정점 크기44는 **10진수44**다.
원본 warehouse 헤더 DWORD는85다. 이 버전에서는 뒤24바이트를 읽지 않는다.
그 메모리의 값이나 이후 생성/수정은 확인되지 않았으므로 0 tangent/binormal로 채우지 않는다.

`client_core/render_vertex.py`의 `RenderVertex`는 prefix44와 extension24 또는 None으로
이 구분을 보존한다. 출력 변환은 float 계산 없이 바이트를 복사한다. NaN payload·음수0·색 alpha를
Python float 변환으로 바꾸지 않는다. 일반 DAT parser는 기존의 검증된85 profile만 허용한다.

`evidence/warehouse-vertex-copy-replay-v1.json`은 실제39개 block, 정점19,332개에 대해
source prefix 및 두 출력 stream의 해시를 기록한다. 이는 모든 정점에 두 복사를 적용한
CPU replay이며, 실제 shader binding이 각 정점에 두 번 실행된다는 뜻은 아니다.

## 저장 shader code와 요청 ID

loader는 `0x1401ee319`에서 저장 byte를 MOVZX하여 `0x1401ef260`에 넘기고,
반환값을 section+0x18에 쓴다. unsigned 입력0..9의40바이트 jump table을
`tools/render_shader_probe.py`가 명시적으로 풀어
`evidence/engine-render-shader-code-v1.json`에 보존한다.

| 저장 code | loader의 요청 ID |
|---|---:|
| 1 | 0 |
| 2 | 11 |
| 4 | 12 |
| 8 | 10 |
| 9 | 17 |
| 나머지 / unsigned >9 | 21 |

warehouse에는1/2/4만 있으며 각각164/27/135개 section이다.
`client_core/render_shader.translate_shader_code`와 뷰어 scene의
`native_requested_shader_ids`에 이 매핑을 제공한다.

## 요청 ID 이후 후보 선택

`0x1401b28c0`은 요청 ID를 받아 다시 분기하고, 객체 cache를 조회하거나 할당한 후
vtable+8의 ValidateShader 결과를 검사한다. 실패하면 별도 fallback table로 재시도한다.
**저장 code, 요청 ID, 선택 후보, 최종 검증된 shader를 구분해야 한다.**

`evidence/engine-warehouse-shader-candidate-v1.json`은 첫 selector22바이트/target6개,
할당 target20개, validation-failure target18개 및 선택한 분기의 직접 decode를 보존한다.
RTTI와 allocation vtable 쓰기로 다음 candidate ID를 연결했다.

| candidate | RTTI class |
|---|---|
| 0 | CRenderShader_Gouraud |
| 1 | CRenderShader_Gouraud_Texture |
| 11 | CRenderShader_Lightmap |
| 12 | CRenderShader_Lightmap_Texture |

`warehouse_shader_candidate`는 warehouse 요청0/11/12에 한해 **검증 전 후보**를 계산한다.
LightMap/DetailTextures/EnvMapEnable/EnvBumpMap cached 정수와 texture+0x38/+0x3c,
pixel data pointer 존재 및 pixel+0x24 bit0을 supplied 입력으로 받는다.
`0x1400b5820`은 texture+0x10 포인터를 반환한다. 이 필드들의 전체 producer와
DTX command/header로부터의 매핑은 아직 연결하지 않았으며 PNG만으로 추정하지 않는다.

- 요청11은 LightMap이 꺼졌으면 null, 켜졌으면11이다.
- 요청12는 LightMap이 꺼지면 Gouraud 후보 경로로 내려간다. 켜졌을 때 null texture면 null이다.
- 요청0의 일반 texture는 candidate1, null texture는0이다. special mode와 pixel bit에 따라 다른 후보를 고른다.
- lightmapped texture mode4는 EnvBumpMap on→15, bump off/env on→14, 둘 다 off→12다.
  bump off가 type2의 EnvMapEnable 검사로 돌아가는 jump를 독립 검토로 확인하고 교차검사에 반영했다.
- Gouraud texture mode4의 bump off는 EnvMapEnable을 재검사하지 않고 pixel test로 들어가3/9를 고른다.
- lightmapped 경로는 special mode가+0x3c보다 우선하고, Gouraud 경로는+0x3c가 mode/pixel보다 우선한다.

후보 모델은 할당·cache·ValidateShader·실패 fallback·실제 device support를 실행하지 않는다.
따라서 뷰어가 이 후보를 원본의 실제 runtime shader라고 자동 채택하지 않는다.

## 검증과 남은 작업

정점 검사는 원본19,332개 모두를 저장 mesh의 필드값과 두 native output layout으로 대조한다.
85/86 경계, 알 수 없는 tail, float bit pattern 보존도 검사한다. 셰이더 검사는 저장 byte 전체,
unsigned 경계, 후보 gate·특수 mode·feature 비zero·pixel pointer/bit·mode4 교차 분기를 포함한다.

남은 것은 texture 상태 producer, validation 실패 fallback의 완전한 의미,
실제 shader binding과 runtime vertex lighting/추가24바이트 처리다.
이 결과는 렌더 리소스 복원의 확인된 조각이며 전체 플레이 가능 클라이언트의 완성을 뜻하지 않는다.

## DTX 선언에서 renderer texture와 Fullbright 후보로

후속 producer 추적으로 위의 texture 상태 일부를 연결했다.
`evidence/engine-texture-material-producers-v1.json`에 아래7개 함수의 원본 바이트가 있다.
독립 검토에서7개 method/1,378개 명령의 바이트를 현재 EXE와 대조했다.

| 주소 | 확인한 효과 |
|---|---|
| `0x1400c10d0` | DTX header164바이트 읽기. resource type0/version-5 검사 후 TextureData+4에 header 복사 |
| `0x1400a8120` | 새 SharedTexture의+0x38/+0x3c를 포함한 QWORD를0으로 초기화 |
| `0x140129210` | TextureData+0x28의 command 문자열에서 DetailTex/EnvMap/EnvMapAlpha/EnvBumpMap/EnvBumpMapNoFallback을 검색하고 mode+0x38을1/2/3/4/5로 설정 |
| `0x1401e0440` | TextureData internal flags를 renderer texture의+0x24 flags로 변환, AlphaRef 명령 결과의 AX를+0x26에 저장 |
| `0x1400b5820` | SharedTexture+0x10 포인터 반환 |
| `0x14021a250` | Fullbright의 두 texture stage 연산 설정 |
| `0x140219a80` | 같은 texture를 stage0과1에 바인딩 |

중요한 구분: TextureData는 DTX header가+4에 복사된 CPU 자료이고,
SharedTexture+0x10에서 꺼내는 포인터는 renderer texture(비교 소스의 RTexture)다.
**shader가 검사하는+0x24 bit0을 raw DTX offset0x20의 bit로 읽으면 안 된다.**
`0x1401e04a8..0x1401e05bd`에서 raw DTX offset16의 internal flags를 읽어
다음과 같이 repack한다.

```text
renderer_flags = (internal_flags & 1) | ((internal_flags >> 9) & 0xe)
```

raw DTX command offset36은 TextureData+0x28이다. 알파 reference는 raw header의
기존 word를 그대로 사용하는 것이 아니라 CreateRTexture에서 AlphaRef 명령을 다시 검색한다.
호출 `0x1401e0665`의 간접 변환 함수 이름은 원본 import 자료만으로 해소하지 못했다.
저장된 공개 d3d_texture.cpp의 atoi/WORD 동작과 비교하여, 현재 자료에 실제 존재하는
양의 decimal 명령 형식만 코어에서 지원한다. 임의 command grammar 전체의 복원으로 간주하지 않는다.

`client_core/texture_material.py`는 빈 문자열 또는 현재 관찰한 AlphaRef 형식만 허용한다.
다른 명령을 일반 texture로 조용히 바꾸지 않고 거부한다. 새 SharedTexture의 mode/flag가
초기값을 유지하고 renderer texture 생성이 성공했다는 조건으로 `TextureShaderState`를 만든다.
실제 객체 수명 중 다른+0x3c 쓰기를 전부 추적한 것은 아니다.

`evidence/warehouse-material-candidate-replay-v1.json`에서 원본 DTX75개 해시를 확인했다.
14개가 internal bit0을 가지며, 명령은 빈 문자열71개, AlphaRef80 두 개,100 한 개,128 한 개다.
feature preset을 명시한 정적 replay에서 stored code1의164개 section은 candidate1(144개)과
Fullbright candidate7(20개)로 나뉜다. 이는 **후보**이며 ValidateShader 결과를 관찰하지 않았다.
`engine-warehouse-shader-candidate-v2.json`의 allocation vtable/RTTI는7을
`CRenderShader_Gouraud_Texture_Fullbright`와 연결한다.

### Fullbright의 두 단계 색상 비교

0x14021a250의 stage0은 기존 texture×vertex RGB(MODULATE/MODULATE2X)와
alpha texture×vertex를 계산한다. stage1은 TEXTURE/CURRENT를 사용해
COLOROP16(BLENDCURRENTALPHA), ALPHAOP3(SELECTARG2)를 설정한다.
따라서 ideal normalized 비교식은 다음과 같다.

```text
lit = clamp(texture.rgb * vertex.rgb * (Saturate != 0 ? 2 : 1), 0, 1)
a = texture.a * vertex.a
fullbright.rgb = texture.rgb * a + lit * (1-a)
fullbright.a = a
```

stage0 clamp를 먼저 적용하며 단순히 조명을 끄거나 texel alpha만 계수로 사용하지 않는다.
`gouraud_texel`에 이 단계 계산을 제공하고, 뷰어에는 선언된 Fullbright bit가 있는 면의
조명 합성 비교 checkbox로 연결했다. base lightmap 면에는 이 식을 적용하지 않는다.
현재 WebGL의 전역 framebuffer blend와 간단한 alpha discard는 원본의 opaque/AlphaRef
state를 완전히 복원하지 않았다. 최종 픽셀 일치나 actual shader7 선택을 주장하지 않는다.

뷰어 material 선언은 매번 원본 DTX SHA 검증 후 공급한다. 다른 checkout으로 옮기는 검사도
이75개 자료를 복사해 재실행한다. `warehouse-fullbright-browser-v1.json`, REA
`ev_a1361e41c21f9b3467791235b442274dd80b78c8838b8c512802f43e47286b75`에서
Fullbright off/on과 Saturate 전환이 완료됐다. 오류0, mip284, 누락/실패0이며 Chrome도 종료됐다.
스크린샷은 `previews/warehouse-fullbright-comparison.png`다.

검증은 client_core101개, world_render12개, input_command_probe3개로 **116개 통과**했다.
전체 DTX 선언→조건부 후보, native flags repack, current-alpha 혼합, stage0 clamp 순서,
알 수 없는 command 거부를 포함한다. AlphaRef 간접 parser와 실제 alpha test/framebuffer state,
실제 validation/fallback 선택은 남아 있다.

## 검증 실패 전이의 후속 해소

`engine-warehouse-shader-candidate-v3.json`은 failure table18개의 target을 독립 decode하고,
기본 Gouraud Validate `0x1402157d0`의 `MOV AL,1; RET`를 보존한다.
candidate18/19는 table 범위 밖 분기로0에 내려간다.

| 실패 candidate | 다음 candidate |
|---|---:|
| 1,11,18,19 | 0 |
| 2,3,4,6,7,10,12 | 1 |
| 5,9 | 3 |
| 8 | 2 |
| 13,14,16,17 | 12 |
| 15 | 14 |
| 0 | 0으로 재시도하는 target |

0의 정상 검증은 상수1이므로, 모든 객체 할당이 성공했다는 조건에서 실패 전이는
유한하게0으로 도달한다. 할당 실패 시0 경로가 다시 자신을 시도하는 부분은 별도이며,
무한 재시도나 메모리 실패를 독립 코어에서 원본처럼 실행하지 않는다.

`shader_validation_fallback`은 한 단계 전이, `resolve_shader_validation`은 할당 성공 조건의
검증 결과 재생을 제공한다. callback의 native uint8 결과가0이면 fallback, 비zero이면 성공이다.
상수 성공인0에는 device callback을 요청하지 않는다. 실제 device 호출·객체 cache·삭제는
수행하지 않는다. cache에 객체가 존재해도 원본은 material을 넘겨 Validate를 다시 호출하며,
실패한 새 객체의 삭제와 기존 cache 객체 보존을 구분하므로 임의 cache 정책을 추가하지 않았다.

예를 들어7 실패 후1 성공이면 결과1, 둘 다 실패하면0이다.15의 전부 실패 경로는
15→14→12→1→0이다. 원본의20개 allocation candidate에 대해 실패 경로가 도달하고
단순화 과정에서 중간 shader를 건너뛰지 않는 검사를 추가했다.

`0x1401eef50`의 section pre-bind도 기록했다. factory가 null이면 section+0x1c에21을 저장한다.
그 외에는 shader의 vtable+0x50 반환 ID를 +0x1c에 저장하고, block 내 그 ID의 index가-1일 때만
PreviewRenderBlock을 호출한 뒤 각 section에 PreviewSection을 호출한다.
따라서 loader request(+0x18)와 bound ID(+0x1c)가 분리되는 원본 경로도 연결했다.
Preview/실제 draw scheduling 자체는 아직 독립 코어로 조립하지 않았다.

이로써 정적 fallback **순서**는 해소했지만, 원본 장치가 어느 후보에서 성공하는지와
최종 framebuffer/AlphaRef state는 여전히 미확인이다.
