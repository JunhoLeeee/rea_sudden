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

다음 렌더 조사 대상은 엔진 `0x1401ffc10`의 jump table과 `0x140126ca0`의 pixel converter dispatch다. 저장 lightmap triplet의 최종 색 채널을 확인하기 전 임의로 뒤집지 않는다. 게임/DLL을 실행하지 않고 원본 바이트를 정적으로 분석한다.

코드·증거·추출 자료·미리보기는 함께 보존한다. 원본 전체 설치 파일과 REA/Ghidra 분석 환경 자체는 포함하지 않는다. 원본 EXE·패키지 재분석 및 일부 통합 검사는 같은 버전의 서든어택 설치가 필요하다. 도구의 기본 설치 경로는 주로 `C:\Nexon\SuddenAttack`이며 입력 해시가 다르면 같은 빌드로 간주하지 않는다.

`tools/rea_session.py`의 Node/REA/Ghidra/JDK 경로는 이전 PC에 맞춰져 있다. 다른 노트북에서는 연결된 REA 도구를 사용하거나 해당 경로를 실제 설치 위치에 맞춘다. 과거 세션 번호·증거의 로컬 절대 경로·PID는 기록이며 재사용 가능한 실행 상태가 아니다. 자동 컴퓨터 종료 지시는 취소된 상태다.
