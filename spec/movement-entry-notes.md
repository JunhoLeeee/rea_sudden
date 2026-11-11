# 현재 버전 이동 코드의 시작점

원본 CShell.dll SHA-256:
`099d69b5b3af0562ebde39094a5daa72cf2cea455a91625fedb06f55c2300110`.
이 문서는 파일 바이트/Capstone과 새 REA/Ghidra 결과를 교차 대조한 정적 조사다.
원본 게임 실행이나 실제 이동·속도 측정은 하지 않았다.

## 설정 선언과 클라이언트 코드의 구분

`serverbutes.txt`의 `WalkSpeed=150`, `RunSpeed=330`, `JumpSpeed=630` 선언만으로
클라이언트의 실제 이동 속도·점프 속도·단위를 정하면 안 된다.
이번 조사에서 별도 클라이언트 초기 스칼라 함수와 저장 위치를 확보했다.
일부 수치가 선언과 다르며, 이후 모드/무기/서버 상태에 의해 덮어써지는지는 아직 확인하지 않았다.

## CMoveMgr 객체 후보와 초기화

`0x180ef0aa0`은 전달된 객체 포인터를 global `0x181a2b600`에 보관한다.
이 전역은 같은 코드 군에서 사용되고, `0x180f01740`이
`[CMoveMgr] CheckThroughWorldEndLess - CP_DAMAGE`를 출력하므로
**CMoveMgr 관련 객체의 초기화 후보**로 연결했다. top-level `CMoveMgr` RTTI 이름은 아직 찾지 못했다.
파일 문자열에는 `.?AVCheckCanMoveDataObject@CMoveMgr@@`라는 중첩 타입 흔적이 있다.

초기화 함수는 `0x180f031e0(index)`를 0..6 인자로 호출하여 float를 다음 위치에 저장하는 블록을 포함한다.

| index | switch branch | 반환 초기 스칼라 | 객체 저장 오프셋 |
|---|---|---:|---|
| 0 | 0x180f03265 | 180 | +0xf8 |
| 1 | 0x180f03335 | 330 | +0x100 |
| 2 | 0x180f033e1 | 250 | +0xf4 |
| 3 | 0x180f03478 | 567 | +0xb8 |
| 4 | 0x180f03478 | 567 | +0xbc |
| 5 | default 0x180f03644 | 0 | +0xc0 |
| 6 | 0x180f035a3 | 300 | +0x104 |

**각 필드의 의미와 단위는 미확인이다.** 180을 walk speed, 567을 jump speed라고 이름 붙이지 않았다.
함수 자체는 90·10·50의 float literal, 2/3/4/5/7 배수·가산 및 짧은 copy/get/set wrapper로
위 값을 계산한다. wrapper 함수의 실제 바이트가 단순 저장/읽기인지 검증했고,
Ghidra의 switch 의사코드와도 일치했다.

`tools/movement_defaults_probe.py`는 이 계산만 독립적으로 재현한다. 타깃 CPU 코드를 실행하지 않는다.
관찰 결과는 `evidence/movement-initial-scalars.json`이며 다음 명령으로 별도 새 파일에 재생성할 수 있다.

```powershell
python tools/movement_defaults_probe.py --output evidence/movement-initial-scalars-new.json
python -m unittest tools.test_movement_defaults_probe -v
```

주의할 한계: `0x180ef0aa0`의 할당 성공 분기는 보호된 `0x18206ccc4`로 넘어간다.
Ghidra는 그 경로의 이어지는 효과를 완전히 복원하지 못하고 별도 반환처럼 표시한다.
그러므로 위 저장 블록의 실제 runtime 도달성과 실행 시점은 아직 미확인이다.
독립 구현은 이를 최종 물리 규칙으로 바로 채택하면 안 된다.

## reset과 콘솔 변수 소비의 실제 연결

초기화 블록에서 다음으로 호출되는 `0x180ef9550`은 여러 상태를 지우고 일부 값을 설정한다.
그 중 객체 `+0x118`에는 비트패턴 `0xc4fa0000`을 저장한다(float로 해석하면 -2000).
`+0x94`에는 `0x3f800000`(float 1)이 들어간다. 아직 이를 중력·보정 배율로 단정하지 않는다.
두 context 검사 `0x180c72040` / `0x180c720b0`가 모두 0일 때 내부 트리 컨테이너를 비우는 분기도 있다.

`0x180ef0aa0`에는 다음 이름과 실제 엔진 함수 포인터 호출이 연결되어 있다.

| 이름 | 바이트 관찰 |
|---|---|
| HeartBeatOnSpeed | global+0x228 함수포인터로 조회, 없으면 문자열 `0.305f`를 설정하는 경로 |
| walkaccmul | double 1.0을 `%5f`로 포맷한 뒤 조회/필요시 설정 |
| WindRedesign | 동일한 기본값 생성·조회/설정 형태 |

이 초기화 경로는 문자열 존재 이상의 근거다. 다만 `walkaccmul` handle을 프레임 이동 계산에 사용하는 함수는 아직 연결하지 않았다.
`0x180f6c8f0`는 global `0x181a0e320`의 `+0x9b0`가 있을 때
`0x1800887f0(object, "PLAYER_MOVE_SPEED_MULTIPLY")`를 호출하고 double 결과를 float로 변환해 출력 주소에 쓴다.
객체가 없으면 0, 성공 경로는 1을 반환한다. 이 항목의 원천 객체·기본값·모드 적용과 최종 속도 사용은 미확인이다.

## 월드 검사와 필터

`0x180f01740(self, P, D)`는 3성분 float 벡터 두 개를 읽으며
첫 검사 구간의 양 끝을 다음 형태로 구성한다.

```text
start = P + D
end   = P + 10000 * D
```

엔진 가상 슬롯 `+0x210`을 통해 검사한다. 처음 실패하면 x 방향 ±24,
z 방향 ±24를 각각 더한 네 구간을 추가 검사한다. y 방향은 같은 방식으로 옮기지 않는다.
다섯 검사 모두 실패하는 분기는 메시지 객체를 만들어 엔진 `+0x3a8` 호출로 넘긴다.
관찰된 연속 쓰기에는 `0x77`, `2`, `5`, 비트패턴 `0x47c35000`, 벡터 `(0,-1,0)`, `0`, `0`, `3`이 있다.
필드의 정확한 프로토콜 이름과 서버측 소비는 아직 미확인이고, 네트워크 요청은 실행하지 않았다.
이 함수는 이름과 동작상 월드 바깥 검사 후보이며 일반적인 매 프레임 플레이어 충돌 해결 함수로 동일시하지 않는다.

검사 설정에는 두 콜백이 연결된다.

- `0x180f036e0`: 입력 두 포인터가 같은 non-null 값이면 1. 그 외 엔진 객체 flag 조회를 통해
  selector 2의 `0x01000000` 비트가 꺼졌는지, selector 0의 bit0이 켜지고 bit15가 꺼졌는지를 검사한다.
  flag의 원래 enum 이름은 복원하지 않았다.
- `0x180f03760`: `0x180d4a140()`의 반환값이 `0xca` 또는 `0xf5`이면 0, 그 외면 1.
  두 상수의 재질/표면 enum 이름은 아직 미확인이다.

## 입력 콜백의 남은 연결

CSAGameClientShell primary vtable에서 `+0xc8 → 0x180c07be0`, `+0xc0 → 0x180c07c80`은
EDX 입력 번호를 보존해 다른 관리 객체로 전달하는 짧은 콜백이다.
원래 command on/off 이름과 입력 action 선언 ID 대응은 아직 확인 중이다.
`+0xa0`, `+0xb0`의 메서드는 raw key 처리를 의심할 비교가 있으나 같은 이유로 확정하지 않았다.
`+8`, `+0x10`은 최초 후보였지만 bool/상태 전달 형태여서 이동 action 진입점으로 채택하지 않았다.

`0x181a2b600` 전역에 대한 RIP-relative LEA/MOV 패턴 후보는 515개다.
`evidence/movement-singleton-ref-candidates.json`은 그 범위와 주소를 보존한다.
패턴 일치만으로 모든 행을 검증된 xref나 함수 호출로 주장하지 않는다.
`0x180c07ce0`의 source-backed 코드에는 해당 전역을 읽어 `0x180ef9490`, `0x180ef8c20` 등을
호출하는 연결이 있으나, 이 함수는 조건부 메시지 처리 형태여서 일반 Update로 명명하지 않았다.

## 근거 파일과 다음 우선순위

REA/Ghidra 근거:

- `evidence/movement-init-ghidra.json`
- `evidence/movement-constant-selector-ghidra.json`
- `evidence/movement-init-followup-ghidra.json`
- `evidence/movement-speed-multiplier-ghidra.json`
- `evidence/movement-endless-world-check-ghidra.json`
- `evidence/movement-world-intersection-a-ghidra.json`, `movement-world-intersection-b-ghidra.json`

원본 바이트 대조:

- `evidence/movement-entry-native-code.json`
- `evidence/movement-default-switch-arms.json`
- `evidence/movement-default-wrapper-code.json`, `movement-scalar-value-wrappers.json`
- `evidence/movement-input-dispatch-candidates.json`

다음은 필드 `+0xf8/+0x100/+0xf4/+0xb8/+0xbc/+0xc0/+0x104`의 소비·덮어쓰기 함수와
input action → movement flags의 실제 경로를 연결하는 것이다. 그 뒤에만 속도·점프·축·단위를
이름 붙이고 원본 근거를 가진 독립 이동 코어로 구현할 수 있다.

## Action 7 → run 비트 → 속도 선택의 확인된 구간 (2026-11-11)

`client_core/native_input.py`의 `poll_run_control_bit`은 normal-controls 함수의
`0x180efa892..0x180efa924` 구간만 재생한다. 전체 입력/이동 상태 머신을 대신하지 않는다.
이 구간 진입 전 UI·캐릭터·모드 gate가 통과했다는 전제는 호출자가 책임지고 전달한다.

- player `+0x458`이 가리키는 첫 DWORD가 0이 아니면 이 구간은 run flag를 설정하지 않는다.
- mode `0x13`에서는 객체 `+0xdc`가 0일 때 action 7 조회를 건너뛴다.
- 그 외 조회 경로에서 action 7의 **원본 byte**와 `int(+0xdc != 0)`이 다르면
  현재 flags `+0x8c`에 `0x200`을 OR한다.
- mode `0x36`에서 `0x180f8c590`의 반환값이 정확히 1인 경우에도 `0x200`을 OR한다.
  반환값 2를 같은 것으로 해석하지 않는다. 이 helper의 상위 상태는 아직 supplied 값이다.
- 이 구간에는 run bit를 clear하는 쓰기가 없다. 프레임 시작의 flag 초기화와 구분한다.
- setter `0x180ef48b0`은 EDX를 `+0xdc`에 그대로 저장한다. 독립 모델도 0/1로
  제한하지 않고 int32를 받은 뒤 조건에 필요한 `!= 0`만 계산한다.

중요한 의사코드와 실제 바이트 차이: Ghidra는 action 결과 비교를 bool cast처럼 표시하지만,
`0x180efa8db`의 `MOVZX ECX, AL` 다음 `CMP ECX, EAX`는 원래 byte를 보존한다.
예를 들어 supplied command byte가 200이고 `+0xdc`가 1이면 200과 1은 다르므로
run bit가 설정된다. 양쪽을 Python bool로 바꾸는 XOR 구현은 이 입력에서 원본과 달라진다.
실제 장치가 200을 기록하는지까지 관찰했다는 뜻은 아니다.

이 결과를 기존 `movement_limit`의 supplied flags에 넘기는 연결 검사도 추가했다.
action 7이 `0x200`을 만든 경우 일반 조건에서 `+0x100` 스칼라를 선택하지만,
같은 flags에 duck `0x20`이 있으면 `+0xf8`을 선택한다. 테스트의 180/330 값은
기존 초기 스칼라 예시이며 새로운 이동 규칙이나 최종 runtime 값으로 채택한 수치가 아니다.

근거:

- normal-controls Ghidra: `evidence/movement-normal-controls-ghidra.json`,
  `ev_70eab8203e5cf8208bbfd337a8da4cf493a7e864b23b4bd5c62900ab61bd662d`.
- setter Ghidra: `evidence/movement-runlock-toggle-ghidra.json`,
  `ev_4121fd8c4097d004c725f84c9bef2cb487f82cd2aefc24112094e4cf51bb6325`.
- `evidence/movement-run-control-contract.json`: 현재 CShell 해시를 다시 계산한 뒤
  16개 명령 앵커와 zero register 초기화·setter를 직접 파일 바이트로 검사한 로컬 기록.
  이 파일에 새 REA Evidence ID를 임의 부여하지 않았다.
- 원본 CShell SHA-256은 이 문서 첫머리와 같으며, 원본 게임/DLL 실행은 하지 않았다.

```powershell
python tools/run_control_probe.py --output evidence/movement-run-control-contract-new.json
python -m unittest client_core.test_native_input client_core.test_movement_limits -v
```

검증: 위 코어 22개 검사 통과. raw byte 비교, runlock 반전, mode/weapon gate,
정확히 1인 override, gated 조회 생략, 기존 flags 보존 및 속도 선택 연결을 포함한다.
실제 key/device→command byte 쓰기·상위 normal path 도달·최종 가속/충돌/점프는 여전히 미확인이다.

## 입력 fragment의 원본 순서와 후속 덮어쓰기

기존 편의 함수들을 단순히 나열한 결과를 완전한 원본 frame으로 간주하면 안 된다.
`0x180ef9f70`의 static 분기와 `0x180efa3f0` 내부에서 확인된 순서는 다음과 같다.

| 구간 | 확인된 효과 | 독립 구현의 범위 |
|---|---|---|
| `0x180ef9f7e..0x180ef9f94` | current `+0x8c`를 previous `+0xe4`로 복사하고 current=0. actor `+0x20`가 없어도 이 쓰기는 수행 | `begin_control_frame` |
| outer의 상태 분기 | 한 경로는 normal-controls 호출, 다른 경로는 `+0x40` flags를 current에 직접 복사. 직접 복사한 flags의 jump bit가 있으면 `+0x46c`=1 | 상위 경로 자동 선택 미구현 |
| normal의 앞부분 | UI·모드 gate 후 action 10/11이 `0x8/0x4`를 OR. duck 설정·해제·복원 분기 수행 | `poll_basic_direction_bits`는 query→mask 관찰 묶음이며 실제 순서를 온전히 재생하지 않음 |
| `0x180efa892..0x180efa924` | 조건부 action 7 비교와 mode `0x36` override가 `0x200`을 OR | `poll_run_control_bit` |
| 그 이후 | jump query/latch, mode별 추가 상태 변경, `0x180f02170` 호출 | 상위 상태와 helper 효과 미구현 |
| `0x180efabf4..0x180efaccf` | 별도 gate 후 action 0/1/14/13, strafe 확장, activity summary, jump rising edge latch 쓰기 | `poll_basic_direction_bits`의 나머지 매핑 + `postprocess_control_flags`. 중간 gate를 건너뛰는 전체 프레임 API는 제공하지 않음 |
| normal 반환 후 outer mode `0x50` 분기 | 추가 lookup과 `0x180e9d200`이 성공하면 current mask 필터와 previous duck 복원. jump latch를 0으로 덮어씀 | caller-gated `mode_50_control_filter` |
| outer 말미 | player `+0x458` 포인터의 두 번째 DWORD를 current에 OR | 외부 입력으로 구분하며 별도 원천 상태 미복원 |

mode `0x50` 필터의 실제 쓰기는 `0x180efa1de..0x180efa1ff`에 있다.

```text
current = (current & 0xfdfcf400) | (previous & 0x20)
jump_latch(+0x46c) = 0
```

이 필터는 normal-controls가 이미 만든 run `0x200`, jump `0x10`, activity `0x800` 등을
지울 수 있다. current의 duck은 지우고 previous의 duck만 가져온다.
`postprocess_control_flags`를 이 뒤에 다시 호출하는 원본 단계는 확인되지 않았으므로
필터가 지운 summary나 jump latch를 편의상 재생성하지 않는다.
더 늦은 player flags OR가 run bit 등을 다시 추가할 수도 있다. 따라서 직전에 설명한
action→속도 선택 검사는 **supplied flags의 데이터 의존성 검사**이며, 모든 외부 쓰기까지
포함한 최종 입력 frame이나 physics update의 실제 호출 순서를 검증한 결과가 아니다.

근거 파일은 `evidence/movement-control-frame-ghidra.json` 및
`ev_7e8c9c6762365e2f8b5dca5a3fceccf58643925aa9b7216e93584ef82d4ec4a2`다.
`tools/run_control_probe.py`를 확장하여 기존 run 16개와 순서 관련 16개 명령 앵커를
현재 CShell 바이트에서 대조했고, `evidence/movement-run-control-contract-v2.json`에
선택된 frame 쓰기·분기·호출을 저장했다. 원래 v1 보고서는 그대로 보존한다.

추가 검사 2개는 normal의 jump latch 1이 mode 필터의 0으로 덮이는 순서,
previous duck만의 복원 및 필터 뒤 summary 재생성 부재를 검증한다.
`python -m unittest client_core.test_native_input client_core.test_movement_limits -v`는
현재 **24개 통과**한다. runtime frame 스케줄, helper 내부 쓰기, 외부 flags 원천 및
실제 서버/플레이어 상태의 선택은 계속 미확인이다.

## 입력·속도 fragment 독립 재검토

새 run/mode filter와 `movement_limit`을 기존 REA 의사코드 및 현재 파일 바이트와
대조한 결과, 이 제한된 입력 프로파일 안에서 확정할 수 있는 구현 오류는 찾지 못했다.
정수 문맥은 native int32, flags는 uint32, command 결과는 원본 byte를 보존한다.
`movement_limit`의 유한 scalar 제한은 Python 모델의 검증 범위이며 원본이 NaN·무한대나
float32 overflow를 동일하게 거부한다는 뜻은 아니다. 그러한 입력의 원본 SSE 예외·
rounding mode·FTZ/DAZ 동작은 현재 검증 범위에 포함하지 않는다.

`evidence/movement-max-velocity-review-flow.json`에 같은 CShell 해시의 직접 분기
153개 명령을 저장했다. `0x180ef2140/2144`는 두 번의 SUBSS이므로
`selected - (selected - slow)`를 단순히 slow 값 선택으로 바꿀 수 없다.
float32 supplied selected=100000000, slow=1에서는 결과가 0이 되는 경우를
검사에 추가했다. 또한 `0x180ef2233..223f`의 non-mode-D fallback은 cvar를
그대로 유지하지 않고 `max(override, 0)`으로 덮어쓰며,
`0x180ef2250/2259`는 `(1-penalty)*selected` 뒤에 0 clamp를 하지 않는다.
penalty=2이면 음수 limit가 나오는 supplied 입력도 원본 연산대로 보존한다.

이 세 가지 경계 검사 추가 후 입력·속도 코어 검사는 **27개 통과**한다.
앞서 추가한 연결 검사는 특정 fragment를 supplied 상태에서 비교하기 위한 것이며,
원본 runtime의 도달 여부나 모든 mode에서의 frame 호출 순서를 가정하지 않는다.
