# 원본 모델 스킬 비트와 명중 표시 조건

대상은 현재 추출 CShell.dll SHA-256
`099d69b5b3af0562ebde39094a5daa72cf2cea455a91625fedb06f55c2300110`다.
원본 DLL은 실행하지 않았다. 파일 바이트의 Capstone 해석과 동일 빌드의 REA/Ghidra 의사코드를 대조했다.

## 실제 연결

```text
modelbutes section의 ShowHitMarker
  -> 0x180d9fef0에서 GetInt(..., default=0)
  -> 값이 nonzero이면 skill index 0x12 전달
  -> 0x180da03b0에서 record+0x2e88에 uint64 bit18 OR

HitMarker 활성 검사 0x1806db1c0
  -> 필요한 두 전역 포인터가 존재하는지 검사
  -> 현재 문맥에서 모델 ID와 server index를 얻는 호출
  -> 0x180d9fc70에서 내부 객체 +0x2828을 가져와
     0x1811d4010(..., serverIndex, modelId, skillIndex=0x12)로 전달
  -> 모델 인덱스 범위 검사, 기본 모델/재설정 모델의 skillset 선택
  -> bit18 확인
  -> client context+0x3122 바이트가 nonzero인지 추가 확인
```

모델 레코드 배열의 관찰된 stride는 `0x2f10`이다.
`0x180d9f8f0`는 레코드 `+0x2e80`의 bit6을 읽어 재설정 모델 경로를 선택하는 데 사용한다.
기본 모델은 `0x180d9fd90`에서 해당 레코드 `+0x2e88`의 flags를 복사한다.
재설정 모델은 `0x1811d41a0 -> 0x1811d4290`을 통해 별도 매칭 결과를 읽는다.
원본 에러 문자열이 `CModelSkillMgr::getMatchedSkillset`, `serverIndex`, `modelId`, `skillIndex`라는 이름을 제공한다.
기본 스킬셋/모드별 fallback까지 포함한 전체 매칭 컨테이너는 아직 독립 구현하지 않았다.

현재 모델 선택 함수 `0x180c71f40`은 context+0x154c의 override 또는 +0x1544의 두 항목을 읽고
추가 상태에 따라 다른 resolver를 호출한다. `0x180c736d0`에는 보호된 경로가 있고 Ghidra가
반환 형식을 완전히 복원하지 못한다. 이를 임의의 server index나 일정한 반환값으로 대체하지 않았다.

## 확인한 getter 타입 계약

- `0x1813277d0` GetInt: 값 객체의 타입 DWORD가 1일 때만 +8의 정수를 반환한다.
- `0x181327c30` GetBool: 타입 DWORD가 4일 때만 +8의 바이트를 반환한다.
- 다른 타입은 `Type mismatch` 진단 후 호출자가 제공한 기본값으로 돌아간다.
- 기본값은 대부분 0이지만 `JumpSound`는 bool true다. 이 필드는 false일 때 bit14를 설정한다.
- `0x180da03b0`은 bit를 OR하며 false 선언으로 기존 bit를 지우지 않는다.
- Emotion bit9를 설정하는 경우에만 MyEmotionView를 읽어 bit29를 설정하고, 별도의 float offset도 읽는다.
  Ghost bit11의 문자열 경로/offset 같은 추가 효과는 flags 코어에서 구현했다고 주장하지 않는다.

기계용 필드 매핑은 [model-skill-flags.json](model-skill-flags.json)에 있다.
25개 직접 필드와 조건부 MyEmotionView가 포함된다. 원래 철자 `EmotionSndCustum`도 보존한다.

## 독립 구현과 선언 재생

`client_core/model_skills.py`의 범위:

- 이미 해석된 field 값을 대상으로 원본 bit 누적을 재생한다.
- typed declaration adapter는 Python int와 bool을 구분하며, 타입 불일치 시 기본값과 issue를 반환한다.
- HitMarker 조건은 존재 플래그·옵션 바이트·모델 범위·base/matched flags를 명시적으로 전달받아 평가한다.
- 현재 서버 상태·선택 캐릭터·재설정 협상·원본 객체 포인터를 만들어내지 않는다.

`tools/compile_model_skills.py`는 원본 modelbutes.txt의 3,940개 section을 직접 재생했다.
출력은 `evidence/model-skill-declarations.json`이다. ShowHitMarker 직접 선언은 780개이며
그 중 원문 1은 186개, 0은 594개다. 이 숫자를 현재 플레이 가능한 캐릭터 개수로 해석하지 않는다.
상속/alias/모드 적용은 따로 검증해야 한다.

직접 선언의 로컬 토큰 타입 분류와 getter 타입 계약을 적용하면 JumpSound의 숫자형 선언 10개가
bool getter의 기본값을 사용하는 것으로 분류된다. 원본 lexer의 전체 토큰 타입 배정까지
재현한 결과는 아니므로 현재 원본 실행 시 효과를 확정하는 근거로 단독 사용하지 않는다.

## 근거와 검증

| 원본 관찰 | 저장 파일 | REA Evidence ID |
|---|---|---|
| field->bit 로더 | model-skill-bute-load-ghidra.json | ev_268880864b6e5e18e96ec3b9b7d3d4ffdcb56d61b539983be7d128255b767193 |
| OR-only setter | model-skill-set-bit-ghidra.json | ev_602097c59e46b5fa636be5ad2985354d8749d1172ed0ee26ba7112a4d5bb1186 |
| bit query | model-skill-flag-test-ghidra.json | ev_541e75c39bcacf6f8dafc6dbf5b96a31f07bc333b97ed89d615c5cd3797241cc |
| skillset resolver | model-skill-resolve-ghidra.json | ev_f19c1f21be405548780628ba149f87943875f2ef537327405c1e546e7b0458aa |
| typed GetInt | bute-get-int-ghidra.json | ev_abff2c33298053c03b7cde189a582c24c4448955149d3ee7dc50fe3658b8c61e |
| typed GetBool | bute-get-bool-ghidra.json | ev_2157b7c2ff50e0e42f5ed1c1a186ba58c614ba0f1dcfc681aae61c8133e710c5 |

위 파일은 모두 `evidence/` 아래에 있으며 분석 프로파일과 한계가 원문으로 들어 있다.
switch/RTTI 관련 두 expensive analyzer를 끈 프로파일이므로 이름/타입/간접 흐름의 불완전성을 유지한다.
Capstone 관찰은 `cshell-model-*-flow.json`, `cshell-hitmarker-flag-reader-flow.json`에 별도로 보존했다.

```powershell
python -m unittest client_core.test_model_skills -v
python tools/compile_model_skills.py --output new-model-skill-declarations.json
```

8개 코어 검사는 bit18, OR-only, 조건부 Emotion, 반전 JumpSound, typed default,
필수 문맥·모델 범위·재설정 flags 선택 및 입력 범위 오류를 검증한다.
이는 위 부분의 독립 모델 검사이며 원본 클라이언트 전체와의 동등성 검사는 아니다.
