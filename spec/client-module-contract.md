# 현재 버전 엔진 ↔ CShell 계약

이 문서는 원본을 실행하지 않고 기존 REA/Ghidra 결과와 원본 PE 바이트를 대조한 결과다.
구현 대상은 현재 설치본이며, 아래 주소는 ASLR 전 선호 이미지 기준이다.
기계용 상세 기록은 [client-module-contract.json](client-module-contract.json),
새 바이트 관찰은 [module-contract-static-probe-v2.json](../evidence/module-contract-static-probe-v2.json)에 있다.

## 확인한 핵심 연결

엔진이 부르는 CShell은 `InitClientShellDE`라는 export가 아니다. 그 문자열은 로더의 진단 라벨이다.
완전한 CShell export 목록 125개에는 `SetMasterDatabase`와 Lua 계열 124개가 있고,
`InitClientShellDE`는 없다. 실제 연결은 **공유 인터페이스 레지스트리의 이름과 버전**을 통해 이뤄진다.

```text
engine module binder 0x140073ea0
  → optional export SetMasterDatabase(master_registry)
  → module-local interface registrations linked to master registry

CShell static initializer 0x180019a50
  → register(object=0x181952b30, name="IClientShell.Default", version=4)

engine typed holders subscribe to the same name/version:
  holder 0x1403feac0  → destination 0x1403fe650  → virtual callback calls
  holder 0x140406208  → destination 0x140406160  → shell-loader presence check
```

엔진의 두 전역 포인터가 같은 레지스트리 이름/버전에서 공급되는 별도 목적지임을 소스 바이트로 연결했다.
`0x14001a6b0`과 `0x14001b9e0`의 초기화는 둘 다 `r8d=4`를 설정한다.
typed holder의 vtable `0x1403042a8`에서:

| 슬롯 바이트 오프셋 | 함수 | 관찰 |
|---|---|---|
| +0x08 | 0x140077320 | holder+0x18에 저장된 목적지 포인터를 0으로 지움 |
| +0x10 | 0x140077330 | 같은 목적지에 RDX를 저장 |
| +0x18 | 0x140077340 | 같은 목적지의 현재 포인터를 반환 |

이 연결은 기존 의사코드에서 이름을 모르는 `DAT_1403fe650`과 `DAT_140406160`의 역할을 좁힌다.
레지스트리의 검색·충돌·버전 협상 전체 구현과 실행 시 공급 성공은 아직 별도 검증 대상이다.

## 실제 제공 클래스와 가상 호출 대상

별도 static initializer `0x180019a90`가 등록된 동일 객체 주소 `0x181952b30`을
생성자 `0x180566560`에 전달한다. 생성자는 primary vtable `0x181520a88`을 기록한다.
그 vtable의 RTTI Complete Object Locator는 `0x1816b5978`, TypeDescriptor는 `0x18192afa8`이다.
파일에 기록된 원래 맹글링은 `.?AVCSAGameClientShell@@`이며 기저 클래스 배열은 다음과 같다.

```text
CSAGameClientShell → CGameClientShell → IClientShellStub → IClientShell → IBase
```

RTTI 타입명·vtable 포인터와 생성자 쓰기는 실제 바이트 관찰이다.
아래 메서드 이름은 엔진의 인접 로그를 바탕으로 붙인 설명이며 심볼 복원 결과는 아니다.

| primary 슬롯 | 현재 대상 | 엔진에서 관찰한 용도 | 추가 관찰 |
|---|---|---|---|
| +0x40 | 0x180566860 → 0x180c03580 | `OnEnginePreInit` 로그; 0이 아니면 초기화 종료 | 후반 직접 분기 추적이 보호된 간접 분기에 도달, 본문 전체는 미확인 |
| +0x48 | 0x180566740 | `OnEngineInitialized` 로그; 엔진 반환값으로 사용 | 0x180c03ae0 반환값을 저장하고 추가 초기화 수행 |
| +0x120 | 0x180c06ae0 | `InitStartLogo` 로그 | 0이면 두 엔진 플래그를 켜고 성공 반환, 0이 아니면 fallback |
| +0x140 | 0x180c06980 | 위 fallback의 첫 호출 | this+0x100a0..0x100e0의 qword 9개와 +0x10458 dword를 0으로 지움 |
| +0x170 | 0x180c0ce90 | NXGSM 인스턴스 전달 로그 | `mov [rcx+0x21fe0],rdx; ret` |
| +0x180 | 0x180c02820 | `EAC Start` 로그 | 보호된 간접 분기 이후 처리는 미확인 |

vtable에서 읽은 50개 포인터는 선택한 prefix다. vtable 전체 길이가 50이라고 주장하지 않는다.
원본의 보호된 초기화·외부 서비스 흐름을 독립 구현에서 그대로 호출하거나 우회하는 코드는 작성하지 않았다.

## 모듈 로더의 호출 계약

`0x1400bef00`은 client manager의 `+0x32e0`, `+0x32e8`, `+0x32f0`을 0으로 만든다.
`cshell.dll`을 `0x1400bdc40`으로 해석하고 `0x140073ea0`으로 바인딩해 `+0x32f0`에 보관한다.
`0x140406160`의 인터페이스 공급 여부를 검사한 뒤 `cres.dll`을 해석하고 `+0x32e0`에 바인딩한다.
선택적 다른 인터페이스 `DAT_140406168`의 vtable+8에는 CShell binding을 전달한다.
이 별도 인터페이스의 타입과 `cres.dll` 계약은 아직 미확인이다.

| 함수 | 관찰한 결과 값 |
|---|---|
| 파일 해석 0x1400bdc40 | 0 성공, 0이 아니면 복사/해석 실패 |
| 모듈 바인딩 0x140073ea0 | 0 실패, 0xffffffff 성공 |
| 셸 로더 0x1400bef00 | 0 성공; 0x1d/0x1e/0x4c의 실패 경로 |

바인더는 아직 로드되지 않은 모듈일 때 이름 `SetMasterDatabase`를 조회하고,
있으면 `0x1400e3330`의 반환값을 단일 포인터 인자로 전달한다. 이 반환값은
무기/설정 선언 DB로 해석하지 않는다. CShell의 `SetMasterDatabase(0x1803d5ba0)`와
Object.lto의 `SetMasterDatabase(0x180019680)`은 0x48 바이트 모듈 로컬 상태와
0x18 바이트 포인터/양방향 링크 단위를 사용해 master registry에 연결되는 형태다.
인자가 NULL이면 즉시 반환하며, 엔진은 반환값을 사용하지 않는다.

성공한 바인딩 레코드는 0x30 바이트다. `+0`에 모듈 핸들, `+8`에 32비트 상수 1,
`+0x10`부터 경로용 문자열 상태가 있다. `+8`을 참조 카운트라고 단정하지 않는다.
resource resolver의 복사 플래그가 켜졌을 때만 경로를 문자열에 보관한다.

## 초기화 순서

1. `0x14007a2f0`: resource tree 목록과 config 경로를 구성한다. 기본 이름은 `autoexec.cfg`, `display.cfg`다.
2. `0x14008fc10` → `0x140091d30`: `.pkg` 관리자를 먼저 준비한다.
3. 최대 40개 resource tree를 연결한다. 0개면 0x39, 연결 실패면 0x1b 경로가 있다.
4. `0x1400bef00`: CShell → 인터페이스 공급 검사 → cres 순서로 준비한다.
5. 셸 포인터가 있으면 `+0x170`, `+0x180` 호출을 수행하고 그 뒤 로더 반환값을 검사한다.
6. 콘솔/입력 관련 준비 후 config 파일들을 execution flag 2로 재생하고 command-line override를 같은 flag로 적용한다.
7. 다시 config 파일들과 override를 execution flag 1로 적용한다. 앞서 구현된 두 패스 설정 코어와 연결되는 순서다.
8. 렌더 초기화 후보 블록 및 sound 관련 준비 후 `+0x40`을 호출한다. 이 구조체의 완전한 필드 타입은 미확인이다.
9. `+0x120`의 0 결과면 초기화 성공 플래그를 설정한다. 그 외에는 `+0x140` → `+0x48` fallback으로 간다.

초기화 전체를 막연히 `InitClientShellDE()` 하나로 구현하면 인터페이스 공급·두 패스 config·로고 지연 분기를 잃는다.
독립 구현은 위 확인된 순서와 각 단계의 입력·출력부터 분리해야 한다.

## Object.lto의 별도 진입점

`ObjectDLLSetup`은 실제 export이고 주소는 `0x180018210`이다.
선택한 함수 바이트에서는 다음 계약을 관찰했다.

```text
RCX = uint32 출력 class count 주소
RDX = opaque engine 포인터 → module global 0x180690760에 저장
R8  = uint32 출력 주소 → 상수 1 기록
RAX 반환 = 등록 포인터 배열
```

등록 리스트 head는 `0x180611960`; node+0의 등록 포인터를 node+8의 다음 링크를 따라 센 뒤
8바이트 포인터 배열을 만들고 `0x180611968`에 보관한다.
이를 class-definition 등록 목록으로 해석하는 것은 관찰된 동작에 따른 추론이다.
배열 원소의 정확한 C++ 구조와 엔진의 실제 호출측은 아직 연결하지 않았다.

## 구현에 바로 옮길 수 있는 것과 다음 조사

지금 확정한 것은 이 설치본의 **인터페이스 이름/버전, 공급 객체, engine holder, 선택된 vtable 슬롯**이다.
첫 독립 코어는 `IClientShell.Default v4`라는 계약과 두 패스 설정 순서를 명시적으로 보존할 수 있다.
원본 DLL을 로드하는 호환 셸이나 빈 함수로 성공을 흉내내는 구현은 아직 만들지 않는다.

다음 조사는 `0x180c03580`, `0x180c03ae0`, `0x180c06ae0`의 실제 초기화와
ILTClient/ILTRender/ILTDrawPrim 등의 소비 인터페이스 이름·버전·메서드 연결이다.
그 뒤 메뉴 상태 머신과 renderer가 필요로 하는 입력·리소스 계약을 좁힐 수 있다.

## 검증과 제한

재현 도구:

```powershell
python tools/module_contract_probe.py --output evidence/module-contract-static-probe-new.json
python -m unittest tools.test_module_contract_probe -v
```

도구는 세 바이너리의 SHA-256이 현재 고정한 버전과 일치할 때만 관찰을 생성한다.
기존 REA Evidence ID는 JSON의 `evidence`/관찰 파일의 `source_evidence`에 보존했다.
새 Capstone 관찰에는 REA Evidence ID를 임의로 붙이지 않았다.
보호된 간접 분기, 설정/리소스의 실제 runtime 적용, 서버 의존 상태 및 실행 순서 대조는 미완료다.
