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
