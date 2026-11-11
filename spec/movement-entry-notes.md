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
