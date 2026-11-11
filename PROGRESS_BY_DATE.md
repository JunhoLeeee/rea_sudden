# 서든어택 복원 작업 — 날짜별 진행 기록

기준 시간대: Asia/Seoul. 최종 정리: 2026-11-12.
현재 설치본의 원본 코드·리소스를 근거로 독립 클라이언트를 복원하는 작업이다.
아직 전체 게임 플레이가 가능한 클라이언트는 아니다. 원본 EXE/DLL은 실행하지 않았다.

날짜는 기존 조사 문서의 명시 날짜와 Git 커밋 시각을 기준으로 했다.
초기 분석 중 개별 완료일이 기록되지 않은 내용은 아래 누적 작업으로 구분했다.

## 초기 누적 작업 — 2026-11-10~11-11 기록, 개별 완료일 미분리

- 설치본 EXE·CShell·Object 모듈의 정체성, 초기화·모듈 로더·패키지 소비 경로 조사.
- 패키지 320개, 항목 295,705개 목록화와 헤더·인덱스 검증. 검색 DB 구축.
- 초기 선택 항목 276개를 크기·MD5로 검증해 추출. 이후 warehouse 리소스를 추가 복원했다.
- 기본 콘솔 명령 356개, 변수 185개, 액션 119개, 바인딩 51개 선언 재생.
- WelcomeCamp UI XML 13개와 아틀라스 이미지 88개 복원 및 UI 미리보기 구현.
- 무기·미션 등의 선언을 SQLite에 저장. 선언값과 실제 실행 동작은 구분했다.
- 웨어하우스 충돌·객체 자료, 렌더 정점 19,332개·삼각형 10,599개·저장 world 23개 복원.
- 원본 DTX 75개, 저장 mip 284개, lightmap 27개 연결. 대응 패스 삼각형 2,571개를 정확한 기하로 매칭.
- 엔진↔CShell 계약, 모델 스킬 필드 25개와 getter 타입·기본값 규칙 조사 및 독립 코어 구현.

근거: [INVESTIGATION.md](INVESTIGATION.md), [월드 구조](spec/world-format-notes.md),
[렌더 조사](spec/world-render-notes.md), [모델 스킬](spec/model-skill-observed-path.md).

## 2026-11-10 — 명중 표시와 작업 범위 정정

- HitMarker 스타일 선택·일반/헤드샷·처치 트리거·유지/퇴장·회전 경로를 조사하고 독립 모델과 미리보기를 구현했다.
- 색상 0인 처치 트리거도 표시·시간 초기화·사운드 요청을 수행하는 원본 동작에 맞게 수정했다.
- 설정/HitMarker 검사 20개 통과 기록을 남겼다. 당시 HitMarker 실제 창 검사는 Tcl 초기화 문제로 완료하지 못했다.
- 별도로 만들었던 임의 연습 게임은 원본 복원 목표와 달라 개발을 중단했다.
  `practice*`와 검사 기록은 보존하되 원본 동작 복원 성과로 계산하지 않는다.

근거: [당시 조사 기록](INVESTIGATION.md#이어서-진행한-hitmarker-작업-2026-11-10).

## 2026-11-11 — 저장소 이전, 라이트맵 변환, 입력 연결

- Git 저장소를 초기화하고 GitHub `main`에 코드·증거·추출 자료·미리보기·인계 문서를 보존했다.
- 다른 노트북으로 이동했을 때 과거 절대 경로 때문에 lightmap 로딩이 실패하는 문제를 수정했다.
  실제 임시 폴더로 자료를 복사해 재배치를 검사했다.
- lightmap의 형식 jump table과 전용 pixel converter를 해석했다.
  32비트 경로는 RGB source를 BGR0에 기록하며, 저장 PNG RGB 순서를 유지하는 것이 맞다.
- 24/32비트·16비트 555/565 업로드와 형식 선택 코어를 구현했다.
  16비트는 단순 bit 자르기가 아닌 `floor(channel*max/255)`를 사용한다.
- 원본 27개 lightmap을 모든 후보 형식으로 CPU 재생하고 해시를 기록했다.
  32비트 RGB roundtrip 차이 0, 16비트의 8비트 환산 최대 차이 8을 확인했다.
- 뷰어에 업로드 경로·Saturate 비교를 연결하고 브라우저 전환을 검사했다.
- Saturate 기본값 1.0이라는 이전 기록이 옆 Bilinear 레코드를 잘못 연결한 오류임을 확인했다.
  초기화 코드를 추적한 실제 기본 선언은 0.0이며, 과거 증거를 보존하고 정정 보고서를 추가했다.
- action 7의 raw byte 비교→run 비트, mode 0x50의 후속 run/jump 덮어쓰기와 속도 선택 경계를 구현했다.
  이를 전체 이동/physics frame으로 단순 연결하지 않았다.

| 커밋 | 내용 |
|---|---|
| `fba5e7b` | 초기 작업 공간·분석·인계 보존 |
| `49eb2dc` | 폴더 이동 지원, lightmap 채널 경로 해소 |
| `cd44b8c` | lightmap 업로드 형식, 입력 flag 순서 복원 |

## 2026-11-12 — 정점 로더, 셰이더 후보, Fullbright, 검증 fallback

- DAT85는 정점당 44바이트를 읽지만 런타임 할당 stride는 68바이트임을 원본 loader에서 확인했다.
  추가 24바이트는 버전86 이상일 때만 읽으며, 85의 미기록 tail을 임의 0 벡터로 만들지 않았다.
- Gouraud 16바이트·Gouraud_Texture 36바이트 출력 복사를 구현하고 원본 정점 19,332개 전부를 대조했다.
- 저장 shader code 1/2/4→요청 ID 0/11/12를 복원하고 요청·후보·bound shader ID를 구분했다.
- texture/feature 상태를 supplied 입력으로 받는 후보 선택 코어를 구현했다.
  독립 검토로 mode4/bump off/env on의 fallback이14임을 수정하고 교차검사를 추가했다.
- DTX internal flags→renderer texture flags의 원천과 repack 규칙을 연결했다.
  75개 DTX 중 Fullbright 비트 14개, AlphaRef 명령 4개를 확인했다.
- Fullbright의 두 단계 혼합은 단순 조명 비활성화가 아니라 current alpha 기반 혼합임을 확인했다.
  코어와 뷰어 checkbox로 비교할 수 있으며, 새 자료도 원본 DTX 해시를 확인한다.
- shader 검증 실패 전이를 구현했다. 예: `7→1→0`, `12→1→0`, `15→14→12→1→0`.
  실제 device 호출·cache·메모리 실패는 이 supplied-state 모델과 구분한다.
- 브라우저에서 업로드 형식, Fullbright off/on, Saturate 전환을 확인했다.
  기록된 시나리오는 모두 완료됐고 console/page 오류·리소스 누락/실패는 0이었다.

| 커밋 | 내용 |
|---|---|
| `3d67920` | 정점 로딩과 warehouse 셰이더 후보 복원 |
| `258ec21` | DTX 재료 flags와 Fullbright 비교 |
| `e54d49d` | native shader 검증 실패 전이 모델 |

### 마지막 조사만 저장한 항목

`evidence/engine-world-alpha-state-v1.json`에 초기화·월드 draw·객체 상태 helper·재료 바인딩의
정적 명령을 추가 보존했다. 초기 ALPHAFUNC는7이지만, 월드 draw 경로는5(GREATER)를 다시 설정한다.
불투명 helper는 blend를 끄고, translucent helper는 depth write를 끄며 blend를 켠다.
이 결과를 기존 뷰어의 알파/불투명 처리 변경에 아직 적용하지 않았다.

사용자 요청으로 개발을 중단하고 문서·증거만 최종 정리했다.

## 종료 시 검증 상태

- 최근 코드 검사: **119개 통과** = client_core104 + world_render12 + input_command_probe3.
- 위 client_core 전체 검사에는 보존된 `practice*` 프로토타입 검사도 포함된다.
  전체 통과 개수를 원본 복원 기능 수나 원본 게임과의 동등성으로 해석하지 않는다.
- JavaScript 문법 검사와 Git diff 공백 검사 통과.
- 작업용 로컬 뷰어 서버와 provider-owned Chrome 종료 완료.
- 마지막 추가분은 분석 증거·문서이며 실행 코드 변경은 없다.

## 재개할 때 남은 작업

1. 월드 패스의 AlphaRef·ALPHABLENDENABLE·opaque/transparent 상태가 실제 draw에 전달되는 범위 확인.
2. AlphaRef의 원본 간접 숫자 변환 함수와 장치의 실제 shader validation 결과 확인.
3. cache/객체 수명, preview/draw scheduling, 동적 조명 및 runtime vertex 후속 쓰기 연결.
4. 입력 helper와 상위 gate를 연결한 뒤 전체 가속·충돌·점프·카메라를 복원.
5. 무기·피격·애니메이션·화면 상태·서버 의존 동작 통합 및 원본과의 비교 검증.

재개 지점: [SESSION_HANDOFF.md](SESSION_HANDOFF.md).
다른 노트북 설정: [CONTINUE_ON_LAPTOP.md](CONTINUE_ON_LAPTOP.md).
상세 렌더 계약: [spec/native-render-contract.md](spec/native-render-contract.md).
