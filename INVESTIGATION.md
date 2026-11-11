# 서든어택 독립 클라이언트 재현 조사

## 목표와 현재 상태

작업 범위 정정: 최종 목표는 현재 설치된 서든어택 버전의 클라이언트 구현이며 정적 분석은 그 근거를 확보하는 작업이다.
임의의 연습 게임 개발은 요청을 잘못 해석한 별도 작업이다. 아래 연습 프로토타입 기록은
그 구현 내역을 보존하는 것이며, 원본 바이너리 분석의 진행이나 기능 복원으로 계산하지 않는다.
이후 구현은 확인한 원본 함수·참조·데이터 구조·리소스를 따른다.

목표는 로컬에서 실행되는 독립 클라이언트로 화면·조작·게임 규칙을 재현하는 것이다.
현재 결과물은 **원본 웨어하우스 리소스 뷰어, UI 미리보기, 설정·명중 표시·모델 스킬 비트 코어, 리소스 복원 도구**다.
웨어하우스의 실제 저장 렌더 기하·UV·diffuse 텍스처를 표시한다. 원본 조명·셰이더 합성·동적 변환의 동일성은 아직 검증하지 않았다.
원본 이동·사격·피격·적 AI·모델 애니메이션·네트워크 플레이를 통합한 클라이언트는 아직 없다.

원본 게임 실행 파일이나 추출한 게임 DLL을 실행하지 않았다. 실행한 것은 REA/Ghidra 분석기와 직접 작성한 Python 도구·UI 미리보기다.

## 완료한 작업

- REA 6.8.0 / Ghidra 12.1.4 / Java 24.0.2 연결.
- suddenattack.exe의 함수·문자열·임포트·로드 이미지 및 패키지 로더 분석.
- 원본 실행 파일 SHA-256 재확인: 7e37a8098930836fc4ebcfd6e3cded7a616b789f162af68be6e34287c568b0d8.
- 설치된 .pkg **320개**의 헤더와 인덱스 체크섬 검증. 내부 항목 **295,705개** 목록화.
- 검색 DB: [assets.sqlite](evidence/assets.sqlite). 중복 경로와 패키지 소속을 보존하며 우선순위는 추정하지 않는다.
- 선택한 패키지 항목 **276개** 복원. 모든 출력은 기록된 크기·MD5와 일치하고 SHA-256도 기록했다.
- engine.rez에서 렌더 스타일 10개와 콘솔 폰트 1개 복원.
- 기본 콘솔 명령 **356개**의 포인터 표를 순서대로 복원.
- 설정 코어에서 변수 185개, 액션 선언 119개, 바인딩 선언 51개 재생.
- WelcomeCamp XML 13개, 요소 129개, 아틀라스 이미지 88개로 독립 Tk 미리보기 구현.
- 실제 숨긴 Tk 창에서 13개 배치의 로드·렌더링 검증. 이미지 인스턴스 111개를 그렸다.
- weapons.txt 등 7개 선언 파일을 [game-data-v2.sqlite](spec/game-data-v2.sqlite)에 저장. 주석 제외 미해석 줄 0개.

## 복원 파일 범위

| 범위 | 검증 항목 수 | 위치 |
|---|---:|---|
| 게임 모듈 | 6 | extracted/game-file/game_file/ |
| Lua·설정·무기·배치·미션 선언 | 239 | extracted/scripts/sa_scripts/ |
| 텍스트 데이터 | 1 | extracted/text/ |
| 전역 모델 | 6 | extracted/global/ |
| 로그인 이미지 | 9 | extracted/login-ui/ |
| WelcomeCamp UI XML | 13 | extracted/welcome-ui/ |
| 아틀라스 매핑 XML | 1 | extracted/atlas-map/ |
| WelcomeCamp 아틀라스 | 1 | extracted/welcome-atlas/ |

276개는 선택 추출 범위다. 295,705개 전체 파일 내용을 복원한 것이 아니다.
각 폴더의 extraction-manifest.json에 원본 읽기 범위, 기대 MD5, 출력 SHA-256을 남겼다.
패키지 전체 파일 SHA-256은 계산하지 않았으며 헤더·인덱스·선택 데이터 범위의 정체성만 기록했다.

## 확인한 코드 연결

| 주소 | 관찰 | 근거 파일 (evidence/) |
|---|---|---|
| 0x14007a2f0 | engine.rez와 추가 리소스, config/display 경로 구성 후 초기화 호출 | engine-resource-init-code.json |
| 0x14008fc10 | 패키지 초기화·리소스 연결·셸 로딩·설정 처리 순서 | client-init-code.json |
| 0x140091d30 | game 폴더와 .pkg 확장자 및 옵션 구조체 구성 | package-extension-code.json |
| 0x1400bdc40 | game_file/ 안의 요청 모듈을 리소스로 해석·복사 | client-file-resolver-code.json |
| 0x1400bef00 | cshell.dll / cres.dll 준비 및 모듈 연결 | cshell-loader-code.json |
| 0x140073ea0 | 모듈 로딩 및 선택적 SetMasterDatabase 연결 | client-module-load-code.json |
| 0x1400a4af0 | autoexec.cfg 이름에 대해 356개 내장 명령 실행, 기타 이름은 파일 읽기 | config-file-and-fallback-code.json |
| 0x1400a5570 | 공백·제어문자·세미콜론·괄호·따옴표·% 이스케이프 처리 | console-tokenizer-inner-code.json |
| 0x14029ca20 | 플래그에 따른 헤더 암호·전체 암호·zlib 스트림 구성 | member-stream-factory-code.json |
| 0x1402adbe0 | 32비트 키스트림 감산으로 암호 스트림 해석 | snow-cipher-transform-code.json |

CShell.dll은 SetMasterDatabase 및 Lua API를 내보내는 64비트 PE다(cshell-exports.json).
Object.lto는 ObjectDLLSetup, SetMasterDatabase 및 Lua API를 내보내는 64비트 PE다(object-exports.json).

기록 파일의 설명식 이름은 탐색용이다. 함수 식별은 내부 원본 주소와 본문을 기준으로 한다.
package-registration-code.json의 실제 함수 0x1402dd700은 정상 등록이 아니라 패키지 오류 진단 경로다.
InitClientShellDE 문자열만으로 같은 이름의 내보내기 함수가 존재한다고 판단하지 않는다.

## 설정과 규칙의 관찰·한계

- 원본 초기화는 변수 처리와 명령 콜백 처리를 두 패스로 나눈다. client_core도 이 순서를 반영한다.
- 바인딩 하나의 -0.10,-255.0 원문은 임의로 고치지 않고 해석 문제로 기록한다.
- ModelAdd 네이티브 콜백 두 선언은 미구현이다.
- weapons.txt의 11,215개 섹션에는 Ammo/Mod 등도 포함된다. 이를 무기 개수로 해석하지 않는다.
- weapons.txt에는 583,675개 필드가 있다. 선언의 현재 모드 적용 여부·단위·보정은 별도 검증이 필요하다.
- serverbutes.txt의 Player 선언에는 WalkSpeed=150, RunSpeed=330, JumpSpeed=630이 있다. 실제 소비 코드 연결은 미확인이다.
- GameplaySettings.txt에는 HitMarker 색상·표시 시간 선언이 있다. 실제 표시 코드와의 연결을 분석한다.
- UI 좌표·스프라이트는 복원했으나 원본에서의 도달 가능성, 버튼 이벤트, 동적 숫자, 애니메이션, 화면 전환은 미확인이다.

## CShell 분석 프로파일

CShell.dll SHA-256: 099d69b5b3af0562ebde39094a5daa72cf2cea455a91625fedb06f55c2300110.
기본 Ghidra 분석은 330초 및 540초에서 startup timeout을 반환했다. 메모리 부족은 확인되지 않았다.
실패 응답은 evidence/cshell-strings.json과 cshell-strings-retry.json에 보존했다.

이후 Decompiler Switch Analysis 및 Windows x86 PE RTTI Analyzer를 끈 별도 프로파일로 참조를 조사한다.
이 프로파일에서는 switch 복구와 RTTI 기반 클래스·타입·함수 복구가 줄어든다.
결과가 없다는 것이 원본 코드나 함수가 없다는 의미는 아니다. 변경은 로컬 REA 세션에만 적용한다.

cshell-static-anchors.json 및 object-static-anchors.json은 일반 Python의 파일 바이트 관찰이다.
cshell-anchor-ref-candidates.json은 명령 경계가 검증되지 않은 RIP 상대 바이트 패턴 후보다.
PE unwind 범위도 Ghidra의 확정 함수 경계와 구분한다.

## 남은 구현·검증

- [x] HitMarker 선언→설정 소비→트리거→표시 코드의 정적 연결 및 독립 모델 구현.
- [ ] HitMarker 활성 조건 내부의 게임 상태 의미와 원본 런타임 대조.
- [ ] 화면 상태 머신과 메뉴→로컬 연습 흐름 복원.
- [ ] 입력→이동·카메라·충돌·점프 규칙 검증 및 독립 구현.
- [ ] 무기·탄약·재장전·반동·명중·피격·라운드 규칙 구현.
- [ ] 맵·모델·애니메이션을 독립 렌더러로 재생.
- [ ] 서버 의존 상태와 로컬 결정 상태 구분.
- [ ] 기준 시나리오와 비교해 동작 일치 검증.

정적 선언, 직접 구현한 모델, 원본 런타임 관찰을 구분한다.
현재 결과물로 완전한 기능 동등성이나 원본 소스 복원을 주장하지 않는다.

## 이어서 진행한 HitMarker 작업 (2026-11-10)

저장된 REA/Ghidra 결과를 재사용했다. 아래는 정적 관찰이며 원본 실행 관찰이 아니다.

- `hitmarker-consumer-a-code.c` (0x1806dea80), `hitmarker-consumer-b-code.c`
  (0x1806dee60): 프로필 1을 기본으로 복사한 뒤 저장된 스타일 바이트+1 키가 있으면 덮어쓴다.
- `hitmarker-trigger-code.c` (0x1806df270): 일반/헤드샷 색상을 선택하고, 이미 표시 중이면
  경과 시간을 fadeInTime 이하로 제한한다. 색상 전체 값이 0이면 새로 표시를 켜지 않는다.
- `hitmarker-kill-trigger-code.json` (0x1806df350,
  ev_a71b8474210178f2e199790ee24e24490a7c2e8d4d1ce38e36f10fe8753a0288):
  처치는 색상 값과 관계없이 시간을 0으로 만들고 표시를 켜며 killSound.wav 재생을 요청한다.
  독립 모델의 색상 0 처리 오류를 수정하고 회귀 테스트를 추가했다.
- `hitmarker-render-code.c` (0x1806e0120): 진입 시 길이가 증가하고, 유지 이후 길이와 알파가 감소한다.
  퇴장 시 바깥 끝 위치를 유지하며, 전체 시간보다 엄격히 커진 프레임에서 표시를 끈다.
- `hitmarker-rotation-code.json` (0x180b44750,
  ev_e93702bcba55be5beb91fbcd233f13a5bb782917e8d92955d6f89ad68631ae1d):
  중심을 기준으로 정점 회전. 표시 함수는 type 0에서 45도 인수를 전달한다.

`client_core/hitmarker_preview.py`에 스타일 선택 및 일반/헤드샷/처치 시연을 추가했다.
회전과 단색 배경 알파 합성은 Tk에서 구현했으며 원본 GPU 래스터화와의 동등성을 주장하지 않는다.
게임 상태 게이트는 호출자가 활성화 여부를 전달하고, 사운드는 요청 문자열만 반환한다.
좌표의 16비트 넘침 등 극단 입력의 원본 동작은 재현 범위 밖이다.

검증: `python -m unittest client_core.test_hitmarker client_core.test_config -v`의 20개 테스트 통과.
실제 Tk 창 검증은 Python 3.13의 `Can't find a usable init.tcl` 오류로 실행하지 못했다.
라이브러리 경로를 명시해도 같은 오류가 발생했다. GUI smoke 명령은 구현했으나 통과 기록은 없다.
다음 검증은 Tcl이 정상 초기화되는 환경에서 `python -m client_core.hitmarker_preview --smoke` 실행이다.

## 독립 연습 프로토타입 (2026-11-10)

Tk 초기화가 실패하는 환경에서도 사용할 수 있도록 Python 표준 라이브러리 HTTP 서버와 브라우저 WebGL 화면을 구현했다.
기존 Tk 미리보기는 유지한다. `launch-practice.cmd` 또는 `python -m client_core.practice_server`로 실행한다.

구현 파일:

- `client_core/practice.py`: 독립 시뮬레이션. 작은 시간 간격으로 이동/충돌/점프를 처리하고,
  3차원 광선과 벽·표적 박스의 교차를 비교해 가장 가까운 명중 대상을 선택한다.
- `client_core/practice_server.py`: 루프백 HTTP 통신, 세션 토큰, 입력 검증, 연결 지연 시 일시정지.
- `client_core/practice_ui/`: 원근·깊이 검사를 사용하는 WebGL 맵/표적, Canvas 명중 표시,
  키보드/마우스 입력, 탄약/재장전 HUD, 미니맵, 메뉴·일시정지·결과 화면.
- `spec/practice-rules.md`: 직접 정한 연습 규칙 및 기존 관찰과의 구분.

원본에서 정적으로 관찰한 HitMarker 프로필·색상·타이밍·회전 요청을 재사용한다.
연습용 hit 판정 결과를 그 모델에 전달하며, 이것은 원본 명중 판정이나 활성 조건의 복원이 아니다.
게임 DLL이나 원본 실행 파일은 실행하지 않았다. 기존 `config.py`는 선언 재생기로 유지하며,
연습 클라이언트 입력은 별도 정의된 키 매핑을 사용한다.

검증:

- `python -m unittest client_core.test_practice client_core.test_hitmarker client_core.test_config -v`: 36개 통과.
- 16개 연습 검사에 대각 이동 정규화·벽 미끄러짐·긴 프레임 제한·점프 착지·앉기·일시정지,
  머리/몸통 피해·벽 가림·가장 가까운 표적·연사 제한·탄약 보존·재장전 취소·라운드 종료·HTTP 경로/인증 포함.
- `node --check client_core/practice_ui/app.js`: 통과.
- REA가 Chrome을 별도 임시 프로필로 실행하여 시작·사격·무기 전환·일시정지·재개를 수행했다.
  `evidence/practice-browser-smoke.json`, Evidence
  `ev_ee12d013402c85cb2d14a1acdd02c227cbbfc32e7920b4749c1d3cf076433e07`.
  모든 시나리오 단계 완료, 콘솔/페이지 오류 0개. DOM에서 소총 탄약 29/90·처치 1,
  권총 전환 후 7/35, 정지/재개에 따른 메뉴 표시 여부를 확인했다.
- `previews/local-practice.png`: 위 브라우저 실행에서 캡처한 실제 화면.

이 검사는 직접 구현한 프로토타입을 검증한다. 원본 게임과 동작을 비교한 검사는 아니다.
다음 큰 작업은 원본 맵·모델 형식 조사와 렌더러 연결, 이동/무기 소비 코드의 관찰,
관찰된 규칙으로 연습용 수치를 단계적으로 대체하는 것이다.
