# 진행 목표와 사용자 지시

## 종료 정리 (2026-11-12, 사용자 요청)

- 사용자가 개발 중단·정리·커밋을 요청했다. 추가 개발은 중단한 상태다.
- 날짜별 전체 진행 기록은 `PROGRESS_BY_DATE.md`에 모았다. 원본 복원과 중단된 practice 프로토타입을 구분했다.
- 코드 최신 검증은119개 통과이며, 이후 추가분은 `engine-world-alpha-state-v1.json`과 종료 문서다.
- 새 정적 관찰: 초기 ALPHAFUNC=7과 달리 world draw `0x1401b9d20`은 `0x1401ba26b..27b`에서5(GREATER)를 설정한다. 초기값만으로 AlphaRef 비교 경계를 정하지 않는다.
- `0x1402058d0`: blend=0, CL이 nonzero일 때만 ZWRITE=1. CL=0은 기존 depth-write 상태를 유지한다.
- `0x1402057a0`: blend=1/ZWRITE=0. CL=0이면 SRCALPHA/INVSRCALPHA, nonzero이면 ONE/ONE. 객체 선택 gate와 월드 정적 geometry에 이 helper가 적용되는 전체 경로는 아직 분리 조사 중이다.
- 위 상태 관찰을 뷰어 alpha 처리 변경에는 적용하지 않았다. 원본 실행·새 GUI 서버 시작 없이 정리했다.

## 최신 검증 fallback 후속 (2026-11-12)

- `shader_validation_fallback` 및 `resolve_shader_validation` 추가. native failure table:7→1→0,12→1→0,11→0,15→14→12→1→0 등.20개 allocation candidate 전부 검사.
- `engine-warehouse-shader-candidate-v3.json`:17개 method, 모든 failure target,0의 Validate=상수 byte1, section pre-bind 경로 기록. 할당 실패와 cache/삭제는 코어 범위 밖이다.
- 원본 candidate0의 failure target은 자기재시도지만 정상 Validate가항상1이므로 allocation 성공 조건에서 종료. 이를 실제 OOM 처리 구현이라고 해석하지 않는다.
- section loader request는+0x18, pre-bind의 bound shaderID는+0x1c로 다르다.0x1401eef50이 null일때21,그외GetShaderID/preview callback을 쓰는 경로 확인.
- 앞 절의 'fallback 미확인'은 전이 순서에 한해 해소됐다. 실제 장치 결과,Preview/draw scheduling,최종 alpha/framebuffer state는 여전히 미확인.
- 최신 검증: client_core104 + world_render12 + input_command_probe3 =119개 통과. diff 공백 검사 통과. 이번 턴에서 연 로컬 뷰어 서버와 provider-owned Chrome은 모두 종료했다.

## 최신 재료 선언/Fullbright 작업 (2026-11-12)

- `texture_material.py`: DTX header 선언→RTexture flags 및 조건부 shader state. native mapping `(flags&1)|((flags>>9)&0xe)`. raw offset32가 아니라 internal flags offset16에서 온다.
- 원본 TextureData(header+4)와 SharedTexture+0x10의 RTexture를 구분했다. 빈/AlphaRef-only 명령만 지원하며 unknown command를 일반 texture로 처리하지 않는다.
- `engine-texture-material-producers-v1.json`:7함수/1378명령 실제바이트 대조 독립검토 완료. `engine-texture-material-bind-v1.json`은 bind/create 소비 코드.
- `audit_texture_materials.py`/`warehouse-material-candidate-replay-v1.json`:75 DTX 해시확인, Fullbright14, AlphaRef 명령4. supplied fresh/success 조건에서 code1 sections164 = candidate1 144 + candidate7 20.
- factory probe에 candidate7 Fullbright RTTI를 추가해 `engine-warehouse-shader-candidate-v2.json` 생성.
- Fullbright stage1은 BLENDCURRENTALPHA: factor=texture.a*vertex.a. stage0 clamp 후 texture RGB와 lit RGB를 섞고 alpha를 유지. 코어와 viewer checkbox로 비교 가능.
- 뷰어는 DTX SHA도 확인하고 material metadata를 공급한다. relocation 검사에 source DTX75개도 포함했다.
- 최신검사: client_core101 + world_render12 + input_command_probe3 =116 통과, JS문법 통과. 브라우저 Fullbright off/on/Saturate 완료, 오류0, mip284,누락/실패0. REA `ev_a1361e41c21f9b3467791235b442274dd80b78c8838b8c512802f43e47286b75`.
- AlphaRef 숫자 의미는 공개 atoi/WORD 비교와 실제 captured 선언에 한정. 원본 간접 converter 함수이름은 미해결. 최종 opaque/alpha-test/framebuffer-blend/검증fallback는 미확인이다.
- 다음우선: world pass의 ALPHAFUNC/ALPHABLENDENABLE 경로. 초기 state 함수 후보0x1401987a0은 state0x19에7(GREATEREQUAL)을 전달하는 바이트 후보가 있으나 world draw 시점까지 연결하지 않았고 아직 근거파일/구현에 채택하지 않았다.

## 최신 후속 (2026-11-12, 정점과 셰이더 후보)

- `spec/native-render-contract.md`에 다음 경로와 근거를 모았다. 부모/독립 검토 완료 후 기록.
- `engine-render-vertex-loader-v1.json`: 헤더 버전>=85를 전역에 저장. loader는 count*68 할당 후 vertex reader 반복. 버전85는44바이트만, >=86은68바이트 읽기.
- `client_core/render_vertex.py`: 뒤24바이트 미기록을 None으로 보존. Gouraud16/Gouraud_Texture36 출력 복사. 실제19332개 전부 대조 통과.
- `warehouse-vertex-copy-replay-v1.json`:39 block source/output stream hash. 이전 절의 loader→확장 vertex 연결 미확인은 이번에 앞44바이트 범위에서 해소됐다. 후속 tail 생성/조명 변경은 미확인.
- `render_shader.py`: 저장code1/2/4→요청0/11/12. jump table 및 factory selector/할당 분기를 직접 읽어 요청 이후 후보를 구분했다.
- `warehouse_shader_candidate`: 요청0/11/12의 pre-validation 후보만 supplied texture/feature 상태로 계산. mode4/bump off/env on→14의 jump를 독립 검토에서 수정하고 교차검사 추가.
- `engine-render-shader-code-v1.json`, `engine-warehouse-shader-candidate-v1.json`에 native table bytes/선택 flow/RTTI 기록. texture 상태 producer, cache/Validate 실패 fallback와 실제 device 선택은 미확인.
- 뷰어 scene API에 `native_requested_shader_ids` 추가. 검증 전 후보를 실제 runtime shader로 자동 채택하지 않는다.
- 최신 검증: client_core 96개 + world_render 12개 + input_command_probe 3개 = 111개 통과. 정점/후보 독립 검토 반영, git diff 공백 검사 통과.
- 다음: texture+0x38/+0x3c 및 pixel-data+0x24의 producer를 추적. 전체 가속/충돌/점프와 최종 렌더 픽셀도 여전히 미확인.

## 최신 지속 작업 (2026-11-11, 업로드 비교와 입력 후속 쓰기)

- `client_core/lightmap.py`: 설치본 lightmap format 선택과 6개 candidate의 tightly-packed 업로드. 32BitLightMaps!=0이면 20→22→21, 이어 24→25, 모두 실패하면 unchecked 23. HRESULT는 정확히0만 성공이다.
- 16비트 quantization은 floor(channel*max/255)이며 단순 bit truncation이 아니다. 32비트 BGR0, 24비트 native copy의 R/B 반전도 구현했다. 실제 장치 format은 미확인.
- `tools/lightmap_selection_probe.py`/`evidence/engine-lightmap-selection-v1.json`: selection·lookup 생성·convar 초기화 바이트 기록. 이전 Saturate default=1.0은 옆 Bilinear를 잘못 연결한 오류였다. 실제 default float는 `0x1403eaca0`의0.0이다. `engine-render-saturate-corrected-v1.json` 참고. 과거 보고서는 보존.
- `tools/audit_lightmap_upload.py`/`evidence/warehouse-lightmap-upload-replay-v1.json`: 원본27개에서 형식별 업로드 hash. 21/22 RGB roundtrip0, 16비트 nearest8bit maxerror8, 24bitR/B차이56.
- 뷰어 업로드 비교 추가. 원본 DAT 해시/decoded triplet 해시를 확인하고 allowlist된 binary endpoints 제공. GL packed16 texture로 필터링 전에 양자화. source/worldmodel 배열은 변경하지 않았다.
- REA browser `ev_dacf9423ca429344672d97d54dbcf34e67175d61207ac5e707b6d03b3935770d`: comparison과20→24→23→21 모두완료, errors0, native mips284/실패0. 저장 PNG `previews/warehouse-lightmap-upload-32.png`.
- `native_input.poll_run_control_bit`: action7 raw byte != int(runlock!=0), mode/weapon gate와 OR-only 보존. `mode_50_control_filter`: normal 후 mask0xfdfcf400 및 previous duck 복원, jump latch=0. 마지막 외부OR가 다시비트를 쓸수있다. 전체 frame으로 조합하지 않는다.
- 근거 `evidence/movement-run-control-contract-v2.json`: CShell 해시와32앵커 대조. 부모가 재실행한 결과도 byte-for-byte 같았다.
- 후속 Gouraud_Texture 코드도 Saturate에 따라 MODULATE/MODULATE2X를 선택하고 alpha는 일반 곱셈임을 확인했다. 뷰어에 반영. `evidence/engine-gouraud-color-contract-v1.json` 참고.
- 입력 속도 float32 경계 검토 및 검사 3개 추가. `evidence/movement-max-velocity-review-flow.json`은 현재 CShell의 153 명령을 보존한다.
- 최신 검증: client_core 85, world_render 12, input_command_probe 3 = 100개 통과. JS 문법 통과. Gouraud/Saturate+RGB565 브라우저 전환도 오류 0. `ev_c94fead1205b32d33b95e57a8f3e30a22220a095b89f73b6d4ed0df355b5034d`.
- 원본 EXE/DLL은 실행하지 않았다. source vertex stride 0x44(68바이트)와 DAT 44바이트를 혼동하지 않는다. loader→확장 runtime vertex의 전체 연결은 미확인이다.
- 다음: 정점 조명 소비/셰이더 합성의 남은 차이, 입력 helper/상위 gate 추적. 실제 runtime format과 최종화면·전체 physics는 여전히 미확인이다.

## 최신 결과 (2026-11-11, 색 채널과 다른 노트북 재개)

- GitHub `JunhoLeeee/rea_sudden`의 main에 초기 작업을 보존했다. `CONTINUE_ON_LAPTOP.md` 참고.
- `tools/lightmap_format_probe.py`와 `evidence/engine-lightmap-format-dispatch-v1.json`: 45개 format case, type8 converter table 및 각 target의 정적 decode.
- type8→3 변환은 source RGB를 destination BGR0으로 쓴다. 현재 PNG RGB를 유지하는 것이 이 경로와 맞다. 실제 장치의 format 선택·16비트 변환·최종 픽셀은 미확인.
- 뷰어와 render audit에 남은 이전 PC의 lightmap 절대 경로 의존성을 제거했다. 증거 파일과 mesh hash는 유지한다.
- 검증: world viewer 7개(실제 임시 폴더 재배치 포함), world render 12개 통과.
- 다음 작업: texture 생성 시 선택되는 D3D format 후보와 장치 지원에 따른 선택 분기를 확인하고, 16비트 변환·정점 조명 경로의 범위를 좁힌다.
- 이전 절의 '간접 dispatch 미해결'은 이번 절에서 32비트 경로에 한해 해소했다. 과거 PID/세션 번호는 재사용하지 않는다.

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
