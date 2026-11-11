# 다른 노트북에서 재개

```powershell
git clone https://github.com/JunhoLeeee/rea_sudden.git
cd rea_sudden
python -m client_core.world_viewer
```

Python 3.10 이상과 WebGL2 지원 브라우저를 사용한다. 뷰어는 저장소에 포함된 추출 자료를 사용하며 추가 Python 패키지가 필요 없다.

정적 분석 도구의 선택 의존성:

```powershell
python -m pip install -r requirements-analysis.txt
python -m unittest client_core.test_world_viewer client_core.test_model_skills client_core.test_native_input client_core.test_movement_limits -v
```

## 작업 상태

먼저 `SESSION_HANDOFF.md`의 최신 절과 `spec/world-render-notes.md`, `spec/movement-entry-notes.md`를 읽는다. 최신 구현은 원본 웨어하우스 메쉬·텍스처·mip·lightmap 및 Saturate 비교 모드다. 원본 게임 전체를 재현한 상태는 아니다. `practice*`는 중단된 임의 연습 게임이며 복원 목표에 포함하지 않는다.

형식 jump table, converter dispatch, 16비트 lookup과 lightmap format 선택은 후속 조사로 해소했다. `client_core/lightmap.py`, `evidence/engine-lightmap-selection-v1.json` 참고. PNG는 32비트 변환과 같은 RGB를 유지한다. 24비트 native copy의 R/B 반전과 16비트 양자화는 뷰어의 업로드 비교로 확인할 수 있다. 실제 장치의 선택·필터링·원본 최종 픽셀은 미확인이다.

Saturate 기본값 1.0이라는 과거 기록은 옆 Bilinear 레코드를 잘못 연결한 것이었다. 초기화 코드를 확인한 정정값은 0.0이다. 과거 증거는 보존하고 새 정정 보고서로 구분했다. 실행 중 설정값을 관찰한 것은 아니다.

입력 코어는 action 7→run 비트와 mode 0x50의 후속 덮어쓰기까지 구현했다. 전체 frame/physics가 아니며 각 fragment 사이 gate와 helper를 건너뛰어 조합하지 않는다. 다음 조사에서는 정점 조명 소비와 입력 helper의 실제 효과를 좁힌다. 게임/DLL을 실행하지 않고 원본 바이트를 정적으로 분석한다.

코드·증거·추출 자료·미리보기는 함께 보존한다. 원본 전체 설치 파일과 REA/Ghidra 분석 환경 자체는 포함하지 않는다. 원본 EXE·패키지 재분석 및 일부 통합 검사는 같은 버전의 서든어택 설치가 필요하다. 도구의 기본 설치 경로는 주로 `C:\Nexon\SuddenAttack`이며 입력 해시가 다르면 같은 빌드로 간주하지 않는다.

`tools/rea_session.py`의 Node/REA/Ghidra/JDK 경로는 이전 PC에 맞춰져 있다. 다른 노트북에서는 연결된 REA 도구를 사용하거나 해당 경로를 실제 설치 위치에 맞춘다. 과거 세션 번호·증거의 로컬 절대 경로·PID는 기록이며 재사용 가능한 실행 상태가 아니다. 자동 컴퓨터 종료 지시는 취소된 상태다.
