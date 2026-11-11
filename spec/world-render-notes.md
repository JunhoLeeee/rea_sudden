# 현재 설치본 warehouse 렌더 데이터 검증

원본 `ware_house.dat`의 SHA-256은
`d013c3f158f1ecfa849513c0778a7094f48d2e895a1053d69c0ef616b1ed24ea`다.
원본 게임이나 DLL을 실행하지 않고 선택 추출한 파일을 읽었다.
이 문서의 설치본 관찰은 Python 바이트 분석이며 REA Evidence나 원본 실행 관찰이 아니다.

## 섹션 경계와 배열

`tools/world_render.py`는 헤더의 render 오프셋 `398071`부터 읽어 EOF `1805073`까지 정확히 소비한다.
마지막 `1805069`의 DWORD는 0이며 전역 light-group 목록이 비어 있는 형태다.
블록·모델별 개수와 다음 블록의 경계, 모든 정점 인덱스, 섹션 삼각형 개수 합,
트리 자식 인덱스·순환·다중 부모·루트 도달성을 검사한다.
긴 블록 체인도 파일 예산 내에서 읽을 수 있도록 트리 검사는 Python 재귀 대신 명시적 스택을 사용한다.

| 항목 | 관찰된 합계 |
|---|---:|
| 렌더 world | 23: MAIN 1 + 이름을 가진 worldmodel 22 |
| 렌더 block | 39: MAIN 17 + worldmodel당 1 |
| 정점 | 19332 |
| 삼각형 레코드 | 10599 |
| 재질 section | 326 |
| 압축 lightmap | 27 |
| sky portal | 5 |
| occluder / block·global light group | 0 |

실제 정점 stride는 **44 bytes**다. 순서는 `7float + uint32 + 3float`이며
`x,y,z,u0,v0,u1,v1,argb,nx,ny,nz`로 보존한다.
비교한 공개 소스에는 tangent/binormal이 추가된 68-byte 타입도 있으므로 그 크기를 현재 파일에 적용하지 않았다.
삼각형은 `uint32` 4개로 저장한다. 처음 세 값은 같은 블록 정점 배열의 인덱스이고,
네 번째 값은 원래 값 그대로 남긴다. 공개 loader가 이를 poly index로 읽지만 현재 소비 의미는 별도 확인이 필요하다.

## 실제 shader 코드와 중복 패스

| 저장 코드 | section 수 | 삼각형 수 | 공개 코드의 비교 명칭 |
|---|---:|---:|---|
| 1 | 164 | 5457 | Gouraud: 텍스처 + 정점 조명 |
| 2 | 27 | 2571 | base lightmap |
| 4 | 135 | 2571 | lightmapping의 texture 패스 |

모든 section의 두 번째 텍스처 슬롯과 texture-effect 문자열은 비어 있다.
MAIN 17개 블록 각각에서 코드 2와 4의 삼각형 위치 multiset가 **정확히 일치**한다.
좌표 반올림이나 허용 오차 없이, 같은 블록의 세 저장 위치와 cyclic winding으로 대응시켰다.
모든 2571개 대응이 유일하고, 역방향 winding을 같은 것으로 처리하지 않았다.
따라서 diffuse 전용 보기에서 코드 2까지 불투명 diffuse처럼 그리면 동일 위치 기하를 중복 표시한다.

반대로 삼각형의 네 번째 DWORD는 패스 간 안정적인 키가 아니다.
예를 들어 MAIN/block0의 같은 위치 삼각형이 lightmap 레코드에서는 `(...,30)`,
diffuse 레코드에서는 `(...,42)`로 기록된다.
코드 2의 `u0/v0`는 packed lightmap 위치이고 코드 4의 `u0/v0`는 반복 diffuse UV이므로 서로 대체하면 안 된다.

`previews/warehouse-lightmap-links-v2.json`은 다음을 기록한다.

- `world`, `block`: 대응 블록.
- `diffuse_triangle`, `diffuse_section`: 코드 4의 레코드와 재질.
- `lightmap_triangle`, `lightmap_section`: 대응 코드 2 레코드와 lightmap.
- `lightmap_vertices_in_diffuse_order`: diffuse의 세 정점 순서에 맞춘 lightmap 정점 인덱스.

이 데이터로 diffuse UV와 별도 lightmap UV를 동시에 공급할 수 있다.
대응 관계 자체는 직접 바이트 관찰이지만 현재 실행 파일의 blend 방식·saturation 설정·색상 채널은 아직 검증하지 않았다.

## 다른 중복 기하와 화면 검증 주의점

선택한 diffuse 코드 1과 4 사이의 정확한 cyclic-position 중복은 **0개**다.
단, MAIN에서 코드를 합쳐 winding 방향을 무시하면 444개 위치 그룹에 492개의 추가 삼각형이 있다.
대부분 `Light2.dtx`의 정/역방향 복사이며 같은 winding 복사도 존재한다.
`box.DTX`에도 같은 winding 복사가 있고 두 위치 그룹에는 서로 다른 재질의 역방향 면이 있다.
단순 위치 중복 삭제는 원본의 양면/재질 의미를 지울 수 있으므로 수행하지 않았다.
자세한 그룹은 `evidence/warehouse-main-diffuse-duplicate-geometry.json`에 있다.

원본 텍스처에는 하위 mip들이 저장되어 있는데 현재 PNG registry는 level 0만 표시한다.
원본 75개 선택 텍스처 중 36개는 5레벨, 18개는 4레벨, 5개는 3레벨, 1개는 2레벨, 15개는 1레벨이다.
따라서 멀리서 level-0/LINEAR만 사용하는 화면의 고주파 노이즈를 기하 중복으로 단정하지 않는다.
원본 mip 추출·필터·culling·깊이 정밀도·alpha 상태를 각각 대조해야 한다.

## 텍스처와 lightmap의 실제 파일 검증

render section이 요구하는 파일 텍스처는 DTX **73개**다.
`previews/warehouse-textures/textures-map.json`의 기존 선택 추출 75개 안에 모두 있으며,
미복원·미지원·모호한 패키지 선택은 없다. `LightAnim_BASE`는 파일 경로가 아닌 참조다.
DTX 출력 SHA-256과 기록된 패키지 멤버 MD5를 실제 추출 파일에서 다시 계산했고,
PNG SHA-256도 다시 계산하여 registry와 일치함을 확인했다.
기존 75개 추출은 collision material 목록을 근거로 했으며 두 개는 render 목록에 필요하지 않다.

27개 lightmap의 run/span 압축은 선언된 `width*height*3`만큼 정확히 해제된다.
`previews/warehouse-lightmaps/` PNG를 다시 열어 mode=RGB·크기·SHA와 픽셀 바이트를 확인했으며,
각 픽셀 배열은 원본 압축 구간의 해제 triplet 배열과 같다.
여기서 RGB PNG는 저장 triplet 순서를 그대로 시각화한 것이다. 현재 엔진의 채널 해석을 확인한 결과는 아니다.

## 좌표 및 원본 배열 보존

MAIN 렌더 bounds는 `[-2341.5,-463,-1735] .. [2782.5,513,688]`다.
이는 PhysicsBSP의 넓은 bounds와 다르며 실제 렌더용 배열을 충돌 배열로 대체할 수 없음을 보여 준다.
나머지 22개 이름 있는 렌더 worldmodel의 점 bounds는 대응 충돌 모델 bounds와 모두 정확히 같다.
저장 좌표에 model translation이나 source-world offset을 추가하지 않았다.
runtime worldmodel 이동·회전·객체의 현재 상태는 별도 코드 분석 대상이다.

기존 `previews/warehouse-render-mesh.json`의 전체 저장 배열을 새 파싱 결과와 canonical JSON SHA로 대조했다.
PNG export가 덧붙인 경로/PNG 해시 두 메타데이터만 제외하면 동일하다.
점·UV·색·법선·인덱스·section 범위를 viewer를 위해 임의로 변경하지 않았다.

## 비교 소스와 한계

공개 [d3d_renderblock.cpp](https://github.com/jsj2008/lithtech/blob/master/runtime/render_a/src/sys/d3d/d3d_renderblock.cpp)의
enum/stream loader를 형식 비교에 사용했다.
[d3d_rendershader_lightmap.cpp](https://github.com/jsj2008/lithtech/blob/master/runtime/render_a/src/sys/d3d/d3d_rendershader_lightmap.cpp)는
두 패스 모두 각자의 UV0를 사용하고 texture 패스에서 destination-color 곱셈 및 saturate 선택을 설정한다.
이는 공개 구현의 동작이며 현재 서든어택 실행 파일의 동일성을 증명하지 않는다.
조회 소스 URL·길이·SHA는 `evidence/world-render-source-reference-identities.json`, 비교본은
`evidence/world-render-source-comparison/`에 보존했다.

아직 현재 원본 렌더러의 shader 선택·채널 swizzle·lightmap/vertex-light 합성·culling·alpha·안개·
동적 조명·가시성·worldmodel 변환 및 최종 픽셀 일치를 검증하지 않았다.
독립 renderer는 원본 배열/재질을 확인하는 단계이며 완전한 클라이언트 동등성으로 간주하지 않는다.

## 재현 명령

```powershell
python -m unittest discover -s tools -p test_world_render.py -v
python tools/audit_world_render.py --report new-render-audit.json --links new-lightmap-links.json
```

현재 renderer 검사 12개가 통과했다. 경계·잘못된 정점 인덱스·NaN UV·개수 불일치·트리 오류·
압축 오류를 거부하는 검사와 실제 설치본 배열·DTX·PNG·lightmap 픽셀 readback 검증을 포함한다.
최신 전체 검증 결과는 `evidence/warehouse-render-audit-v2.json`이다.

## 설치본 lightmap 소비 코드 후속 조사 (2026-11-11)

`evidence/engine-native-lightmap-consumers.json`의 `0x14021f880`에서
render state `0x1b`를 1, `0x13`을 9로 설정한다. `0x14021f93b`는
`0x1403eacc0`을 0과 비교하여 state `0x14`에 1 또는 3을 전달한다.
같은 분기가 fog color state `0x22`를 `0xffffff` 또는 `0x808080`으로 선택한다.
`0x1401970d0`은 캐시를 검사한 뒤 장치 vtable `+0x1c8`에 상태를 전달한다.
저장된 공개 lightmap 구현과 대조하면 ALPHABLENDENABLE=TRUE,
SRCBLEND=DESTCOLOR, DESTBLEND=ZERO/SRCCOLOR 분기와 대응한다.

이 해석에서 안개 등 다른 연산을 제외한 색 합성은 `diffuse * lightmap` 또는
`clamp(2 * diffuse * lightmap, 0, 1)`이다. 뷰어에 두 비교 모드를 추가했다.
2배 계수는 정확히 대응시킨 lightmap 면에만 적용하며 Gouraud 면에는 적용하지 않는다.
단일 WebGL shader의 비교 계산이므로 원본의 두 패스 사이 정밀도·양자화·알파·안개까지
재현한 것으로 간주하지 않는다. 원본 게임에서 현재 선택되는 경로도 미확인이다.

`Saturate` 문자열과 기본 float 1.0의 저장 위치는 각 probe의 `saturation_record`에 있다.
기본 선언을 실제 실행 중 설정값으로 간주하지 않는다.

업로드 경로 `0x14021df70` → `0x1400da5a0`은 원본 triplet run/span 해제와 연결된다.
`0x140220e90`은 source pitch를 width*3으로 지정하고 pixel format setter에
형식 8, alpha mask 0, 나머지 mask `0xff0000/0xff00/0xff`를 전달한다.
새 `evidence/engine-native-lightmap-pixel-format-flow.json`은 setter `0x140126ee0`이
이 인수를 저장하고 mask별 shift/width를 계산하는 코드를 보존한다.
`0x1401ffc10`의 format dispatch는 간접 jump table이어서 단순 분기 추적만으로
모든 target을 복원하지 못했다. 최종 RGB 채널 의미와 변환 함수는 추가 추적이 필요하다.
따라서 현재 저장 triplet PNG의 채널 순서는 이 조사만으로 바꾸지 않았다.

이 파일들은 Capstone 직접 바이트 관찰이며 REA의 인증된 Evidence 레코드와 구분한다.
원본 EXE SHA-256은 `7e37a8098930836fc4ebcfd6e3cded7a616b789f162af68be6e34287c568b0d8`이고
이번 probe에서도 현재 파일 해시가 일치해야만 보고서를 생성하도록 검사했다.

## 라이트맵 색 채널 dispatch 해소 (2026-11-11)

`tools/lightmap_format_probe.py`는 같은 EXE 해시를 확인한 뒤 `0x1401ffc10`의
입력 20..64를 45바이트 selector와 13개의 image-relative target으로 명시적으로 푼다.
전체 selector/target 바이트와 각 target의 독립 정적 decode를
`evidence/engine-lightmap-format-dispatch-v1.json`에 보존했다. 간접 분기 일반 해석기를
구현한 것이 아니며 이 해시·주소·guard에 한정한 해석이다.

- 형식 20: 24bpp, alpha 0, R/G/B mask `0xff0000/0xff00/0xff`.
- 형식 21: 32bpp, alpha `0xff000000`, 같은 R/G/B mask.
- 형식 22: 32bpp, alpha 0, 같은 R/G/B mask.
- `0x1401ff6e0`은 32bpp를 내부 type 3, 24bpp를 type 8로 만든다.
- `0x140126ca0`의 변환 table은 `source_type*10+destination_type`이다.
  type 8→3의 pointer는 `0x140120b80`, 8→8은 `0x140120550`이다.

중요한 것은 source mask 선언만으로 triplet을 BGR로 판단할 수 없다는 점이다.
type 8→3은 범용 mask 추출이 아닌 전용 변환을 사용한다. 업로드의
`0x140220f57`은 R8을 0으로 지워 color-key 없는 경로를 선택한다.
변환기의 `0x140120c70..0x140120c95`는 source `[s0,s1,s2]`에서
destination `[s2,s1,s0,0]`를 만든다. destination의 red mask가 `0xff0000`이므로
이 경로의 source triplet은 **RGB**다. 현재 저장 PNG는 RGB 그대로 유지하며 swizzle하지 않는다.
32비트 업로드의 alpha byte 0은 확인된 저장 동작이며, 이를 PNG alpha나 최종 합성 alpha로
확장해서 해석하지 않는다. 8→8은 row copy이며 이 경로의 실제 선택·색 해석은 별도 미확인이다.

이로써 32비트 변환 경로의 채널 문제는 해소했다. 실제 장치가 선택하는 texture format,
16비트 변환의 양자화, fog, 실제 Saturate 상태와 최종 픽셀 일치는 아직 미확인이다.
이 기록은 원본을 실행하지 않은 직접 바이트 관찰·정적 해석이며 REA 인증 Evidence와 구분한다.

## 작업 폴더 이동 지원 (2026-11-11)

기존 mesh의 `png_path`는 생성 PC의 절대 경로를 보존한다. 원본 증거와 mesh hash를 바꾸지 않고
`tools/artifact_paths.py`로 `previews` 하위 참조를 현재 checkout에 연결한다.
경로 순회와 모호한 참조를 거부하고 기존 PNG SHA 검증을 유지한다.
뷰어와 lightmap export audit 모두 이를 사용한다. 실제 임시 폴더로 previews를 복사한 뒤
모든 texture/mip와 lightmap 27개가 새 폴더에서 로드되는 회귀 검사를 추가했다.
