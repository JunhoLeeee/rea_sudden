# 현재 설치본 ware_house.dat 구조 조사

## 원본과 검증 범위

원본 게임이나 DLL을 실행하지 않고, 설치된 `C:/Nexon/SuddenAttack/game/sa_worlds_00009.pkg`의
`sa_worlds/project/ware_house.dat` 항목 한 개만 선택 추출했다.
`extracted/world-warehouse/extraction-manifest.json`에서 패키지 인덱스·저장 범위·크기·MD5·출력 SHA-256을 확인한다.

- 출력 크기: 1,805,073 bytes.
- 출력 SHA-256: `d013c3f158f1ecfa849513c0778a7094f48d2e895a1053d69c0ef616b1ed24ea`.
- 파서: `tools/world_dat.py`.
- 최신 구조 보고서: `evidence/warehouse-world-structure-v2.json`.
- 원본 충돌기하 배열: `previews/warehouse-collision-mesh.json`.
- 원본 충돌기하 OBJ: `previews/warehouse-collision.obj`.

임의로 제작한 맵이 아니다. 다만 충돌용 데이터에서 읽은 기하이며, 현재 클라이언트의 최종 화면·재질·조명·동적 배치를 복원했다고 주장하지 않는다.
이 기록은 일반 Python의 파일 바이트 관찰이며 REA Evidence나 원본 런타임 관찰이 아니다.

## 직접 관찰한 정합성

첫 DWORD는 85다. 헤더의 6개 오프셋은 다음과 같다.

| 필드 명칭 | 파일 오프셋 | 해당 시작점 |
|---|---:|---:|
| objects | 4 | 299145 |
| blind_objects | 8 | 392147 |
| light_grid | 12 | 392151 |
| blockers | 16 | 396899 |
| particle_blockers | 20 | 398063 |
| render | 24 | 398071 |

나머지 8 DWORD는 0이고, 60에서 길이 DWORD를 읽은 뒤 40바이트 world-info 문자열을 읽는다.
뒤에 전역 min/max, source-world offset, 트리 min/max와 노드 수가 이어진다.
트리 선언 노드는 341이며, LSB 우선 분할 비트 341개를 읽었을 때 85개 분할과 256개 말단으로 정확히 종료된다.
트리 바로 뒤의 모델 수는 23이다.

전체 모델을 읽은 위치가 objects 시작점 299145와 정확히 일치한다.
모델마다 모든 polygon→surface/plane/point 및 node→polygon/child/root 인덱스를 검증했다.
legacy portals/leaves/visible/leaf-list/sections 테이블은 이 파일에서 모두 0이다.

| 항목 | 합계 |
|---|---:|
| 모델 | 23 |
| 저장 점 | 4651 |
| 평면 | 2380 |
| surface | 119 |
| polygon | 3546 |
| polygon vertex 참조 | 13764 |
| BSP 노드 | 7960 |

모델 22의 저장 이름은 `PhysicsBSP`이며 점 4471개가 있다. 나머지 모델은 `passage break*`, `EndlessFall*`,
`DemoSkyWorldModel0` 등의 저장 이름을 가진다. 이름만으로 현재 모드의 가시성·충돌·이벤트 동작을 확정하지 않는다.

## 좌표, translation, winding

저장 world bounds는 `[-4121.5,-3040,-4096] .. [4070.5,3040,4096]`, source-world offset은 `[-230.5,1632,512]`다.
OBJ와 mesh JSON은 저장된 x/y/z를 그대로 출력한다. 축 변경, 미터 변환, source-world offset 또는 모델 translation을 추가 적용하지 않는다.
모든 저장 점이 해당 모델 선언 bbox 안에 있고, 보고된 translation은 각 bbox 중심과 일치한다.
따라서 translation을 한 번 더 더하면 저장 bbox와 어긋난다. 이는 원본 런타임의 움직이는 worldmodel 변환을 해명한 결과는 아니다.

실제로 `passage break` 모델의 translation은 `[2371.5,-181.5,381]`인 반면,
동명 Breakable 객체의 Pos는 `[2368.5,-180,384]`다. 모델 저장 좌표와 동적 객체 배치를 무조건 합산하면 안 된다.
원본 엔진의 local/world 변환 소비 코드는 별도 분석이 필요하다.

모든 3546 polygon에서 저장된 첫 세 점으로 계산한 `cross(p1-p0,p2-p0)·storedPlaneNormal`이 양수다.
역방향 및 첫 삼각형 퇴화는 0개다. 원본 인덱스 순서를 보존한다. 이는 저장 평면에 대한 winding 관찰이지,
현재 렌더러의 culling 방식이나 화면의 좌우손 좌표계를 확정한 것은 아니다.

점-평면 식 `dot(point,normal)-distance`의 최대 절댓값은 PhysicsBSP에서 약 3.2233이다.
다른 모델은 대부분 0 또는 약 0.00012 이하다. 좌표/인덱스 정합성은 검증됐지만,
모든 면이 완전한 평면이라는 가정을 충돌 구현에 바로 적용하지 않는다.

## 객체 선언

objects 범위 299145..392147을 레코드 크기·속성 개수·속성 데이터 길이로 전부 검증했다.
125개 객체를 읽고 blind_objects 시작점 392147에서 정확히 종료된다.

| 저장 클래스 | 개수 |
|---|---:|
| Light | 39 |
| GameStartPoint | 18 |
| EndlessFall | 17 |
| ScaleSprite | 16 |
| SoundFX | 10 |
| DirLight | 8 |
| CeremonyPoint | 8 |
| Breakable | 4 |
| Camera / StaticSunLight / DemoSkyWorldModel / WorldProperties / ObjectLight | 각 1 |

문자열·3float·4float·float·int32·bool의 관찰된 타입/길이 조합만 해석한다.
각 속성은 `name,type_code,flags,offset,encoded_bytes,value`를 보존한다.
Rotation은 원본의 4float를 그대로 보존하며 quaternion/Euler 의미나 단위를 임의로 지정하지 않는다.
GameStartPoint의 Team 문자열·Pos·StartPoint·SpawnPoint 등의 선언도 보고서에 보존했다.
이 객체가 현재 모드에서 선택되는지, 어떤 초기 위치 보정이 들어가는지는 별도 코드 분석이 필요하다.

## 구조 비교에 사용한 외부 소스

필드 이름과 비트 순서는 공개된 LithTech 소스의
[world_shared_bsp.cpp](https://github.com/jsj2008/lithtech/blob/master/runtime/world/src/world_shared_bsp.cpp),
[world_tree.cpp](https://github.com/jsj2008/lithtech/blob/master/runtime/world/src/world_tree.cpp),
[PCWorldPacker.cpp](https://github.com/jsj2008/lithtech/blob/master/tools/PreProcessor/Packer_PC/PCWorldPacker.cpp)를 비교해 가설을 세웠다.
공개 코드의 버전-85 구조와 현재 파일의 경계·개수·참조가 일치한다는 관찰이다.
이 외부 코드가 현재 서든어택 소스이거나 현재 실행 파일과 동일하다는 주장은 하지 않는다.
조회한 파일의 URL·길이·SHA-256은 `evidence/world-format-source-reference-identities.json`에 보존했다.

## 사용과 후속 작업

```powershell
python tools/world_dat.py extracted/world-warehouse/sa_worlds/project/ware_house.dat new-report.json --obj new-collision.obj --mesh new-mesh.json
python -m unittest discover -s tools -p test_world_dat.py -v
```

출력은 새 경로만 허용한다. 원본은 수정하지 않는다. 실물 파일 회귀 및 경계/형식 오류 포함 8개 검사 통과.

후속 작업은 render 구간의 vertex/triangle/UV/lightmap 구조 복원, 패키지의 텍스처 참조 해석,
원본 엔진의 worldmodel 변환 및 BSP 충돌 소비 코드 확인이다. 충돌 OBJ를 읽기 전용 뷰어에 표시할 수 있지만,
렌더링 전용 기하와의 차이 및 객체별 가시성을 분명히 표시해야 한다.
