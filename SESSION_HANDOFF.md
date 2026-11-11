# 진행 목표와 사용자 지시

## 최신 재개 결과 (2026-11-11, Saturate 비교)

- 아래의 이전 세션 번호·PID·작성 중 표시는 과거 기록이다. 이번 턴에서는 기존 프로세스에 의존하지 않았다.
- `client_core/world_ui/viewer.js`, `index.html`: 원본 lightmap 소비 코드의 Saturate 분기를 두 비교 모드로 반영했다. 2배 합성은 lightmap이 대응된 면에만 적용한다.
- `spec/world-render-notes.md` 마지막 절: 상태 setter·분기 주소·업로드 형식·미해결 간접 dispatch를 기록했다.
- 새 정적 기록: `evidence/engine-native-lightmap-pixel-format-flow.json`. 원본 EXE 해시 검증 후 직접 바이트를 읽었으며 게임/DLL은 실행하지 않았다.
- 검증: `python -m unittest client_core.test_world_viewer -v` 5개 통과, `node --check client_core/world_ui/viewer.js` 통과.
- Chrome 브라우저에서 로드 및 comparison/saturate/lightmap/saturate 전환 완료. 이벤트 오류 0, 텍스처 실패 0, 원본 mip 284개 로드.
  `evidence/warehouse-render-saturate-browser.json`, REA `ev_bb844bba0235859177041da6c9e8a520e4dd2556786945e447a3d327676d8b6a`.
- 다음 작업: `0x1401ffc10` jump table과 pixel converter dispatch를 명시적으로 풀어 저장 triplet의 최종 색 채널을 검증한다. 실제 Saturate 값·안개·원본 최종 픽셀 일치는 아직 미확인이다.

- 현재 설치된 서든어택 버전의 클라이언트 동작·리소스를 재현하는 것이 목표다.
- 정적 분석은 그 구현을 위한 근거 수집이며, 임의의 연습 게임으로 대체하지 않는다.
- 사용자는 자리를 비운 동안 상태를 주기적으로 검사하고 사용 가능한 토큰 한도까지 계속 작업하라고 지시했다.
- 컴퓨터 종료 요청은 이후 취소되었다. **자동 종료 명령을 실행하지 않는다.**
- 현재 REA stdio 세션: tools/rea_session.py --tag full-access-check (exec session 76996).
- CShell Ghidra 시작 제한 330초 실패 후 런타임 설정 1,200,000ms로 늘려 재시작했다.
  진행 요청: 0x180d9fc70 procedure_pseudo_code, 저장 예정 evidence/hitmarker-mode-eligibility-1200s-code.json.
- 권한 변경 후 새 프로세스에서 open_binary 성공. 과거 권한 오류 기록은 현재 상태가 아니다.
- 조사 중 Java PID는 10432였으며 재확인 후 사용해야 한다. 원본 게임/DLL은 실행하지 않는다.

## 이번 지속 작업의 결과 (갱신 중)

- 원본 ware_house.dat 충돌 기하·객체 복원: spec/world-format-notes.md, tools/world_dat.py,
  evidence/warehouse-world-structure-v2.json, previews/warehouse-collision-mesh.json.
- 엔진↔CShell 인터페이스 계약: module_contract 에이전트가 spec/client-module-contract.* 작성 중.
- 모델 스킬 비트 경로: ShowHitMarker→bit18→180d9fc70→1811d4010.
  tools/native_slice.py로 원본 바이트를 따라간 결과 evidence/cshell-*-flow.json에 보존했다.
- spec/model-skill-flags.json에 25개 필드/비트 및 조건부 MyEmotionView를 복원했다.
  client_core/model_skills.py는 주어진 상태의 비트 누적/HitMarker 게이트 모델이며 아직 검증·확장 중.
- 새 확인: Bute GetInt는 타입1만, GetBool은 타입4만 허용하고 불일치는 기본값 반환.
  modelbutes의 JumpSound=0(정수)은 bool false와 같은 것으로 단정하면 안 된다.

## 남은 즉시 작업

1. 모델 선언 입력의 타입 구분과 불일치 기본값을 구현/검사하고 원본 선언 전체에 적용한다.
2. 원본 PhysicsBSP를 시각적으로 확인하는 읽기 전용 뷰어 연결 (임의 게임플레이 없음).
3. Ghidra 상태 검사; 성공 시 같은 세션을 재사용해 모델 스킬·명중 이벤트·입력 이동 소비 함수 추적.
4. source hash/분석 프로파일/증거 ID/미확인을 보고서에 갱신한다.
