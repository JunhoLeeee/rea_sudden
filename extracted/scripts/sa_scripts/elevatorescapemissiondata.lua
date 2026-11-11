
function Init()
	LSInclude("sa_scripts/ActionEventLua_AI_Data.lua")
	LSInclude("sa_scripts/ElevatorEscapePerkData.lua")
end

----------------------------------------------------------------------------------------------------
-- 게임 시작 시 가지고 있을 무기.
----------------------------------------------------------------------------------------------------
PrimaryWeapon		= -1
SecondaryWeapon		= 1588
MeleeWeapon		= 0
ThrowWeapon		= 3065
UsedWeapon		= 3064

----------------------------------------------------------------------------------------------------
-- 게임 시작 플레이어 HP. 기본 hp100에서 더 해지는 hp값.
----------------------------------------------------------------------------------------------------
PlayerAddHP		= 0

----------------------------------------------------------------------------------------------------
-- 층 갯수.
----------------------------------------------------------------------------------------------------
TOTAL_FLOOR = 100


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- 함정 제한시간 종료 대미지
----------------------------------------------------------------------------------------------------
TrapTimeDamage = 5

----------------------------------------------------------------------------------------------------
-- 빈사 남은 시간
----------------------------------------------------------------------------------------------------
Dying_RemainTime = 45

----------------------------------------------------------------------------------------------------
-- 층 이동 연출
----------------------------------------------------------------------------------------------------
-- N층 시작 시 컷신을 보여주고 싶으면 N-1층을 입력해야한다.
-- 컷신은 1층 시작 시, 25층 시작 시, 50층 시작 시 출력된다.

function GetCutSceneIndex(CurrentFloor)	-- 컷신 보여주는 시간 (1)
	return -1, 0.0			-- 컷신이 없음.
end

function GetCutSceneFileName(CutSceneIndex)		-- 컷신 파일 이름
	if CutSceneIndex == 0 then
		return "0200.bik"			-- 컷신 파일의 위치는 SA폴더가 기본이라 game폴더 이하에서 넣을 경우 수동으로 지정해줘야 함
	end
	if CutSceneIndex == 1 then
		return "0201.bik"			-- 컷신 파일의 위치는 SA폴더가 기본이라 game폴더 이하에서 넣을 경우 수동으로 지정해줘야 함
	end
	if CutSceneIndex == 2 then
		return "0202.bik"			-- 컷신 파일의 위치는 SA폴더가 기본이라 game폴더 이하에서 넣을 경우 수동으로 지정해줘야 함
	end	
	return "0101.em"
end

ChangeFloor_FadeOutTime = 1.0			-- 페이드 아웃 시간 (2)
ChangeFloor_ElevatorSoundTime = 3.0		-- 엘레베이터 사운드 들리는 시간 (3) 사운드가 두개인데 두개의 합
ChangeFloor_ElevatorSoundTime2 = 1.0	-- 엘레베이터 사운드 첫번째거 들리는 시간 그 이후 두번째 것 들림
ChangeFloor_FadeInTime = 1.0			-- 페이드 인 시간 (4)
ChangeFloor_FloorNotiTime = 1.0			-- 층 알려주는 시간 (5)
ChangeFloor_ChapterTime = 3.0			-- 챕터를 알려주는 시간
ChangeFloor_MandateFadeOutTime = 3.0	-- 방장 위임때 맨처음 까만화면으로 기다림. 그 이후에는 엘리베이터 사운드

UIChangeFloor_ChapterBackX = 200			-- 챕터 배경 UI 표시 오프셋
UIChangeFloor_ChapterBackY = 70
UIChangeFloor_ChapterBackWidth = 512		-- 리소스의 크기
UIChangeFloor_ChapterBackHeight = 128

UIChangeFloor_ChapterX = 250				-- 챕터 숫자 UI 표시 오프셋, 이 값은 챕터 배경 UI에서 상대적임.
UIChangeFloor_ChapterY = 14					
UIChangeFloor_ChapterDiff = 30				-- 두자리수나 세자리수 일때 간격
UIChangeFloor_ChapterWidth = 64				-- 리소스의 크기
UIChangeFloor_ChapterHeight = 64

UIChangeFloor_RemainFloorX = 250			-- 앞으로 몇 층 남았습니다. 표시
UIChangeFloor_RemainFloorY = 550
UIChangeFloor_RemainFloorTime = 1.5			-- 보여주는 시간

SCENE_FLOOR = 50							-- 총 100층이지만 50층은 일종의 초기 경험을 하는 층으로 바뀜

ElevatorSound1 = "SA_Interface2/Snd/Elevator/SYSTEM/EXIT_ElevatorClose.wav"
ElevatorSound2 = "SA_Interface2/Snd/Elevator/SYSTEM/EXIT_ElevatorAlarm.wav"
ChangeFloor_ElevatorOpenSoundRadius = 800		--엘레베이터 문열리는 소리 범위

-- 엘리베이터  층 표시하는 3D UI데이터
ChangeFloor_FloorNumber_Forward = 0		-- 앞으로 얼마나 튀어나오는지
ChangeFloor_FloorNumber_Up = 0				-- 위로 얼마나 올라가는지
ChangeFloor_FloorNumber_Back = -11   		-- 백의 자리 수 가로 오프셋
ChangeFloor_FloorNumber_Ship =  3.8			-- 십의 자리 수 가로 오프셋
ChangeFloor_FloorNumber_One = 18.5		    -- 1의 자리 수 가로 오프셋
ChangeFloor_FloorNumber_Width = 20			-- 숫자의 가로
ChangeFloor_FloorNumber_Height = 20			-- 숫자의 세로 크기

----------------------------------------------------------------------------------------------------
--  구간 스테이지 갯수.
----------------------------------------------------------------------------------------------------
SECTION_STAGE_COUNT = 10

----------------------------------------------------------------------------------------------------
-- 스테이지 갯수.
----------------------------------------------------------------------------------------------------
STAGE_COUNT = 7

----------------------------------------------------------------------------------------------------
-- 구간 스테이지 타입 선정을 위한 배열.
----------------------------------------------------------------------------------------------------
Section_Stage_Info = {}

Section_Stage_Info[1] = {}
Section_Stage_Info[1].Name = "StageType1"
Section_Stage_Info[1].Probability = 100
Section_Stage_Info[1].BattleStageMax = 70
Section_Stage_Info[1].BattleStageMin = 50
Section_Stage_Info[1].FarmingStageMax = 20
Section_Stage_Info[1].FarmingStageMin = 15
Section_Stage_Info[1].PuzzleStageMax = 30
Section_Stage_Info[1].PuzzleStageMin = 25

Section_Stage_Info[2] = {}
Section_Stage_Info[2].Name = "StageType2"
Section_Stage_Info[2].Probability = 0
Section_Stage_Info[2].BattleStageMax = 70
Section_Stage_Info[2].BattleStageMin = 50
Section_Stage_Info[2].FarmingStageMax = 20
Section_Stage_Info[2].FarmingStageMin = 15
Section_Stage_Info[2].PuzzleStageMax = 30
Section_Stage_Info[2].PuzzleStageMin = 25

Section_Stage_Info[3] = {}
Section_Stage_Info[3].Name = "StageType3"
Section_Stage_Info[3].Probability = 0
Section_Stage_Info[3].BattleStageMax = 70
Section_Stage_Info[3].BattleStageMin = 50
Section_Stage_Info[3].FarmingStageMax = 20
Section_Stage_Info[3].FarmingStageMin = 15
Section_Stage_Info[3].PuzzleStageMax = 30
Section_Stage_Info[3].PuzzleStageMin = 25


----------------------------------------------------------------------------------------------------
-- 구간 스테이지 타입의 리스트 이름을 반환한다.
----------------------------------------------------------------------------------------------------
function GetSectionStageListName()

	strSectionStageListName = "Section_Stage_Info"

	return strSectionStageListName

end

----------------------------------------------------------------------------------------------------
-- 구간 스테이지 타입의 리스트 갯수를 반환한다. 배열변수 앞에 #을 붙이면 갯수가 반환된다.
----------------------------------------------------------------------------------------------------
function GetSectionStageListCount()

	nCount = #Section_Stage_Info

	return nCount
end


----------------------------------------------------------------------------------------------------
-- 스테이지1 스폰포인트 배열.  --엘레베이터, 플레이어 스폰포인트 설정
----------------------------------------------------------------------------------------------------
 
 
 
Stage1_SpawnPoint_Info = {}

Stage1_SpawnPoint_Info[1] ={}
Stage1_SpawnPoint_Info[1].Area = "GameStartArea1_1"
Stage1_SpawnPoint_Info[1].Position = "Bottom"
Stage1_SpawnPoint_Info[1].Probability = 100
Stage1_SpawnPoint_Info[1].Door = "MovableModel1_1"
Stage1_SpawnPoint_Info[1].StartRoom = "EventArea1_1_1"
Stage1_SpawnPoint_Info[1].SpawnPointCount = 8
Stage1_SpawnPoint_Info[1].SpawnPoint_1 = "GameStartPoint1_1_1"
Stage1_SpawnPoint_Info[1].SpawnPoint_2 = "GameStartPoint1_1_2"
Stage1_SpawnPoint_Info[1].SpawnPoint_3 = "GameStartPoint1_1_3"
Stage1_SpawnPoint_Info[1].SpawnPoint_4 = "GameStartPoint1_1_4"
Stage1_SpawnPoint_Info[1].SpawnPoint_5 = "GameStartPoint1_1_01"
Stage1_SpawnPoint_Info[1].SpawnPoint_6 = "GameStartPoint1_1_02"
Stage1_SpawnPoint_Info[1].SpawnPoint_7 = "GameStartPoint1_1_03"
Stage1_SpawnPoint_Info[1].SpawnPoint_8 = "GameStartPoint1_1_04"	   
Stage1_SpawnPoint_Info[2] ={}
Stage1_SpawnPoint_Info[2].Area = "GameStartArea1_2"
Stage1_SpawnPoint_Info[2].Position = "Bottom"
Stage1_SpawnPoint_Info[2].Probability = 100
Stage1_SpawnPoint_Info[2].Door = "MovableModel1_2"
Stage1_SpawnPoint_Info[2].StartRoom = "EventArea1_1_2"
Stage1_SpawnPoint_Info[2].SpawnPointCount = 8
Stage1_SpawnPoint_Info[2].SpawnPoint_1 = "GameStartPoint1_2_1"
Stage1_SpawnPoint_Info[2].SpawnPoint_2 = "GameStartPoint1_2_2"
Stage1_SpawnPoint_Info[2].SpawnPoint_3 = "GameStartPoint1_2_3"
Stage1_SpawnPoint_Info[2].SpawnPoint_4 = "GameStartPoint1_2_4"
Stage1_SpawnPoint_Info[2].SpawnPoint_5 = "GameStartPoint1_2_01"
Stage1_SpawnPoint_Info[2].SpawnPoint_6 = "GameStartPoint1_2_02"
Stage1_SpawnPoint_Info[2].SpawnPoint_7 = "GameStartPoint1_2_03"
Stage1_SpawnPoint_Info[2].SpawnPoint_8 = "GameStartPoint1_2_04"	   
Stage1_SpawnPoint_Info[3] ={}
Stage1_SpawnPoint_Info[3].Area = "GameStartArea1_3"
Stage1_SpawnPoint_Info[3].Position = "Bottom"
Stage1_SpawnPoint_Info[3].Probability = 100
Stage1_SpawnPoint_Info[3].Door = "MovableModel1_3"
Stage1_SpawnPoint_Info[3].StartRoom = "EventArea1_1_3"
Stage1_SpawnPoint_Info[3].SpawnPointCount = 8
Stage1_SpawnPoint_Info[3].SpawnPoint_1 = "GameStartPoint1_3_1"
Stage1_SpawnPoint_Info[3].SpawnPoint_2 = "GameStartPoint1_3_2"
Stage1_SpawnPoint_Info[3].SpawnPoint_3 = "GameStartPoint1_3_3"
Stage1_SpawnPoint_Info[3].SpawnPoint_4 = "GameStartPoint1_3_4"
Stage1_SpawnPoint_Info[3].SpawnPoint_5 = "GameStartPoint1_3_01"
Stage1_SpawnPoint_Info[3].SpawnPoint_6 = "GameStartPoint1_3_02"
Stage1_SpawnPoint_Info[3].SpawnPoint_7 = "GameStartPoint1_3_03"
Stage1_SpawnPoint_Info[3].SpawnPoint_8 = "GameStartPoint1_3_04"	   
Stage1_SpawnPoint_Info[4] ={}
Stage1_SpawnPoint_Info[4].Area = "GameStartArea1_4"
Stage1_SpawnPoint_Info[4].Position = "Bottom"
Stage1_SpawnPoint_Info[4].Probability = 100
Stage1_SpawnPoint_Info[4].Door = "MovableModel1_4"
Stage1_SpawnPoint_Info[4].StartRoom = "EventArea1_1_4"
Stage1_SpawnPoint_Info[4].SpawnPointCount = 8
Stage1_SpawnPoint_Info[4].SpawnPoint_1 = "GameStartPoint1_4_1"
Stage1_SpawnPoint_Info[4].SpawnPoint_2 = "GameStartPoint1_4_2"
Stage1_SpawnPoint_Info[4].SpawnPoint_3 = "GameStartPoint1_4_3"
Stage1_SpawnPoint_Info[4].SpawnPoint_4 = "GameStartPoint1_4_4"
Stage1_SpawnPoint_Info[4].SpawnPoint_5 = "GameStartPoint1_4_01"
Stage1_SpawnPoint_Info[4].SpawnPoint_6 = "GameStartPoint1_4_02"
Stage1_SpawnPoint_Info[4].SpawnPoint_7 = "GameStartPoint1_4_03"
Stage1_SpawnPoint_Info[4].SpawnPoint_8 = "GameStartPoint1_4_04"	   
Stage1_SpawnPoint_Info[5] ={}
Stage1_SpawnPoint_Info[5].Area = "GameStartArea1_5"
Stage1_SpawnPoint_Info[5].Position = "Bottom"
Stage1_SpawnPoint_Info[5].Probability = 100
Stage1_SpawnPoint_Info[5].Door = "MovableModel1_5"
Stage1_SpawnPoint_Info[5].StartRoom = "EventArea1_1_5"
Stage1_SpawnPoint_Info[5].SpawnPointCount = 8
Stage1_SpawnPoint_Info[5].SpawnPoint_1 = "GameStartPoint1_5_1"
Stage1_SpawnPoint_Info[5].SpawnPoint_2 = "GameStartPoint1_5_2"
Stage1_SpawnPoint_Info[5].SpawnPoint_3 = "GameStartPoint1_5_3"
Stage1_SpawnPoint_Info[5].SpawnPoint_4 = "GameStartPoint1_5_4"
Stage1_SpawnPoint_Info[5].SpawnPoint_5 = "GameStartPoint1_5_01"
Stage1_SpawnPoint_Info[5].SpawnPoint_6 = "GameStartPoint1_5_02"
Stage1_SpawnPoint_Info[5].SpawnPoint_7 = "GameStartPoint1_5_03"
Stage1_SpawnPoint_Info[5].SpawnPoint_8 = "GameStartPoint1_5_04"	   
Stage1_SpawnPoint_Info[6] ={}
Stage1_SpawnPoint_Info[6].Area = "GameStartArea1_6"
Stage1_SpawnPoint_Info[6].Position = "Right"
Stage1_SpawnPoint_Info[6].Probability = 100
Stage1_SpawnPoint_Info[6].Door = "MovableModel1_11"
Stage1_SpawnPoint_Info[6].StartRoom = "EventArea1_1_5"
Stage1_SpawnPoint_Info[6].SpawnPointCount = 8
Stage1_SpawnPoint_Info[6].SpawnPoint_1 = "GameStartPoint1_6_1"
Stage1_SpawnPoint_Info[6].SpawnPoint_2 = "GameStartPoint1_6_2"
Stage1_SpawnPoint_Info[6].SpawnPoint_3 = "GameStartPoint1_6_3"
Stage1_SpawnPoint_Info[6].SpawnPoint_4 = "GameStartPoint1_6_4"
Stage1_SpawnPoint_Info[6].SpawnPoint_5 = "GameStartPoint1_6_01"
Stage1_SpawnPoint_Info[6].SpawnPoint_6 = "GameStartPoint1_6_02"
Stage1_SpawnPoint_Info[6].SpawnPoint_7 = "GameStartPoint1_6_03"
Stage1_SpawnPoint_Info[6].SpawnPoint_8 = "GameStartPoint1_6_04"	   
Stage1_SpawnPoint_Info[7] ={}
Stage1_SpawnPoint_Info[7].Area = "GameStartArea1_7"
Stage1_SpawnPoint_Info[7].Position = "Right"
Stage1_SpawnPoint_Info[7].Probability = 100
Stage1_SpawnPoint_Info[7].Door = "MovableModel1_22"
Stage1_SpawnPoint_Info[7].StartRoom = "EventArea1_2_5"
Stage1_SpawnPoint_Info[7].SpawnPointCount = 8
Stage1_SpawnPoint_Info[7].SpawnPoint_1 = "GameStartPoint1_7_1"
Stage1_SpawnPoint_Info[7].SpawnPoint_2 = "GameStartPoint1_7_2"
Stage1_SpawnPoint_Info[7].SpawnPoint_3 = "GameStartPoint1_7_3"
Stage1_SpawnPoint_Info[7].SpawnPoint_4 = "GameStartPoint1_7_4"
Stage1_SpawnPoint_Info[7].SpawnPoint_5 = "GameStartPoint1_7_01"
Stage1_SpawnPoint_Info[7].SpawnPoint_6 = "GameStartPoint1_7_02"
Stage1_SpawnPoint_Info[7].SpawnPoint_7 = "GameStartPoint1_7_03"
Stage1_SpawnPoint_Info[7].SpawnPoint_8 = "GameStartPoint1_7_04"	   
Stage1_SpawnPoint_Info[8] ={}
Stage1_SpawnPoint_Info[8].Area = "GameStartArea1_8"
Stage1_SpawnPoint_Info[8].Position = "Right"
Stage1_SpawnPoint_Info[8].Probability = 100
Stage1_SpawnPoint_Info[8].Door = "MovableModel1_33"
Stage1_SpawnPoint_Info[8].StartRoom = "EventArea1_3_5"
Stage1_SpawnPoint_Info[8].SpawnPointCount = 8
Stage1_SpawnPoint_Info[8].SpawnPoint_1 = "GameStartPoint1_8_1"
Stage1_SpawnPoint_Info[8].SpawnPoint_2 = "GameStartPoint1_8_2"
Stage1_SpawnPoint_Info[8].SpawnPoint_3 = "GameStartPoint1_8_3"
Stage1_SpawnPoint_Info[8].SpawnPoint_4 = "GameStartPoint1_8_4"
Stage1_SpawnPoint_Info[8].SpawnPoint_5 = "GameStartPoint1_8_01"
Stage1_SpawnPoint_Info[8].SpawnPoint_6 = "GameStartPoint1_8_02"
Stage1_SpawnPoint_Info[8].SpawnPoint_7 = "GameStartPoint1_8_03"
Stage1_SpawnPoint_Info[8].SpawnPoint_8 = "GameStartPoint1_8_04"	   
Stage1_SpawnPoint_Info[9] ={}
Stage1_SpawnPoint_Info[9].Area = "GameStartArea1_9"
Stage1_SpawnPoint_Info[9].Position = "Right"
Stage1_SpawnPoint_Info[9].Probability = 100
Stage1_SpawnPoint_Info[9].Door = "MovableModel1_44"
Stage1_SpawnPoint_Info[9].StartRoom = "EventArea1_4_5"
Stage1_SpawnPoint_Info[9].SpawnPointCount = 8
Stage1_SpawnPoint_Info[9].SpawnPoint_1 = "GameStartPoint1_9_1"
Stage1_SpawnPoint_Info[9].SpawnPoint_2 = "GameStartPoint1_9_2"
Stage1_SpawnPoint_Info[9].SpawnPoint_3 = "GameStartPoint1_9_3"
Stage1_SpawnPoint_Info[9].SpawnPoint_4 = "GameStartPoint1_9_4"
Stage1_SpawnPoint_Info[9].SpawnPoint_5 = "GameStartPoint1_9_01"
Stage1_SpawnPoint_Info[9].SpawnPoint_6 = "GameStartPoint1_9_02"
Stage1_SpawnPoint_Info[9].SpawnPoint_7 = "GameStartPoint1_9_03"
Stage1_SpawnPoint_Info[9].SpawnPoint_8 = "GameStartPoint1_9_04"	   
Stage1_SpawnPoint_Info[10] ={}
Stage1_SpawnPoint_Info[10].Area = "GameStartArea1_10"
Stage1_SpawnPoint_Info[10].Position = "Right"
Stage1_SpawnPoint_Info[10].Probability = 100
Stage1_SpawnPoint_Info[10].Door = "MovableModel1_55"
Stage1_SpawnPoint_Info[10].StartRoom = "EventArea1_5_5"
Stage1_SpawnPoint_Info[10].SpawnPointCount = 8
Stage1_SpawnPoint_Info[10].SpawnPoint_1 = "GameStartPoint1_10_1"
Stage1_SpawnPoint_Info[10].SpawnPoint_2 = "GameStartPoint1_10_2"
Stage1_SpawnPoint_Info[10].SpawnPoint_3 = "GameStartPoint1_10_3"
Stage1_SpawnPoint_Info[10].SpawnPoint_4 = "GameStartPoint1_10_4"
Stage1_SpawnPoint_Info[10].SpawnPoint_5 = "GameStartPoint1_10_01"
Stage1_SpawnPoint_Info[10].SpawnPoint_6 = "GameStartPoint1_10_02"
Stage1_SpawnPoint_Info[10].SpawnPoint_7 = "GameStartPoint1_10_03"
Stage1_SpawnPoint_Info[10].SpawnPoint_8 = "GameStartPoint1_10_04"	   
Stage1_SpawnPoint_Info[11] ={}
Stage1_SpawnPoint_Info[11].Area = "GameStartArea1_11"
Stage1_SpawnPoint_Info[11].Position = "Top"
Stage1_SpawnPoint_Info[11].Probability = 100
Stage1_SpawnPoint_Info[11].Door = "MovableModel1_60"
Stage1_SpawnPoint_Info[11].StartRoom = "EventArea1_5_5"
Stage1_SpawnPoint_Info[11].SpawnPointCount = 8
Stage1_SpawnPoint_Info[11].SpawnPoint_1 = "GameStartPoint1_11_1"
Stage1_SpawnPoint_Info[11].SpawnPoint_2 = "GameStartPoint1_11_2"
Stage1_SpawnPoint_Info[11].SpawnPoint_3 = "GameStartPoint1_11_3"
Stage1_SpawnPoint_Info[11].SpawnPoint_4 = "GameStartPoint1_11_4"
Stage1_SpawnPoint_Info[11].SpawnPoint_5 = "GameStartPoint1_11_01"
Stage1_SpawnPoint_Info[11].SpawnPoint_6 = "GameStartPoint1_11_02"
Stage1_SpawnPoint_Info[11].SpawnPoint_7 = "GameStartPoint1_11_03"
Stage1_SpawnPoint_Info[11].SpawnPoint_8 = "GameStartPoint1_11_04"	   
Stage1_SpawnPoint_Info[12] ={}
Stage1_SpawnPoint_Info[12].Area = "GameStartArea1_12"
Stage1_SpawnPoint_Info[12].Position = "Top"
Stage1_SpawnPoint_Info[12].Probability = 100
Stage1_SpawnPoint_Info[12].Door = "MovableModel1_59"
Stage1_SpawnPoint_Info[12].StartRoom = "EventArea1_5_4"
Stage1_SpawnPoint_Info[12].SpawnPointCount = 8
Stage1_SpawnPoint_Info[12].SpawnPoint_1 = "GameStartPoint1_12_1"
Stage1_SpawnPoint_Info[12].SpawnPoint_2 = "GameStartPoint1_12_2"
Stage1_SpawnPoint_Info[12].SpawnPoint_3 = "GameStartPoint1_12_3"
Stage1_SpawnPoint_Info[12].SpawnPoint_4 = "GameStartPoint1_12_4"
Stage1_SpawnPoint_Info[12].SpawnPoint_5 = "GameStartPoint1_12_01"
Stage1_SpawnPoint_Info[12].SpawnPoint_6 = "GameStartPoint1_12_02"
Stage1_SpawnPoint_Info[12].SpawnPoint_7 = "GameStartPoint1_12_03"
Stage1_SpawnPoint_Info[12].SpawnPoint_8 = "GameStartPoint1_12_04"	   
Stage1_SpawnPoint_Info[13] ={}
Stage1_SpawnPoint_Info[13].Area = "GameStartArea1_13"
Stage1_SpawnPoint_Info[13].Position = "Top"
Stage1_SpawnPoint_Info[13].Probability = 100
Stage1_SpawnPoint_Info[13].Door = "MovableModel1_58"
Stage1_SpawnPoint_Info[13].StartRoom = "EventArea1_5_3"
Stage1_SpawnPoint_Info[13].SpawnPointCount = 8
Stage1_SpawnPoint_Info[13].SpawnPoint_1 = "GameStartPoint1_13_1"
Stage1_SpawnPoint_Info[13].SpawnPoint_2 = "GameStartPoint1_13_2"
Stage1_SpawnPoint_Info[13].SpawnPoint_3 = "GameStartPoint1_13_3"
Stage1_SpawnPoint_Info[13].SpawnPoint_4 = "GameStartPoint1_13_4"
Stage1_SpawnPoint_Info[13].SpawnPoint_5 = "GameStartPoint1_13_01"
Stage1_SpawnPoint_Info[13].SpawnPoint_6 = "GameStartPoint1_13_02"
Stage1_SpawnPoint_Info[13].SpawnPoint_7 = "GameStartPoint1_13_03"
Stage1_SpawnPoint_Info[13].SpawnPoint_8 = "GameStartPoint1_13_04"	   
Stage1_SpawnPoint_Info[14] ={}
Stage1_SpawnPoint_Info[14].Area = "GameStartArea1_14"
Stage1_SpawnPoint_Info[14].Position = "Top"
Stage1_SpawnPoint_Info[14].Probability = 100
Stage1_SpawnPoint_Info[14].Door = "MovableModel1_57"
Stage1_SpawnPoint_Info[14].StartRoom = "EventArea1_5_2"
Stage1_SpawnPoint_Info[14].SpawnPointCount = 8
Stage1_SpawnPoint_Info[14].SpawnPoint_1 = "GameStartPoint1_14_1"
Stage1_SpawnPoint_Info[14].SpawnPoint_2 = "GameStartPoint1_14_2"
Stage1_SpawnPoint_Info[14].SpawnPoint_3 = "GameStartPoint1_14_3"
Stage1_SpawnPoint_Info[14].SpawnPoint_4 = "GameStartPoint1_14_4"
Stage1_SpawnPoint_Info[14].SpawnPoint_5 = "GameStartPoint1_14_01"
Stage1_SpawnPoint_Info[14].SpawnPoint_6 = "GameStartPoint1_14_02"
Stage1_SpawnPoint_Info[14].SpawnPoint_7 = "GameStartPoint1_14_03"
Stage1_SpawnPoint_Info[14].SpawnPoint_8 = "GameStartPoint1_14_04"	   
Stage1_SpawnPoint_Info[15] ={}
Stage1_SpawnPoint_Info[15].Area = "GameStartArea1_15"
Stage1_SpawnPoint_Info[15].Position = "Top"
Stage1_SpawnPoint_Info[15].Probability = 100
Stage1_SpawnPoint_Info[15].Door = "MovableModel1_56"
Stage1_SpawnPoint_Info[15].StartRoom = "EventArea1_5_1"
Stage1_SpawnPoint_Info[15].SpawnPointCount = 8
Stage1_SpawnPoint_Info[15].SpawnPoint_1 = "GameStartPoint1_15_1"
Stage1_SpawnPoint_Info[15].SpawnPoint_2 = "GameStartPoint1_15_2"
Stage1_SpawnPoint_Info[15].SpawnPoint_3 = "GameStartPoint1_15_3"
Stage1_SpawnPoint_Info[15].SpawnPoint_4 = "GameStartPoint1_15_4"
Stage1_SpawnPoint_Info[15].SpawnPoint_5 = "GameStartPoint1_15_01"
Stage1_SpawnPoint_Info[15].SpawnPoint_6 = "GameStartPoint1_15_02"
Stage1_SpawnPoint_Info[15].SpawnPoint_7 = "GameStartPoint1_15_03"
Stage1_SpawnPoint_Info[15].SpawnPoint_8 = "GameStartPoint1_15_04"	   
Stage1_SpawnPoint_Info[16] ={}
Stage1_SpawnPoint_Info[16].Area = "GameStartArea1_16"
Stage1_SpawnPoint_Info[16].Position = "Left"
Stage1_SpawnPoint_Info[16].Probability = 100
Stage1_SpawnPoint_Info[16].Door = "MovableModel1_50"
Stage1_SpawnPoint_Info[16].StartRoom = "EventArea1_5_1"
Stage1_SpawnPoint_Info[16].SpawnPointCount = 8
Stage1_SpawnPoint_Info[16].SpawnPoint_1 = "GameStartPoint1_16_1"
Stage1_SpawnPoint_Info[16].SpawnPoint_2 = "GameStartPoint1_16_2"
Stage1_SpawnPoint_Info[16].SpawnPoint_3 = "GameStartPoint1_16_3"
Stage1_SpawnPoint_Info[16].SpawnPoint_4 = "GameStartPoint1_16_4"
Stage1_SpawnPoint_Info[16].SpawnPoint_5 = "GameStartPoint1_16_01"
Stage1_SpawnPoint_Info[16].SpawnPoint_6 = "GameStartPoint1_16_02"
Stage1_SpawnPoint_Info[16].SpawnPoint_7 = "GameStartPoint1_16_03"
Stage1_SpawnPoint_Info[16].SpawnPoint_8 = "GameStartPoint1_16_04"	   
Stage1_SpawnPoint_Info[17] ={}
Stage1_SpawnPoint_Info[17].Area = "GameStartArea1_17"
Stage1_SpawnPoint_Info[17].Position = "Left"
Stage1_SpawnPoint_Info[17].Probability = 100
Stage1_SpawnPoint_Info[17].Door = "MovableModel1_39"
Stage1_SpawnPoint_Info[17].StartRoom = "EventArea1_4_1"
Stage1_SpawnPoint_Info[17].SpawnPointCount = 8
Stage1_SpawnPoint_Info[17].SpawnPoint_1 = "GameStartPoint1_17_1"
Stage1_SpawnPoint_Info[17].SpawnPoint_2 = "GameStartPoint1_17_2"
Stage1_SpawnPoint_Info[17].SpawnPoint_3 = "GameStartPoint1_17_3"
Stage1_SpawnPoint_Info[17].SpawnPoint_4 = "GameStartPoint1_17_4"
Stage1_SpawnPoint_Info[17].SpawnPoint_5 = "GameStartPoint1_17_01"
Stage1_SpawnPoint_Info[17].SpawnPoint_6 = "GameStartPoint1_17_02"
Stage1_SpawnPoint_Info[17].SpawnPoint_7 = "GameStartPoint1_17_03"
Stage1_SpawnPoint_Info[17].SpawnPoint_8 = "GameStartPoint1_17_04"	   
Stage1_SpawnPoint_Info[18] ={}
Stage1_SpawnPoint_Info[18].Area = "GameStartArea1_18"
Stage1_SpawnPoint_Info[18].Position = "Left"
Stage1_SpawnPoint_Info[18].Probability = 100
Stage1_SpawnPoint_Info[18].Door = "MovableModel1_28"
Stage1_SpawnPoint_Info[18].StartRoom = "EventArea1_3_1"
Stage1_SpawnPoint_Info[18].SpawnPointCount = 8
Stage1_SpawnPoint_Info[18].SpawnPoint_1 = "GameStartPoint1_18_1"
Stage1_SpawnPoint_Info[18].SpawnPoint_2 = "GameStartPoint1_18_2"
Stage1_SpawnPoint_Info[18].SpawnPoint_3 = "GameStartPoint1_18_3"
Stage1_SpawnPoint_Info[18].SpawnPoint_4 = "GameStartPoint1_18_4"
Stage1_SpawnPoint_Info[18].SpawnPoint_5 = "GameStartPoint1_18_01"
Stage1_SpawnPoint_Info[18].SpawnPoint_6 = "GameStartPoint1_18_02"
Stage1_SpawnPoint_Info[18].SpawnPoint_7 = "GameStartPoint1_18_03"
Stage1_SpawnPoint_Info[18].SpawnPoint_8 = "GameStartPoint1_18_04"	   
Stage1_SpawnPoint_Info[19] ={}
Stage1_SpawnPoint_Info[19].Area = "GameStartArea1_19"
Stage1_SpawnPoint_Info[19].Position = "Left"
Stage1_SpawnPoint_Info[19].Probability = 100
Stage1_SpawnPoint_Info[19].Door = "MovableModel1_17"
Stage1_SpawnPoint_Info[19].StartRoom = "EventArea1_2_1"
Stage1_SpawnPoint_Info[19].SpawnPointCount = 8
Stage1_SpawnPoint_Info[19].SpawnPoint_1 = "GameStartPoint1_19_1"
Stage1_SpawnPoint_Info[19].SpawnPoint_2 = "GameStartPoint1_19_2"
Stage1_SpawnPoint_Info[19].SpawnPoint_3 = "GameStartPoint1_19_3"
Stage1_SpawnPoint_Info[19].SpawnPoint_4 = "GameStartPoint1_19_4"
Stage1_SpawnPoint_Info[19].SpawnPoint_5 = "GameStartPoint1_19_01"
Stage1_SpawnPoint_Info[19].SpawnPoint_6 = "GameStartPoint1_19_02"
Stage1_SpawnPoint_Info[19].SpawnPoint_7 = "GameStartPoint1_19_03"
Stage1_SpawnPoint_Info[19].SpawnPoint_8 = "GameStartPoint1_19_04"	   
Stage1_SpawnPoint_Info[20] ={}
Stage1_SpawnPoint_Info[20].Area = "GameStartArea1_20"
Stage1_SpawnPoint_Info[20].Position = "Left"
Stage1_SpawnPoint_Info[20].Probability = 100
Stage1_SpawnPoint_Info[20].Door = "MovableModel1_6"
Stage1_SpawnPoint_Info[20].StartRoom = "EventArea1_1_1"
Stage1_SpawnPoint_Info[20].SpawnPointCount = 8
Stage1_SpawnPoint_Info[20].SpawnPoint_1 = "GameStartPoint1_20_1"
Stage1_SpawnPoint_Info[20].SpawnPoint_2 = "GameStartPoint1_20_2"
Stage1_SpawnPoint_Info[20].SpawnPoint_3 = "GameStartPoint1_20_3"
Stage1_SpawnPoint_Info[20].SpawnPoint_4 = "GameStartPoint1_20_4"
Stage1_SpawnPoint_Info[20].SpawnPoint_5 = "GameStartPoint1_20_01"
Stage1_SpawnPoint_Info[20].SpawnPoint_6 = "GameStartPoint1_20_02"
Stage1_SpawnPoint_Info[20].SpawnPoint_7 = "GameStartPoint1_20_03"
Stage1_SpawnPoint_Info[20].SpawnPoint_8 = "GameStartPoint1_20_04"	   
Stage2_SpawnPoint_Info = {}

Stage2_SpawnPoint_Info[1] ={}
Stage2_SpawnPoint_Info[1].Area = "GameStartArea2_1"
Stage2_SpawnPoint_Info[1].Position = "Bottom"
Stage2_SpawnPoint_Info[1].Probability = 100
Stage2_SpawnPoint_Info[1].Door = "MovableModel2_1"
Stage2_SpawnPoint_Info[1].StartRoom = "EventArea2_1_1"
Stage2_SpawnPoint_Info[1].SpawnPointCount = 8
Stage2_SpawnPoint_Info[1].SpawnPoint_1 = "GameStartPoint2_1_1"
Stage2_SpawnPoint_Info[1].SpawnPoint_2 = "GameStartPoint2_1_2"
Stage2_SpawnPoint_Info[1].SpawnPoint_3 = "GameStartPoint2_1_3"
Stage2_SpawnPoint_Info[1].SpawnPoint_4 = "GameStartPoint2_1_4"
Stage2_SpawnPoint_Info[1].SpawnPoint_5 = "GameStartPoint2_1_01"
Stage2_SpawnPoint_Info[1].SpawnPoint_6 = "GameStartPoint2_1_02"
Stage2_SpawnPoint_Info[1].SpawnPoint_7 = "GameStartPoint2_1_03"
Stage2_SpawnPoint_Info[1].SpawnPoint_8 = "GameStartPoint2_1_04"	   
Stage2_SpawnPoint_Info[2] ={}
Stage2_SpawnPoint_Info[2].Area = "GameStartArea2_2"
Stage2_SpawnPoint_Info[2].Position = "Bottom"
Stage2_SpawnPoint_Info[2].Probability = 100
Stage2_SpawnPoint_Info[2].Door = "MovableModel2_2"
Stage2_SpawnPoint_Info[2].StartRoom = "EventArea2_1_2"
Stage2_SpawnPoint_Info[2].SpawnPointCount = 8
Stage2_SpawnPoint_Info[2].SpawnPoint_1 = "GameStartPoint2_2_1"
Stage2_SpawnPoint_Info[2].SpawnPoint_2 = "GameStartPoint2_2_2"
Stage2_SpawnPoint_Info[2].SpawnPoint_3 = "GameStartPoint2_2_3"
Stage2_SpawnPoint_Info[2].SpawnPoint_4 = "GameStartPoint2_2_4"
Stage2_SpawnPoint_Info[2].SpawnPoint_5 = "GameStartPoint2_2_01"
Stage2_SpawnPoint_Info[2].SpawnPoint_6 = "GameStartPoint2_2_02"
Stage2_SpawnPoint_Info[2].SpawnPoint_7 = "GameStartPoint2_2_03"
Stage2_SpawnPoint_Info[2].SpawnPoint_8 = "GameStartPoint2_2_04"	   
Stage2_SpawnPoint_Info[3] ={}
Stage2_SpawnPoint_Info[3].Area = "GameStartArea2_3"
Stage2_SpawnPoint_Info[3].Position = "Bottom"
Stage2_SpawnPoint_Info[3].Probability = 100
Stage2_SpawnPoint_Info[3].Door = "MovableModel2_3"
Stage2_SpawnPoint_Info[3].StartRoom = "EventArea2_1_3"
Stage2_SpawnPoint_Info[3].SpawnPointCount = 8
Stage2_SpawnPoint_Info[3].SpawnPoint_1 = "GameStartPoint2_3_1"
Stage2_SpawnPoint_Info[3].SpawnPoint_2 = "GameStartPoint2_3_2"
Stage2_SpawnPoint_Info[3].SpawnPoint_3 = "GameStartPoint2_3_3"
Stage2_SpawnPoint_Info[3].SpawnPoint_4 = "GameStartPoint2_3_4"
Stage2_SpawnPoint_Info[3].SpawnPoint_5 = "GameStartPoint2_3_01"
Stage2_SpawnPoint_Info[3].SpawnPoint_6 = "GameStartPoint2_3_02"
Stage2_SpawnPoint_Info[3].SpawnPoint_7 = "GameStartPoint2_3_03"
Stage2_SpawnPoint_Info[3].SpawnPoint_8 = "GameStartPoint2_3_04"	   
Stage2_SpawnPoint_Info[4] ={}
Stage2_SpawnPoint_Info[4].Area = "GameStartArea2_4"
Stage2_SpawnPoint_Info[4].Position = "Bottom"
Stage2_SpawnPoint_Info[4].Probability = 100
Stage2_SpawnPoint_Info[4].Door = "MovableModel2_4"
Stage2_SpawnPoint_Info[4].StartRoom = "EventArea2_1_4"
Stage2_SpawnPoint_Info[4].SpawnPointCount = 8
Stage2_SpawnPoint_Info[4].SpawnPoint_1 = "GameStartPoint2_4_1"
Stage2_SpawnPoint_Info[4].SpawnPoint_2 = "GameStartPoint2_4_2"
Stage2_SpawnPoint_Info[4].SpawnPoint_3 = "GameStartPoint2_4_3"
Stage2_SpawnPoint_Info[4].SpawnPoint_4 = "GameStartPoint2_4_4"
Stage2_SpawnPoint_Info[4].SpawnPoint_5 = "GameStartPoint2_4_01"
Stage2_SpawnPoint_Info[4].SpawnPoint_6 = "GameStartPoint2_4_02"
Stage2_SpawnPoint_Info[4].SpawnPoint_7 = "GameStartPoint2_4_03"
Stage2_SpawnPoint_Info[4].SpawnPoint_8 = "GameStartPoint2_4_04"	   
Stage2_SpawnPoint_Info[5] ={}
Stage2_SpawnPoint_Info[5].Area = "GameStartArea2_5"
Stage2_SpawnPoint_Info[5].Position = "Bottom"
Stage2_SpawnPoint_Info[5].Probability = 100
Stage2_SpawnPoint_Info[5].Door = "MovableModel2_5"
Stage2_SpawnPoint_Info[5].StartRoom = "EventArea2_1_5"
Stage2_SpawnPoint_Info[5].SpawnPointCount = 8
Stage2_SpawnPoint_Info[5].SpawnPoint_1 = "GameStartPoint2_5_1"
Stage2_SpawnPoint_Info[5].SpawnPoint_2 = "GameStartPoint2_5_2"
Stage2_SpawnPoint_Info[5].SpawnPoint_3 = "GameStartPoint2_5_3"
Stage2_SpawnPoint_Info[5].SpawnPoint_4 = "GameStartPoint2_5_4"
Stage2_SpawnPoint_Info[5].SpawnPoint_5 = "GameStartPoint2_5_01"
Stage2_SpawnPoint_Info[5].SpawnPoint_6 = "GameStartPoint2_5_02"
Stage2_SpawnPoint_Info[5].SpawnPoint_7 = "GameStartPoint2_5_03"
Stage2_SpawnPoint_Info[5].SpawnPoint_8 = "GameStartPoint2_5_04"	   
Stage2_SpawnPoint_Info[6] ={}
Stage2_SpawnPoint_Info[6].Area = "GameStartArea2_6"
Stage2_SpawnPoint_Info[6].Position = "Right"
Stage2_SpawnPoint_Info[6].Probability = 100
Stage2_SpawnPoint_Info[6].Door = "MovableModel2_11"
Stage2_SpawnPoint_Info[6].StartRoom = "EventArea2_1_5"
Stage2_SpawnPoint_Info[6].SpawnPointCount = 8
Stage2_SpawnPoint_Info[6].SpawnPoint_1 = "GameStartPoint2_6_1"
Stage2_SpawnPoint_Info[6].SpawnPoint_2 = "GameStartPoint2_6_2"
Stage2_SpawnPoint_Info[6].SpawnPoint_3 = "GameStartPoint2_6_3"
Stage2_SpawnPoint_Info[6].SpawnPoint_4 = "GameStartPoint2_6_4"
Stage2_SpawnPoint_Info[6].SpawnPoint_5 = "GameStartPoint2_6_01"
Stage2_SpawnPoint_Info[6].SpawnPoint_6 = "GameStartPoint2_6_02"
Stage2_SpawnPoint_Info[6].SpawnPoint_7 = "GameStartPoint2_6_03"
Stage2_SpawnPoint_Info[6].SpawnPoint_8 = "GameStartPoint2_6_04"	   
Stage2_SpawnPoint_Info[7] ={}
Stage2_SpawnPoint_Info[7].Area = "GameStartArea2_7"
Stage2_SpawnPoint_Info[7].Position = "Right"
Stage2_SpawnPoint_Info[7].Probability = 100
Stage2_SpawnPoint_Info[7].Door = "MovableModel2_22"
Stage2_SpawnPoint_Info[7].StartRoom = "EventArea2_2_5"
Stage2_SpawnPoint_Info[7].SpawnPointCount = 8
Stage2_SpawnPoint_Info[7].SpawnPoint_1 = "GameStartPoint2_7_1"
Stage2_SpawnPoint_Info[7].SpawnPoint_2 = "GameStartPoint2_7_2"
Stage2_SpawnPoint_Info[7].SpawnPoint_3 = "GameStartPoint2_7_3"
Stage2_SpawnPoint_Info[7].SpawnPoint_4 = "GameStartPoint2_7_4"
Stage2_SpawnPoint_Info[7].SpawnPoint_5 = "GameStartPoint2_7_01"
Stage2_SpawnPoint_Info[7].SpawnPoint_6 = "GameStartPoint2_7_02"
Stage2_SpawnPoint_Info[7].SpawnPoint_7 = "GameStartPoint2_7_03"
Stage2_SpawnPoint_Info[7].SpawnPoint_8 = "GameStartPoint2_7_04"	   
Stage2_SpawnPoint_Info[8] ={}
Stage2_SpawnPoint_Info[8].Area = "GameStartArea2_8"
Stage2_SpawnPoint_Info[8].Position = "Right"
Stage2_SpawnPoint_Info[8].Probability = 100
Stage2_SpawnPoint_Info[8].Door = "MovableModel2_33"
Stage2_SpawnPoint_Info[8].StartRoom = "EventArea2_3_5"
Stage2_SpawnPoint_Info[8].SpawnPointCount = 8
Stage2_SpawnPoint_Info[8].SpawnPoint_1 = "GameStartPoint2_8_1"
Stage2_SpawnPoint_Info[8].SpawnPoint_2 = "GameStartPoint2_8_2"
Stage2_SpawnPoint_Info[8].SpawnPoint_3 = "GameStartPoint2_8_3"
Stage2_SpawnPoint_Info[8].SpawnPoint_4 = "GameStartPoint2_8_4"
Stage2_SpawnPoint_Info[8].SpawnPoint_5 = "GameStartPoint2_8_01"
Stage2_SpawnPoint_Info[8].SpawnPoint_6 = "GameStartPoint2_8_02"
Stage2_SpawnPoint_Info[8].SpawnPoint_7 = "GameStartPoint2_8_03"
Stage2_SpawnPoint_Info[8].SpawnPoint_8 = "GameStartPoint2_8_04"	   
Stage2_SpawnPoint_Info[9] ={}
Stage2_SpawnPoint_Info[9].Area = "GameStartArea2_9"
Stage2_SpawnPoint_Info[9].Position = "Right"
Stage2_SpawnPoint_Info[9].Probability = 100
Stage2_SpawnPoint_Info[9].Door = "MovableModel2_44"
Stage2_SpawnPoint_Info[9].StartRoom = "EventArea2_4_5"
Stage2_SpawnPoint_Info[9].SpawnPointCount = 8
Stage2_SpawnPoint_Info[9].SpawnPoint_1 = "GameStartPoint2_9_1"
Stage2_SpawnPoint_Info[9].SpawnPoint_2 = "GameStartPoint2_9_2"
Stage2_SpawnPoint_Info[9].SpawnPoint_3 = "GameStartPoint2_9_3"
Stage2_SpawnPoint_Info[9].SpawnPoint_4 = "GameStartPoint2_9_4"
Stage2_SpawnPoint_Info[9].SpawnPoint_5 = "GameStartPoint2_9_01"
Stage2_SpawnPoint_Info[9].SpawnPoint_6 = "GameStartPoint2_9_02"
Stage2_SpawnPoint_Info[9].SpawnPoint_7 = "GameStartPoint2_9_03"
Stage2_SpawnPoint_Info[9].SpawnPoint_8 = "GameStartPoint2_9_04"	   
Stage2_SpawnPoint_Info[10] ={}
Stage2_SpawnPoint_Info[10].Area = "GameStartArea2_10"
Stage2_SpawnPoint_Info[10].Position = "Right"
Stage2_SpawnPoint_Info[10].Probability = 100
Stage2_SpawnPoint_Info[10].Door = "MovableModel2_55"
Stage2_SpawnPoint_Info[10].StartRoom = "EventArea2_5_5"
Stage2_SpawnPoint_Info[10].SpawnPointCount = 8
Stage2_SpawnPoint_Info[10].SpawnPoint_1 = "GameStartPoint2_10_1"
Stage2_SpawnPoint_Info[10].SpawnPoint_2 = "GameStartPoint2_10_2"
Stage2_SpawnPoint_Info[10].SpawnPoint_3 = "GameStartPoint2_10_3"
Stage2_SpawnPoint_Info[10].SpawnPoint_4 = "GameStartPoint2_10_4"
Stage2_SpawnPoint_Info[10].SpawnPoint_5 = "GameStartPoint2_10_01"
Stage2_SpawnPoint_Info[10].SpawnPoint_6 = "GameStartPoint2_10_02"
Stage2_SpawnPoint_Info[10].SpawnPoint_7 = "GameStartPoint2_10_03"
Stage2_SpawnPoint_Info[10].SpawnPoint_8 = "GameStartPoint2_10_04"	   
Stage2_SpawnPoint_Info[11] ={}
Stage2_SpawnPoint_Info[11].Area = "GameStartArea2_11"
Stage2_SpawnPoint_Info[11].Position = "Top"
Stage2_SpawnPoint_Info[11].Probability = 100
Stage2_SpawnPoint_Info[11].Door = "MovableModel2_60"
Stage2_SpawnPoint_Info[11].StartRoom = "EventArea2_5_5"
Stage2_SpawnPoint_Info[11].SpawnPointCount = 8
Stage2_SpawnPoint_Info[11].SpawnPoint_1 = "GameStartPoint2_11_1"
Stage2_SpawnPoint_Info[11].SpawnPoint_2 = "GameStartPoint2_11_2"
Stage2_SpawnPoint_Info[11].SpawnPoint_3 = "GameStartPoint2_11_3"
Stage2_SpawnPoint_Info[11].SpawnPoint_4 = "GameStartPoint2_11_4"
Stage2_SpawnPoint_Info[11].SpawnPoint_5 = "GameStartPoint2_11_01"
Stage2_SpawnPoint_Info[11].SpawnPoint_6 = "GameStartPoint2_11_02"
Stage2_SpawnPoint_Info[11].SpawnPoint_7 = "GameStartPoint2_11_03"
Stage2_SpawnPoint_Info[11].SpawnPoint_8 = "GameStartPoint2_11_04"	   
Stage2_SpawnPoint_Info[12] ={}
Stage2_SpawnPoint_Info[12].Area = "GameStartArea2_12"
Stage2_SpawnPoint_Info[12].Position = "Top"
Stage2_SpawnPoint_Info[12].Probability = 100
Stage2_SpawnPoint_Info[12].Door = "MovableModel2_59"
Stage2_SpawnPoint_Info[12].StartRoom = "EventArea2_5_4"
Stage2_SpawnPoint_Info[12].SpawnPointCount = 8
Stage2_SpawnPoint_Info[12].SpawnPoint_1 = "GameStartPoint2_12_1"
Stage2_SpawnPoint_Info[12].SpawnPoint_2 = "GameStartPoint2_12_2"
Stage2_SpawnPoint_Info[12].SpawnPoint_3 = "GameStartPoint2_12_3"
Stage2_SpawnPoint_Info[12].SpawnPoint_4 = "GameStartPoint2_12_4"
Stage2_SpawnPoint_Info[12].SpawnPoint_5 = "GameStartPoint2_12_01"
Stage2_SpawnPoint_Info[12].SpawnPoint_6 = "GameStartPoint2_12_02"
Stage2_SpawnPoint_Info[12].SpawnPoint_7 = "GameStartPoint2_12_03"
Stage2_SpawnPoint_Info[12].SpawnPoint_8 = "GameStartPoint2_12_04"	   
Stage2_SpawnPoint_Info[13] ={}
Stage2_SpawnPoint_Info[13].Area = "GameStartArea2_13"
Stage2_SpawnPoint_Info[13].Position = "Top"
Stage2_SpawnPoint_Info[13].Probability = 100
Stage2_SpawnPoint_Info[13].Door = "MovableModel2_58"
Stage2_SpawnPoint_Info[13].StartRoom = "EventArea2_5_3"
Stage2_SpawnPoint_Info[13].SpawnPointCount = 8
Stage2_SpawnPoint_Info[13].SpawnPoint_1 = "GameStartPoint2_13_1"
Stage2_SpawnPoint_Info[13].SpawnPoint_2 = "GameStartPoint2_13_2"
Stage2_SpawnPoint_Info[13].SpawnPoint_3 = "GameStartPoint2_13_3"
Stage2_SpawnPoint_Info[13].SpawnPoint_4 = "GameStartPoint2_13_4"
Stage2_SpawnPoint_Info[13].SpawnPoint_5 = "GameStartPoint2_13_01"
Stage2_SpawnPoint_Info[13].SpawnPoint_6 = "GameStartPoint2_13_02"
Stage2_SpawnPoint_Info[13].SpawnPoint_7 = "GameStartPoint2_13_03"
Stage2_SpawnPoint_Info[13].SpawnPoint_8 = "GameStartPoint2_13_04"	   
Stage2_SpawnPoint_Info[14] ={}
Stage2_SpawnPoint_Info[14].Area = "GameStartArea2_14"
Stage2_SpawnPoint_Info[14].Position = "Top"
Stage2_SpawnPoint_Info[14].Probability = 100
Stage2_SpawnPoint_Info[14].Door = "MovableModel2_57"
Stage2_SpawnPoint_Info[14].StartRoom = "EventArea2_5_2"
Stage2_SpawnPoint_Info[14].SpawnPointCount = 8
Stage2_SpawnPoint_Info[14].SpawnPoint_1 = "GameStartPoint2_14_1"
Stage2_SpawnPoint_Info[14].SpawnPoint_2 = "GameStartPoint2_14_2"
Stage2_SpawnPoint_Info[14].SpawnPoint_3 = "GameStartPoint2_14_3"
Stage2_SpawnPoint_Info[14].SpawnPoint_4 = "GameStartPoint2_14_4"
Stage2_SpawnPoint_Info[14].SpawnPoint_5 = "GameStartPoint2_14_01"
Stage2_SpawnPoint_Info[14].SpawnPoint_6 = "GameStartPoint2_14_02"
Stage2_SpawnPoint_Info[14].SpawnPoint_7 = "GameStartPoint2_14_03"
Stage2_SpawnPoint_Info[14].SpawnPoint_8 = "GameStartPoint2_14_04"	   
Stage2_SpawnPoint_Info[15] ={}
Stage2_SpawnPoint_Info[15].Area = "GameStartArea2_15"
Stage2_SpawnPoint_Info[15].Position = "Top"
Stage2_SpawnPoint_Info[15].Probability = 100
Stage2_SpawnPoint_Info[15].Door = "MovableModel2_56"
Stage2_SpawnPoint_Info[15].StartRoom = "EventArea2_5_1"
Stage2_SpawnPoint_Info[15].SpawnPointCount = 8
Stage2_SpawnPoint_Info[15].SpawnPoint_1 = "GameStartPoint2_15_1"
Stage2_SpawnPoint_Info[15].SpawnPoint_2 = "GameStartPoint2_15_2"
Stage2_SpawnPoint_Info[15].SpawnPoint_3 = "GameStartPoint2_15_3"
Stage2_SpawnPoint_Info[15].SpawnPoint_4 = "GameStartPoint2_15_4"
Stage2_SpawnPoint_Info[15].SpawnPoint_5 = "GameStartPoint2_15_01"
Stage2_SpawnPoint_Info[15].SpawnPoint_6 = "GameStartPoint2_15_02"
Stage2_SpawnPoint_Info[15].SpawnPoint_7 = "GameStartPoint2_15_03"
Stage2_SpawnPoint_Info[15].SpawnPoint_8 = "GameStartPoint2_15_04"	   
Stage2_SpawnPoint_Info[16] ={}
Stage2_SpawnPoint_Info[16].Area = "GameStartArea2_16"
Stage2_SpawnPoint_Info[16].Position = "Left"
Stage2_SpawnPoint_Info[16].Probability = 100
Stage2_SpawnPoint_Info[16].Door = "MovableModel2_50"
Stage2_SpawnPoint_Info[16].StartRoom = "EventArea2_5_1"
Stage2_SpawnPoint_Info[16].SpawnPointCount = 8
Stage2_SpawnPoint_Info[16].SpawnPoint_1 = "GameStartPoint2_16_1"
Stage2_SpawnPoint_Info[16].SpawnPoint_2 = "GameStartPoint2_16_2"
Stage2_SpawnPoint_Info[16].SpawnPoint_3 = "GameStartPoint2_16_3"
Stage2_SpawnPoint_Info[16].SpawnPoint_4 = "GameStartPoint2_16_4"
Stage2_SpawnPoint_Info[16].SpawnPoint_5 = "GameStartPoint2_16_01"
Stage2_SpawnPoint_Info[16].SpawnPoint_6 = "GameStartPoint2_16_02"
Stage2_SpawnPoint_Info[16].SpawnPoint_7 = "GameStartPoint2_16_03"
Stage2_SpawnPoint_Info[16].SpawnPoint_8 = "GameStartPoint2_16_04"	   
Stage2_SpawnPoint_Info[17] ={}
Stage2_SpawnPoint_Info[17].Area = "GameStartArea2_17"
Stage2_SpawnPoint_Info[17].Position = "Left"
Stage2_SpawnPoint_Info[17].Probability = 100
Stage2_SpawnPoint_Info[17].Door = "MovableModel2_39"
Stage2_SpawnPoint_Info[17].StartRoom = "EventArea2_4_1"
Stage2_SpawnPoint_Info[17].SpawnPointCount = 8
Stage2_SpawnPoint_Info[17].SpawnPoint_1 = "GameStartPoint2_17_1"
Stage2_SpawnPoint_Info[17].SpawnPoint_2 = "GameStartPoint2_17_2"
Stage2_SpawnPoint_Info[17].SpawnPoint_3 = "GameStartPoint2_17_3"
Stage2_SpawnPoint_Info[17].SpawnPoint_4 = "GameStartPoint2_17_4"
Stage2_SpawnPoint_Info[17].SpawnPoint_5 = "GameStartPoint2_17_01"
Stage2_SpawnPoint_Info[17].SpawnPoint_6 = "GameStartPoint2_17_02"
Stage2_SpawnPoint_Info[17].SpawnPoint_7 = "GameStartPoint2_17_03"
Stage2_SpawnPoint_Info[17].SpawnPoint_8 = "GameStartPoint2_17_04"	   
 
Stage2_SpawnPoint_Info[18] ={}
Stage2_SpawnPoint_Info[18].Area = "GameStartArea2_18"
Stage2_SpawnPoint_Info[18].Position = "Left"
Stage2_SpawnPoint_Info[18].Probability = 100
Stage2_SpawnPoint_Info[18].Door = "MovableModel2_28"
Stage2_SpawnPoint_Info[18].StartRoom = "EventArea2_3_1"
Stage2_SpawnPoint_Info[18].SpawnPointCount = 8
Stage2_SpawnPoint_Info[18].SpawnPoint_1 = "GameStartPoint2_18_1"
Stage2_SpawnPoint_Info[18].SpawnPoint_2 = "GameStartPoint2_18_2"
Stage2_SpawnPoint_Info[18].SpawnPoint_3 = "GameStartPoint2_18_3"
Stage2_SpawnPoint_Info[18].SpawnPoint_4 = "GameStartPoint2_18_4"
Stage2_SpawnPoint_Info[18].SpawnPoint_5 = "GameStartPoint2_18_01"
Stage2_SpawnPoint_Info[18].SpawnPoint_6 = "GameStartPoint2_18_02"
Stage2_SpawnPoint_Info[18].SpawnPoint_7 = "GameStartPoint2_18_03"
Stage2_SpawnPoint_Info[18].SpawnPoint_8 = "GameStartPoint2_18_04"	   
Stage2_SpawnPoint_Info[19] ={}
Stage2_SpawnPoint_Info[19].Area = "GameStartArea2_19"
Stage2_SpawnPoint_Info[19].Position = "Left"
Stage2_SpawnPoint_Info[19].Probability = 100
Stage2_SpawnPoint_Info[19].Door = "MovableModel2_17"
Stage2_SpawnPoint_Info[19].StartRoom = "EventArea2_2_1"
Stage2_SpawnPoint_Info[19].SpawnPointCount = 8
Stage2_SpawnPoint_Info[19].SpawnPoint_1 = "GameStartPoint2_19_1"
Stage2_SpawnPoint_Info[19].SpawnPoint_2 = "GameStartPoint2_19_2"
Stage2_SpawnPoint_Info[19].SpawnPoint_3 = "GameStartPoint2_19_3"
Stage2_SpawnPoint_Info[19].SpawnPoint_4 = "GameStartPoint2_19_4"
Stage2_SpawnPoint_Info[19].SpawnPoint_5 = "GameStartPoint2_19_01"
Stage2_SpawnPoint_Info[19].SpawnPoint_6 = "GameStartPoint2_19_02"
Stage2_SpawnPoint_Info[19].SpawnPoint_7 = "GameStartPoint2_19_03"
Stage2_SpawnPoint_Info[19].SpawnPoint_8 = "GameStartPoint2_19_04"	   
Stage2_SpawnPoint_Info[20] ={}
Stage2_SpawnPoint_Info[20].Area = "GameStartArea2_20"
Stage2_SpawnPoint_Info[20].Position = "Left"
Stage2_SpawnPoint_Info[20].Probability = 100
Stage2_SpawnPoint_Info[20].Door = "MovableModel2_6"
Stage2_SpawnPoint_Info[20].StartRoom = "EventArea2_1_1"
Stage2_SpawnPoint_Info[20].SpawnPointCount = 8
Stage2_SpawnPoint_Info[20].SpawnPoint_1 = "GameStartPoint2_20_1"
Stage2_SpawnPoint_Info[20].SpawnPoint_2 = "GameStartPoint2_20_2"
Stage2_SpawnPoint_Info[20].SpawnPoint_3 = "GameStartPoint2_20_3"
Stage2_SpawnPoint_Info[20].SpawnPoint_4 = "GameStartPoint2_20_4"
Stage2_SpawnPoint_Info[20].SpawnPoint_5 = "GameStartPoint2_20_01"
Stage2_SpawnPoint_Info[20].SpawnPoint_6 = "GameStartPoint2_20_02"
Stage2_SpawnPoint_Info[20].SpawnPoint_7 = "GameStartPoint2_20_03"
Stage2_SpawnPoint_Info[20].SpawnPoint_8 = "GameStartPoint2_20_04"	   
Stage3_SpawnPoint_Info = {}

Stage3_SpawnPoint_Info[1] ={}
Stage3_SpawnPoint_Info[1].Area = "GameStartArea3_1"
Stage3_SpawnPoint_Info[1].Position = "Bottom"
Stage3_SpawnPoint_Info[1].Probability = 100
Stage3_SpawnPoint_Info[1].Door = "MovableModel3_1"
Stage3_SpawnPoint_Info[1].StartRoom = "EventArea3_1_1"
Stage3_SpawnPoint_Info[1].SpawnPointCount = 8
Stage3_SpawnPoint_Info[1].SpawnPoint_1 = "GameStartPoint3_1_1"
Stage3_SpawnPoint_Info[1].SpawnPoint_2 = "GameStartPoint3_1_2"
Stage3_SpawnPoint_Info[1].SpawnPoint_3 = "GameStartPoint3_1_3"
Stage3_SpawnPoint_Info[1].SpawnPoint_4 = "GameStartPoint3_1_4"
Stage3_SpawnPoint_Info[1].SpawnPoint_5 = "GameStartPoint3_1_01"
Stage3_SpawnPoint_Info[1].SpawnPoint_6 = "GameStartPoint3_1_02"
Stage3_SpawnPoint_Info[1].SpawnPoint_7 = "GameStartPoint3_1_03"
Stage3_SpawnPoint_Info[1].SpawnPoint_8 = "GameStartPoint3_1_04"	   
Stage3_SpawnPoint_Info[2] ={}
Stage3_SpawnPoint_Info[2].Area = "GameStartArea3_2"
Stage3_SpawnPoint_Info[2].Position = "Bottom"
Stage3_SpawnPoint_Info[2].Probability = 100
Stage3_SpawnPoint_Info[2].Door = "MovableModel3_2"
Stage3_SpawnPoint_Info[2].StartRoom = "EventArea3_1_2"
Stage3_SpawnPoint_Info[2].SpawnPointCount = 8
Stage3_SpawnPoint_Info[2].SpawnPoint_1 = "GameStartPoint3_2_1"
Stage3_SpawnPoint_Info[2].SpawnPoint_2 = "GameStartPoint3_2_2"
Stage3_SpawnPoint_Info[2].SpawnPoint_3 = "GameStartPoint3_2_3"
Stage3_SpawnPoint_Info[2].SpawnPoint_4 = "GameStartPoint3_2_4"
Stage3_SpawnPoint_Info[2].SpawnPoint_5 = "GameStartPoint3_2_01"
Stage3_SpawnPoint_Info[2].SpawnPoint_6 = "GameStartPoint3_2_02"
Stage3_SpawnPoint_Info[2].SpawnPoint_7 = "GameStartPoint3_2_03"
Stage3_SpawnPoint_Info[2].SpawnPoint_8 = "GameStartPoint3_2_04"	   
Stage3_SpawnPoint_Info[3] ={}
Stage3_SpawnPoint_Info[3].Area = "GameStartArea3_3"
Stage3_SpawnPoint_Info[3].Position = "Bottom"
Stage3_SpawnPoint_Info[3].Probability = 100
Stage3_SpawnPoint_Info[3].Door = "MovableModel3_3"
Stage3_SpawnPoint_Info[3].StartRoom = "EventArea3_1_3"
Stage3_SpawnPoint_Info[3].SpawnPointCount = 8
Stage3_SpawnPoint_Info[3].SpawnPoint_1 = "GameStartPoint3_3_1"
Stage3_SpawnPoint_Info[3].SpawnPoint_2 = "GameStartPoint3_3_2"
Stage3_SpawnPoint_Info[3].SpawnPoint_3 = "GameStartPoint3_3_3"
Stage3_SpawnPoint_Info[3].SpawnPoint_4 = "GameStartPoint3_3_4"
Stage3_SpawnPoint_Info[3].SpawnPoint_5 = "GameStartPoint3_3_01"
Stage3_SpawnPoint_Info[3].SpawnPoint_6 = "GameStartPoint3_3_02"
Stage3_SpawnPoint_Info[3].SpawnPoint_7 = "GameStartPoint3_3_03"
Stage3_SpawnPoint_Info[3].SpawnPoint_8 = "GameStartPoint3_3_04"	   
Stage3_SpawnPoint_Info[4] ={}
Stage3_SpawnPoint_Info[4].Area = "GameStartArea3_4"
Stage3_SpawnPoint_Info[4].Position = "Bottom"
Stage3_SpawnPoint_Info[4].Probability = 100
Stage3_SpawnPoint_Info[4].Door = "MovableModel3_4"
Stage3_SpawnPoint_Info[4].StartRoom = "EventArea3_1_4"
Stage3_SpawnPoint_Info[4].SpawnPointCount = 8
Stage3_SpawnPoint_Info[4].SpawnPoint_1 = "GameStartPoint3_4_1"
Stage3_SpawnPoint_Info[4].SpawnPoint_2 = "GameStartPoint3_4_2"
Stage3_SpawnPoint_Info[4].SpawnPoint_3 = "GameStartPoint3_4_3"
Stage3_SpawnPoint_Info[4].SpawnPoint_4 = "GameStartPoint3_4_4"
Stage3_SpawnPoint_Info[4].SpawnPoint_5 = "GameStartPoint3_4_01"
Stage3_SpawnPoint_Info[4].SpawnPoint_6 = "GameStartPoint3_4_02"
Stage3_SpawnPoint_Info[4].SpawnPoint_7 = "GameStartPoint3_4_03"
Stage3_SpawnPoint_Info[4].SpawnPoint_8 = "GameStartPoint3_4_04"	   
Stage3_SpawnPoint_Info[5] ={}
Stage3_SpawnPoint_Info[5].Area = "GameStartArea3_5"
Stage3_SpawnPoint_Info[5].Position = "Bottom"
Stage3_SpawnPoint_Info[5].Probability = 100
Stage3_SpawnPoint_Info[5].Door = "MovableModel3_5"
Stage3_SpawnPoint_Info[5].StartRoom = "EventArea3_1_5"
Stage3_SpawnPoint_Info[5].SpawnPointCount = 8
Stage3_SpawnPoint_Info[5].SpawnPoint_1 = "GameStartPoint3_5_1"
Stage3_SpawnPoint_Info[5].SpawnPoint_2 = "GameStartPoint3_5_2"
Stage3_SpawnPoint_Info[5].SpawnPoint_3 = "GameStartPoint3_5_3"
Stage3_SpawnPoint_Info[5].SpawnPoint_4 = "GameStartPoint3_5_4"
Stage3_SpawnPoint_Info[5].SpawnPoint_5 = "GameStartPoint3_5_01"
Stage3_SpawnPoint_Info[5].SpawnPoint_6 = "GameStartPoint3_5_02"
Stage3_SpawnPoint_Info[5].SpawnPoint_7 = "GameStartPoint3_5_03"
Stage3_SpawnPoint_Info[5].SpawnPoint_8 = "GameStartPoint3_5_04"	   
Stage3_SpawnPoint_Info[6] ={}
Stage3_SpawnPoint_Info[6].Area = "GameStartArea3_6"
Stage3_SpawnPoint_Info[6].Position = "Right"
Stage3_SpawnPoint_Info[6].Probability = 100
Stage3_SpawnPoint_Info[6].Door = "MovableModel3_11"
Stage3_SpawnPoint_Info[6].StartRoom = "EventArea3_1_5"
Stage3_SpawnPoint_Info[6].SpawnPointCount = 8
Stage3_SpawnPoint_Info[6].SpawnPoint_1 = "GameStartPoint3_6_1"
Stage3_SpawnPoint_Info[6].SpawnPoint_2 = "GameStartPoint3_6_2"
Stage3_SpawnPoint_Info[6].SpawnPoint_3 = "GameStartPoint3_6_3"
Stage3_SpawnPoint_Info[6].SpawnPoint_4 = "GameStartPoint3_6_4"
Stage3_SpawnPoint_Info[6].SpawnPoint_5 = "GameStartPoint3_6_01"
Stage3_SpawnPoint_Info[6].SpawnPoint_6 = "GameStartPoint3_6_02"
Stage3_SpawnPoint_Info[6].SpawnPoint_7 = "GameStartPoint3_6_03"
Stage3_SpawnPoint_Info[6].SpawnPoint_8 = "GameStartPoint3_6_04"	   
Stage3_SpawnPoint_Info[7] ={}
Stage3_SpawnPoint_Info[7].Area = "GameStartArea3_7"
Stage3_SpawnPoint_Info[7].Position = "Right"
Stage3_SpawnPoint_Info[7].Probability = 100
Stage3_SpawnPoint_Info[7].Door = "MovableModel3_22"
Stage3_SpawnPoint_Info[7].StartRoom = "EventArea3_2_5"
Stage3_SpawnPoint_Info[7].SpawnPointCount = 8
Stage3_SpawnPoint_Info[7].SpawnPoint_1 = "GameStartPoint3_7_1"
Stage3_SpawnPoint_Info[7].SpawnPoint_2 = "GameStartPoint3_7_2"
Stage3_SpawnPoint_Info[7].SpawnPoint_3 = "GameStartPoint3_7_3"
Stage3_SpawnPoint_Info[7].SpawnPoint_4 = "GameStartPoint3_7_4"
Stage3_SpawnPoint_Info[7].SpawnPoint_5 = "GameStartPoint3_7_01"
Stage3_SpawnPoint_Info[7].SpawnPoint_6 = "GameStartPoint3_7_02"
Stage3_SpawnPoint_Info[7].SpawnPoint_7 = "GameStartPoint3_7_03"
Stage3_SpawnPoint_Info[7].SpawnPoint_8 = "GameStartPoint3_7_04"	   
Stage3_SpawnPoint_Info[8] ={}
Stage3_SpawnPoint_Info[8].Area = "GameStartArea3_8"
Stage3_SpawnPoint_Info[8].Position = "Right"
Stage3_SpawnPoint_Info[8].Probability = 100
Stage3_SpawnPoint_Info[8].Door = "MovableModel3_33"
Stage3_SpawnPoint_Info[8].StartRoom = "EventArea3_3_5"
Stage3_SpawnPoint_Info[8].SpawnPointCount = 8
Stage3_SpawnPoint_Info[8].SpawnPoint_1 = "GameStartPoint3_8_1"
Stage3_SpawnPoint_Info[8].SpawnPoint_2 = "GameStartPoint3_8_2"
Stage3_SpawnPoint_Info[8].SpawnPoint_3 = "GameStartPoint3_8_3"
Stage3_SpawnPoint_Info[8].SpawnPoint_4 = "GameStartPoint3_8_4"
Stage3_SpawnPoint_Info[8].SpawnPoint_5 = "GameStartPoint3_8_01"
Stage3_SpawnPoint_Info[8].SpawnPoint_6 = "GameStartPoint3_8_02"
Stage3_SpawnPoint_Info[8].SpawnPoint_7 = "GameStartPoint3_8_03"
Stage3_SpawnPoint_Info[8].SpawnPoint_8 = "GameStartPoint3_8_04"	   
Stage3_SpawnPoint_Info[9] ={}
Stage3_SpawnPoint_Info[9].Area = "GameStartArea3_9"
Stage3_SpawnPoint_Info[9].Position = "Right"
Stage3_SpawnPoint_Info[9].Probability = 100
Stage3_SpawnPoint_Info[9].Door = "MovableModel3_44"
Stage3_SpawnPoint_Info[9].StartRoom = "EventArea3_4_5"
Stage3_SpawnPoint_Info[9].SpawnPointCount = 8
Stage3_SpawnPoint_Info[9].SpawnPoint_1 = "GameStartPoint3_9_1"
Stage3_SpawnPoint_Info[9].SpawnPoint_2 = "GameStartPoint3_9_2"
Stage3_SpawnPoint_Info[9].SpawnPoint_3 = "GameStartPoint3_9_3"
Stage3_SpawnPoint_Info[9].SpawnPoint_4 = "GameStartPoint3_9_4"
Stage3_SpawnPoint_Info[9].SpawnPoint_5 = "GameStartPoint3_9_01"
Stage3_SpawnPoint_Info[9].SpawnPoint_6 = "GameStartPoint3_9_02"
Stage3_SpawnPoint_Info[9].SpawnPoint_7 = "GameStartPoint3_9_03"
Stage3_SpawnPoint_Info[9].SpawnPoint_8 = "GameStartPoint3_9_04"	   
Stage3_SpawnPoint_Info[10] ={}
Stage3_SpawnPoint_Info[10].Area = "GameStartArea3_10"
Stage3_SpawnPoint_Info[10].Position = "Right"
Stage3_SpawnPoint_Info[10].Probability = 100
Stage3_SpawnPoint_Info[10].Door = "MovableModel3_55"
Stage3_SpawnPoint_Info[10].StartRoom = "EventArea3_5_5"
Stage3_SpawnPoint_Info[10].SpawnPointCount = 8
Stage3_SpawnPoint_Info[10].SpawnPoint_1 = "GameStartPoint3_10_1"
Stage3_SpawnPoint_Info[10].SpawnPoint_2 = "GameStartPoint3_10_2"
Stage3_SpawnPoint_Info[10].SpawnPoint_3 = "GameStartPoint3_10_3"
Stage3_SpawnPoint_Info[10].SpawnPoint_4 = "GameStartPoint3_10_4"
Stage3_SpawnPoint_Info[10].SpawnPoint_5 = "GameStartPoint3_10_01"
Stage3_SpawnPoint_Info[10].SpawnPoint_6 = "GameStartPoint3_10_02"
Stage3_SpawnPoint_Info[10].SpawnPoint_7 = "GameStartPoint3_10_03"
Stage3_SpawnPoint_Info[10].SpawnPoint_8 = "GameStartPoint3_10_04"	   
Stage3_SpawnPoint_Info[11] ={}
Stage3_SpawnPoint_Info[11].Area = "GameStartArea3_11"
Stage3_SpawnPoint_Info[11].Position = "Top"
Stage3_SpawnPoint_Info[11].Probability = 100
Stage3_SpawnPoint_Info[11].Door = "MovableModel3_60"
Stage3_SpawnPoint_Info[11].StartRoom = "EventArea3_5_5"
Stage3_SpawnPoint_Info[11].SpawnPointCount = 8
Stage3_SpawnPoint_Info[11].SpawnPoint_1 = "GameStartPoint3_11_1"
Stage3_SpawnPoint_Info[11].SpawnPoint_2 = "GameStartPoint3_11_2"
Stage3_SpawnPoint_Info[11].SpawnPoint_3 = "GameStartPoint3_11_3"
Stage3_SpawnPoint_Info[11].SpawnPoint_4 = "GameStartPoint3_11_4"
Stage3_SpawnPoint_Info[11].SpawnPoint_5 = "GameStartPoint3_11_01"
Stage3_SpawnPoint_Info[11].SpawnPoint_6 = "GameStartPoint3_11_02"
Stage3_SpawnPoint_Info[11].SpawnPoint_7 = "GameStartPoint3_11_03"
Stage3_SpawnPoint_Info[11].SpawnPoint_8 = "GameStartPoint3_11_04"	   
Stage3_SpawnPoint_Info[12] ={}
Stage3_SpawnPoint_Info[12].Area = "GameStartArea3_12"
Stage3_SpawnPoint_Info[12].Position = "Top"
Stage3_SpawnPoint_Info[12].Probability = 100
Stage3_SpawnPoint_Info[12].Door = "MovableModel3_59"
Stage3_SpawnPoint_Info[12].StartRoom = "EventArea3_5_4"
Stage3_SpawnPoint_Info[12].SpawnPointCount = 8
Stage3_SpawnPoint_Info[12].SpawnPoint_1 = "GameStartPoint3_12_1"
Stage3_SpawnPoint_Info[12].SpawnPoint_2 = "GameStartPoint3_12_2"
Stage3_SpawnPoint_Info[12].SpawnPoint_3 = "GameStartPoint3_12_3"
Stage3_SpawnPoint_Info[12].SpawnPoint_4 = "GameStartPoint3_12_4"
Stage3_SpawnPoint_Info[12].SpawnPoint_5 = "GameStartPoint3_12_01"
Stage3_SpawnPoint_Info[12].SpawnPoint_6 = "GameStartPoint3_12_02"
Stage3_SpawnPoint_Info[12].SpawnPoint_7 = "GameStartPoint3_12_03"
Stage3_SpawnPoint_Info[12].SpawnPoint_8 = "GameStartPoint3_12_04"	   
Stage3_SpawnPoint_Info[13] ={}
Stage3_SpawnPoint_Info[13].Area = "GameStartArea3_13"
Stage3_SpawnPoint_Info[13].Position = "Top"
Stage3_SpawnPoint_Info[13].Probability = 100
Stage3_SpawnPoint_Info[13].Door = "MovableModel3_58"
Stage3_SpawnPoint_Info[13].StartRoom = "EventArea3_5_3"
Stage3_SpawnPoint_Info[13].SpawnPointCount = 8
Stage3_SpawnPoint_Info[13].SpawnPoint_1 = "GameStartPoint3_13_1"
Stage3_SpawnPoint_Info[13].SpawnPoint_2 = "GameStartPoint3_13_2"
Stage3_SpawnPoint_Info[13].SpawnPoint_3 = "GameStartPoint3_13_3"
Stage3_SpawnPoint_Info[13].SpawnPoint_4 = "GameStartPoint3_13_4"
Stage3_SpawnPoint_Info[13].SpawnPoint_5 = "GameStartPoint3_13_01"
Stage3_SpawnPoint_Info[13].SpawnPoint_6 = "GameStartPoint3_13_02"
Stage3_SpawnPoint_Info[13].SpawnPoint_7 = "GameStartPoint3_13_03"
Stage3_SpawnPoint_Info[13].SpawnPoint_8 = "GameStartPoint3_13_04"	   
Stage3_SpawnPoint_Info[14] ={}
Stage3_SpawnPoint_Info[14].Area = "GameStartArea3_14"
Stage3_SpawnPoint_Info[14].Position = "Top"
Stage3_SpawnPoint_Info[14].Probability = 100
Stage3_SpawnPoint_Info[14].Door = "MovableModel3_57"
Stage3_SpawnPoint_Info[14].StartRoom = "EventArea3_5_2"
Stage3_SpawnPoint_Info[14].SpawnPointCount = 8
Stage3_SpawnPoint_Info[14].SpawnPoint_1 = "GameStartPoint3_14_1"
Stage3_SpawnPoint_Info[14].SpawnPoint_2 = "GameStartPoint3_14_2"
Stage3_SpawnPoint_Info[14].SpawnPoint_3 = "GameStartPoint3_14_3"
Stage3_SpawnPoint_Info[14].SpawnPoint_4 = "GameStartPoint3_14_4"
Stage3_SpawnPoint_Info[14].SpawnPoint_5 = "GameStartPoint3_14_01"
Stage3_SpawnPoint_Info[14].SpawnPoint_6 = "GameStartPoint3_14_02"
Stage3_SpawnPoint_Info[14].SpawnPoint_7 = "GameStartPoint3_14_03"
Stage3_SpawnPoint_Info[14].SpawnPoint_8 = "GameStartPoint3_14_04"	   
Stage3_SpawnPoint_Info[15] ={}
Stage3_SpawnPoint_Info[15].Area = "GameStartArea3_15"
Stage3_SpawnPoint_Info[15].Position = "Top"
Stage3_SpawnPoint_Info[15].Probability = 100
Stage3_SpawnPoint_Info[15].Door = "MovableModel3_56"
Stage3_SpawnPoint_Info[15].StartRoom = "EventArea3_5_1"
Stage3_SpawnPoint_Info[15].SpawnPointCount = 8
Stage3_SpawnPoint_Info[15].SpawnPoint_1 = "GameStartPoint3_15_1"
Stage3_SpawnPoint_Info[15].SpawnPoint_2 = "GameStartPoint3_15_2"
Stage3_SpawnPoint_Info[15].SpawnPoint_3 = "GameStartPoint3_15_3"
Stage3_SpawnPoint_Info[15].SpawnPoint_4 = "GameStartPoint3_15_4"
Stage3_SpawnPoint_Info[15].SpawnPoint_5 = "GameStartPoint3_15_01"
Stage3_SpawnPoint_Info[15].SpawnPoint_6 = "GameStartPoint3_15_02"
Stage3_SpawnPoint_Info[15].SpawnPoint_7 = "GameStartPoint3_15_03"
Stage3_SpawnPoint_Info[15].SpawnPoint_8 = "GameStartPoint3_15_04"	   
Stage3_SpawnPoint_Info[16] ={}
Stage3_SpawnPoint_Info[16].Area = "GameStartArea3_16"
Stage3_SpawnPoint_Info[16].Position = "Left"
Stage3_SpawnPoint_Info[16].Probability = 100
Stage3_SpawnPoint_Info[16].Door = "MovableModel3_50"
Stage3_SpawnPoint_Info[16].StartRoom = "EventArea3_5_1"
Stage3_SpawnPoint_Info[16].SpawnPointCount = 8
Stage3_SpawnPoint_Info[16].SpawnPoint_1 = "GameStartPoint3_16_1"
Stage3_SpawnPoint_Info[16].SpawnPoint_2 = "GameStartPoint3_16_2"
Stage3_SpawnPoint_Info[16].SpawnPoint_3 = "GameStartPoint3_16_3"
Stage3_SpawnPoint_Info[16].SpawnPoint_4 = "GameStartPoint3_16_4"
Stage3_SpawnPoint_Info[16].SpawnPoint_5 = "GameStartPoint3_16_01"
Stage3_SpawnPoint_Info[16].SpawnPoint_6 = "GameStartPoint3_16_02"
Stage3_SpawnPoint_Info[16].SpawnPoint_7 = "GameStartPoint3_16_03"
Stage3_SpawnPoint_Info[16].SpawnPoint_8 = "GameStartPoint3_16_04"	   
Stage3_SpawnPoint_Info[17] ={}
Stage3_SpawnPoint_Info[17].Area = "GameStartArea3_17"
Stage3_SpawnPoint_Info[17].Position = "Left"
Stage3_SpawnPoint_Info[17].Probability = 100
Stage3_SpawnPoint_Info[17].Door = "MovableModel3_39"
Stage3_SpawnPoint_Info[17].StartRoom = "EventArea3_4_1"
Stage3_SpawnPoint_Info[17].SpawnPointCount = 8
Stage3_SpawnPoint_Info[17].SpawnPoint_1 = "GameStartPoint3_17_1"
Stage3_SpawnPoint_Info[17].SpawnPoint_2 = "GameStartPoint3_17_2"
Stage3_SpawnPoint_Info[17].SpawnPoint_3 = "GameStartPoint3_17_3"
Stage3_SpawnPoint_Info[17].SpawnPoint_4 = "GameStartPoint3_17_4"
Stage3_SpawnPoint_Info[17].SpawnPoint_5 = "GameStartPoint3_17_01"
Stage3_SpawnPoint_Info[17].SpawnPoint_6 = "GameStartPoint3_17_02"
Stage3_SpawnPoint_Info[17].SpawnPoint_7 = "GameStartPoint3_17_03"
Stage3_SpawnPoint_Info[17].SpawnPoint_8 = "GameStartPoint3_17_04"	   
Stage3_SpawnPoint_Info[18] ={}
Stage3_SpawnPoint_Info[18].Area = "GameStartArea3_18"
Stage3_SpawnPoint_Info[18].Position = "Left"
Stage3_SpawnPoint_Info[18].Probability = 100
Stage3_SpawnPoint_Info[18].Door = "MovableModel3_28"
Stage3_SpawnPoint_Info[18].StartRoom = "EventArea3_3_1"
Stage3_SpawnPoint_Info[18].SpawnPointCount = 8
Stage3_SpawnPoint_Info[18].SpawnPoint_1 = "GameStartPoint3_18_1"
Stage3_SpawnPoint_Info[18].SpawnPoint_2 = "GameStartPoint3_18_2"
Stage3_SpawnPoint_Info[18].SpawnPoint_3 = "GameStartPoint3_18_3"
Stage3_SpawnPoint_Info[18].SpawnPoint_4 = "GameStartPoint3_18_4"
Stage3_SpawnPoint_Info[18].SpawnPoint_5 = "GameStartPoint3_18_01"
Stage3_SpawnPoint_Info[18].SpawnPoint_6 = "GameStartPoint3_18_02"
Stage3_SpawnPoint_Info[18].SpawnPoint_7 = "GameStartPoint3_18_03"
Stage3_SpawnPoint_Info[18].SpawnPoint_8 = "GameStartPoint3_18_04"	   
Stage3_SpawnPoint_Info[19] ={}
Stage3_SpawnPoint_Info[19].Area = "GameStartArea3_19"
Stage3_SpawnPoint_Info[19].Position = "Left"
Stage3_SpawnPoint_Info[19].Probability = 100
Stage3_SpawnPoint_Info[19].Door = "MovableModel3_17"
Stage3_SpawnPoint_Info[19].StartRoom = "EventArea3_2_1"
Stage3_SpawnPoint_Info[19].SpawnPointCount = 8
Stage3_SpawnPoint_Info[19].SpawnPoint_1 = "GameStartPoint3_19_1"
Stage3_SpawnPoint_Info[19].SpawnPoint_2 = "GameStartPoint3_19_2"
Stage3_SpawnPoint_Info[19].SpawnPoint_3 = "GameStartPoint3_19_3"
Stage3_SpawnPoint_Info[19].SpawnPoint_4 = "GameStartPoint3_19_4"
Stage3_SpawnPoint_Info[19].SpawnPoint_5 = "GameStartPoint3_19_01"
Stage3_SpawnPoint_Info[19].SpawnPoint_6 = "GameStartPoint3_19_02"
Stage3_SpawnPoint_Info[19].SpawnPoint_7 = "GameStartPoint3_19_03"
Stage3_SpawnPoint_Info[19].SpawnPoint_8 = "GameStartPoint3_19_04"	   
Stage3_SpawnPoint_Info[20] ={}
Stage3_SpawnPoint_Info[20].Area = "GameStartArea3_20"
Stage3_SpawnPoint_Info[20].Position = "Left"
Stage3_SpawnPoint_Info[20].Probability = 100
Stage3_SpawnPoint_Info[20].Door = "MovableModel3_6"
Stage3_SpawnPoint_Info[20].StartRoom = "EventArea3_1_1"
Stage3_SpawnPoint_Info[20].SpawnPointCount = 8
Stage3_SpawnPoint_Info[20].SpawnPoint_1 = "GameStartPoint3_20_1"
Stage3_SpawnPoint_Info[20].SpawnPoint_2 = "GameStartPoint3_20_2"
Stage3_SpawnPoint_Info[20].SpawnPoint_3 = "GameStartPoint3_20_3"
Stage3_SpawnPoint_Info[20].SpawnPoint_4 = "GameStartPoint3_20_4"
Stage3_SpawnPoint_Info[20].SpawnPoint_5 = "GameStartPoint3_20_01"
Stage3_SpawnPoint_Info[20].SpawnPoint_6 = "GameStartPoint3_20_02"
Stage3_SpawnPoint_Info[20].SpawnPoint_7 = "GameStartPoint3_20_03"
Stage3_SpawnPoint_Info[20].SpawnPoint_8 = "GameStartPoint3_20_04"	 
 
Stage4_SpawnPoint_Info = {}

Stage4_SpawnPoint_Info[1] ={}
Stage4_SpawnPoint_Info[1].Area = "GameStartArea4_1"
Stage4_SpawnPoint_Info[1].Position = "Bottom"
Stage4_SpawnPoint_Info[1].Probability = 100
Stage4_SpawnPoint_Info[1].Door = "MovableModel4_1"
Stage4_SpawnPoint_Info[1].StartRoom = "EventArea4_1_1"
Stage4_SpawnPoint_Info[1].SpawnPointCount = 8
Stage4_SpawnPoint_Info[1].SpawnPoint_1 = "GameStartPoint4_1_1"
Stage4_SpawnPoint_Info[1].SpawnPoint_2 = "GameStartPoint4_1_2"
Stage4_SpawnPoint_Info[1].SpawnPoint_3 = "GameStartPoint4_1_3"
Stage4_SpawnPoint_Info[1].SpawnPoint_4 = "GameStartPoint4_1_4"
Stage4_SpawnPoint_Info[1].SpawnPoint_5 = "GameStartPoint4_1_01"
Stage4_SpawnPoint_Info[1].SpawnPoint_6 = "GameStartPoint4_1_02"
Stage4_SpawnPoint_Info[1].SpawnPoint_7 = "GameStartPoint4_1_03"
Stage4_SpawnPoint_Info[1].SpawnPoint_8 = "GameStartPoint4_1_04"	   
Stage4_SpawnPoint_Info[2] ={}
Stage4_SpawnPoint_Info[2].Area = "GameStartArea4_2"
Stage4_SpawnPoint_Info[2].Position = "Bottom"
Stage4_SpawnPoint_Info[2].Probability = 100
Stage4_SpawnPoint_Info[2].Door = "MovableModel4_2"
Stage4_SpawnPoint_Info[2].StartRoom = "EventArea4_1_2"
Stage4_SpawnPoint_Info[2].SpawnPointCount = 8
Stage4_SpawnPoint_Info[2].SpawnPoint_1 = "GameStartPoint4_2_1"
Stage4_SpawnPoint_Info[2].SpawnPoint_2 = "GameStartPoint4_2_2"
Stage4_SpawnPoint_Info[2].SpawnPoint_3 = "GameStartPoint4_2_3"
Stage4_SpawnPoint_Info[2].SpawnPoint_4 = "GameStartPoint4_2_4"
Stage4_SpawnPoint_Info[2].SpawnPoint_5 = "GameStartPoint4_2_01"
Stage4_SpawnPoint_Info[2].SpawnPoint_6 = "GameStartPoint4_2_02"
Stage4_SpawnPoint_Info[2].SpawnPoint_7 = "GameStartPoint4_2_03"
Stage4_SpawnPoint_Info[2].SpawnPoint_8 = "GameStartPoint4_2_04"	   
Stage4_SpawnPoint_Info[3] ={}
Stage4_SpawnPoint_Info[3].Area = "GameStartArea4_3"
Stage4_SpawnPoint_Info[3].Position = "Bottom"
Stage4_SpawnPoint_Info[3].Probability = 100
Stage4_SpawnPoint_Info[3].Door = "MovableModel4_3"
Stage4_SpawnPoint_Info[3].StartRoom = "EventArea4_1_3"
Stage4_SpawnPoint_Info[3].SpawnPointCount = 8
Stage4_SpawnPoint_Info[3].SpawnPoint_1 = "GameStartPoint4_3_1"
Stage4_SpawnPoint_Info[3].SpawnPoint_2 = "GameStartPoint4_3_2"
Stage4_SpawnPoint_Info[3].SpawnPoint_3 = "GameStartPoint4_3_3"
Stage4_SpawnPoint_Info[3].SpawnPoint_4 = "GameStartPoint4_3_4"
Stage4_SpawnPoint_Info[3].SpawnPoint_5 = "GameStartPoint4_3_01"
Stage4_SpawnPoint_Info[3].SpawnPoint_6 = "GameStartPoint4_3_02"
Stage4_SpawnPoint_Info[3].SpawnPoint_7 = "GameStartPoint4_3_03"
Stage4_SpawnPoint_Info[3].SpawnPoint_8 = "GameStartPoint4_3_04"	   
Stage4_SpawnPoint_Info[4] ={}
Stage4_SpawnPoint_Info[4].Area = "GameStartArea4_4"
Stage4_SpawnPoint_Info[4].Position = "Bottom"
Stage4_SpawnPoint_Info[4].Probability = 100
Stage4_SpawnPoint_Info[4].Door = "MovableModel4_4"
Stage4_SpawnPoint_Info[4].StartRoom = "EventArea4_1_4"
Stage4_SpawnPoint_Info[4].SpawnPointCount = 8
Stage4_SpawnPoint_Info[4].SpawnPoint_1 = "GameStartPoint4_4_1"
Stage4_SpawnPoint_Info[4].SpawnPoint_2 = "GameStartPoint4_4_2"
Stage4_SpawnPoint_Info[4].SpawnPoint_3 = "GameStartPoint4_4_3"
Stage4_SpawnPoint_Info[4].SpawnPoint_4 = "GameStartPoint4_4_4"
Stage4_SpawnPoint_Info[4].SpawnPoint_5 = "GameStartPoint4_4_01"
Stage4_SpawnPoint_Info[4].SpawnPoint_6 = "GameStartPoint4_4_02"
Stage4_SpawnPoint_Info[4].SpawnPoint_7 = "GameStartPoint4_4_03"
Stage4_SpawnPoint_Info[4].SpawnPoint_8 = "GameStartPoint4_4_04"	   
Stage4_SpawnPoint_Info[5] ={}
Stage4_SpawnPoint_Info[5].Area = "GameStartArea4_5"
Stage4_SpawnPoint_Info[5].Position = "Bottom"
Stage4_SpawnPoint_Info[5].Probability = 100
Stage4_SpawnPoint_Info[5].Door = "MovableModel4_5"
Stage4_SpawnPoint_Info[5].StartRoom = "EventArea4_1_5"
Stage4_SpawnPoint_Info[5].SpawnPointCount = 8
Stage4_SpawnPoint_Info[5].SpawnPoint_1 = "GameStartPoint4_5_1"
Stage4_SpawnPoint_Info[5].SpawnPoint_2 = "GameStartPoint4_5_2"
Stage4_SpawnPoint_Info[5].SpawnPoint_3 = "GameStartPoint4_5_3"
Stage4_SpawnPoint_Info[5].SpawnPoint_4 = "GameStartPoint4_5_4"
Stage4_SpawnPoint_Info[5].SpawnPoint_5 = "GameStartPoint4_5_01"
Stage4_SpawnPoint_Info[5].SpawnPoint_6 = "GameStartPoint4_5_02"
Stage4_SpawnPoint_Info[5].SpawnPoint_7 = "GameStartPoint4_5_03"
Stage4_SpawnPoint_Info[5].SpawnPoint_8 = "GameStartPoint4_5_04"	   
Stage4_SpawnPoint_Info[6] ={}
Stage4_SpawnPoint_Info[6].Area = "GameStartArea4_6"
Stage4_SpawnPoint_Info[6].Position = "Right"
Stage4_SpawnPoint_Info[6].Probability = 100
Stage4_SpawnPoint_Info[6].Door = "MovableModel4_11"
Stage4_SpawnPoint_Info[6].StartRoom = "EventArea4_1_5"
Stage4_SpawnPoint_Info[6].SpawnPointCount = 8
Stage4_SpawnPoint_Info[6].SpawnPoint_1 = "GameStartPoint4_6_1"
Stage4_SpawnPoint_Info[6].SpawnPoint_2 = "GameStartPoint4_6_2"
Stage4_SpawnPoint_Info[6].SpawnPoint_3 = "GameStartPoint4_6_3"
Stage4_SpawnPoint_Info[6].SpawnPoint_4 = "GameStartPoint4_6_4"
Stage4_SpawnPoint_Info[6].SpawnPoint_5 = "GameStartPoint4_6_01"
Stage4_SpawnPoint_Info[6].SpawnPoint_6 = "GameStartPoint4_6_02"
Stage4_SpawnPoint_Info[6].SpawnPoint_7 = "GameStartPoint4_6_03"
Stage4_SpawnPoint_Info[6].SpawnPoint_8 = "GameStartPoint4_6_04"	   
Stage4_SpawnPoint_Info[7] ={}
Stage4_SpawnPoint_Info[7].Area = "GameStartArea4_7"
Stage4_SpawnPoint_Info[7].Position = "Right"
Stage4_SpawnPoint_Info[7].Probability = 100
Stage4_SpawnPoint_Info[7].Door = "MovableModel4_22"
Stage4_SpawnPoint_Info[7].StartRoom = "EventArea4_2_5"
Stage4_SpawnPoint_Info[7].SpawnPointCount = 8
Stage4_SpawnPoint_Info[7].SpawnPoint_1 = "GameStartPoint4_7_1"
Stage4_SpawnPoint_Info[7].SpawnPoint_2 = "GameStartPoint4_7_2"
Stage4_SpawnPoint_Info[7].SpawnPoint_3 = "GameStartPoint4_7_3"
Stage4_SpawnPoint_Info[7].SpawnPoint_4 = "GameStartPoint4_7_4"
Stage4_SpawnPoint_Info[7].SpawnPoint_5 = "GameStartPoint4_7_01"
Stage4_SpawnPoint_Info[7].SpawnPoint_6 = "GameStartPoint4_7_02"
Stage4_SpawnPoint_Info[7].SpawnPoint_7 = "GameStartPoint4_7_03"
Stage4_SpawnPoint_Info[7].SpawnPoint_8 = "GameStartPoint4_7_04"	   
Stage4_SpawnPoint_Info[8] ={}
Stage4_SpawnPoint_Info[8].Area = "GameStartArea4_8"
Stage4_SpawnPoint_Info[8].Position = "Right"
Stage4_SpawnPoint_Info[8].Probability = 100
Stage4_SpawnPoint_Info[8].Door = "MovableModel4_33"
Stage4_SpawnPoint_Info[8].StartRoom = "EventArea4_3_5"
Stage4_SpawnPoint_Info[8].SpawnPointCount = 8
Stage4_SpawnPoint_Info[8].SpawnPoint_1 = "GameStartPoint4_8_1"
Stage4_SpawnPoint_Info[8].SpawnPoint_2 = "GameStartPoint4_8_2"
Stage4_SpawnPoint_Info[8].SpawnPoint_3 = "GameStartPoint4_8_3"
Stage4_SpawnPoint_Info[8].SpawnPoint_4 = "GameStartPoint4_8_4"
Stage4_SpawnPoint_Info[8].SpawnPoint_5 = "GameStartPoint4_8_01"
Stage4_SpawnPoint_Info[8].SpawnPoint_6 = "GameStartPoint4_8_02"
Stage4_SpawnPoint_Info[8].SpawnPoint_7 = "GameStartPoint4_8_03"
Stage4_SpawnPoint_Info[8].SpawnPoint_8 = "GameStartPoint4_8_04"	   
Stage4_SpawnPoint_Info[9] ={}
Stage4_SpawnPoint_Info[9].Area = "GameStartArea4_9"
Stage4_SpawnPoint_Info[9].Position = "Right"
Stage4_SpawnPoint_Info[9].Probability = 100
Stage4_SpawnPoint_Info[9].Door = "MovableModel4_44"
Stage4_SpawnPoint_Info[9].StartRoom = "EventArea4_4_5"
Stage4_SpawnPoint_Info[9].SpawnPointCount = 8
Stage4_SpawnPoint_Info[9].SpawnPoint_1 = "GameStartPoint4_9_1"
Stage4_SpawnPoint_Info[9].SpawnPoint_2 = "GameStartPoint4_9_2"
Stage4_SpawnPoint_Info[9].SpawnPoint_3 = "GameStartPoint4_9_3"
Stage4_SpawnPoint_Info[9].SpawnPoint_4 = "GameStartPoint4_9_4"
Stage4_SpawnPoint_Info[9].SpawnPoint_5 = "GameStartPoint4_9_01"
Stage4_SpawnPoint_Info[9].SpawnPoint_6 = "GameStartPoint4_9_02"
Stage4_SpawnPoint_Info[9].SpawnPoint_7 = "GameStartPoint4_9_03"
Stage4_SpawnPoint_Info[9].SpawnPoint_8 = "GameStartPoint4_9_04"	   
Stage4_SpawnPoint_Info[10] ={}
Stage4_SpawnPoint_Info[10].Area = "GameStartArea4_10"
Stage4_SpawnPoint_Info[10].Position = "Right"
Stage4_SpawnPoint_Info[10].Probability = 100
Stage4_SpawnPoint_Info[10].Door = "MovableModel4_55"
Stage4_SpawnPoint_Info[10].StartRoom = "EventArea4_5_5"
Stage4_SpawnPoint_Info[10].SpawnPointCount = 8
Stage4_SpawnPoint_Info[10].SpawnPoint_1 = "GameStartPoint4_10_1"
Stage4_SpawnPoint_Info[10].SpawnPoint_2 = "GameStartPoint4_10_2"
Stage4_SpawnPoint_Info[10].SpawnPoint_3 = "GameStartPoint4_10_3"
Stage4_SpawnPoint_Info[10].SpawnPoint_4 = "GameStartPoint4_10_4"
Stage4_SpawnPoint_Info[10].SpawnPoint_5 = "GameStartPoint4_10_01"
Stage4_SpawnPoint_Info[10].SpawnPoint_6 = "GameStartPoint4_10_02"
Stage4_SpawnPoint_Info[10].SpawnPoint_7 = "GameStartPoint4_10_03"
Stage4_SpawnPoint_Info[10].SpawnPoint_8 = "GameStartPoint4_10_04"	   
Stage4_SpawnPoint_Info[11] ={}
Stage4_SpawnPoint_Info[11].Area = "GameStartArea4_11"
Stage4_SpawnPoint_Info[11].Position = "Top"
Stage4_SpawnPoint_Info[11].Probability = 100
Stage4_SpawnPoint_Info[11].Door = "MovableModel4_60"
Stage4_SpawnPoint_Info[11].StartRoom = "EventArea4_5_5"
Stage4_SpawnPoint_Info[11].SpawnPointCount = 8
Stage4_SpawnPoint_Info[11].SpawnPoint_1 = "GameStartPoint4_11_1"
Stage4_SpawnPoint_Info[11].SpawnPoint_2 = "GameStartPoint4_11_2"
Stage4_SpawnPoint_Info[11].SpawnPoint_3 = "GameStartPoint4_11_3"
Stage4_SpawnPoint_Info[11].SpawnPoint_4 = "GameStartPoint4_11_4"
Stage4_SpawnPoint_Info[11].SpawnPoint_5 = "GameStartPoint4_11_01"
Stage4_SpawnPoint_Info[11].SpawnPoint_6 = "GameStartPoint4_11_02"
Stage4_SpawnPoint_Info[11].SpawnPoint_7 = "GameStartPoint4_11_03"
Stage4_SpawnPoint_Info[11].SpawnPoint_8 = "GameStartPoint4_11_04"	   
Stage4_SpawnPoint_Info[12] ={}
Stage4_SpawnPoint_Info[12].Area = "GameStartArea4_12"
Stage4_SpawnPoint_Info[12].Position = "Top"
Stage4_SpawnPoint_Info[12].Probability = 100
Stage4_SpawnPoint_Info[12].Door = "MovableModel4_59"
Stage4_SpawnPoint_Info[12].StartRoom = "EventArea4_5_4"
Stage4_SpawnPoint_Info[12].SpawnPointCount = 8
Stage4_SpawnPoint_Info[12].SpawnPoint_1 = "GameStartPoint4_12_1"
Stage4_SpawnPoint_Info[12].SpawnPoint_2 = "GameStartPoint4_12_2"
Stage4_SpawnPoint_Info[12].SpawnPoint_3 = "GameStartPoint4_12_3"
Stage4_SpawnPoint_Info[12].SpawnPoint_4 = "GameStartPoint4_12_4"
Stage4_SpawnPoint_Info[12].SpawnPoint_5 = "GameStartPoint4_12_01"
Stage4_SpawnPoint_Info[12].SpawnPoint_6 = "GameStartPoint4_12_02"
Stage4_SpawnPoint_Info[12].SpawnPoint_7 = "GameStartPoint4_12_03"
Stage4_SpawnPoint_Info[12].SpawnPoint_8 = "GameStartPoint4_12_04"	   
Stage4_SpawnPoint_Info[13] ={}
Stage4_SpawnPoint_Info[13].Area = "GameStartArea4_13"
Stage4_SpawnPoint_Info[13].Position = "Top"
Stage4_SpawnPoint_Info[13].Probability = 100
Stage4_SpawnPoint_Info[13].Door = "MovableModel4_58"
Stage4_SpawnPoint_Info[13].StartRoom = "EventArea4_5_3"
Stage4_SpawnPoint_Info[13].SpawnPointCount = 8
Stage4_SpawnPoint_Info[13].SpawnPoint_1 = "GameStartPoint4_13_1"
Stage4_SpawnPoint_Info[13].SpawnPoint_2 = "GameStartPoint4_13_2"
Stage4_SpawnPoint_Info[13].SpawnPoint_3 = "GameStartPoint4_13_3"
Stage4_SpawnPoint_Info[13].SpawnPoint_4 = "GameStartPoint4_13_4"
Stage4_SpawnPoint_Info[13].SpawnPoint_5 = "GameStartPoint4_13_01"
Stage4_SpawnPoint_Info[13].SpawnPoint_6 = "GameStartPoint4_13_02"
Stage4_SpawnPoint_Info[13].SpawnPoint_7 = "GameStartPoint4_13_03"
Stage4_SpawnPoint_Info[13].SpawnPoint_8 = "GameStartPoint4_13_04"	   
Stage4_SpawnPoint_Info[14] ={}
Stage4_SpawnPoint_Info[14].Area = "GameStartArea4_14"
Stage4_SpawnPoint_Info[14].Position = "Top"
Stage4_SpawnPoint_Info[14].Probability = 100
Stage4_SpawnPoint_Info[14].Door = "MovableModel4_57"
Stage4_SpawnPoint_Info[14].StartRoom = "EventArea4_5_2"
Stage4_SpawnPoint_Info[14].SpawnPointCount = 8
Stage4_SpawnPoint_Info[14].SpawnPoint_1 = "GameStartPoint4_14_1"
Stage4_SpawnPoint_Info[14].SpawnPoint_2 = "GameStartPoint4_14_2"
Stage4_SpawnPoint_Info[14].SpawnPoint_3 = "GameStartPoint4_14_3"
Stage4_SpawnPoint_Info[14].SpawnPoint_4 = "GameStartPoint4_14_4"
Stage4_SpawnPoint_Info[14].SpawnPoint_5 = "GameStartPoint4_14_01"
Stage4_SpawnPoint_Info[14].SpawnPoint_6 = "GameStartPoint4_14_02"
Stage4_SpawnPoint_Info[14].SpawnPoint_7 = "GameStartPoint4_14_03"
Stage4_SpawnPoint_Info[14].SpawnPoint_8 = "GameStartPoint4_14_04"	   
Stage4_SpawnPoint_Info[15] ={}
Stage4_SpawnPoint_Info[15].Area = "GameStartArea4_15"
Stage4_SpawnPoint_Info[15].Position = "Top"
Stage4_SpawnPoint_Info[15].Probability = 100
Stage4_SpawnPoint_Info[15].Door = "MovableModel4_56"
Stage4_SpawnPoint_Info[15].StartRoom = "EventArea4_5_1"
Stage4_SpawnPoint_Info[15].SpawnPointCount = 8
Stage4_SpawnPoint_Info[15].SpawnPoint_1 = "GameStartPoint4_15_1"
Stage4_SpawnPoint_Info[15].SpawnPoint_2 = "GameStartPoint4_15_2"
Stage4_SpawnPoint_Info[15].SpawnPoint_3 = "GameStartPoint4_15_3"
Stage4_SpawnPoint_Info[15].SpawnPoint_4 = "GameStartPoint4_15_4"
Stage4_SpawnPoint_Info[15].SpawnPoint_5 = "GameStartPoint4_15_01"
Stage4_SpawnPoint_Info[15].SpawnPoint_6 = "GameStartPoint4_15_02"
Stage4_SpawnPoint_Info[15].SpawnPoint_7 = "GameStartPoint4_15_03"
Stage4_SpawnPoint_Info[15].SpawnPoint_8 = "GameStartPoint4_15_04"	   
Stage4_SpawnPoint_Info[16] ={}
Stage4_SpawnPoint_Info[16].Area = "GameStartArea4_16"
Stage4_SpawnPoint_Info[16].Position = "Left"
Stage4_SpawnPoint_Info[16].Probability = 100
Stage4_SpawnPoint_Info[16].Door = "MovableModel4_50"
Stage4_SpawnPoint_Info[16].StartRoom = "EventArea4_5_1"
Stage4_SpawnPoint_Info[16].SpawnPointCount = 8
Stage4_SpawnPoint_Info[16].SpawnPoint_1 = "GameStartPoint4_16_1"
Stage4_SpawnPoint_Info[16].SpawnPoint_2 = "GameStartPoint4_16_2"
Stage4_SpawnPoint_Info[16].SpawnPoint_3 = "GameStartPoint4_16_3"
Stage4_SpawnPoint_Info[16].SpawnPoint_4 = "GameStartPoint4_16_4"
Stage4_SpawnPoint_Info[16].SpawnPoint_5 = "GameStartPoint4_16_01"
Stage4_SpawnPoint_Info[16].SpawnPoint_6 = "GameStartPoint4_16_02"
Stage4_SpawnPoint_Info[16].SpawnPoint_7 = "GameStartPoint4_16_03"
Stage4_SpawnPoint_Info[16].SpawnPoint_8 = "GameStartPoint4_16_04"	   
Stage4_SpawnPoint_Info[17] ={}
Stage4_SpawnPoint_Info[17].Area = "GameStartArea4_17"
Stage4_SpawnPoint_Info[17].Position = "Left"
Stage4_SpawnPoint_Info[17].Probability = 100
Stage4_SpawnPoint_Info[17].Door = "MovableModel4_39"
Stage4_SpawnPoint_Info[17].StartRoom = "EventArea4_4_1"
Stage4_SpawnPoint_Info[17].SpawnPointCount = 8
Stage4_SpawnPoint_Info[17].SpawnPoint_1 = "GameStartPoint4_17_1"
Stage4_SpawnPoint_Info[17].SpawnPoint_2 = "GameStartPoint4_17_2"
Stage4_SpawnPoint_Info[17].SpawnPoint_3 = "GameStartPoint4_17_3"
Stage4_SpawnPoint_Info[17].SpawnPoint_4 = "GameStartPoint4_17_4"
Stage4_SpawnPoint_Info[17].SpawnPoint_5 = "GameStartPoint4_17_01"
Stage4_SpawnPoint_Info[17].SpawnPoint_6 = "GameStartPoint4_17_02"
Stage4_SpawnPoint_Info[17].SpawnPoint_7 = "GameStartPoint4_17_03"
Stage4_SpawnPoint_Info[17].SpawnPoint_8 = "GameStartPoint4_17_04"	   
Stage4_SpawnPoint_Info[18] ={}
Stage4_SpawnPoint_Info[18].Area = "GameStartArea4_18"
Stage4_SpawnPoint_Info[18].Position = "Left"
Stage4_SpawnPoint_Info[18].Probability = 100
Stage4_SpawnPoint_Info[18].Door = "MovableModel4_28"
Stage4_SpawnPoint_Info[18].StartRoom = "EventArea4_3_1"
Stage4_SpawnPoint_Info[18].SpawnPointCount = 8
Stage4_SpawnPoint_Info[18].SpawnPoint_1 = "GameStartPoint4_18_1"
Stage4_SpawnPoint_Info[18].SpawnPoint_2 = "GameStartPoint4_18_2"
Stage4_SpawnPoint_Info[18].SpawnPoint_3 = "GameStartPoint4_18_3"
Stage4_SpawnPoint_Info[18].SpawnPoint_4 = "GameStartPoint4_18_4"
Stage4_SpawnPoint_Info[18].SpawnPoint_5 = "GameStartPoint4_18_01"
Stage4_SpawnPoint_Info[18].SpawnPoint_6 = "GameStartPoint4_18_02"
Stage4_SpawnPoint_Info[18].SpawnPoint_7 = "GameStartPoint4_18_03"
Stage4_SpawnPoint_Info[18].SpawnPoint_8 = "GameStartPoint4_18_04"	   
Stage4_SpawnPoint_Info[19] ={}
Stage4_SpawnPoint_Info[19].Area = "GameStartArea4_19"
Stage4_SpawnPoint_Info[19].Position = "Left"
Stage4_SpawnPoint_Info[19].Probability = 100
Stage4_SpawnPoint_Info[19].Door = "MovableModel4_17"
Stage4_SpawnPoint_Info[19].StartRoom = "EventArea4_2_1"
Stage4_SpawnPoint_Info[19].SpawnPointCount = 8
Stage4_SpawnPoint_Info[19].SpawnPoint_1 = "GameStartPoint4_19_1"
Stage4_SpawnPoint_Info[19].SpawnPoint_2 = "GameStartPoint4_19_2"
Stage4_SpawnPoint_Info[19].SpawnPoint_3 = "GameStartPoint4_19_3"
Stage4_SpawnPoint_Info[19].SpawnPoint_4 = "GameStartPoint4_19_4"
Stage4_SpawnPoint_Info[19].SpawnPoint_5 = "GameStartPoint4_19_01"
Stage4_SpawnPoint_Info[19].SpawnPoint_6 = "GameStartPoint4_19_02"
Stage4_SpawnPoint_Info[19].SpawnPoint_7 = "GameStartPoint4_19_03"
Stage4_SpawnPoint_Info[19].SpawnPoint_8 = "GameStartPoint4_19_04"	   
Stage4_SpawnPoint_Info[20] ={}
Stage4_SpawnPoint_Info[20].Area = "GameStartArea4_20"
Stage4_SpawnPoint_Info[20].Position = "Left"
Stage4_SpawnPoint_Info[20].Probability = 100
Stage4_SpawnPoint_Info[20].Door = "MovableModel4_6"
Stage4_SpawnPoint_Info[20].StartRoom = "EventArea4_1_1"
Stage4_SpawnPoint_Info[20].SpawnPointCount = 8
Stage4_SpawnPoint_Info[20].SpawnPoint_1 = "GameStartPoint4_20_1"
Stage4_SpawnPoint_Info[20].SpawnPoint_2 = "GameStartPoint4_20_2"
Stage4_SpawnPoint_Info[20].SpawnPoint_3 = "GameStartPoint4_20_3"
Stage4_SpawnPoint_Info[20].SpawnPoint_4 = "GameStartPoint4_20_4"
Stage4_SpawnPoint_Info[20].SpawnPoint_5 = "GameStartPoint4_20_01"
Stage4_SpawnPoint_Info[20].SpawnPoint_6 = "GameStartPoint4_20_02"
Stage4_SpawnPoint_Info[20].SpawnPoint_7 = "GameStartPoint4_20_03"
Stage4_SpawnPoint_Info[20].SpawnPoint_8 = "GameStartPoint4_20_04"	 
 
Stage5_SpawnPoint_Info = {}

Stage5_SpawnPoint_Info[1] ={}
Stage5_SpawnPoint_Info[1].Area = "GameStartArea5_1"
Stage5_SpawnPoint_Info[1].Position = "Bottom"
Stage5_SpawnPoint_Info[1].Probability = 100
Stage5_SpawnPoint_Info[1].Door = "MovableModel5_1"
Stage5_SpawnPoint_Info[1].StartRoom = "EventArea5_1_1"
Stage5_SpawnPoint_Info[1].SpawnPointCount = 8
Stage5_SpawnPoint_Info[1].SpawnPoint_1 = "GameStartPoint5_1_1"
Stage5_SpawnPoint_Info[1].SpawnPoint_2 = "GameStartPoint5_1_2"
Stage5_SpawnPoint_Info[1].SpawnPoint_3 = "GameStartPoint5_1_3"
Stage5_SpawnPoint_Info[1].SpawnPoint_4 = "GameStartPoint5_1_4"
Stage5_SpawnPoint_Info[1].SpawnPoint_5 = "GameStartPoint5_1_01"
Stage5_SpawnPoint_Info[1].SpawnPoint_6 = "GameStartPoint5_1_02"
Stage5_SpawnPoint_Info[1].SpawnPoint_7 = "GameStartPoint5_1_03"
Stage5_SpawnPoint_Info[1].SpawnPoint_8 = "GameStartPoint5_1_04"	   
Stage5_SpawnPoint_Info[2] ={}
Stage5_SpawnPoint_Info[2].Area = "GameStartArea5_2"
Stage5_SpawnPoint_Info[2].Position = "Bottom"
Stage5_SpawnPoint_Info[2].Probability = 100
Stage5_SpawnPoint_Info[2].Door = "MovableModel5_2"
Stage5_SpawnPoint_Info[2].StartRoom = "EventArea5_1_2"
Stage5_SpawnPoint_Info[2].SpawnPointCount = 8
Stage5_SpawnPoint_Info[2].SpawnPoint_1 = "GameStartPoint5_2_1"
Stage5_SpawnPoint_Info[2].SpawnPoint_2 = "GameStartPoint5_2_2"
Stage5_SpawnPoint_Info[2].SpawnPoint_3 = "GameStartPoint5_2_3"
Stage5_SpawnPoint_Info[2].SpawnPoint_4 = "GameStartPoint5_2_4"
Stage5_SpawnPoint_Info[2].SpawnPoint_5 = "GameStartPoint5_2_01"
Stage5_SpawnPoint_Info[2].SpawnPoint_6 = "GameStartPoint5_2_02"
Stage5_SpawnPoint_Info[2].SpawnPoint_7 = "GameStartPoint5_2_03"
Stage5_SpawnPoint_Info[2].SpawnPoint_8 = "GameStartPoint5_2_04"	   
Stage5_SpawnPoint_Info[3] ={}
Stage5_SpawnPoint_Info[3].Area = "GameStartArea5_3"
Stage5_SpawnPoint_Info[3].Position = "Bottom"
Stage5_SpawnPoint_Info[3].Probability = 100
Stage5_SpawnPoint_Info[3].Door = "MovableModel5_3"
Stage5_SpawnPoint_Info[3].StartRoom = "EventArea5_1_3"
Stage5_SpawnPoint_Info[3].SpawnPointCount = 8
Stage5_SpawnPoint_Info[3].SpawnPoint_1 = "GameStartPoint5_3_1"
Stage5_SpawnPoint_Info[3].SpawnPoint_2 = "GameStartPoint5_3_2"
Stage5_SpawnPoint_Info[3].SpawnPoint_3 = "GameStartPoint5_3_3"
Stage5_SpawnPoint_Info[3].SpawnPoint_4 = "GameStartPoint5_3_4"
Stage5_SpawnPoint_Info[3].SpawnPoint_5 = "GameStartPoint5_3_01"
Stage5_SpawnPoint_Info[3].SpawnPoint_6 = "GameStartPoint5_3_02"
Stage5_SpawnPoint_Info[3].SpawnPoint_7 = "GameStartPoint5_3_03"
Stage5_SpawnPoint_Info[3].SpawnPoint_8 = "GameStartPoint5_3_04"	   
Stage5_SpawnPoint_Info[4] ={}
Stage5_SpawnPoint_Info[4].Area = "GameStartArea5_4"
Stage5_SpawnPoint_Info[4].Position = "Bottom"
Stage5_SpawnPoint_Info[4].Probability = 100
Stage5_SpawnPoint_Info[4].Door = "MovableModel5_4"
Stage5_SpawnPoint_Info[4].StartRoom = "EventArea5_1_4"
Stage5_SpawnPoint_Info[4].SpawnPointCount = 8
Stage5_SpawnPoint_Info[4].SpawnPoint_1 = "GameStartPoint5_4_1"
Stage5_SpawnPoint_Info[4].SpawnPoint_2 = "GameStartPoint5_4_2"
Stage5_SpawnPoint_Info[4].SpawnPoint_3 = "GameStartPoint5_4_3"
Stage5_SpawnPoint_Info[4].SpawnPoint_4 = "GameStartPoint5_4_4"
Stage5_SpawnPoint_Info[4].SpawnPoint_5 = "GameStartPoint5_4_01"
Stage5_SpawnPoint_Info[4].SpawnPoint_6 = "GameStartPoint5_4_02"
Stage5_SpawnPoint_Info[4].SpawnPoint_7 = "GameStartPoint5_4_03"
Stage5_SpawnPoint_Info[4].SpawnPoint_8 = "GameStartPoint5_4_04"	   
Stage5_SpawnPoint_Info[5] ={}
Stage5_SpawnPoint_Info[5].Area = "GameStartArea5_5"
Stage5_SpawnPoint_Info[5].Position = "Bottom"
Stage5_SpawnPoint_Info[5].Probability = 100
Stage5_SpawnPoint_Info[5].Door = "MovableModel5_5"
Stage5_SpawnPoint_Info[5].StartRoom = "EventArea5_1_5"
Stage5_SpawnPoint_Info[5].SpawnPointCount = 8
Stage5_SpawnPoint_Info[5].SpawnPoint_1 = "GameStartPoint5_5_1"
Stage5_SpawnPoint_Info[5].SpawnPoint_2 = "GameStartPoint5_5_2"
Stage5_SpawnPoint_Info[5].SpawnPoint_3 = "GameStartPoint5_5_3"
Stage5_SpawnPoint_Info[5].SpawnPoint_4 = "GameStartPoint5_5_4"
Stage5_SpawnPoint_Info[5].SpawnPoint_5 = "GameStartPoint5_5_01"
Stage5_SpawnPoint_Info[5].SpawnPoint_6 = "GameStartPoint5_5_02"
Stage5_SpawnPoint_Info[5].SpawnPoint_7 = "GameStartPoint5_5_03"
Stage5_SpawnPoint_Info[5].SpawnPoint_8 = "GameStartPoint5_5_04"	   
Stage5_SpawnPoint_Info[6] ={}
Stage5_SpawnPoint_Info[6].Area = "GameStartArea5_6"
Stage5_SpawnPoint_Info[6].Position = "Right"
Stage5_SpawnPoint_Info[6].Probability = 100
Stage5_SpawnPoint_Info[6].Door = "MovableModel5_11"
Stage5_SpawnPoint_Info[6].StartRoom = "EventArea5_1_5"
Stage5_SpawnPoint_Info[6].SpawnPointCount = 8
Stage5_SpawnPoint_Info[6].SpawnPoint_1 = "GameStartPoint5_6_1"
Stage5_SpawnPoint_Info[6].SpawnPoint_2 = "GameStartPoint5_6_2"
Stage5_SpawnPoint_Info[6].SpawnPoint_3 = "GameStartPoint5_6_3"
Stage5_SpawnPoint_Info[6].SpawnPoint_4 = "GameStartPoint5_6_4"
Stage5_SpawnPoint_Info[6].SpawnPoint_5 = "GameStartPoint5_6_01"
Stage5_SpawnPoint_Info[6].SpawnPoint_6 = "GameStartPoint5_6_02"
Stage5_SpawnPoint_Info[6].SpawnPoint_7 = "GameStartPoint5_6_03"
Stage5_SpawnPoint_Info[6].SpawnPoint_8 = "GameStartPoint5_6_04"	   
Stage5_SpawnPoint_Info[7] ={}
Stage5_SpawnPoint_Info[7].Area = "GameStartArea5_7"
Stage5_SpawnPoint_Info[7].Position = "Right"
Stage5_SpawnPoint_Info[7].Probability = 100
Stage5_SpawnPoint_Info[7].Door = "MovableModel5_22"
Stage5_SpawnPoint_Info[7].StartRoom = "EventArea5_2_5"
Stage5_SpawnPoint_Info[7].SpawnPointCount = 8
Stage5_SpawnPoint_Info[7].SpawnPoint_1 = "GameStartPoint5_7_1"
Stage5_SpawnPoint_Info[7].SpawnPoint_2 = "GameStartPoint5_7_2"
Stage5_SpawnPoint_Info[7].SpawnPoint_3 = "GameStartPoint5_7_3"
Stage5_SpawnPoint_Info[7].SpawnPoint_4 = "GameStartPoint5_7_4"
Stage5_SpawnPoint_Info[7].SpawnPoint_5 = "GameStartPoint5_7_01"
Stage5_SpawnPoint_Info[7].SpawnPoint_6 = "GameStartPoint5_7_02"
Stage5_SpawnPoint_Info[7].SpawnPoint_7 = "GameStartPoint5_7_03"
Stage5_SpawnPoint_Info[7].SpawnPoint_8 = "GameStartPoint5_7_04"	   
Stage5_SpawnPoint_Info[8] ={}
Stage5_SpawnPoint_Info[8].Area = "GameStartArea5_8"
Stage5_SpawnPoint_Info[8].Position = "Right"
Stage5_SpawnPoint_Info[8].Probability = 100
Stage5_SpawnPoint_Info[8].Door = "MovableModel5_33"
Stage5_SpawnPoint_Info[8].StartRoom = "EventArea5_3_5"
Stage5_SpawnPoint_Info[8].SpawnPointCount = 8
Stage5_SpawnPoint_Info[8].SpawnPoint_1 = "GameStartPoint5_8_1"
Stage5_SpawnPoint_Info[8].SpawnPoint_2 = "GameStartPoint5_8_2"
Stage5_SpawnPoint_Info[8].SpawnPoint_3 = "GameStartPoint5_8_3"
Stage5_SpawnPoint_Info[8].SpawnPoint_4 = "GameStartPoint5_8_4"
Stage5_SpawnPoint_Info[8].SpawnPoint_5 = "GameStartPoint5_8_01"
Stage5_SpawnPoint_Info[8].SpawnPoint_6 = "GameStartPoint5_8_02"
Stage5_SpawnPoint_Info[8].SpawnPoint_7 = "GameStartPoint5_8_03"
Stage5_SpawnPoint_Info[8].SpawnPoint_8 = "GameStartPoint5_8_04"	   
Stage5_SpawnPoint_Info[9] ={}
Stage5_SpawnPoint_Info[9].Area = "GameStartArea5_9"
Stage5_SpawnPoint_Info[9].Position = "Right"
Stage5_SpawnPoint_Info[9].Probability = 100
Stage5_SpawnPoint_Info[9].Door = "MovableModel5_44"
Stage5_SpawnPoint_Info[9].StartRoom = "EventArea5_4_5"
Stage5_SpawnPoint_Info[9].SpawnPointCount = 8
Stage5_SpawnPoint_Info[9].SpawnPoint_1 = "GameStartPoint5_9_1"
Stage5_SpawnPoint_Info[9].SpawnPoint_2 = "GameStartPoint5_9_2"
Stage5_SpawnPoint_Info[9].SpawnPoint_3 = "GameStartPoint5_9_3"
Stage5_SpawnPoint_Info[9].SpawnPoint_4 = "GameStartPoint5_9_4"
Stage5_SpawnPoint_Info[9].SpawnPoint_5 = "GameStartPoint5_9_01"
Stage5_SpawnPoint_Info[9].SpawnPoint_6 = "GameStartPoint5_9_02"
Stage5_SpawnPoint_Info[9].SpawnPoint_7 = "GameStartPoint5_9_03"
Stage5_SpawnPoint_Info[9].SpawnPoint_8 = "GameStartPoint5_9_04"	   
Stage5_SpawnPoint_Info[10] ={}
Stage5_SpawnPoint_Info[10].Area = "GameStartArea5_10"
Stage5_SpawnPoint_Info[10].Position = "Right"
Stage5_SpawnPoint_Info[10].Probability = 100
Stage5_SpawnPoint_Info[10].Door = "MovableModel5_55"
Stage5_SpawnPoint_Info[10].StartRoom = "EventArea5_5_5"
Stage5_SpawnPoint_Info[10].SpawnPointCount = 8
Stage5_SpawnPoint_Info[10].SpawnPoint_1 = "GameStartPoint5_10_1"
Stage5_SpawnPoint_Info[10].SpawnPoint_2 = "GameStartPoint5_10_2"
Stage5_SpawnPoint_Info[10].SpawnPoint_3 = "GameStartPoint5_10_3"
Stage5_SpawnPoint_Info[10].SpawnPoint_4 = "GameStartPoint5_10_4"
Stage5_SpawnPoint_Info[10].SpawnPoint_5 = "GameStartPoint5_10_01"
Stage5_SpawnPoint_Info[10].SpawnPoint_6 = "GameStartPoint5_10_02"
Stage5_SpawnPoint_Info[10].SpawnPoint_7 = "GameStartPoint5_10_03"
Stage5_SpawnPoint_Info[10].SpawnPoint_8 = "GameStartPoint5_10_04"	   
Stage5_SpawnPoint_Info[11] ={}
Stage5_SpawnPoint_Info[11].Area = "GameStartArea5_11"
Stage5_SpawnPoint_Info[11].Position = "Top"
Stage5_SpawnPoint_Info[11].Probability = 100
Stage5_SpawnPoint_Info[11].Door = "MovableModel5_60"
Stage5_SpawnPoint_Info[11].StartRoom = "EventArea5_5_5"
Stage5_SpawnPoint_Info[11].SpawnPointCount = 8
Stage5_SpawnPoint_Info[11].SpawnPoint_1 = "GameStartPoint5_11_1"
Stage5_SpawnPoint_Info[11].SpawnPoint_2 = "GameStartPoint5_11_2"
Stage5_SpawnPoint_Info[11].SpawnPoint_3 = "GameStartPoint5_11_3"
Stage5_SpawnPoint_Info[11].SpawnPoint_4 = "GameStartPoint5_11_4"
Stage5_SpawnPoint_Info[11].SpawnPoint_5 = "GameStartPoint5_11_01"
Stage5_SpawnPoint_Info[11].SpawnPoint_6 = "GameStartPoint5_11_02"
Stage5_SpawnPoint_Info[11].SpawnPoint_7 = "GameStartPoint5_11_03"
Stage5_SpawnPoint_Info[11].SpawnPoint_8 = "GameStartPoint5_11_04"	   
Stage5_SpawnPoint_Info[12] ={}
Stage5_SpawnPoint_Info[12].Area = "GameStartArea5_12"
Stage5_SpawnPoint_Info[12].Position = "Top"
Stage5_SpawnPoint_Info[12].Probability = 100
Stage5_SpawnPoint_Info[12].Door = "MovableModel5_59"
Stage5_SpawnPoint_Info[12].StartRoom = "EventArea5_5_4"
Stage5_SpawnPoint_Info[12].SpawnPointCount = 8
Stage5_SpawnPoint_Info[12].SpawnPoint_1 = "GameStartPoint5_12_1"
Stage5_SpawnPoint_Info[12].SpawnPoint_2 = "GameStartPoint5_12_2"
Stage5_SpawnPoint_Info[12].SpawnPoint_3 = "GameStartPoint5_12_3"
Stage5_SpawnPoint_Info[12].SpawnPoint_4 = "GameStartPoint5_12_4"
Stage5_SpawnPoint_Info[12].SpawnPoint_5 = "GameStartPoint5_12_01"
Stage5_SpawnPoint_Info[12].SpawnPoint_6 = "GameStartPoint5_12_02"
Stage5_SpawnPoint_Info[12].SpawnPoint_7 = "GameStartPoint5_12_03"
Stage5_SpawnPoint_Info[12].SpawnPoint_8 = "GameStartPoint5_12_04"	   
Stage5_SpawnPoint_Info[13] ={}
Stage5_SpawnPoint_Info[13].Area = "GameStartArea5_13"
Stage5_SpawnPoint_Info[13].Position = "Top"
Stage5_SpawnPoint_Info[13].Probability = 100
Stage5_SpawnPoint_Info[13].Door = "MovableModel5_58"
Stage5_SpawnPoint_Info[13].StartRoom = "EventArea5_5_3"
Stage5_SpawnPoint_Info[13].SpawnPointCount = 8
Stage5_SpawnPoint_Info[13].SpawnPoint_1 = "GameStartPoint5_13_1"
Stage5_SpawnPoint_Info[13].SpawnPoint_2 = "GameStartPoint5_13_2"
Stage5_SpawnPoint_Info[13].SpawnPoint_3 = "GameStartPoint5_13_3"
Stage5_SpawnPoint_Info[13].SpawnPoint_4 = "GameStartPoint5_13_4"
Stage5_SpawnPoint_Info[13].SpawnPoint_5 = "GameStartPoint5_13_01"
Stage5_SpawnPoint_Info[13].SpawnPoint_6 = "GameStartPoint5_13_02"
Stage5_SpawnPoint_Info[13].SpawnPoint_7 = "GameStartPoint5_13_03"
Stage5_SpawnPoint_Info[13].SpawnPoint_8 = "GameStartPoint5_13_04"	   
Stage5_SpawnPoint_Info[14] ={}
Stage5_SpawnPoint_Info[14].Area = "GameStartArea5_14"
Stage5_SpawnPoint_Info[14].Position = "Top"
Stage5_SpawnPoint_Info[14].Probability = 100
Stage5_SpawnPoint_Info[14].Door = "MovableModel5_57"
Stage5_SpawnPoint_Info[14].StartRoom = "EventArea5_5_2"
Stage5_SpawnPoint_Info[14].SpawnPointCount = 8
Stage5_SpawnPoint_Info[14].SpawnPoint_1 = "GameStartPoint5_14_1"
Stage5_SpawnPoint_Info[14].SpawnPoint_2 = "GameStartPoint5_14_2"
Stage5_SpawnPoint_Info[14].SpawnPoint_3 = "GameStartPoint5_14_3"
Stage5_SpawnPoint_Info[14].SpawnPoint_4 = "GameStartPoint5_14_4"
Stage5_SpawnPoint_Info[14].SpawnPoint_5 = "GameStartPoint5_14_01"
Stage5_SpawnPoint_Info[14].SpawnPoint_6 = "GameStartPoint5_14_02"
Stage5_SpawnPoint_Info[14].SpawnPoint_7 = "GameStartPoint5_14_03"
Stage5_SpawnPoint_Info[14].SpawnPoint_8 = "GameStartPoint5_14_04"	   
Stage5_SpawnPoint_Info[15] ={}
Stage5_SpawnPoint_Info[15].Area = "GameStartArea5_15"
Stage5_SpawnPoint_Info[15].Position = "Top"
Stage5_SpawnPoint_Info[15].Probability = 100
Stage5_SpawnPoint_Info[15].Door = "MovableModel5_56"
Stage5_SpawnPoint_Info[15].StartRoom = "EventArea5_5_1"
Stage5_SpawnPoint_Info[15].SpawnPointCount = 8
Stage5_SpawnPoint_Info[15].SpawnPoint_1 = "GameStartPoint5_15_1"
Stage5_SpawnPoint_Info[15].SpawnPoint_2 = "GameStartPoint5_15_2"
Stage5_SpawnPoint_Info[15].SpawnPoint_3 = "GameStartPoint5_15_3"
Stage5_SpawnPoint_Info[15].SpawnPoint_4 = "GameStartPoint5_15_4"
Stage5_SpawnPoint_Info[15].SpawnPoint_5 = "GameStartPoint5_15_01"
Stage5_SpawnPoint_Info[15].SpawnPoint_6 = "GameStartPoint5_15_02"
Stage5_SpawnPoint_Info[15].SpawnPoint_7 = "GameStartPoint5_15_03"
Stage5_SpawnPoint_Info[15].SpawnPoint_8 = "GameStartPoint5_15_04"	   
Stage5_SpawnPoint_Info[16] ={}
Stage5_SpawnPoint_Info[16].Area = "GameStartArea5_16"
Stage5_SpawnPoint_Info[16].Position = "Left"
Stage5_SpawnPoint_Info[16].Probability = 100
Stage5_SpawnPoint_Info[16].Door = "MovableModel5_50"
Stage5_SpawnPoint_Info[16].StartRoom = "EventArea5_5_1"
Stage5_SpawnPoint_Info[16].SpawnPointCount = 8
Stage5_SpawnPoint_Info[16].SpawnPoint_1 = "GameStartPoint5_16_1"
Stage5_SpawnPoint_Info[16].SpawnPoint_2 = "GameStartPoint5_16_2"
Stage5_SpawnPoint_Info[16].SpawnPoint_3 = "GameStartPoint5_16_3"
Stage5_SpawnPoint_Info[16].SpawnPoint_4 = "GameStartPoint5_16_4"
Stage5_SpawnPoint_Info[16].SpawnPoint_5 = "GameStartPoint5_16_01"
Stage5_SpawnPoint_Info[16].SpawnPoint_6 = "GameStartPoint5_16_02"
Stage5_SpawnPoint_Info[16].SpawnPoint_7 = "GameStartPoint5_16_03"
Stage5_SpawnPoint_Info[16].SpawnPoint_8 = "GameStartPoint5_16_04"	   
Stage5_SpawnPoint_Info[17] ={}
Stage5_SpawnPoint_Info[17].Area = "GameStartArea5_17"
Stage5_SpawnPoint_Info[17].Position = "Left"
Stage5_SpawnPoint_Info[17].Probability = 100
Stage5_SpawnPoint_Info[17].Door = "MovableModel5_39"
Stage5_SpawnPoint_Info[17].StartRoom = "EventArea5_4_1"
Stage5_SpawnPoint_Info[17].SpawnPointCount = 8
Stage5_SpawnPoint_Info[17].SpawnPoint_1 = "GameStartPoint5_17_1"
Stage5_SpawnPoint_Info[17].SpawnPoint_2 = "GameStartPoint5_17_2"
Stage5_SpawnPoint_Info[17].SpawnPoint_3 = "GameStartPoint5_17_3"
Stage5_SpawnPoint_Info[17].SpawnPoint_4 = "GameStartPoint5_17_4"
Stage5_SpawnPoint_Info[17].SpawnPoint_5 = "GameStartPoint5_17_01"
Stage5_SpawnPoint_Info[17].SpawnPoint_6 = "GameStartPoint5_17_02"
Stage5_SpawnPoint_Info[17].SpawnPoint_7 = "GameStartPoint5_17_03"
Stage5_SpawnPoint_Info[17].SpawnPoint_8 = "GameStartPoint5_17_04"	   
Stage5_SpawnPoint_Info[18] ={}
Stage5_SpawnPoint_Info[18].Area = "GameStartArea5_18"
Stage5_SpawnPoint_Info[18].Position = "Left"
Stage5_SpawnPoint_Info[18].Probability = 100
Stage5_SpawnPoint_Info[18].Door = "MovableModel5_28"
Stage5_SpawnPoint_Info[18].StartRoom = "EventArea5_3_1"
Stage5_SpawnPoint_Info[18].SpawnPointCount = 8
Stage5_SpawnPoint_Info[18].SpawnPoint_1 = "GameStartPoint5_18_1"
Stage5_SpawnPoint_Info[18].SpawnPoint_2 = "GameStartPoint5_18_2"
Stage5_SpawnPoint_Info[18].SpawnPoint_3 = "GameStartPoint5_18_3"
Stage5_SpawnPoint_Info[18].SpawnPoint_4 = "GameStartPoint5_18_4"
Stage5_SpawnPoint_Info[18].SpawnPoint_5 = "GameStartPoint5_18_01"
Stage5_SpawnPoint_Info[18].SpawnPoint_6 = "GameStartPoint5_18_02"
Stage5_SpawnPoint_Info[18].SpawnPoint_7 = "GameStartPoint5_18_03"
Stage5_SpawnPoint_Info[18].SpawnPoint_8 = "GameStartPoint5_18_04"	   
Stage5_SpawnPoint_Info[19] ={}
Stage5_SpawnPoint_Info[19].Area = "GameStartArea5_19"
Stage5_SpawnPoint_Info[19].Position = "Left"
Stage5_SpawnPoint_Info[19].Probability = 100
Stage5_SpawnPoint_Info[19].Door = "MovableModel5_17"
Stage5_SpawnPoint_Info[19].StartRoom = "EventArea5_2_1"
Stage5_SpawnPoint_Info[19].SpawnPointCount = 8
Stage5_SpawnPoint_Info[19].SpawnPoint_1 = "GameStartPoint5_19_1"
Stage5_SpawnPoint_Info[19].SpawnPoint_2 = "GameStartPoint5_19_2"
Stage5_SpawnPoint_Info[19].SpawnPoint_3 = "GameStartPoint5_19_3"
Stage5_SpawnPoint_Info[19].SpawnPoint_4 = "GameStartPoint5_19_4"
Stage5_SpawnPoint_Info[19].SpawnPoint_5 = "GameStartPoint5_19_01"
Stage5_SpawnPoint_Info[19].SpawnPoint_6 = "GameStartPoint5_19_02"
Stage5_SpawnPoint_Info[19].SpawnPoint_7 = "GameStartPoint5_19_03"
Stage5_SpawnPoint_Info[19].SpawnPoint_8 = "GameStartPoint5_19_04"	   
Stage5_SpawnPoint_Info[20] ={}
Stage5_SpawnPoint_Info[20].Area = "GameStartArea5_20"
Stage5_SpawnPoint_Info[20].Position = "Left"
Stage5_SpawnPoint_Info[20].Probability = 100
Stage5_SpawnPoint_Info[20].Door = "MovableModel5_6"
Stage5_SpawnPoint_Info[20].StartRoom = "EventArea5_1_1"
Stage5_SpawnPoint_Info[20].SpawnPointCount = 8
Stage5_SpawnPoint_Info[20].SpawnPoint_1 = "GameStartPoint5_20_1"
Stage5_SpawnPoint_Info[20].SpawnPoint_2 = "GameStartPoint5_20_2"
Stage5_SpawnPoint_Info[20].SpawnPoint_3 = "GameStartPoint5_20_3"
Stage5_SpawnPoint_Info[20].SpawnPoint_4 = "GameStartPoint5_20_4"
Stage5_SpawnPoint_Info[20].SpawnPoint_5 = "GameStartPoint5_20_01"
Stage5_SpawnPoint_Info[20].SpawnPoint_6 = "GameStartPoint5_20_02"
Stage5_SpawnPoint_Info[20].SpawnPoint_7 = "GameStartPoint5_20_03"
Stage5_SpawnPoint_Info[20].SpawnPoint_8 = "GameStartPoint5_20_04"	   

Stage6_SpawnPoint_Info = {}

Stage6_SpawnPoint_Info[1] ={}
Stage6_SpawnPoint_Info[1].Area = "GameStartArea6_1"
Stage6_SpawnPoint_Info[1].Position = "Bottom"
Stage6_SpawnPoint_Info[1].Probability = 100

Stage6_SpawnPoint_Info[1].StartRoom = "EventArea6_1_2"
Stage6_SpawnPoint_Info[1].SpawnPointCount = 8
Stage6_SpawnPoint_Info[1].SpawnPoint_1 = "GameStartPoint6_1_1"
Stage6_SpawnPoint_Info[1].SpawnPoint_2 = "GameStartPoint6_1_2"
Stage6_SpawnPoint_Info[1].SpawnPoint_3 = "GameStartPoint6_1_3"
Stage6_SpawnPoint_Info[1].SpawnPoint_4 = "GameStartPoint6_1_4"
Stage6_SpawnPoint_Info[1].SpawnPoint_5 = "GameStartPoint6_1_01"
Stage6_SpawnPoint_Info[1].SpawnPoint_6 = "GameStartPoint6_1_02"
Stage6_SpawnPoint_Info[1].SpawnPoint_7 = "GameStartPoint6_1_03"
Stage6_SpawnPoint_Info[1].SpawnPoint_8 = "GameStartPoint6_1_04"	   
Stage20_SpawnPoint_Info = {}

Stage20_SpawnPoint_Info[1] ={}
Stage20_SpawnPoint_Info[1].Area = "GameStartArea20_1"
Stage20_SpawnPoint_Info[1].Position = "Bottom"
Stage20_SpawnPoint_Info[1].Probability = 100
Stage20_SpawnPoint_Info[1].Door = "MovableModel20_1"
Stage20_SpawnPoint_Info[1].StartRoom = "EventArea20_1_1"
Stage20_SpawnPoint_Info[1].SpawnPointCount = 8
Stage20_SpawnPoint_Info[1].SpawnPoint_1 = "GameStartPoint20_1_1"
Stage20_SpawnPoint_Info[1].SpawnPoint_2 = "GameStartPoint20_1_2"
Stage20_SpawnPoint_Info[1].SpawnPoint_3 = "GameStartPoint20_1_3"
Stage20_SpawnPoint_Info[1].SpawnPoint_4 = "GameStartPoint20_1_4"
Stage20_SpawnPoint_Info[1].SpawnPoint_5 = "GameStartPoint20_1_01"
Stage20_SpawnPoint_Info[1].SpawnPoint_6 = "GameStartPoint20_1_02"
Stage20_SpawnPoint_Info[1].SpawnPoint_7 = "GameStartPoint20_1_03"
Stage20_SpawnPoint_Info[1].SpawnPoint_8 = "GameStartPoint20_1_04"	 

	 

	 
	 
	 

----------------------------------------------------------------------------------------------------
-- 스테이지1의 방과 벽에 대한 배열. 실제 플레이 영역
----------------------------------------------------------------------------------------------------
 
  
  
 
Stage1_Room_Info = {}

Stage1_Room_Info[1] ={}
Stage1_Room_Info[1].Room = "EventArea1_1_1"
Stage1_Room_Info[1].Coordinate = "1,1"
Stage1_Room_Info[1].WallCount = 4
Stage1_Room_Info[1].Wall_1 = "MovableModel1_1"
Stage1_Room_Info[1].Wall_2 = "MovableModel1_6"
Stage1_Room_Info[1].Wall_3 = "MovableModel1_7"
Stage1_Room_Info[1].Wall_4 = "MovableModel1_12"
Stage1_Room_Info[1].ItemSpawnPointCount = 2
Stage1_Room_Info[1].ItemSpawnPoint_1 = "SaPoint1_1_1_1"
Stage1_Room_Info[1].ItemSpawnPoint_2 = "SaPoint1_1_1_2"
	   
Stage1_Room_Info[2] ={}
Stage1_Room_Info[2].Room = "EventArea1_1_2"
Stage1_Room_Info[2].Coordinate = "2,1"
Stage1_Room_Info[2].WallCount = 4
Stage1_Room_Info[2].Wall_1 = "MovableModel1_2"
Stage1_Room_Info[2].Wall_2 = "MovableModel1_7"
Stage1_Room_Info[2].Wall_3 = "MovableModel1_8"
Stage1_Room_Info[2].Wall_4 = "MovableModel1_13"
Stage1_Room_Info[2].ItemSpawnPointCount = 2
Stage1_Room_Info[2].ItemSpawnPoint_1 = "SaPoint1_1_2_1"
Stage1_Room_Info[2].ItemSpawnPoint_2 = "SaPoint1_1_2_2"
	   
Stage1_Room_Info[3] ={}
Stage1_Room_Info[3].Room = "EventArea1_1_3"
Stage1_Room_Info[3].Coordinate = "3,1"
Stage1_Room_Info[3].WallCount = 4
Stage1_Room_Info[3].Wall_1 = "MovableModel1_3"
Stage1_Room_Info[3].Wall_2 = "MovableModel1_8"
Stage1_Room_Info[3].Wall_3 = "MovableModel1_9"
Stage1_Room_Info[3].Wall_4 = "MovableModel1_14"
Stage1_Room_Info[3].ItemSpawnPointCount = 2
Stage1_Room_Info[3].ItemSpawnPoint_1 = "SaPoint1_1_3_1"
Stage1_Room_Info[3].ItemSpawnPoint_2 = "SaPoint1_1_3_2"
	   
Stage1_Room_Info[4] ={}
Stage1_Room_Info[4].Room = "EventArea1_1_4"
Stage1_Room_Info[4].Coordinate = "4,1"
Stage1_Room_Info[4].WallCount = 4
Stage1_Room_Info[4].Wall_1 = "MovableModel1_4"
Stage1_Room_Info[4].Wall_2 = "MovableModel1_9"
Stage1_Room_Info[4].Wall_3 = "MovableModel1_10"
Stage1_Room_Info[4].Wall_4 = "MovableModel1_15"
Stage1_Room_Info[4].ItemSpawnPointCount = 2
Stage1_Room_Info[4].ItemSpawnPoint_1 = "SaPoint1_1_4_1"
Stage1_Room_Info[4].ItemSpawnPoint_2 = "SaPoint1_1_4_2"
	   
Stage1_Room_Info[5] ={}
Stage1_Room_Info[5].Room = "EventArea1_1_5"
Stage1_Room_Info[5].Coordinate = "5,1"
Stage1_Room_Info[5].WallCount = 4
Stage1_Room_Info[5].Wall_1 = "MovableModel1_5"
Stage1_Room_Info[5].Wall_2 = "MovableModel1_10"
Stage1_Room_Info[5].Wall_3 = "MovableModel1_11"
Stage1_Room_Info[5].Wall_4 = "MovableModel1_16"
Stage1_Room_Info[5].ItemSpawnPointCount = 2
Stage1_Room_Info[5].ItemSpawnPoint_1 = "SaPoint1_1_5_1"
Stage1_Room_Info[5].ItemSpawnPoint_2 = "SaPoint1_1_5_2"
	   
Stage1_Room_Info[6] ={}
Stage1_Room_Info[6].Room = "EventArea1_2_1"
Stage1_Room_Info[6].Coordinate = "1,2"
Stage1_Room_Info[6].WallCount = 4
Stage1_Room_Info[6].Wall_1 = "MovableModel1_12"
Stage1_Room_Info[6].Wall_2 = "MovableModel1_17"
Stage1_Room_Info[6].Wall_3 = "MovableModel1_18"
Stage1_Room_Info[6].Wall_4 = "MovableModel1_23"
Stage1_Room_Info[6].ItemSpawnPointCount = 2
Stage1_Room_Info[6].ItemSpawnPoint_1 = "SaPoint1_2_1_1"
Stage1_Room_Info[6].ItemSpawnPoint_2 = "SaPoint1_2_1_2"
	   
Stage1_Room_Info[7] ={}
Stage1_Room_Info[7].Room = "EventArea1_2_2"
Stage1_Room_Info[7].Coordinate = "2,2"
Stage1_Room_Info[7].WallCount = 4
Stage1_Room_Info[7].Wall_1 = "MovableModel1_13"
Stage1_Room_Info[7].Wall_2 = "MovableModel1_18"
Stage1_Room_Info[7].Wall_3 = "MovableModel1_19"
Stage1_Room_Info[7].Wall_4 = "MovableModel1_24"
Stage1_Room_Info[7].ItemSpawnPointCount = 2
Stage1_Room_Info[7].ItemSpawnPoint_1 = "SaPoint1_2_2_1"
Stage1_Room_Info[7].ItemSpawnPoint_2 = "SaPoint1_2_2_2"
	   
Stage1_Room_Info[8] ={}
Stage1_Room_Info[8].Room = "EventArea1_2_3"
Stage1_Room_Info[8].Coordinate = "3,2"
Stage1_Room_Info[8].WallCount = 4
Stage1_Room_Info[8].Wall_1 = "MovableModel1_14"
Stage1_Room_Info[8].Wall_2 = "MovableModel1_19"
Stage1_Room_Info[8].Wall_3 = "MovableModel1_20"
Stage1_Room_Info[8].Wall_4 = "MovableModel1_25"
Stage1_Room_Info[8].ItemSpawnPointCount = 2
Stage1_Room_Info[8].ItemSpawnPoint_1 = "SaPoint1_2_3_1"
Stage1_Room_Info[8].ItemSpawnPoint_2 = "SaPoint1_2_3_2"
	   
Stage1_Room_Info[9] ={}
Stage1_Room_Info[9].Room = "EventArea1_2_4"
Stage1_Room_Info[9].Coordinate = "4,2"
Stage1_Room_Info[9].WallCount = 4
Stage1_Room_Info[9].Wall_1 = "MovableModel1_15"
Stage1_Room_Info[9].Wall_2 = "MovableModel1_20"
Stage1_Room_Info[9].Wall_3 = "MovableModel1_21"
Stage1_Room_Info[9].Wall_4 = "MovableModel1_26"
Stage1_Room_Info[9].ItemSpawnPointCount = 2
Stage1_Room_Info[9].ItemSpawnPoint_1 = "SaPoint1_2_4_1"
Stage1_Room_Info[9].ItemSpawnPoint_2 = "SaPoint1_2_4_2"
	   
Stage1_Room_Info[10] ={}
Stage1_Room_Info[10].Room = "EventArea1_2_5"
Stage1_Room_Info[10].Coordinate = "5,2"
Stage1_Room_Info[10].WallCount = 4
Stage1_Room_Info[10].Wall_1 = "MovableModel1_16"
Stage1_Room_Info[10].Wall_2 = "MovableModel1_21"
Stage1_Room_Info[10].Wall_3 = "MovableModel1_22"
Stage1_Room_Info[10].Wall_4 = "MovableModel1_27"
Stage1_Room_Info[10].ItemSpawnPointCount = 2
Stage1_Room_Info[10].ItemSpawnPoint_1 = "SaPoint1_2_5_1"
Stage1_Room_Info[10].ItemSpawnPoint_2 = "SaPoint1_2_5_2"
	   
Stage1_Room_Info[11] ={}
Stage1_Room_Info[11].Room = "EventArea1_3_1"
Stage1_Room_Info[11].Coordinate = "1,3"
Stage1_Room_Info[11].WallCount = 4
Stage1_Room_Info[11].Wall_1 = "MovableModel1_23"
Stage1_Room_Info[11].Wall_2 = "MovableModel1_28"
Stage1_Room_Info[11].Wall_3 = "MovableModel1_29"
Stage1_Room_Info[11].Wall_4 = "MovableModel1_34"
Stage1_Room_Info[11].ItemSpawnPointCount = 2
Stage1_Room_Info[11].ItemSpawnPoint_1 = "SaPoint1_3_1_1"
Stage1_Room_Info[11].ItemSpawnPoint_2 = "SaPoint1_3_1_2"
	   
Stage1_Room_Info[12] ={}
Stage1_Room_Info[12].Room = "EventArea1_3_2"
Stage1_Room_Info[12].Coordinate = "2,3"
Stage1_Room_Info[12].WallCount = 4
Stage1_Room_Info[12].Wall_1 = "MovableModel1_24"
Stage1_Room_Info[12].Wall_2 = "MovableModel1_29"
Stage1_Room_Info[12].Wall_3 = "MovableModel1_30"
Stage1_Room_Info[12].Wall_4 = "MovableModel1_35"
Stage1_Room_Info[12].ItemSpawnPointCount = 2
Stage1_Room_Info[12].ItemSpawnPoint_1 = "SaPoint1_3_2_1"
Stage1_Room_Info[12].ItemSpawnPoint_2 = "SaPoint1_3_2_2"
	   
Stage1_Room_Info[13] ={}
Stage1_Room_Info[13].Room = "EventArea1_3_3"
Stage1_Room_Info[13].Coordinate = "3,3"
Stage1_Room_Info[13].WallCount = 4
Stage1_Room_Info[13].Wall_1 = "MovableModel1_25"
Stage1_Room_Info[13].Wall_2 = "MovableModel1_30"
Stage1_Room_Info[13].Wall_3 = "MovableModel1_31"
Stage1_Room_Info[13].Wall_4 = "MovableModel1_36"
Stage1_Room_Info[13].ItemSpawnPointCount = 2
Stage1_Room_Info[13].ItemSpawnPoint_1 = "SaPoint1_3_3_1"
Stage1_Room_Info[13].ItemSpawnPoint_2 = "SaPoint1_3_3_2"
	   
Stage1_Room_Info[14] ={}
Stage1_Room_Info[14].Room = "EventArea1_3_4"
Stage1_Room_Info[14].Coordinate = "4,3"
Stage1_Room_Info[14].WallCount = 4
Stage1_Room_Info[14].Wall_1 = "MovableModel1_26"
Stage1_Room_Info[14].Wall_2 = "MovableModel1_31"
Stage1_Room_Info[14].Wall_3 = "MovableModel1_32"
Stage1_Room_Info[14].Wall_4 = "MovableModel1_37"
Stage1_Room_Info[14].ItemSpawnPointCount = 2
Stage1_Room_Info[14].ItemSpawnPoint_1 = "SaPoint1_3_4_1"
Stage1_Room_Info[14].ItemSpawnPoint_2 = "SaPoint1_3_4_2"
	   
Stage1_Room_Info[15] ={}
Stage1_Room_Info[15].Room = "EventArea1_3_5"
Stage1_Room_Info[15].Coordinate = "5,3"
Stage1_Room_Info[15].WallCount = 4
Stage1_Room_Info[15].Wall_1 = "MovableModel1_27"
Stage1_Room_Info[15].Wall_2 = "MovableModel1_32"
Stage1_Room_Info[15].Wall_3 = "MovableModel1_33"
Stage1_Room_Info[15].Wall_4 = "MovableModel1_38"
Stage1_Room_Info[15].ItemSpawnPointCount = 2
Stage1_Room_Info[15].ItemSpawnPoint_1 = "SaPoint1_3_5_1"
Stage1_Room_Info[15].ItemSpawnPoint_2 = "SaPoint1_3_5_2"
	   
Stage1_Room_Info[16] ={}
Stage1_Room_Info[16].Room = "EventArea1_4_1"
Stage1_Room_Info[16].Coordinate = "1,4"
Stage1_Room_Info[16].WallCount = 4
Stage1_Room_Info[16].Wall_1 = "MovableModel1_34"
Stage1_Room_Info[16].Wall_2 = "MovableModel1_39"
Stage1_Room_Info[16].Wall_3 = "MovableModel1_40"
Stage1_Room_Info[16].Wall_4 = "MovableModel1_45"
Stage1_Room_Info[16].ItemSpawnPointCount = 2
Stage1_Room_Info[16].ItemSpawnPoint_1 = "SaPoint1_4_1_1"
Stage1_Room_Info[16].ItemSpawnPoint_2 = "SaPoint1_4_1_2"
	   
Stage1_Room_Info[17] ={}
Stage1_Room_Info[17].Room = "EventArea1_4_2"
Stage1_Room_Info[17].Coordinate = "2,4"
Stage1_Room_Info[17].WallCount = 4
Stage1_Room_Info[17].Wall_1 = "MovableModel1_35"
Stage1_Room_Info[17].Wall_2 = "MovableModel1_40"
Stage1_Room_Info[17].Wall_3 = "MovableModel1_41"
Stage1_Room_Info[17].Wall_4 = "MovableModel1_46"
Stage1_Room_Info[17].ItemSpawnPointCount = 2
Stage1_Room_Info[17].ItemSpawnPoint_1 = "SaPoint1_4_2_1"
Stage1_Room_Info[17].ItemSpawnPoint_2 = "SaPoint1_4_2_2"
	   
Stage1_Room_Info[18] ={}
Stage1_Room_Info[18].Room = "EventArea1_4_3"
Stage1_Room_Info[18].Coordinate = "3,4"
Stage1_Room_Info[18].WallCount = 4
Stage1_Room_Info[18].Wall_1 = "MovableModel1_36"
Stage1_Room_Info[18].Wall_2 = "MovableModel1_41"
Stage1_Room_Info[18].Wall_3 = "MovableModel1_42"
Stage1_Room_Info[18].Wall_4 = "MovableModel1_47"
Stage1_Room_Info[18].ItemSpawnPointCount = 2
Stage1_Room_Info[18].ItemSpawnPoint_1 = "SaPoint1_4_3_1"
Stage1_Room_Info[18].ItemSpawnPoint_2 = "SaPoint1_4_3_2"
	   
Stage1_Room_Info[19] ={}
Stage1_Room_Info[19].Room = "EventArea1_4_4"
Stage1_Room_Info[19].Coordinate = "4,4"
Stage1_Room_Info[19].WallCount = 4
Stage1_Room_Info[19].Wall_1 = "MovableModel1_37"
Stage1_Room_Info[19].Wall_2 = "MovableModel1_42"
Stage1_Room_Info[19].Wall_3 = "MovableModel1_43"
Stage1_Room_Info[19].Wall_4 = "MovableModel1_48"
Stage1_Room_Info[19].ItemSpawnPointCount = 2
Stage1_Room_Info[19].ItemSpawnPoint_1 = "SaPoint1_4_4_1"
Stage1_Room_Info[19].ItemSpawnPoint_2 = "SaPoint1_4_4_2"
	   
Stage1_Room_Info[20] ={}
Stage1_Room_Info[20].Room = "EventArea1_4_5"
Stage1_Room_Info[20].Coordinate = "5,4"
Stage1_Room_Info[20].WallCount = 4
Stage1_Room_Info[20].Wall_1 = "MovableModel1_38"
Stage1_Room_Info[20].Wall_2 = "MovableModel1_43"
Stage1_Room_Info[20].Wall_3 = "MovableModel1_44"
Stage1_Room_Info[20].Wall_4 = "MovableModel1_49"
Stage1_Room_Info[20].ItemSpawnPointCount = 2
Stage1_Room_Info[20].ItemSpawnPoint_1 = "SaPoint1_4_5_1"
Stage1_Room_Info[20].ItemSpawnPoint_2 = "SaPoint1_4_5_2"
	   
Stage1_Room_Info[21] ={}
Stage1_Room_Info[21].Room = "EventArea1_5_1"
Stage1_Room_Info[21].Coordinate = "1,5"
Stage1_Room_Info[21].WallCount = 4
Stage1_Room_Info[21].Wall_1 = "MovableModel1_45"
Stage1_Room_Info[21].Wall_2 = "MovableModel1_50"
Stage1_Room_Info[21].Wall_3 = "MovableModel1_51"
Stage1_Room_Info[21].Wall_4 = "MovableModel1_56"
Stage1_Room_Info[21].ItemSpawnPointCount = 2
Stage1_Room_Info[21].ItemSpawnPoint_1 = "SaPoint1_5_1_1"
Stage1_Room_Info[21].ItemSpawnPoint_2 = "SaPoint1_5_1_2"
	   
Stage1_Room_Info[22] ={}
Stage1_Room_Info[22].Room = "EventArea1_5_2"
Stage1_Room_Info[22].Coordinate = "2,5"
Stage1_Room_Info[22].WallCount = 4
Stage1_Room_Info[22].Wall_1 = "MovableModel1_46"
Stage1_Room_Info[22].Wall_2 = "MovableModel1_51"
Stage1_Room_Info[22].Wall_3 = "MovableModel1_52"
Stage1_Room_Info[22].Wall_4 = "MovableModel1_57"
Stage1_Room_Info[22].ItemSpawnPointCount = 2
Stage1_Room_Info[22].ItemSpawnPoint_1 = "SaPoint1_5_2_1"
Stage1_Room_Info[22].ItemSpawnPoint_2 = "SaPoint1_5_2_2"
	   
Stage1_Room_Info[23] ={}
Stage1_Room_Info[23].Room = "EventArea1_5_3"
Stage1_Room_Info[23].Coordinate = "3,5"
Stage1_Room_Info[23].WallCount = 4
Stage1_Room_Info[23].Wall_1 = "MovableModel1_47"
Stage1_Room_Info[23].Wall_2 = "MovableModel1_52"
Stage1_Room_Info[23].Wall_3 = "MovableModel1_53"
Stage1_Room_Info[23].Wall_4 = "MovableModel1_58"
Stage1_Room_Info[23].ItemSpawnPointCount = 2
Stage1_Room_Info[23].ItemSpawnPoint_1 = "SaPoint1_5_3_1"
Stage1_Room_Info[23].ItemSpawnPoint_2 = "SaPoint1_5_3_2"
	   
Stage1_Room_Info[24] ={}
Stage1_Room_Info[24].Room = "EventArea1_5_4"
Stage1_Room_Info[24].Coordinate = "4,5"
Stage1_Room_Info[24].WallCount = 4
Stage1_Room_Info[24].Wall_1 = "MovableModel1_48"
Stage1_Room_Info[24].Wall_2 = "MovableModel1_53"
Stage1_Room_Info[24].Wall_3 = "MovableModel1_54"
Stage1_Room_Info[24].Wall_4 = "MovableModel1_59"
Stage1_Room_Info[24].ItemSpawnPointCount = 2
Stage1_Room_Info[24].ItemSpawnPoint_1 = "SaPoint1_5_4_1"
Stage1_Room_Info[24].ItemSpawnPoint_2 = "SaPoint1_5_4_2"
	   
Stage1_Room_Info[25] ={}
Stage1_Room_Info[25].Room = "EventArea1_5_5"
Stage1_Room_Info[25].Coordinate = "5,5"
Stage1_Room_Info[25].WallCount = 4
Stage1_Room_Info[25].Wall_1 = "MovableModel1_49"
Stage1_Room_Info[25].Wall_2 = "MovableModel1_54"
Stage1_Room_Info[25].Wall_3 = "MovableModel1_55"
Stage1_Room_Info[25].Wall_4 = "MovableModel1_60"
Stage1_Room_Info[25].ItemSpawnPointCount = 2
Stage1_Room_Info[25].ItemSpawnPoint_1 = "SaPoint1_5_5_1"
Stage1_Room_Info[25].ItemSpawnPoint_2 = "SaPoint1_5_5_2"
	   
Stage2_Room_Info = {}

Stage2_Room_Info[1] ={}
Stage2_Room_Info[1].Room = "EventArea2_1_1"
Stage2_Room_Info[1].Coordinate = "1,1"
Stage2_Room_Info[1].WallCount = 4
Stage2_Room_Info[1].Wall_1 = "MovableModel2_1"
Stage2_Room_Info[1].Wall_2 = "MovableModel2_6"
Stage2_Room_Info[1].Wall_3 = "MovableModel2_7"
Stage2_Room_Info[1].Wall_4 = "MovableModel2_12"
Stage2_Room_Info[1].ItemSpawnPointCount = 2
Stage2_Room_Info[1].ItemSpawnPoint_1 = "SaPoint2_1_1_1"
Stage2_Room_Info[1].ItemSpawnPoint_2 = "SaPoint2_1_1_2"
	   
Stage2_Room_Info[2] ={}
Stage2_Room_Info[2].Room = "EventArea2_1_2"
Stage2_Room_Info[2].Coordinate = "2,1"
Stage2_Room_Info[2].WallCount = 4
Stage2_Room_Info[2].Wall_1 = "MovableModel2_2"
Stage2_Room_Info[2].Wall_2 = "MovableModel2_7"
Stage2_Room_Info[2].Wall_3 = "MovableModel2_8"
Stage2_Room_Info[2].Wall_4 = "MovableModel2_13"
Stage2_Room_Info[2].ItemSpawnPointCount = 2
Stage2_Room_Info[2].ItemSpawnPoint_1 = "SaPoint2_1_2_1"
Stage2_Room_Info[2].ItemSpawnPoint_2 = "SaPoint2_1_2_2"
	   
Stage2_Room_Info[3] ={}
Stage2_Room_Info[3].Room = "EventArea2_1_3"
Stage2_Room_Info[3].Coordinate = "3,1"
Stage2_Room_Info[3].WallCount = 4
Stage2_Room_Info[3].Wall_1 = "MovableModel2_3"
Stage2_Room_Info[3].Wall_2 = "MovableModel2_8"
Stage2_Room_Info[3].Wall_3 = "MovableModel2_9"
Stage2_Room_Info[3].Wall_4 = "MovableModel2_14"
Stage2_Room_Info[3].ItemSpawnPointCount = 2
Stage2_Room_Info[3].ItemSpawnPoint_1 = "SaPoint2_1_3_1"
Stage2_Room_Info[3].ItemSpawnPoint_2 = "SaPoint2_1_3_2"
	   
Stage2_Room_Info[4] ={}
Stage2_Room_Info[4].Room = "EventArea2_1_4"
Stage2_Room_Info[4].Coordinate = "4,1"
Stage2_Room_Info[4].WallCount = 4
Stage2_Room_Info[4].Wall_1 = "MovableModel2_4"
Stage2_Room_Info[4].Wall_2 = "MovableModel2_9"
Stage2_Room_Info[4].Wall_3 = "MovableModel2_10"
Stage2_Room_Info[4].Wall_4 = "MovableModel2_15"
Stage2_Room_Info[4].ItemSpawnPointCount = 2
Stage2_Room_Info[4].ItemSpawnPoint_1 = "SaPoint2_1_4_1"
Stage2_Room_Info[4].ItemSpawnPoint_2 = "SaPoint2_1_4_2"
	   
Stage2_Room_Info[5] ={}
Stage2_Room_Info[5].Room = "EventArea2_1_5"
Stage2_Room_Info[5].Coordinate = "5,1"
Stage2_Room_Info[5].WallCount = 4
Stage2_Room_Info[5].Wall_1 = "MovableModel2_5"
Stage2_Room_Info[5].Wall_2 = "MovableModel2_10"
Stage2_Room_Info[5].Wall_3 = "MovableModel2_11"
Stage2_Room_Info[5].Wall_4 = "MovableModel2_16"
Stage2_Room_Info[5].ItemSpawnPointCount = 2
Stage2_Room_Info[5].ItemSpawnPoint_1 = "SaPoint2_1_5_1"
Stage2_Room_Info[5].ItemSpawnPoint_2 = "SaPoint2_1_5_2"
	   
Stage2_Room_Info[6] ={}
Stage2_Room_Info[6].Room = "EventArea2_2_1"
Stage2_Room_Info[6].Coordinate = "1,2"
Stage2_Room_Info[6].WallCount = 4
Stage2_Room_Info[6].Wall_1 = "MovableModel2_12"
Stage2_Room_Info[6].Wall_2 = "MovableModel2_17"
Stage2_Room_Info[6].Wall_3 = "MovableModel2_18"
Stage2_Room_Info[6].Wall_4 = "MovableModel2_23"
Stage2_Room_Info[6].ItemSpawnPointCount = 2
Stage2_Room_Info[6].ItemSpawnPoint_1 = "SaPoint2_2_1_1"
Stage2_Room_Info[6].ItemSpawnPoint_2 = "SaPoint2_2_1_2"
	   
Stage2_Room_Info[7] ={}
Stage2_Room_Info[7].Room = "EventArea2_2_2"
Stage2_Room_Info[7].Coordinate = "2,2"
Stage2_Room_Info[7].WallCount = 4
Stage2_Room_Info[7].Wall_1 = "MovableModel2_13"
Stage2_Room_Info[7].Wall_2 = "MovableModel2_18"
Stage2_Room_Info[7].Wall_3 = "MovableModel2_19"
Stage2_Room_Info[7].Wall_4 = "MovableModel2_24"
Stage2_Room_Info[7].ItemSpawnPointCount = 2
Stage2_Room_Info[7].ItemSpawnPoint_1 = "SaPoint2_2_2_1"
Stage2_Room_Info[7].ItemSpawnPoint_2 = "SaPoint2_2_2_2"
	   
Stage2_Room_Info[8] ={}
Stage2_Room_Info[8].Room = "EventArea2_2_3"
Stage2_Room_Info[8].Coordinate = "3,2"
Stage2_Room_Info[8].WallCount = 4
Stage2_Room_Info[8].Wall_1 = "MovableModel2_14"
Stage2_Room_Info[8].Wall_2 = "MovableModel2_19"
Stage2_Room_Info[8].Wall_3 = "MovableModel2_20"
Stage2_Room_Info[8].Wall_4 = "MovableModel2_25"
Stage2_Room_Info[8].ItemSpawnPointCount = 2
Stage2_Room_Info[8].ItemSpawnPoint_1 = "SaPoint2_2_3_1"
Stage2_Room_Info[8].ItemSpawnPoint_2 = "SaPoint2_2_3_2"
	   
Stage2_Room_Info[9] ={}
Stage2_Room_Info[9].Room = "EventArea2_2_4"
Stage2_Room_Info[9].Coordinate = "4,2"
Stage2_Room_Info[9].WallCount = 4
Stage2_Room_Info[9].Wall_1 = "MovableModel2_15"
Stage2_Room_Info[9].Wall_2 = "MovableModel2_20"
Stage2_Room_Info[9].Wall_3 = "MovableModel2_21"
Stage2_Room_Info[9].Wall_4 = "MovableModel2_26"
Stage2_Room_Info[9].ItemSpawnPointCount = 2
Stage2_Room_Info[9].ItemSpawnPoint_1 = "SaPoint2_2_4_1"
Stage2_Room_Info[9].ItemSpawnPoint_2 = "SaPoint2_2_4_2"
	   
Stage2_Room_Info[10] ={}
Stage2_Room_Info[10].Room = "EventArea2_2_5"
Stage2_Room_Info[10].Coordinate = "5,2"
Stage2_Room_Info[10].WallCount = 4
Stage2_Room_Info[10].Wall_1 = "MovableModel2_16"
Stage2_Room_Info[10].Wall_2 = "MovableModel2_21"
Stage2_Room_Info[10].Wall_3 = "MovableModel2_22"
Stage2_Room_Info[10].Wall_4 = "MovableModel2_27"
Stage2_Room_Info[10].ItemSpawnPointCount = 2
Stage2_Room_Info[10].ItemSpawnPoint_1 = "SaPoint2_2_5_1"
Stage2_Room_Info[10].ItemSpawnPoint_2 = "SaPoint2_2_5_2"
	   
Stage2_Room_Info[11] ={}
Stage2_Room_Info[11].Room = "EventArea2_3_1"
Stage2_Room_Info[11].Coordinate = "1,3"
Stage2_Room_Info[11].WallCount = 4
Stage2_Room_Info[11].Wall_1 = "MovableModel2_23"
Stage2_Room_Info[11].Wall_2 = "MovableModel2_28"
Stage2_Room_Info[11].Wall_3 = "MovableModel2_29"
Stage2_Room_Info[11].Wall_4 = "MovableModel2_34"
Stage2_Room_Info[11].ItemSpawnPointCount = 2
Stage2_Room_Info[11].ItemSpawnPoint_1 = "SaPoint2_3_1_1"
Stage2_Room_Info[11].ItemSpawnPoint_2 = "SaPoint2_3_1_2"
	   
Stage2_Room_Info[12] ={}
Stage2_Room_Info[12].Room = "EventArea2_3_2"
Stage2_Room_Info[12].Coordinate = "2,3"
Stage2_Room_Info[12].WallCount = 4
Stage2_Room_Info[12].Wall_1 = "MovableModel2_24"
Stage2_Room_Info[12].Wall_2 = "MovableModel2_29"
Stage2_Room_Info[12].Wall_3 = "MovableModel2_30"
Stage2_Room_Info[12].Wall_4 = "MovableModel2_35"
Stage2_Room_Info[12].ItemSpawnPointCount = 2
Stage2_Room_Info[12].ItemSpawnPoint_1 = "SaPoint2_3_2_1"
Stage2_Room_Info[12].ItemSpawnPoint_2 = "SaPoint2_3_2_2"
	   
Stage2_Room_Info[13] ={}
Stage2_Room_Info[13].Room = "EventArea2_3_3"
Stage2_Room_Info[13].Coordinate = "3,3"
Stage2_Room_Info[13].WallCount = 4
Stage2_Room_Info[13].Wall_1 = "MovableModel2_25"
Stage2_Room_Info[13].Wall_2 = "MovableModel2_30"
Stage2_Room_Info[13].Wall_3 = "MovableModel2_31"
Stage2_Room_Info[13].Wall_4 = "MovableModel2_36"
Stage2_Room_Info[13].ItemSpawnPointCount = 2
Stage2_Room_Info[13].ItemSpawnPoint_1 = "SaPoint2_3_3_1"
Stage2_Room_Info[13].ItemSpawnPoint_2 = "SaPoint2_3_3_2"
	   
Stage2_Room_Info[14] ={}
Stage2_Room_Info[14].Room = "EventArea2_3_4"
Stage2_Room_Info[14].Coordinate = "4,3"
Stage2_Room_Info[14].WallCount = 4
Stage2_Room_Info[14].Wall_1 = "MovableModel2_26"
Stage2_Room_Info[14].Wall_2 = "MovableModel2_31"
Stage2_Room_Info[14].Wall_3 = "MovableModel2_32"
Stage2_Room_Info[14].Wall_4 = "MovableModel2_37"
Stage2_Room_Info[14].ItemSpawnPointCount = 2
Stage2_Room_Info[14].ItemSpawnPoint_1 = "SaPoint2_3_4_1"
Stage2_Room_Info[14].ItemSpawnPoint_2 = "SaPoint2_3_4_2"
	   
Stage2_Room_Info[15] ={}
Stage2_Room_Info[15].Room = "EventArea2_3_5"
Stage2_Room_Info[15].Coordinate = "5,3"
Stage2_Room_Info[15].WallCount = 4
Stage2_Room_Info[15].Wall_1 = "MovableModel2_27"
Stage2_Room_Info[15].Wall_2 = "MovableModel2_32"
Stage2_Room_Info[15].Wall_3 = "MovableModel2_33"
Stage2_Room_Info[15].Wall_4 = "MovableModel2_38"
Stage2_Room_Info[15].ItemSpawnPointCount = 2
Stage2_Room_Info[15].ItemSpawnPoint_1 = "SaPoint2_3_5_1"
Stage2_Room_Info[15].ItemSpawnPoint_2 = "SaPoint2_3_5_2"
	   
Stage2_Room_Info[16] ={}
Stage2_Room_Info[16].Room = "EventArea2_4_1"
Stage2_Room_Info[16].Coordinate = "1,4"
Stage2_Room_Info[16].WallCount = 4
Stage2_Room_Info[16].Wall_1 = "MovableModel2_34"
Stage2_Room_Info[16].Wall_2 = "MovableModel2_39"
Stage2_Room_Info[16].Wall_3 = "MovableModel2_40"
Stage2_Room_Info[16].Wall_4 = "MovableModel2_45"
Stage2_Room_Info[16].ItemSpawnPointCount = 2
Stage2_Room_Info[16].ItemSpawnPoint_1 = "SaPoint2_4_1_1"
Stage2_Room_Info[16].ItemSpawnPoint_2 = "SaPoint2_4_1_2"
	   
Stage2_Room_Info[17] ={}
Stage2_Room_Info[17].Room = "EventArea2_4_2"
Stage2_Room_Info[17].Coordinate = "2,4"
Stage2_Room_Info[17].WallCount = 4
Stage2_Room_Info[17].Wall_1 = "MovableModel2_35"
Stage2_Room_Info[17].Wall_2 = "MovableModel2_40"
Stage2_Room_Info[17].Wall_3 = "MovableModel2_41"
Stage2_Room_Info[17].Wall_4 = "MovableModel2_46"
Stage2_Room_Info[17].ItemSpawnPointCount = 2
Stage2_Room_Info[17].ItemSpawnPoint_1 = "SaPoint2_4_2_1"
Stage2_Room_Info[17].ItemSpawnPoint_2 = "SaPoint2_4_2_2"
	   
Stage2_Room_Info[18] ={}
Stage2_Room_Info[18].Room = "EventArea2_4_3"
Stage2_Room_Info[18].Coordinate = "3,4"
Stage2_Room_Info[18].WallCount = 4
Stage2_Room_Info[18].Wall_1 = "MovableModel2_36"
Stage2_Room_Info[18].Wall_2 = "MovableModel2_41"
Stage2_Room_Info[18].Wall_3 = "MovableModel2_42"
Stage2_Room_Info[18].Wall_4 = "MovableModel2_47"
Stage2_Room_Info[18].ItemSpawnPointCount = 2
Stage2_Room_Info[18].ItemSpawnPoint_1 = "SaPoint2_4_3_1"
Stage2_Room_Info[18].ItemSpawnPoint_2 = "SaPoint2_4_3_2"
	   
Stage2_Room_Info[19] ={}
Stage2_Room_Info[19].Room = "EventArea2_4_4"
Stage2_Room_Info[19].Coordinate = "4,4"
Stage2_Room_Info[19].WallCount = 4
Stage2_Room_Info[19].Wall_1 = "MovableModel2_37"
Stage2_Room_Info[19].Wall_2 = "MovableModel2_42"
Stage2_Room_Info[19].Wall_3 = "MovableModel2_43"
Stage2_Room_Info[19].Wall_4 = "MovableModel2_48"
Stage2_Room_Info[19].ItemSpawnPointCount = 2
Stage2_Room_Info[19].ItemSpawnPoint_1 = "SaPoint2_4_4_1"
Stage2_Room_Info[19].ItemSpawnPoint_2 = "SaPoint2_4_4_2"
	   
Stage2_Room_Info[20] ={}
Stage2_Room_Info[20].Room = "EventArea2_4_5"
Stage2_Room_Info[20].Coordinate = "5,4"
Stage2_Room_Info[20].WallCount = 4
Stage2_Room_Info[20].Wall_1 = "MovableModel2_38"
Stage2_Room_Info[20].Wall_2 = "MovableModel2_43"
Stage2_Room_Info[20].Wall_3 = "MovableModel2_44"
Stage2_Room_Info[20].Wall_4 = "MovableModel2_49"
Stage2_Room_Info[20].ItemSpawnPointCount = 2
Stage2_Room_Info[20].ItemSpawnPoint_1 = "SaPoint2_4_5_1"
Stage2_Room_Info[20].ItemSpawnPoint_2 = "SaPoint2_4_5_2"
	   
Stage2_Room_Info[21] ={}
Stage2_Room_Info[21].Room = "EventArea2_5_1"
Stage2_Room_Info[21].Coordinate = "1,5"
Stage2_Room_Info[21].WallCount = 4
Stage2_Room_Info[21].Wall_1 = "MovableModel2_45"
Stage2_Room_Info[21].Wall_2 = "MovableModel2_50"
Stage2_Room_Info[21].Wall_3 = "MovableModel2_51"
Stage2_Room_Info[21].Wall_4 = "MovableModel2_56"
Stage2_Room_Info[21].ItemSpawnPointCount = 2
Stage2_Room_Info[21].ItemSpawnPoint_1 = "SaPoint2_5_1_1"
Stage2_Room_Info[21].ItemSpawnPoint_2 = "SaPoint2_5_1_2"
	   
Stage2_Room_Info[22] ={}
Stage2_Room_Info[22].Room = "EventArea2_5_2"
Stage2_Room_Info[22].Coordinate = "2,5"
Stage2_Room_Info[22].WallCount = 4
Stage2_Room_Info[22].Wall_1 = "MovableModel2_46"
Stage2_Room_Info[22].Wall_2 = "MovableModel2_51"
Stage2_Room_Info[22].Wall_3 = "MovableModel2_52"
Stage2_Room_Info[22].Wall_4 = "MovableModel2_57"
Stage2_Room_Info[22].ItemSpawnPointCount = 2
Stage2_Room_Info[22].ItemSpawnPoint_1 = "SaPoint2_5_2_1"
Stage2_Room_Info[22].ItemSpawnPoint_2 = "SaPoint2_5_2_2"
	   
Stage2_Room_Info[23] ={}
Stage2_Room_Info[23].Room = "EventArea2_5_3"
Stage2_Room_Info[23].Coordinate = "3,5"
Stage2_Room_Info[23].WallCount = 4
Stage2_Room_Info[23].Wall_1 = "MovableModel2_47"
Stage2_Room_Info[23].Wall_2 = "MovableModel2_52"
Stage2_Room_Info[23].Wall_3 = "MovableModel2_53"
Stage2_Room_Info[23].Wall_4 = "MovableModel2_58"
Stage2_Room_Info[23].ItemSpawnPointCount = 2
Stage2_Room_Info[23].ItemSpawnPoint_1 = "SaPoint2_5_3_1"
Stage2_Room_Info[23].ItemSpawnPoint_2 = "SaPoint2_5_3_2"
	   
Stage2_Room_Info[24] ={}
Stage2_Room_Info[24].Room = "EventArea2_5_4"
Stage2_Room_Info[24].Coordinate = "4,5"
Stage2_Room_Info[24].WallCount = 4
Stage2_Room_Info[24].Wall_1 = "MovableModel2_48"
Stage2_Room_Info[24].Wall_2 = "MovableModel2_53"
Stage2_Room_Info[24].Wall_3 = "MovableModel2_54"
Stage2_Room_Info[24].Wall_4 = "MovableModel2_59"
Stage2_Room_Info[24].ItemSpawnPointCount = 2
Stage2_Room_Info[24].ItemSpawnPoint_1 = "SaPoint2_5_4_1"
Stage2_Room_Info[24].ItemSpawnPoint_2 = "SaPoint2_5_4_2"
	   
Stage2_Room_Info[25] ={}
Stage2_Room_Info[25].Room = "EventArea2_5_5"
Stage2_Room_Info[25].Coordinate = "5,5"
Stage2_Room_Info[25].WallCount = 4
Stage2_Room_Info[25].Wall_1 = "MovableModel2_49"
Stage2_Room_Info[25].Wall_2 = "MovableModel2_54"
Stage2_Room_Info[25].Wall_3 = "MovableModel2_55"
Stage2_Room_Info[25].Wall_4 = "MovableModel2_60"
Stage2_Room_Info[25].ItemSpawnPointCount = 2
Stage2_Room_Info[25].ItemSpawnPoint_1 = "SaPoint2_5_5_1"
Stage2_Room_Info[25].ItemSpawnPoint_2 = "SaPoint2_5_5_2"
	   
 
Stage3_Room_Info = {}

Stage3_Room_Info[1] ={}
Stage3_Room_Info[1].Room = "EventArea3_1_1"
Stage3_Room_Info[1].Coordinate = "1,1"
Stage3_Room_Info[1].WallCount = 4
Stage3_Room_Info[1].Wall_1 = "MovableModel3_1"
Stage3_Room_Info[1].Wall_2 = "MovableModel3_6"
Stage3_Room_Info[1].Wall_3 = "MovableModel3_7"
Stage3_Room_Info[1].Wall_4 = "MovableModel3_12"
Stage3_Room_Info[1].ItemSpawnPointCount = 2
Stage3_Room_Info[1].ItemSpawnPoint_1 = "SaPoint3_1_1_1"
Stage3_Room_Info[1].ItemSpawnPoint_2 = "SaPoint3_1_1_2"
	   
Stage3_Room_Info[2] ={}
Stage3_Room_Info[2].Room = "EventArea3_1_2"
Stage3_Room_Info[2].Coordinate = "2,1"
Stage3_Room_Info[2].WallCount = 4
Stage3_Room_Info[2].Wall_1 = "MovableModel3_2"
Stage3_Room_Info[2].Wall_2 = "MovableModel3_7"
Stage3_Room_Info[2].Wall_3 = "MovableModel3_8"
Stage3_Room_Info[2].Wall_4 = "MovableModel3_13"
Stage3_Room_Info[2].ItemSpawnPointCount = 2
Stage3_Room_Info[2].ItemSpawnPoint_1 = "SaPoint3_1_2_1"
Stage3_Room_Info[2].ItemSpawnPoint_2 = "SaPoint3_1_2_2"
	   
Stage3_Room_Info[3] ={}
Stage3_Room_Info[3].Room = "EventArea3_1_3"
Stage3_Room_Info[3].Coordinate = "3,1"
Stage3_Room_Info[3].WallCount = 4
Stage3_Room_Info[3].Wall_1 = "MovableModel3_3"
Stage3_Room_Info[3].Wall_2 = "MovableModel3_8"
Stage3_Room_Info[3].Wall_3 = "MovableModel3_9"
Stage3_Room_Info[3].Wall_4 = "MovableModel3_14"
Stage3_Room_Info[3].ItemSpawnPointCount = 2
Stage3_Room_Info[3].ItemSpawnPoint_1 = "SaPoint3_1_3_1"
Stage3_Room_Info[3].ItemSpawnPoint_2 = "SaPoint3_1_3_2"
	   
Stage3_Room_Info[4] ={}
Stage3_Room_Info[4].Room = "EventArea3_1_4"
Stage3_Room_Info[4].Coordinate = "4,1"
Stage3_Room_Info[4].WallCount = 4
Stage3_Room_Info[4].Wall_1 = "MovableModel3_4"
Stage3_Room_Info[4].Wall_2 = "MovableModel3_9"
Stage3_Room_Info[4].Wall_3 = "MovableModel3_10"
Stage3_Room_Info[4].Wall_4 = "MovableModel3_15"
Stage3_Room_Info[4].ItemSpawnPointCount = 2
Stage3_Room_Info[4].ItemSpawnPoint_1 = "SaPoint3_1_4_1"
Stage3_Room_Info[4].ItemSpawnPoint_2 = "SaPoint3_1_4_2"
	   
Stage3_Room_Info[5] ={}
Stage3_Room_Info[5].Room = "EventArea3_1_5"
Stage3_Room_Info[5].Coordinate = "5,1"
Stage3_Room_Info[5].WallCount = 4
Stage3_Room_Info[5].Wall_1 = "MovableModel3_5"
Stage3_Room_Info[5].Wall_2 = "MovableModel3_10"
Stage3_Room_Info[5].Wall_3 = "MovableModel3_11"
Stage3_Room_Info[5].Wall_4 = "MovableModel3_16"
Stage3_Room_Info[5].ItemSpawnPointCount = 2
Stage3_Room_Info[5].ItemSpawnPoint_1 = "SaPoint3_1_5_1"
Stage3_Room_Info[5].ItemSpawnPoint_2 = "SaPoint3_1_5_2"
	   
Stage3_Room_Info[6] ={}
Stage3_Room_Info[6].Room = "EventArea3_2_1"
Stage3_Room_Info[6].Coordinate = "1,2"
Stage3_Room_Info[6].WallCount = 4
Stage3_Room_Info[6].Wall_1 = "MovableModel3_12"
Stage3_Room_Info[6].Wall_2 = "MovableModel3_17"
Stage3_Room_Info[6].Wall_3 = "MovableModel3_18"
Stage3_Room_Info[6].Wall_4 = "MovableModel3_23"
Stage3_Room_Info[6].ItemSpawnPointCount = 2
Stage3_Room_Info[6].ItemSpawnPoint_1 = "SaPoint3_2_1_1"
Stage3_Room_Info[6].ItemSpawnPoint_2 = "SaPoint3_2_1_2"
	   
Stage3_Room_Info[7] ={}
Stage3_Room_Info[7].Room = "EventArea3_2_2"
Stage3_Room_Info[7].Coordinate = "2,2"
Stage3_Room_Info[7].WallCount = 4
Stage3_Room_Info[7].Wall_1 = "MovableModel3_13"
Stage3_Room_Info[7].Wall_2 = "MovableModel3_18"
Stage3_Room_Info[7].Wall_3 = "MovableModel3_19"
Stage3_Room_Info[7].Wall_4 = "MovableModel3_24"
Stage3_Room_Info[7].ItemSpawnPointCount = 2
Stage3_Room_Info[7].ItemSpawnPoint_1 = "SaPoint3_2_2_1"
Stage3_Room_Info[7].ItemSpawnPoint_2 = "SaPoint3_2_2_2"
	   
Stage3_Room_Info[8] ={}
Stage3_Room_Info[8].Room = "EventArea3_2_3"
Stage3_Room_Info[8].Coordinate = "3,2"
Stage3_Room_Info[8].WallCount = 4
Stage3_Room_Info[8].Wall_1 = "MovableModel3_14"
Stage3_Room_Info[8].Wall_2 = "MovableModel3_19"
Stage3_Room_Info[8].Wall_3 = "MovableModel3_20"
Stage3_Room_Info[8].Wall_4 = "MovableModel3_25"
Stage3_Room_Info[8].ItemSpawnPointCount = 2
Stage3_Room_Info[8].ItemSpawnPoint_1 = "SaPoint3_2_3_1"
Stage3_Room_Info[8].ItemSpawnPoint_2 = "SaPoint3_2_3_2"
	   
Stage3_Room_Info[9] ={}
Stage3_Room_Info[9].Room = "EventArea3_2_4"
Stage3_Room_Info[9].Coordinate = "4,2"
Stage3_Room_Info[9].WallCount = 4
Stage3_Room_Info[9].Wall_1 = "MovableModel3_15"
Stage3_Room_Info[9].Wall_2 = "MovableModel3_20"
Stage3_Room_Info[9].Wall_3 = "MovableModel3_21"
Stage3_Room_Info[9].Wall_4 = "MovableModel3_26"
Stage3_Room_Info[9].ItemSpawnPointCount = 2
Stage3_Room_Info[9].ItemSpawnPoint_1 = "SaPoint3_2_4_1"
Stage3_Room_Info[9].ItemSpawnPoint_2 = "SaPoint3_2_4_2"
	   
Stage3_Room_Info[10] ={}
Stage3_Room_Info[10].Room = "EventArea3_2_5"
Stage3_Room_Info[10].Coordinate = "5,2"
Stage3_Room_Info[10].WallCount = 4
Stage3_Room_Info[10].Wall_1 = "MovableModel3_16"
Stage3_Room_Info[10].Wall_2 = "MovableModel3_21"
Stage3_Room_Info[10].Wall_3 = "MovableModel3_22"
Stage3_Room_Info[10].Wall_4 = "MovableModel3_27"
Stage3_Room_Info[10].ItemSpawnPointCount = 2
Stage3_Room_Info[10].ItemSpawnPoint_1 = "SaPoint3_2_5_1"
Stage3_Room_Info[10].ItemSpawnPoint_2 = "SaPoint3_2_5_2"
	   
Stage3_Room_Info[11] ={}
Stage3_Room_Info[11].Room = "EventArea3_3_1"
Stage3_Room_Info[11].Coordinate = "1,3"
Stage3_Room_Info[11].WallCount = 4
Stage3_Room_Info[11].Wall_1 = "MovableModel3_23"
Stage3_Room_Info[11].Wall_2 = "MovableModel3_28"
Stage3_Room_Info[11].Wall_3 = "MovableModel3_29"
Stage3_Room_Info[11].Wall_4 = "MovableModel3_34"
Stage3_Room_Info[11].ItemSpawnPointCount = 2
Stage3_Room_Info[11].ItemSpawnPoint_1 = "SaPoint3_3_1_1"
Stage3_Room_Info[11].ItemSpawnPoint_2 = "SaPoint3_3_1_2"
	   
Stage3_Room_Info[12] ={}
Stage3_Room_Info[12].Room = "EventArea3_3_2"
Stage3_Room_Info[12].Coordinate = "2,3"
Stage3_Room_Info[12].WallCount = 4
Stage3_Room_Info[12].Wall_1 = "MovableModel3_24"
Stage3_Room_Info[12].Wall_2 = "MovableModel3_29"
Stage3_Room_Info[12].Wall_3 = "MovableModel3_30"
Stage3_Room_Info[12].Wall_4 = "MovableModel3_35"
Stage3_Room_Info[12].ItemSpawnPointCount = 2
Stage3_Room_Info[12].ItemSpawnPoint_1 = "SaPoint3_3_2_1"
Stage3_Room_Info[12].ItemSpawnPoint_2 = "SaPoint3_3_2_2"
	   
Stage3_Room_Info[13] ={}
Stage3_Room_Info[13].Room = "EventArea3_3_3"
Stage3_Room_Info[13].Coordinate = "3,3"
Stage3_Room_Info[13].WallCount = 4
Stage3_Room_Info[13].Wall_1 = "MovableModel3_25"
Stage3_Room_Info[13].Wall_2 = "MovableModel3_30"
Stage3_Room_Info[13].Wall_3 = "MovableModel3_31"
Stage3_Room_Info[13].Wall_4 = "MovableModel3_36"
Stage3_Room_Info[13].ItemSpawnPointCount = 2
Stage3_Room_Info[13].ItemSpawnPoint_1 = "SaPoint3_3_3_1"
Stage3_Room_Info[13].ItemSpawnPoint_2 = "SaPoint3_3_3_2"
	   
Stage3_Room_Info[14] ={}
Stage3_Room_Info[14].Room = "EventArea3_3_4"
Stage3_Room_Info[14].Coordinate = "4,3"
Stage3_Room_Info[14].WallCount = 4
Stage3_Room_Info[14].Wall_1 = "MovableModel3_26"
Stage3_Room_Info[14].Wall_2 = "MovableModel3_31"
Stage3_Room_Info[14].Wall_3 = "MovableModel3_32"
Stage3_Room_Info[14].Wall_4 = "MovableModel3_37"
Stage3_Room_Info[14].ItemSpawnPointCount = 2
Stage3_Room_Info[14].ItemSpawnPoint_1 = "SaPoint3_3_4_1"
Stage3_Room_Info[14].ItemSpawnPoint_2 = "SaPoint3_3_4_2"
	   
Stage3_Room_Info[15] ={}
Stage3_Room_Info[15].Room = "EventArea3_3_5"
Stage3_Room_Info[15].Coordinate = "5,3"
Stage3_Room_Info[15].WallCount = 4
Stage3_Room_Info[15].Wall_1 = "MovableModel3_27"
Stage3_Room_Info[15].Wall_2 = "MovableModel3_32"
Stage3_Room_Info[15].Wall_3 = "MovableModel3_33"
Stage3_Room_Info[15].Wall_4 = "MovableModel3_38"
Stage3_Room_Info[15].ItemSpawnPointCount = 2
Stage3_Room_Info[15].ItemSpawnPoint_1 = "SaPoint3_3_5_1"
Stage3_Room_Info[15].ItemSpawnPoint_2 = "SaPoint3_3_5_2"
	   
Stage3_Room_Info[16] ={}
Stage3_Room_Info[16].Room = "EventArea3_4_1"
Stage3_Room_Info[16].Coordinate = "1,4"
Stage3_Room_Info[16].WallCount = 4
Stage3_Room_Info[16].Wall_1 = "MovableModel3_34"
Stage3_Room_Info[16].Wall_2 = "MovableModel3_39"
Stage3_Room_Info[16].Wall_3 = "MovableModel3_40"
Stage3_Room_Info[16].Wall_4 = "MovableModel3_45"
Stage3_Room_Info[16].ItemSpawnPointCount = 2
Stage3_Room_Info[16].ItemSpawnPoint_1 = "SaPoint3_4_1_1"
Stage3_Room_Info[16].ItemSpawnPoint_2 = "SaPoint3_4_1_2"
	   
Stage3_Room_Info[17] ={}
Stage3_Room_Info[17].Room = "EventArea3_4_2"
Stage3_Room_Info[17].Coordinate = "2,4"
Stage3_Room_Info[17].WallCount = 4
Stage3_Room_Info[17].Wall_1 = "MovableModel3_35"
Stage3_Room_Info[17].Wall_2 = "MovableModel3_40"
Stage3_Room_Info[17].Wall_3 = "MovableModel3_41"
Stage3_Room_Info[17].Wall_4 = "MovableModel3_46"
Stage3_Room_Info[17].ItemSpawnPointCount = 2
Stage3_Room_Info[17].ItemSpawnPoint_1 = "SaPoint3_4_2_1"
Stage3_Room_Info[17].ItemSpawnPoint_2 = "SaPoint3_4_2_2"
	   
Stage3_Room_Info[18] ={}
Stage3_Room_Info[18].Room = "EventArea3_4_3"
Stage3_Room_Info[18].Coordinate = "3,4"
Stage3_Room_Info[18].WallCount = 4
Stage3_Room_Info[18].Wall_1 = "MovableModel3_36"
Stage3_Room_Info[18].Wall_2 = "MovableModel3_41"
Stage3_Room_Info[18].Wall_3 = "MovableModel3_42"
Stage3_Room_Info[18].Wall_4 = "MovableModel3_47"
Stage3_Room_Info[18].ItemSpawnPointCount = 2
Stage3_Room_Info[18].ItemSpawnPoint_1 = "SaPoint3_4_3_1"
Stage3_Room_Info[18].ItemSpawnPoint_2 = "SaPoint3_4_3_2"
	   
Stage3_Room_Info[19] ={}
Stage3_Room_Info[19].Room = "EventArea3_4_4"
Stage3_Room_Info[19].Coordinate = "4,4"
Stage3_Room_Info[19].WallCount = 4
Stage3_Room_Info[19].Wall_1 = "MovableModel3_37"
Stage3_Room_Info[19].Wall_2 = "MovableModel3_42"
Stage3_Room_Info[19].Wall_3 = "MovableModel3_43"
Stage3_Room_Info[19].Wall_4 = "MovableModel3_48"
Stage3_Room_Info[19].ItemSpawnPointCount = 2
Stage3_Room_Info[19].ItemSpawnPoint_1 = "SaPoint3_4_4_1"
Stage3_Room_Info[19].ItemSpawnPoint_2 = "SaPoint3_4_4_2"
	   
Stage3_Room_Info[20] ={}
Stage3_Room_Info[20].Room = "EventArea3_4_5"
Stage3_Room_Info[20].Coordinate = "5,4"
Stage3_Room_Info[20].WallCount = 4
Stage3_Room_Info[20].Wall_1 = "MovableModel3_38"
Stage3_Room_Info[20].Wall_2 = "MovableModel3_43"
Stage3_Room_Info[20].Wall_3 = "MovableModel3_44"
Stage3_Room_Info[20].Wall_4 = "MovableModel3_49"
Stage3_Room_Info[20].ItemSpawnPointCount = 2
Stage3_Room_Info[20].ItemSpawnPoint_1 = "SaPoint3_4_5_1"
Stage3_Room_Info[20].ItemSpawnPoint_2 = "SaPoint3_4_5_2"
	   
Stage3_Room_Info[21] ={}
Stage3_Room_Info[21].Room = "EventArea3_5_1"
Stage3_Room_Info[21].Coordinate = "1,5"
Stage3_Room_Info[21].WallCount = 4
Stage3_Room_Info[21].Wall_1 = "MovableModel3_45"
Stage3_Room_Info[21].Wall_2 = "MovableModel3_50"
Stage3_Room_Info[21].Wall_3 = "MovableModel3_51"
Stage3_Room_Info[21].Wall_4 = "MovableModel3_56"
Stage3_Room_Info[21].ItemSpawnPointCount = 2
Stage3_Room_Info[21].ItemSpawnPoint_1 = "SaPoint3_5_1_1"
Stage3_Room_Info[21].ItemSpawnPoint_2 = "SaPoint3_5_1_2"
	   
Stage3_Room_Info[22] ={}
Stage3_Room_Info[22].Room = "EventArea3_5_2"
Stage3_Room_Info[22].Coordinate = "2,5"
Stage3_Room_Info[22].WallCount = 4
Stage3_Room_Info[22].Wall_1 = "MovableModel3_46"
Stage3_Room_Info[22].Wall_2 = "MovableModel3_51"
Stage3_Room_Info[22].Wall_3 = "MovableModel3_52"
Stage3_Room_Info[22].Wall_4 = "MovableModel3_57"
Stage3_Room_Info[22].ItemSpawnPointCount = 2
Stage3_Room_Info[22].ItemSpawnPoint_1 = "SaPoint3_5_2_1"
Stage3_Room_Info[22].ItemSpawnPoint_2 = "SaPoint3_5_2_2"
	   
Stage3_Room_Info[23] ={}
Stage3_Room_Info[23].Room = "EventArea3_5_3"
Stage3_Room_Info[23].Coordinate = "3,5"
Stage3_Room_Info[23].WallCount = 4
Stage3_Room_Info[23].Wall_1 = "MovableModel3_47"
Stage3_Room_Info[23].Wall_2 = "MovableModel3_52"
Stage3_Room_Info[23].Wall_3 = "MovableModel3_53"
Stage3_Room_Info[23].Wall_4 = "MovableModel3_58"
Stage3_Room_Info[23].ItemSpawnPointCount = 2
Stage3_Room_Info[23].ItemSpawnPoint_1 = "SaPoint3_5_3_1"
Stage3_Room_Info[23].ItemSpawnPoint_2 = "SaPoint3_5_3_2"
	   
Stage3_Room_Info[24] ={}
Stage3_Room_Info[24].Room = "EventArea3_5_4"
Stage3_Room_Info[24].Coordinate = "4,5"
Stage3_Room_Info[24].WallCount = 4
Stage3_Room_Info[24].Wall_1 = "MovableModel3_48"
Stage3_Room_Info[24].Wall_2 = "MovableModel3_53"
Stage3_Room_Info[24].Wall_3 = "MovableModel3_54"
Stage3_Room_Info[24].Wall_4 = "MovableModel3_59"
Stage3_Room_Info[24].ItemSpawnPointCount = 2
Stage3_Room_Info[24].ItemSpawnPoint_1 = "SaPoint3_5_4_1"
Stage3_Room_Info[24].ItemSpawnPoint_2 = "SaPoint3_5_4_2"
	   
Stage3_Room_Info[25] ={}
Stage3_Room_Info[25].Room = "EventArea3_5_5"
Stage3_Room_Info[25].Coordinate = "5,5"
Stage3_Room_Info[25].WallCount = 4
Stage3_Room_Info[25].Wall_1 = "MovableModel3_49"
Stage3_Room_Info[25].Wall_2 = "MovableModel3_54"
Stage3_Room_Info[25].Wall_3 = "MovableModel3_55"
Stage3_Room_Info[25].Wall_4 = "MovableModel3_60"
Stage3_Room_Info[25].ItemSpawnPointCount = 2
Stage3_Room_Info[25].ItemSpawnPoint_1 = "SaPoint3_5_5_1"
Stage3_Room_Info[25].ItemSpawnPoint_2 = "SaPoint3_5_5_2"
	   
Stage4_Room_Info = {}

Stage4_Room_Info[1] ={}
Stage4_Room_Info[1].Room = "EventArea4_1_1"
Stage4_Room_Info[1].Coordinate = "1,1"
Stage4_Room_Info[1].WallCount = 4
Stage4_Room_Info[1].Wall_1 = "MovableModel4_1"
Stage4_Room_Info[1].Wall_2 = "MovableModel4_6"
Stage4_Room_Info[1].Wall_3 = "MovableModel4_7"
Stage4_Room_Info[1].Wall_4 = "MovableModel4_12"
Stage4_Room_Info[1].ItemSpawnPointCount = 2
Stage4_Room_Info[1].ItemSpawnPoint_1 = "SaPoint4_1_1_1"
Stage4_Room_Info[1].ItemSpawnPoint_2 = "SaPoint4_1_1_2"
	   
Stage4_Room_Info[2] ={}
Stage4_Room_Info[2].Room = "EventArea4_1_2"
Stage4_Room_Info[2].Coordinate = "2,1"
Stage4_Room_Info[2].WallCount = 4
Stage4_Room_Info[2].Wall_1 = "MovableModel4_2"
Stage4_Room_Info[2].Wall_2 = "MovableModel4_7"
Stage4_Room_Info[2].Wall_3 = "MovableModel4_8"
Stage4_Room_Info[2].Wall_4 = "MovableModel4_13"
Stage4_Room_Info[2].ItemSpawnPointCount = 2
Stage4_Room_Info[2].ItemSpawnPoint_1 = "SaPoint4_1_2_1"
Stage4_Room_Info[2].ItemSpawnPoint_2 = "SaPoint4_1_2_2"
	   
Stage4_Room_Info[3] ={}
Stage4_Room_Info[3].Room = "EventArea4_1_3"
Stage4_Room_Info[3].Coordinate = "3,1"
Stage4_Room_Info[3].WallCount = 4
Stage4_Room_Info[3].Wall_1 = "MovableModel4_3"
Stage4_Room_Info[3].Wall_2 = "MovableModel4_8"
Stage4_Room_Info[3].Wall_3 = "MovableModel4_9"
Stage4_Room_Info[3].Wall_4 = "MovableModel4_14"
Stage4_Room_Info[3].ItemSpawnPointCount = 2
Stage4_Room_Info[3].ItemSpawnPoint_1 = "SaPoint4_1_3_1"
Stage4_Room_Info[3].ItemSpawnPoint_2 = "SaPoint4_1_3_2"
	   
Stage4_Room_Info[4] ={}
Stage4_Room_Info[4].Room = "EventArea4_1_4"
Stage4_Room_Info[4].Coordinate = "4,1"
Stage4_Room_Info[4].WallCount = 4
Stage4_Room_Info[4].Wall_1 = "MovableModel4_4"
Stage4_Room_Info[4].Wall_2 = "MovableModel4_9"
Stage4_Room_Info[4].Wall_3 = "MovableModel4_10"
Stage4_Room_Info[4].Wall_4 = "MovableModel4_15"
Stage4_Room_Info[4].ItemSpawnPointCount = 2
Stage4_Room_Info[4].ItemSpawnPoint_1 = "SaPoint4_1_4_1"
Stage4_Room_Info[4].ItemSpawnPoint_2 = "SaPoint4_1_4_2"
	   
Stage4_Room_Info[5] ={}
Stage4_Room_Info[5].Room = "EventArea4_1_5"
Stage4_Room_Info[5].Coordinate = "5,1"
Stage4_Room_Info[5].WallCount = 4
Stage4_Room_Info[5].Wall_1 = "MovableModel4_5"
Stage4_Room_Info[5].Wall_2 = "MovableModel4_10"
Stage4_Room_Info[5].Wall_3 = "MovableModel4_11"
Stage4_Room_Info[5].Wall_4 = "MovableModel4_16"
Stage4_Room_Info[5].ItemSpawnPointCount = 2
Stage4_Room_Info[5].ItemSpawnPoint_1 = "SaPoint4_1_5_1"
Stage4_Room_Info[5].ItemSpawnPoint_2 = "SaPoint4_1_5_2"
	   
Stage4_Room_Info[6] ={}
Stage4_Room_Info[6].Room = "EventArea4_2_1"
Stage4_Room_Info[6].Coordinate = "1,2"
Stage4_Room_Info[6].WallCount = 4
Stage4_Room_Info[6].Wall_1 = "MovableModel4_12"
Stage4_Room_Info[6].Wall_2 = "MovableModel4_17"
Stage4_Room_Info[6].Wall_3 = "MovableModel4_18"
Stage4_Room_Info[6].Wall_4 = "MovableModel4_23"
Stage4_Room_Info[6].ItemSpawnPointCount = 2
Stage4_Room_Info[6].ItemSpawnPoint_1 = "SaPoint4_2_1_1"
Stage4_Room_Info[6].ItemSpawnPoint_2 = "SaPoint4_2_1_2"
	   
Stage4_Room_Info[7] ={}
Stage4_Room_Info[7].Room = "EventArea4_2_2"
Stage4_Room_Info[7].Coordinate = "2,2"
Stage4_Room_Info[7].WallCount = 4
Stage4_Room_Info[7].Wall_1 = "MovableModel4_13"
Stage4_Room_Info[7].Wall_2 = "MovableModel4_18"
Stage4_Room_Info[7].Wall_3 = "MovableModel4_19"
Stage4_Room_Info[7].Wall_4 = "MovableModel4_24"
Stage4_Room_Info[7].ItemSpawnPointCount = 2
Stage4_Room_Info[7].ItemSpawnPoint_1 = "SaPoint4_2_2_1"
Stage4_Room_Info[7].ItemSpawnPoint_2 = "SaPoint4_2_2_2"
	   
Stage4_Room_Info[8] ={}
Stage4_Room_Info[8].Room = "EventArea4_2_3"
Stage4_Room_Info[8].Coordinate = "3,2"
Stage4_Room_Info[8].WallCount = 4
Stage4_Room_Info[8].Wall_1 = "MovableModel4_14"
Stage4_Room_Info[8].Wall_2 = "MovableModel4_19"
Stage4_Room_Info[8].Wall_3 = "MovableModel4_20"
Stage4_Room_Info[8].Wall_4 = "MovableModel4_25"
Stage4_Room_Info[8].ItemSpawnPointCount = 2
Stage4_Room_Info[8].ItemSpawnPoint_1 = "SaPoint4_2_3_1"
Stage4_Room_Info[8].ItemSpawnPoint_2 = "SaPoint4_2_3_2"
	   
Stage4_Room_Info[9] ={}
Stage4_Room_Info[9].Room = "EventArea4_2_4"
Stage4_Room_Info[9].Coordinate = "4,2"
Stage4_Room_Info[9].WallCount = 4
Stage4_Room_Info[9].Wall_1 = "MovableModel4_15"
Stage4_Room_Info[9].Wall_2 = "MovableModel4_20"
Stage4_Room_Info[9].Wall_3 = "MovableModel4_21"
Stage4_Room_Info[9].Wall_4 = "MovableModel4_26"
Stage4_Room_Info[9].ItemSpawnPointCount = 2
Stage4_Room_Info[9].ItemSpawnPoint_1 = "SaPoint4_2_4_1"
Stage4_Room_Info[9].ItemSpawnPoint_2 = "SaPoint4_2_4_2"
	   
Stage4_Room_Info[10] ={}
Stage4_Room_Info[10].Room = "EventArea4_2_5"
Stage4_Room_Info[10].Coordinate = "5,2"
Stage4_Room_Info[10].WallCount = 4
Stage4_Room_Info[10].Wall_1 = "MovableModel4_16"
Stage4_Room_Info[10].Wall_2 = "MovableModel4_21"
Stage4_Room_Info[10].Wall_3 = "MovableModel4_22"
Stage4_Room_Info[10].Wall_4 = "MovableModel4_27"
Stage4_Room_Info[10].ItemSpawnPointCount = 2
Stage4_Room_Info[10].ItemSpawnPoint_1 = "SaPoint4_2_5_1"
Stage4_Room_Info[10].ItemSpawnPoint_2 = "SaPoint4_2_5_2"
	   
Stage4_Room_Info[11] ={}
Stage4_Room_Info[11].Room = "EventArea4_3_1"
Stage4_Room_Info[11].Coordinate = "1,3"
Stage4_Room_Info[11].WallCount = 4
Stage4_Room_Info[11].Wall_1 = "MovableModel4_23"
Stage4_Room_Info[11].Wall_2 = "MovableModel4_28"
Stage4_Room_Info[11].Wall_3 = "MovableModel4_29"
Stage4_Room_Info[11].Wall_4 = "MovableModel4_34"
Stage4_Room_Info[11].ItemSpawnPointCount = 2
Stage4_Room_Info[11].ItemSpawnPoint_1 = "SaPoint4_3_1_1"
Stage4_Room_Info[11].ItemSpawnPoint_2 = "SaPoint4_3_1_2"
	   
Stage4_Room_Info[12] ={}
Stage4_Room_Info[12].Room = "EventArea4_3_2"
Stage4_Room_Info[12].Coordinate = "2,3"
Stage4_Room_Info[12].WallCount = 4
Stage4_Room_Info[12].Wall_1 = "MovableModel4_24"
Stage4_Room_Info[12].Wall_2 = "MovableModel4_29"
Stage4_Room_Info[12].Wall_3 = "MovableModel4_30"
Stage4_Room_Info[12].Wall_4 = "MovableModel4_35"
Stage4_Room_Info[12].ItemSpawnPointCount = 2
Stage4_Room_Info[12].ItemSpawnPoint_1 = "SaPoint4_3_2_1"
Stage4_Room_Info[12].ItemSpawnPoint_2 = "SaPoint4_3_2_2"
	   
Stage4_Room_Info[13] ={}
Stage4_Room_Info[13].Room = "EventArea4_3_3"
Stage4_Room_Info[13].Coordinate = "3,3"
Stage4_Room_Info[13].WallCount = 4
Stage4_Room_Info[13].Wall_1 = "MovableModel4_25"
Stage4_Room_Info[13].Wall_2 = "MovableModel4_30"
Stage4_Room_Info[13].Wall_3 = "MovableModel4_31"
Stage4_Room_Info[13].Wall_4 = "MovableModel4_36"
Stage4_Room_Info[13].ItemSpawnPointCount = 2
Stage4_Room_Info[13].ItemSpawnPoint_1 = "SaPoint4_3_3_1"
Stage4_Room_Info[13].ItemSpawnPoint_2 = "SaPoint4_3_3_2"
	   
Stage4_Room_Info[14] ={}
Stage4_Room_Info[14].Room = "EventArea4_3_4"
Stage4_Room_Info[14].Coordinate = "4,3"
Stage4_Room_Info[14].WallCount = 4
Stage4_Room_Info[14].Wall_1 = "MovableModel4_26"
Stage4_Room_Info[14].Wall_2 = "MovableModel4_31"
Stage4_Room_Info[14].Wall_3 = "MovableModel4_32"
Stage4_Room_Info[14].Wall_4 = "MovableModel4_37"
Stage4_Room_Info[14].ItemSpawnPointCount = 2
Stage4_Room_Info[14].ItemSpawnPoint_1 = "SaPoint4_3_4_1"
Stage4_Room_Info[14].ItemSpawnPoint_2 = "SaPoint4_3_4_2"
	   
Stage4_Room_Info[15] ={}
Stage4_Room_Info[15].Room = "EventArea4_3_5"
Stage4_Room_Info[15].Coordinate = "5,3"
Stage4_Room_Info[15].WallCount = 4
Stage4_Room_Info[15].Wall_1 = "MovableModel4_27"
Stage4_Room_Info[15].Wall_2 = "MovableModel4_32"
Stage4_Room_Info[15].Wall_3 = "MovableModel4_33"
Stage4_Room_Info[15].Wall_4 = "MovableModel4_38"
Stage4_Room_Info[15].ItemSpawnPointCount = 2
Stage4_Room_Info[15].ItemSpawnPoint_1 = "SaPoint4_3_5_1"
Stage4_Room_Info[15].ItemSpawnPoint_2 = "SaPoint4_3_5_2"
	   
Stage4_Room_Info[16] ={}
Stage4_Room_Info[16].Room = "EventArea4_4_1"
Stage4_Room_Info[16].Coordinate = "1,4"
Stage4_Room_Info[16].WallCount = 4
Stage4_Room_Info[16].Wall_1 = "MovableModel4_34"
Stage4_Room_Info[16].Wall_2 = "MovableModel4_39"
Stage4_Room_Info[16].Wall_3 = "MovableModel4_40"
Stage4_Room_Info[16].Wall_4 = "MovableModel4_45"
Stage4_Room_Info[16].ItemSpawnPointCount = 2
Stage4_Room_Info[16].ItemSpawnPoint_1 = "SaPoint4_4_1_1"
Stage4_Room_Info[16].ItemSpawnPoint_2 = "SaPoint4_4_1_2"
	   
Stage4_Room_Info[17] ={}
Stage4_Room_Info[17].Room = "EventArea4_4_2"
Stage4_Room_Info[17].Coordinate = "2,4"
Stage4_Room_Info[17].WallCount = 4
Stage4_Room_Info[17].Wall_1 = "MovableModel4_35"
Stage4_Room_Info[17].Wall_2 = "MovableModel4_40"
Stage4_Room_Info[17].Wall_3 = "MovableModel4_41"
Stage4_Room_Info[17].Wall_4 = "MovableModel4_46"
Stage4_Room_Info[17].ItemSpawnPointCount = 2
Stage4_Room_Info[17].ItemSpawnPoint_1 = "SaPoint4_4_2_1"
Stage4_Room_Info[17].ItemSpawnPoint_2 = "SaPoint4_4_2_2"
	   
Stage4_Room_Info[18] ={}
Stage4_Room_Info[18].Room = "EventArea4_4_3"
Stage4_Room_Info[18].Coordinate = "3,4"
Stage4_Room_Info[18].WallCount = 4
Stage4_Room_Info[18].Wall_1 = "MovableModel4_36"
Stage4_Room_Info[18].Wall_2 = "MovableModel4_41"
Stage4_Room_Info[18].Wall_3 = "MovableModel4_42"
Stage4_Room_Info[18].Wall_4 = "MovableModel4_47"
Stage4_Room_Info[18].ItemSpawnPointCount = 2
Stage4_Room_Info[18].ItemSpawnPoint_1 = "SaPoint4_4_3_1"
Stage4_Room_Info[18].ItemSpawnPoint_2 = "SaPoint4_4_3_2"
	   
Stage4_Room_Info[19] ={}
Stage4_Room_Info[19].Room = "EventArea4_4_4"
Stage4_Room_Info[19].Coordinate = "4,4"
Stage4_Room_Info[19].WallCount = 4
Stage4_Room_Info[19].Wall_1 = "MovableModel4_37"
Stage4_Room_Info[19].Wall_2 = "MovableModel4_42"
Stage4_Room_Info[19].Wall_3 = "MovableModel4_43"
Stage4_Room_Info[19].Wall_4 = "MovableModel4_48"
Stage4_Room_Info[19].ItemSpawnPointCount = 2
Stage4_Room_Info[19].ItemSpawnPoint_1 = "SaPoint4_4_4_1"
Stage4_Room_Info[19].ItemSpawnPoint_2 = "SaPoint4_4_4_2"
	   
Stage4_Room_Info[20] ={}
Stage4_Room_Info[20].Room = "EventArea4_4_5"
Stage4_Room_Info[20].Coordinate = "5,4"
Stage4_Room_Info[20].WallCount = 4
Stage4_Room_Info[20].Wall_1 = "MovableModel4_38"
Stage4_Room_Info[20].Wall_2 = "MovableModel4_43"
Stage4_Room_Info[20].Wall_3 = "MovableModel4_44"
Stage4_Room_Info[20].Wall_4 = "MovableModel4_49"
Stage4_Room_Info[20].ItemSpawnPointCount = 2
Stage4_Room_Info[20].ItemSpawnPoint_1 = "SaPoint4_4_5_1"
Stage4_Room_Info[20].ItemSpawnPoint_2 = "SaPoint4_4_5_2"
	   
Stage4_Room_Info[21] ={}
Stage4_Room_Info[21].Room = "EventArea4_5_1"
Stage4_Room_Info[21].Coordinate = "1,5"
Stage4_Room_Info[21].WallCount = 4
Stage4_Room_Info[21].Wall_1 = "MovableModel4_45"
Stage4_Room_Info[21].Wall_2 = "MovableModel4_50"
Stage4_Room_Info[21].Wall_3 = "MovableModel4_51"
Stage4_Room_Info[21].Wall_4 = "MovableModel4_56"
Stage4_Room_Info[21].ItemSpawnPointCount = 2
Stage4_Room_Info[21].ItemSpawnPoint_1 = "SaPoint4_5_1_1"
Stage4_Room_Info[21].ItemSpawnPoint_2 = "SaPoint4_5_1_2"
	   
Stage4_Room_Info[22] ={}
Stage4_Room_Info[22].Room = "EventArea4_5_2"
Stage4_Room_Info[22].Coordinate = "2,5"
Stage4_Room_Info[22].WallCount = 4
Stage4_Room_Info[22].Wall_1 = "MovableModel4_46"
Stage4_Room_Info[22].Wall_2 = "MovableModel4_51"
Stage4_Room_Info[22].Wall_3 = "MovableModel4_52"
Stage4_Room_Info[22].Wall_4 = "MovableModel4_57"
Stage4_Room_Info[22].ItemSpawnPointCount = 2
Stage4_Room_Info[22].ItemSpawnPoint_1 = "SaPoint4_5_2_1"
Stage4_Room_Info[22].ItemSpawnPoint_2 = "SaPoint4_5_2_2"
	   
Stage4_Room_Info[23] ={}
Stage4_Room_Info[23].Room = "EventArea4_5_3"
Stage4_Room_Info[23].Coordinate = "3,5"
Stage4_Room_Info[23].WallCount = 4
Stage4_Room_Info[23].Wall_1 = "MovableModel4_47"
Stage4_Room_Info[23].Wall_2 = "MovableModel4_52"
Stage4_Room_Info[23].Wall_3 = "MovableModel4_53"
Stage4_Room_Info[23].Wall_4 = "MovableModel4_58"
Stage4_Room_Info[23].ItemSpawnPointCount = 2
Stage4_Room_Info[23].ItemSpawnPoint_1 = "SaPoint4_5_3_1"
Stage4_Room_Info[23].ItemSpawnPoint_2 = "SaPoint4_5_3_2"
	   
Stage4_Room_Info[24] ={}
Stage4_Room_Info[24].Room = "EventArea4_5_4"
Stage4_Room_Info[24].Coordinate = "4,5"
Stage4_Room_Info[24].WallCount = 4
Stage4_Room_Info[24].Wall_1 = "MovableModel4_48"
Stage4_Room_Info[24].Wall_2 = "MovableModel4_53"
Stage4_Room_Info[24].Wall_3 = "MovableModel4_54"
Stage4_Room_Info[24].Wall_4 = "MovableModel4_59"
Stage4_Room_Info[24].ItemSpawnPointCount = 2
Stage4_Room_Info[24].ItemSpawnPoint_1 = "SaPoint4_5_4_1"
Stage4_Room_Info[24].ItemSpawnPoint_2 = "SaPoint4_5_4_2"
	   
Stage4_Room_Info[25] ={}
Stage4_Room_Info[25].Room = "EventArea4_5_5"
Stage4_Room_Info[25].Coordinate = "5,5"
Stage4_Room_Info[25].WallCount = 4
Stage4_Room_Info[25].Wall_1 = "MovableModel4_49"
Stage4_Room_Info[25].Wall_2 = "MovableModel4_54"
Stage4_Room_Info[25].Wall_3 = "MovableModel4_55"
Stage4_Room_Info[25].Wall_4 = "MovableModel4_60"
Stage4_Room_Info[25].ItemSpawnPointCount = 2
Stage4_Room_Info[25].ItemSpawnPoint_1 = "SaPoint4_5_5_1"
Stage4_Room_Info[25].ItemSpawnPoint_2 = "SaPoint4_5_5_2"
	 
 
Stage5_Room_Info = {}

Stage5_Room_Info[1] ={}
Stage5_Room_Info[1].Room = "EventArea5_1_1"
Stage5_Room_Info[1].Coordinate = "1,1"
Stage5_Room_Info[1].WallCount = 4
Stage5_Room_Info[1].Wall_1 = "MovableModel5_1"
Stage5_Room_Info[1].Wall_2 = "MovableModel5_6"
Stage5_Room_Info[1].Wall_3 = "MovableModel5_7"
Stage5_Room_Info[1].Wall_4 = "MovableModel5_12"
Stage5_Room_Info[1].ItemSpawnPointCount = 2
Stage5_Room_Info[1].ItemSpawnPoint_1 = "SaPoint5_1_1_1"
Stage5_Room_Info[1].ItemSpawnPoint_2 = "SaPoint5_1_1_2"
	   
Stage5_Room_Info[2] ={}
Stage5_Room_Info[2].Room = "EventArea5_1_2"
Stage5_Room_Info[2].Coordinate = "2,1"
Stage5_Room_Info[2].WallCount = 4
Stage5_Room_Info[2].Wall_1 = "MovableModel5_2"
Stage5_Room_Info[2].Wall_2 = "MovableModel5_7"
Stage5_Room_Info[2].Wall_3 = "MovableModel5_8"
Stage5_Room_Info[2].Wall_4 = "MovableModel5_13"
Stage5_Room_Info[2].ItemSpawnPointCount = 2
Stage5_Room_Info[2].ItemSpawnPoint_1 = "SaPoint5_1_2_1"
Stage5_Room_Info[2].ItemSpawnPoint_2 = "SaPoint5_1_2_2"
	   
Stage5_Room_Info[3] ={}
Stage5_Room_Info[3].Room = "EventArea5_1_3"
Stage5_Room_Info[3].Coordinate = "3,1"
Stage5_Room_Info[3].WallCount = 4
Stage5_Room_Info[3].Wall_1 = "MovableModel5_3"
Stage5_Room_Info[3].Wall_2 = "MovableModel5_8"
Stage5_Room_Info[3].Wall_3 = "MovableModel5_9"
Stage5_Room_Info[3].Wall_4 = "MovableModel5_14"
Stage5_Room_Info[3].ItemSpawnPointCount = 2
Stage5_Room_Info[3].ItemSpawnPoint_1 = "SaPoint5_1_3_1"
Stage5_Room_Info[3].ItemSpawnPoint_2 = "SaPoint5_1_3_2"
	   
Stage5_Room_Info[4] ={}
Stage5_Room_Info[4].Room = "EventArea5_1_4"
Stage5_Room_Info[4].Coordinate = "4,1"
Stage5_Room_Info[4].WallCount = 4
Stage5_Room_Info[4].Wall_1 = "MovableModel5_4"
Stage5_Room_Info[4].Wall_2 = "MovableModel5_9"
Stage5_Room_Info[4].Wall_3 = "MovableModel5_10"
Stage5_Room_Info[4].Wall_4 = "MovableModel5_15"
Stage5_Room_Info[4].ItemSpawnPointCount = 2
Stage5_Room_Info[4].ItemSpawnPoint_1 = "SaPoint5_1_4_1"
Stage5_Room_Info[4].ItemSpawnPoint_2 = "SaPoint5_1_4_2"
	   
Stage5_Room_Info[5] ={}
Stage5_Room_Info[5].Room = "EventArea5_1_5"
Stage5_Room_Info[5].Coordinate = "5,1"
Stage5_Room_Info[5].WallCount = 4
Stage5_Room_Info[5].Wall_1 = "MovableModel5_5"
Stage5_Room_Info[5].Wall_2 = "MovableModel5_10"
Stage5_Room_Info[5].Wall_3 = "MovableModel5_11"
Stage5_Room_Info[5].Wall_4 = "MovableModel5_16"
Stage5_Room_Info[5].ItemSpawnPointCount = 2
Stage5_Room_Info[5].ItemSpawnPoint_1 = "SaPoint5_1_5_1"
Stage5_Room_Info[5].ItemSpawnPoint_2 = "SaPoint5_1_5_2"
	   
Stage5_Room_Info[6] ={}
Stage5_Room_Info[6].Room = "EventArea5_2_1"
Stage5_Room_Info[6].Coordinate = "1,2"
Stage5_Room_Info[6].WallCount = 4
Stage5_Room_Info[6].Wall_1 = "MovableModel5_12"
Stage5_Room_Info[6].Wall_2 = "MovableModel5_17"
Stage5_Room_Info[6].Wall_3 = "MovableModel5_18"
Stage5_Room_Info[6].Wall_4 = "MovableModel5_23"
Stage5_Room_Info[6].ItemSpawnPointCount = 2
Stage5_Room_Info[6].ItemSpawnPoint_1 = "SaPoint5_2_1_1"
Stage5_Room_Info[6].ItemSpawnPoint_2 = "SaPoint5_2_1_2"
	   
Stage5_Room_Info[7] ={}
Stage5_Room_Info[7].Room = "EventArea5_2_2"
Stage5_Room_Info[7].Coordinate = "2,2"
Stage5_Room_Info[7].WallCount = 4
Stage5_Room_Info[7].Wall_1 = "MovableModel5_13"
Stage5_Room_Info[7].Wall_2 = "MovableModel5_18"
Stage5_Room_Info[7].Wall_3 = "MovableModel5_19"
Stage5_Room_Info[7].Wall_4 = "MovableModel5_24"
Stage5_Room_Info[7].ItemSpawnPointCount = 2
Stage5_Room_Info[7].ItemSpawnPoint_1 = "SaPoint5_2_2_1"
Stage5_Room_Info[7].ItemSpawnPoint_2 = "SaPoint5_2_2_2"
	   
Stage5_Room_Info[8] ={}
Stage5_Room_Info[8].Room = "EventArea5_2_3"
Stage5_Room_Info[8].Coordinate = "3,2"
Stage5_Room_Info[8].WallCount = 4
Stage5_Room_Info[8].Wall_1 = "MovableModel5_14"
Stage5_Room_Info[8].Wall_2 = "MovableModel5_19"
Stage5_Room_Info[8].Wall_3 = "MovableModel5_20"
Stage5_Room_Info[8].Wall_4 = "MovableModel5_25"
Stage5_Room_Info[8].ItemSpawnPointCount = 2
Stage5_Room_Info[8].ItemSpawnPoint_1 = "SaPoint5_2_3_1"
Stage5_Room_Info[8].ItemSpawnPoint_2 = "SaPoint5_2_3_2"
	   
Stage5_Room_Info[9] ={}
Stage5_Room_Info[9].Room = "EventArea5_2_4"
Stage5_Room_Info[9].Coordinate = "4,2"
Stage5_Room_Info[9].WallCount = 4
Stage5_Room_Info[9].Wall_1 = "MovableModel5_15"
Stage5_Room_Info[9].Wall_2 = "MovableModel5_20"
Stage5_Room_Info[9].Wall_3 = "MovableModel5_21"
Stage5_Room_Info[9].Wall_4 = "MovableModel5_26"
Stage5_Room_Info[9].ItemSpawnPointCount = 2
Stage5_Room_Info[9].ItemSpawnPoint_1 = "SaPoint5_2_4_1"
Stage5_Room_Info[9].ItemSpawnPoint_2 = "SaPoint5_2_4_2"
	   
Stage5_Room_Info[10] ={}
Stage5_Room_Info[10].Room = "EventArea5_2_5"
Stage5_Room_Info[10].Coordinate = "5,2"
Stage5_Room_Info[10].WallCount = 4
Stage5_Room_Info[10].Wall_1 = "MovableModel5_16"
Stage5_Room_Info[10].Wall_2 = "MovableModel5_21"
Stage5_Room_Info[10].Wall_3 = "MovableModel5_22"
Stage5_Room_Info[10].Wall_4 = "MovableModel5_27"
Stage5_Room_Info[10].ItemSpawnPointCount = 2
Stage5_Room_Info[10].ItemSpawnPoint_1 = "SaPoint5_2_5_1"
Stage5_Room_Info[10].ItemSpawnPoint_2 = "SaPoint5_2_5_2"
	   
Stage5_Room_Info[11] ={}
Stage5_Room_Info[11].Room = "EventArea5_3_1"
Stage5_Room_Info[11].Coordinate = "1,3"
Stage5_Room_Info[11].WallCount = 4
Stage5_Room_Info[11].Wall_1 = "MovableModel5_23"
Stage5_Room_Info[11].Wall_2 = "MovableModel5_28"
Stage5_Room_Info[11].Wall_3 = "MovableModel5_29"
Stage5_Room_Info[11].Wall_4 = "MovableModel5_34"
Stage5_Room_Info[11].ItemSpawnPointCount = 2
Stage5_Room_Info[11].ItemSpawnPoint_1 = "SaPoint5_3_1_1"
Stage5_Room_Info[11].ItemSpawnPoint_2 = "SaPoint5_3_1_2"
	   
Stage5_Room_Info[12] ={}
Stage5_Room_Info[12].Room = "EventArea5_3_2"
Stage5_Room_Info[12].Coordinate = "2,3"
Stage5_Room_Info[12].WallCount = 4
Stage5_Room_Info[12].Wall_1 = "MovableModel5_24"
Stage5_Room_Info[12].Wall_2 = "MovableModel5_29"
Stage5_Room_Info[12].Wall_3 = "MovableModel5_30"
Stage5_Room_Info[12].Wall_4 = "MovableModel5_35"
Stage5_Room_Info[12].ItemSpawnPointCount = 2
Stage5_Room_Info[12].ItemSpawnPoint_1 = "SaPoint5_3_2_1"
Stage5_Room_Info[12].ItemSpawnPoint_2 = "SaPoint5_3_2_2"
	   
Stage5_Room_Info[13] ={}
Stage5_Room_Info[13].Room = "EventArea5_3_3"
Stage5_Room_Info[13].Coordinate = "3,3"
Stage5_Room_Info[13].WallCount = 4
Stage5_Room_Info[13].Wall_1 = "MovableModel5_25"
Stage5_Room_Info[13].Wall_2 = "MovableModel5_30"
Stage5_Room_Info[13].Wall_3 = "MovableModel5_31"
Stage5_Room_Info[13].Wall_4 = "MovableModel5_36"
Stage5_Room_Info[13].ItemSpawnPointCount = 2
Stage5_Room_Info[13].ItemSpawnPoint_1 = "SaPoint5_3_3_1"
Stage5_Room_Info[13].ItemSpawnPoint_2 = "SaPoint5_3_3_2"
	   
Stage5_Room_Info[14] ={}
Stage5_Room_Info[14].Room = "EventArea5_3_4"
Stage5_Room_Info[14].Coordinate = "4,3"
Stage5_Room_Info[14].WallCount = 4
Stage5_Room_Info[14].Wall_1 = "MovableModel5_26"
Stage5_Room_Info[14].Wall_2 = "MovableModel5_31"
Stage5_Room_Info[14].Wall_3 = "MovableModel5_32"
Stage5_Room_Info[14].Wall_4 = "MovableModel5_37"
Stage5_Room_Info[14].ItemSpawnPointCount = 2
Stage5_Room_Info[14].ItemSpawnPoint_1 = "SaPoint5_3_4_1"
Stage5_Room_Info[14].ItemSpawnPoint_2 = "SaPoint5_3_4_2"
	   
Stage5_Room_Info[15] ={}
Stage5_Room_Info[15].Room = "EventArea5_3_5"
Stage5_Room_Info[15].Coordinate = "5,3"
Stage5_Room_Info[15].WallCount = 4
Stage5_Room_Info[15].Wall_1 = "MovableModel5_27"
Stage5_Room_Info[15].Wall_2 = "MovableModel5_32"
Stage5_Room_Info[15].Wall_3 = "MovableModel5_33"
Stage5_Room_Info[15].Wall_4 = "MovableModel5_38"
Stage5_Room_Info[15].ItemSpawnPointCount = 2
Stage5_Room_Info[15].ItemSpawnPoint_1 = "SaPoint5_3_5_1"
Stage5_Room_Info[15].ItemSpawnPoint_2 = "SaPoint5_3_5_2"
	   
Stage5_Room_Info[16] ={}
Stage5_Room_Info[16].Room = "EventArea5_4_1"
Stage5_Room_Info[16].Coordinate = "1,4"
Stage5_Room_Info[16].WallCount = 4
Stage5_Room_Info[16].Wall_1 = "MovableModel5_34"
Stage5_Room_Info[16].Wall_2 = "MovableModel5_39"
Stage5_Room_Info[16].Wall_3 = "MovableModel5_40"
Stage5_Room_Info[16].Wall_4 = "MovableModel5_45"
Stage5_Room_Info[16].ItemSpawnPointCount = 2
Stage5_Room_Info[16].ItemSpawnPoint_1 = "SaPoint5_4_1_1"
Stage5_Room_Info[16].ItemSpawnPoint_2 = "SaPoint5_4_1_2"
	   
Stage5_Room_Info[17] ={}
Stage5_Room_Info[17].Room = "EventArea5_4_2"
Stage5_Room_Info[17].Coordinate = "2,4"
Stage5_Room_Info[17].WallCount = 4
Stage5_Room_Info[17].Wall_1 = "MovableModel5_35"
Stage5_Room_Info[17].Wall_2 = "MovableModel5_40"
Stage5_Room_Info[17].Wall_3 = "MovableModel5_41"
Stage5_Room_Info[17].Wall_4 = "MovableModel5_46"
Stage5_Room_Info[17].ItemSpawnPointCount = 2
Stage5_Room_Info[17].ItemSpawnPoint_1 = "SaPoint5_4_2_1"
Stage5_Room_Info[17].ItemSpawnPoint_2 = "SaPoint5_4_2_2"
	   
Stage5_Room_Info[18] ={}
Stage5_Room_Info[18].Room = "EventArea5_4_3"
Stage5_Room_Info[18].Coordinate = "3,4"
Stage5_Room_Info[18].WallCount = 4
Stage5_Room_Info[18].Wall_1 = "MovableModel5_36"
Stage5_Room_Info[18].Wall_2 = "MovableModel5_41"
Stage5_Room_Info[18].Wall_3 = "MovableModel5_42"
Stage5_Room_Info[18].Wall_4 = "MovableModel5_47"
Stage5_Room_Info[18].ItemSpawnPointCount = 2
Stage5_Room_Info[18].ItemSpawnPoint_1 = "SaPoint5_4_3_1"
Stage5_Room_Info[18].ItemSpawnPoint_2 = "SaPoint5_4_3_2"
	   
Stage5_Room_Info[19] ={}
Stage5_Room_Info[19].Room = "EventArea5_4_4"
Stage5_Room_Info[19].Coordinate = "4,4"
Stage5_Room_Info[19].WallCount = 4
Stage5_Room_Info[19].Wall_1 = "MovableModel5_37"
Stage5_Room_Info[19].Wall_2 = "MovableModel5_42"
Stage5_Room_Info[19].Wall_3 = "MovableModel5_43"
Stage5_Room_Info[19].Wall_4 = "MovableModel5_48"
Stage5_Room_Info[19].ItemSpawnPointCount = 2
Stage5_Room_Info[19].ItemSpawnPoint_1 = "SaPoint5_4_4_1"
Stage5_Room_Info[19].ItemSpawnPoint_2 = "SaPoint5_4_4_2"
	   
Stage5_Room_Info[20] ={}
Stage5_Room_Info[20].Room = "EventArea5_4_5"
Stage5_Room_Info[20].Coordinate = "5,4"
Stage5_Room_Info[20].WallCount = 4
Stage5_Room_Info[20].Wall_1 = "MovableModel5_38"
Stage5_Room_Info[20].Wall_2 = "MovableModel5_43"
Stage5_Room_Info[20].Wall_3 = "MovableModel5_44"
Stage5_Room_Info[20].Wall_4 = "MovableModel5_49"
Stage5_Room_Info[20].ItemSpawnPointCount = 2
Stage5_Room_Info[20].ItemSpawnPoint_1 = "SaPoint5_4_5_1"
Stage5_Room_Info[20].ItemSpawnPoint_2 = "SaPoint5_4_5_2"
	   
Stage5_Room_Info[21] ={}
Stage5_Room_Info[21].Room = "EventArea5_5_1"
Stage5_Room_Info[21].Coordinate = "1,5"
Stage5_Room_Info[21].WallCount = 4
Stage5_Room_Info[21].Wall_1 = "MovableModel5_45"
Stage5_Room_Info[21].Wall_2 = "MovableModel5_50"
Stage5_Room_Info[21].Wall_3 = "MovableModel5_51"
Stage5_Room_Info[21].Wall_4 = "MovableModel5_56"
Stage5_Room_Info[21].ItemSpawnPointCount = 2
Stage5_Room_Info[21].ItemSpawnPoint_1 = "SaPoint5_5_1_1"
Stage5_Room_Info[21].ItemSpawnPoint_2 = "SaPoint5_5_1_2"
	   
Stage5_Room_Info[22] ={}
Stage5_Room_Info[22].Room = "EventArea5_5_2"
Stage5_Room_Info[22].Coordinate = "2,5"
Stage5_Room_Info[22].WallCount = 4
Stage5_Room_Info[22].Wall_1 = "MovableModel5_46"
Stage5_Room_Info[22].Wall_2 = "MovableModel5_51"
Stage5_Room_Info[22].Wall_3 = "MovableModel5_52"
Stage5_Room_Info[22].Wall_4 = "MovableModel5_57"
Stage5_Room_Info[22].ItemSpawnPointCount = 2
Stage5_Room_Info[22].ItemSpawnPoint_1 = "SaPoint5_5_2_1"
Stage5_Room_Info[22].ItemSpawnPoint_2 = "SaPoint5_5_2_2"
	   
Stage5_Room_Info[23] ={}
Stage5_Room_Info[23].Room = "EventArea5_5_3"
Stage5_Room_Info[23].Coordinate = "3,5"
Stage5_Room_Info[23].WallCount = 4
Stage5_Room_Info[23].Wall_1 = "MovableModel5_47"
Stage5_Room_Info[23].Wall_2 = "MovableModel5_52"
Stage5_Room_Info[23].Wall_3 = "MovableModel5_53"
Stage5_Room_Info[23].Wall_4 = "MovableModel5_58"
Stage5_Room_Info[23].ItemSpawnPointCount = 2
Stage5_Room_Info[23].ItemSpawnPoint_1 = "SaPoint5_5_3_1"
Stage5_Room_Info[23].ItemSpawnPoint_2 = "SaPoint5_5_3_2"
	   
Stage5_Room_Info[24] ={}
Stage5_Room_Info[24].Room = "EventArea5_5_4"
Stage5_Room_Info[24].Coordinate = "4,5"
Stage5_Room_Info[24].WallCount = 4
Stage5_Room_Info[24].Wall_1 = "MovableModel5_48"
Stage5_Room_Info[24].Wall_2 = "MovableModel5_53"
Stage5_Room_Info[24].Wall_3 = "MovableModel5_54"
Stage5_Room_Info[24].Wall_4 = "MovableModel5_59"
Stage5_Room_Info[24].ItemSpawnPointCount = 2
Stage5_Room_Info[24].ItemSpawnPoint_1 = "SaPoint5_5_4_1"
Stage5_Room_Info[24].ItemSpawnPoint_2 = "SaPoint5_5_4_2"
	   
Stage5_Room_Info[25] ={}
Stage5_Room_Info[25].Room = "EventArea5_5_5"
Stage5_Room_Info[25].Coordinate = "5,5"
Stage5_Room_Info[25].WallCount = 4
Stage5_Room_Info[25].Wall_1 = "MovableModel5_49"
Stage5_Room_Info[25].Wall_2 = "MovableModel5_54"
Stage5_Room_Info[25].Wall_3 = "MovableModel5_55"
Stage5_Room_Info[25].Wall_4 = "MovableModel5_60"
Stage5_Room_Info[25].ItemSpawnPointCount = 2
Stage5_Room_Info[25].ItemSpawnPoint_1 = "SaPoint5_5_5_1"
Stage5_Room_Info[25].ItemSpawnPoint_2 = "SaPoint5_5_5_2"
	   
 
Stage6_Room_Info = {}

Stage6_Room_Info[1] ={}
Stage6_Room_Info[1].Room = "EventArea6_1_1"
Stage6_Room_Info[1].Coordinate = "1,1"
Stage6_Room_Info[1].WallCount = 2
Stage6_Room_Info[1].Wall_1 = "MovableModel6_7"
Stage6_Room_Info[1].Wall_2 = "MovableModel6_12"

	   
Stage6_Room_Info[2] ={}
Stage6_Room_Info[2].Room = "EventArea6_1_2"
Stage6_Room_Info[2].Coordinate = "2,1"
Stage6_Room_Info[2].WallCount = 3
Stage6_Room_Info[2].Wall_1 = "MovableModel6_7"
Stage6_Room_Info[2].Wall_2 = "MovableModel6_8"
Stage6_Room_Info[2].Wall_3 = "MovableModel6_13"

	   
Stage6_Room_Info[3] ={}
Stage6_Room_Info[3].Room = "EventArea6_1_3"
Stage6_Room_Info[3].Coordinate = "3,1"
Stage6_Room_Info[3].WallCount = 2
Stage6_Room_Info[3].Wall_1 = "MovableModel6_8"
Stage6_Room_Info[3].Wall_2 = "MovableModel6_14"

	   
Stage6_Room_Info[4] ={}
Stage6_Room_Info[4].Room = "EventArea6_2_1"
Stage6_Room_Info[4].Coordinate = "1,2"
Stage6_Room_Info[4].WallCount = 3
Stage6_Room_Info[4].Wall_1 = "MovableModel6_12"
Stage6_Room_Info[4].Wall_2 = "MovableModel6_18"
Stage6_Room_Info[4].Wall_3 = "MovableModel6_23"

	   
Stage6_Room_Info[5] ={}
Stage6_Room_Info[5].Room = "EventArea6_2_2"
Stage6_Room_Info[5].Coordinate = "2,2"
Stage6_Room_Info[5].WallCount = 4
Stage6_Room_Info[5].Wall_1 = "MovableModel6_13"
Stage6_Room_Info[5].Wall_2 = "MovableModel6_18"
Stage6_Room_Info[5].Wall_3 = "MovableModel6_19"
Stage6_Room_Info[5].Wall_4 = "MovableModel6_24"

	   
Stage6_Room_Info[6] ={}
Stage6_Room_Info[6].Room = "EventArea6_2_3"
Stage6_Room_Info[6].Coordinate = "3,2"
Stage6_Room_Info[6].WallCount = 3
Stage6_Room_Info[6].Wall_1 = "MovableModel6_14"
Stage6_Room_Info[6].Wall_2 = "MovableModel6_19"
Stage6_Room_Info[6].Wall_3 = "MovableModel6_25"

	   
Stage6_Room_Info[7] ={}
Stage6_Room_Info[7].Room = "EventArea6_3_1"
Stage6_Room_Info[7].Coordinate = "1,3"
Stage6_Room_Info[7].WallCount = 3
Stage6_Room_Info[7].Wall_1 = "MovableModel6_23"
Stage6_Room_Info[7].Wall_2 = "MovableModel6_29"
Stage6_Room_Info[7].Wall_3 = "MovableModel6_34"

	   
Stage6_Room_Info[8] ={}
Stage6_Room_Info[8].Room = "EventArea6_3_2"
Stage6_Room_Info[8].Coordinate = "2,3"
Stage6_Room_Info[8].WallCount = 4
Stage6_Room_Info[8].Wall_1 = "MovableModel6_24"
Stage6_Room_Info[8].Wall_2 = "MovableModel6_29"
Stage6_Room_Info[8].Wall_3 = "MovableModel6_30"
Stage6_Room_Info[8].Wall_4 = "MovableModel6_35"

	   
Stage6_Room_Info[9] ={}
Stage6_Room_Info[9].Room = "EventArea6_3_3"
Stage6_Room_Info[9].Coordinate = "3,3"
Stage6_Room_Info[9].WallCount = 3
Stage6_Room_Info[9].Wall_1 = "MovableModel6_25"
Stage6_Room_Info[9].Wall_2 = "MovableModel6_30"
Stage6_Room_Info[9].Wall_3 = "MovableModel6_36"

	   
Stage6_Room_Info[10] ={}
Stage6_Room_Info[10].Room = "EventArea6_4_1"
Stage6_Room_Info[10].Coordinate = "1,4"
Stage6_Room_Info[10].WallCount = 3
Stage6_Room_Info[10].Wall_1 = "MovableModel6_34"
Stage6_Room_Info[10].Wall_2 = "MovableModel6_40"
Stage6_Room_Info[10].Wall_3 = "MovableModel6_45"

	   
Stage6_Room_Info[11] ={}
Stage6_Room_Info[11].Room = "EventArea6_4_2"
Stage6_Room_Info[11].Coordinate = "2,4"
Stage6_Room_Info[11].WallCount = 4
Stage6_Room_Info[11].Wall_1 = "MovableModel6_35"
Stage6_Room_Info[11].Wall_2 = "MovableModel6_40"
Stage6_Room_Info[11].Wall_3 = "MovableModel6_41"
Stage6_Room_Info[11].Wall_4 = "MovableModel6_46"

	   
Stage6_Room_Info[12] ={}
Stage6_Room_Info[12].Room = "EventArea6_4_3"
Stage6_Room_Info[12].Coordinate = "3,4"
Stage6_Room_Info[12].WallCount = 3
Stage6_Room_Info[12].Wall_1 = "MovableModel6_36"
Stage6_Room_Info[12].Wall_2 = "MovableModel6_41"
Stage6_Room_Info[12].Wall_3 = "MovableModel6_47"

	   
Stage6_Room_Info[13] ={}
Stage6_Room_Info[13].Room = "EventArea6_5_1"
Stage6_Room_Info[13].Coordinate = "1,5"
Stage6_Room_Info[13].WallCount = 2
Stage6_Room_Info[13].Wall_1 = "MovableModel6_45"
Stage6_Room_Info[13].Wall_2 = "MovableModel6_51"

	   
Stage6_Room_Info[14] ={}
Stage6_Room_Info[14].Room = "EventArea6_5_2"
Stage6_Room_Info[14].Coordinate = "2,5"
Stage6_Room_Info[14].WallCount = 3
Stage6_Room_Info[14].Wall_1 = "MovableModel6_46"
Stage6_Room_Info[14].Wall_2 = "MovableModel6_51"
Stage6_Room_Info[14].Wall_3 = "MovableModel6_52"

	   
Stage6_Room_Info[15] ={}
Stage6_Room_Info[15].Room = "EventArea6_5_3"
Stage6_Room_Info[15].Coordinate = "3,5"
Stage6_Room_Info[15].WallCount = 2
Stage6_Room_Info[15].Wall_1 = "MovableModel6_47"
Stage6_Room_Info[15].Wall_2 = "MovableModel6_52"

	   
Stage20_Room_Info = {}

Stage20_Room_Info[1] ={}
Stage20_Room_Info[1].Room = "EventArea20_1_1"
Stage20_Room_Info[1].Coordinate = "1,1"
Stage20_Room_Info[1].WallCount = 0
Stage20_Room_Info[1].ItemSpawnPointCount = 0
	 


----------------------------------------------------------------------------------------------------
-- 스테이지 이름을 반환한다. 스테이지 관련 정보를 클라이언트에서 저장하기 위해서 호출되는 함수.
----------------------------------------------------------------------------------------------------
function GetStageName(nIndex)

	strStageName = ""

	if	nIndex == 0 then strStageName = "Stage1"
	
	elseif nIndex == 1	then strStageName = "Stage2"
	
	elseif nIndex == 2	then strStageName = "Stage3"
	
	elseif nIndex == 3	then strStageName = "Stage4"
	
	elseif nIndex == 4	then strStageName = "Stage5"
	
	elseif nIndex == 5	then strStageName = "Stage6"
	
	elseif nIndex == 6	then strStageName = "Stage20"
		
	end

	return strStageName
end

----------------------------------------------------------------------------------------------------
-- 스테이지 타입을 정의한다. 클라이언트와 같아야한다.
----------------------------------------------------------------------------------------------------
STAGE_TYPE_NOTHING = 0
STAGE_TYPE_BATTLE = 1
STAGE_TYPE_FARMING = 2
STAGE_TYPE_PUZZLE = 4

----------------------------------------------------------------------------------------------------
-- 스테이지 타입으로 이름을 반환한다. 클라이언트에서 층 이동을 할때 마다 어떤 스테이지가 나와야하는지 알기 위해 호출.
-- 위에 호출되는 함수 function GetStageName(nIndex) 와 이름 맞춰야 한다.
----------------------------------------------------------------------------------------------------
function GetStageNameByType(nStageType)

	strStageName = ""

	if nStageType == STAGE_TYPE_BATTLE then

		nRand = math.random( 1, 5 )
		
		if nRand == 1 then strStageName = "Stage1"

		elseif nRand == 2 then strStageName = "Stage2"

		elseif nRand == 3 then strStageName = "Stage3"

		elseif nRand == 4 then strStageName = "Stage4"

		elseif nRand == 5 then strStageName = "Stage5"

		end
	
	
	elseif nStageType == STAGE_TYPE_PUZZLE	then strStageName = "Stage6"
			
	elseif nStageType == STAGE_TYPE_FARMING	then strStageName = "Stage20"
		
	end

	return strStageName
end

----------------------------------------------------------------------------------------------------
-- 스테이지 사이즈를 반환한다. 플레이 영역만
----------------------------------------------------------------------------------------------------
function GetStageSize(strStageName)

	nSizeX = 0
	nSizeY = 0

	if strStageName == "Stage1" then

		nSizeX = 5
		nSizeY = 5
		
	elseif strStageName == "Stage2" then
		
		nSizeX = 5
		nSizeY = 5

	elseif strStageName == "Stage3" then
		
		nSizeX = 5
		nSizeY = 5		

	elseif strStageName == "Stage4" then
		
		nSizeX = 5
		nSizeY = 5		
		
	elseif strStageName == "Stage5" then
		
		nSizeX = 5
		nSizeY = 5		

	elseif strStageName == "Stage6" then
		
		nSizeX = 5
		nSizeY = 5				

	elseif strStageName == "Stage20" then
		
		nSizeX = 1
		nSizeY = 1		
		
	end

	return nSizeX, nSizeY
end

----------------------------------------------------------------------------------------------------
-- 스테이지의 스폰 포인트 리스트 이름을 반환한다.
----------------------------------------------------------------------------------------------------
function GetSpawnPointListName(strStageName)

	strSpawnPointListName = ""

	if	strStageName == "Stage1" then strSpawnPointListName = "Stage1_SpawnPoint_Info"

	elseif strStageName == "Stage2" then strSpawnPointListName = "Stage2_SpawnPoint_Info"
	
	elseif strStageName == "Stage3" then strSpawnPointListName = "Stage3_SpawnPoint_Info"
	
	elseif strStageName == "Stage4" then strSpawnPointListName = "Stage4_SpawnPoint_Info"
	
	elseif strStageName == "Stage5" then strSpawnPointListName = "Stage5_SpawnPoint_Info"
	
	elseif strStageName == "Stage6" then strSpawnPointListName = "Stage6_SpawnPoint_Info"
	
	elseif strStageName == "Stage20" then strSpawnPointListName = "Stage20_SpawnPoint_Info"
	
	end

	return strSpawnPointListName
end

----------------------------------------------------------------------------------------------------
-- 스테이지의 스폰 포인트 리스트의 갯수를 반환한다. 배열변수 앞에 #을 붙이면 갯수가 반환된다.
----------------------------------------------------------------------------------------------------
function GetSpawnPointListCount(strStageName)

	nCount = 0

	if	strStageName == "Stage1" then nCount = #Stage1_SpawnPoint_Info
	
	elseif strStageName == "Stage2" then nCount = #Stage2_SpawnPoint_Info

	elseif strStageName == "Stage3" then nCount = #Stage3_SpawnPoint_Info
	
	elseif strStageName == "Stage4" then nCount = #Stage4_SpawnPoint_Info
	
	elseif strStageName == "Stage5" then nCount = #Stage5_SpawnPoint_Info
	
	elseif strStageName == "Stage6" then nCount = #Stage6_SpawnPoint_Info
	
	elseif strStageName == "Stage20" then nCount = #Stage20_SpawnPoint_Info
	
	end

	return nCount
end

----------------------------------------------------------------------------------------------------
-- 스테이지의 방 리스트 이름을 반환한다.
----------------------------------------------------------------------------------------------------
function GetRoomListName(strStageName)

	strRoomListName = ""

	if	strStageName == "Stage1" then strRoomListName = "Stage1_Room_Info"
	
	elseif strStageName == "Stage2" then strRoomListName = "Stage2_Room_Info"
	
	elseif strStageName == "Stage3" then strRoomListName = "Stage3_Room_Info"
	
	elseif strStageName == "Stage4" then strRoomListName = "Stage4_Room_Info"
	
	elseif strStageName == "Stage5" then strRoomListName = "Stage5_Room_Info"
	
	elseif strStageName == "Stage6" then strRoomListName = "Stage6_Room_Info"
	
	elseif strStageName == "Stage20" then strRoomListName = "Stage20_Room_Info"

	end

	return strRoomListName
end

----------------------------------------------------------------------------------------------------
-- 스테이지의 방 리스트의 갯수를 반환한다. 배열변수 앞에 #을 붙이면 갯수가 반환된다.
----------------------------------------------------------------------------------------------------
function GetRoomListCount(strStageName)

	nCount = 0

	if	strStageName == "Stage1" then nCount = #Stage1_Room_Info
	
	elseif strStageName == "Stage2" then nCount = #Stage2_Room_Info
	
	elseif strStageName == "Stage3" then nCount = #Stage3_Room_Info
	
	elseif strStageName == "Stage4" then nCount = #Stage4_Room_Info
	
	elseif strStageName == "Stage5" then nCount = #Stage5_Room_Info
	
	elseif strStageName == "Stage6" then nCount = #Stage6_Room_Info
	
	elseif strStageName == "Stage20" then nCount = #Stage20_Room_Info
	
	end

	return nCount
end

----------------------------------------------------------------------------------------------------
-- 방 모양 정보가 들어있는 배열.
----------------------------------------------------------------------------------------------------
Room_Shape_Info = {}

----------------------------------------------------------------------------------------------------
-- 방 하나 배열 (기본)
-- .Score 는 임시로 들어가 있음. 나중에 빼야 함
-- 게임 타입에서 적용될 방에 대한 설정필요. 아래 참고
-- StageType = STAGE_TYPE_BATTLE + STAGE_TYPE_FARMING + STAGE_TYPE_PUZZLE
----------------------------------------------------------------------------------------------------
  

 


--------------------------------------------------
-- 방 하나짜리 배열.
--------------------------------------------------

Room_Shape_Info[1] = {}
Room_Shape_Info[1].Name = "Shape1"
Room_Shape_Info[1].StageType = STAGE_TYPE_FARMING	   
Room_Shape_Info[1].Probability = 100
Room_Shape_Info[1].StartRoom = "1,1"	   
Room_Shape_Info[1].RoomCount = 1	   
Room_Shape_Info[1].Composition = {"1,1",}	   
Room_Shape_Info[1].RoomWeight = {1, }	   
	   
Room_Shape_Info[2] = {}
Room_Shape_Info[2].Name = "Shape2"
Room_Shape_Info[2].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[2].Probability = 200
Room_Shape_Info[2].StartRoom = "1,1"	   
Room_Shape_Info[2].RoomCount = 4	   
Room_Shape_Info[2].Composition = {"1,1","1,2","1,3","1,4",}	   
Room_Shape_Info[2].RoomWeight = {1, 40, 30, 60, }	   
	   
Room_Shape_Info[3] = {}
Room_Shape_Info[3].Name = "TypeA"
Room_Shape_Info[3].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[3].Probability = 200
Room_Shape_Info[3].StartRoom = "1,1"	   
Room_Shape_Info[3].RoomCount = 5	   
Room_Shape_Info[3].Composition = {"1,1","1,2","1,3","1,4","1,5",}	   
Room_Shape_Info[3].RoomWeight = {1, 40, 50, 30, 100, }	   
	   


--------------------------------------------------
-- ㅡ 자 배열
--------------------------------------------------

Room_Shape_Info[4] = {}
Room_Shape_Info[4].Name = "Shape4"
Room_Shape_Info[4].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[4].Probability = 100
Room_Shape_Info[4].StartRoom = "1,1"	   
Room_Shape_Info[4].RoomCount = 4	   
Room_Shape_Info[4].Composition = {"1,1","2,1","3,1","4,1",}	   
Room_Shape_Info[4].RoomWeight = {1, 40, 30, 60, }	   
	   
Room_Shape_Info[5] = {}
Room_Shape_Info[5].Name = "Shape5"
Room_Shape_Info[5].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[5].Probability = 100
Room_Shape_Info[5].StartRoom = "1,1"	   
Room_Shape_Info[5].RoomCount = 5	   
Room_Shape_Info[5].Composition = {"1,1","2,1","3,1","4,1","5,1",}	   
Room_Shape_Info[5].RoomWeight = {1, 40, 50, 30, 100, }	   
	   
Room_Shape_Info[6] = {}
Room_Shape_Info[6].Name = "Shape6"
Room_Shape_Info[6].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[6].Probability = 100
Room_Shape_Info[6].StartRoom = "4,1"	   
Room_Shape_Info[6].RoomCount = 4	   
Room_Shape_Info[6].Composition = {"1,1","2,1","3,1","4,1",}	   
Room_Shape_Info[6].RoomWeight = {60, 30, 40, 1, }	   
	   
Room_Shape_Info[7] = {}
Room_Shape_Info[7].Name = "Shape7"
Room_Shape_Info[7].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[7].Probability = 100
Room_Shape_Info[7].StartRoom = "5,1"	   
Room_Shape_Info[7].RoomCount = 5	   
Room_Shape_Info[7].Composition = {"1,1","2,1","3,1","4,1","5,1",}	   
Room_Shape_Info[7].RoomWeight = {100, 30, 50, 40, 1, }	   
	   
Room_Shape_Info[8] = {}
Room_Shape_Info[8].Name = "Shape8"
Room_Shape_Info[8].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[8].Probability = 100
Room_Shape_Info[8].StartRoom = "2,1"	   
Room_Shape_Info[8].RoomCount = 4	   
Room_Shape_Info[8].Composition = {"1,1","2,1","3,1","4,1",}	   
Room_Shape_Info[8].RoomWeight = {50, 1, 10, 50, }	   
	   
Room_Shape_Info[9] = {}
Room_Shape_Info[9].Name = "Shape9"
Room_Shape_Info[9].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[9].Probability = 100
Room_Shape_Info[9].StartRoom = "3,1"	   
Room_Shape_Info[9].RoomCount = 4	   
Room_Shape_Info[9].Composition = {"1,1","2,1","3,1","4,1",}	   
Room_Shape_Info[9].RoomWeight = {50, 10, 1, 50, }	   
	   
Room_Shape_Info[10] = {}
Room_Shape_Info[10].Name = "Shape10"
Room_Shape_Info[10].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[10].Probability = 100
Room_Shape_Info[10].StartRoom = "3,1"	   
Room_Shape_Info[10].RoomCount = 5	   
Room_Shape_Info[10].Composition = {"1,1","2,1","3,1","4,1","5,1",}	   
Room_Shape_Info[10].RoomWeight = {50, 30, 1, 30, 50, }	   
	   
Room_Shape_Info[11] = {}
Room_Shape_Info[11].Name = "Shape11"
Room_Shape_Info[11].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[11].Probability = 100
Room_Shape_Info[11].StartRoom = "2,1"	   
Room_Shape_Info[11].RoomCount = 5	   
Room_Shape_Info[11].Composition = {"1,1","2,1","3,1","4,1","5,1",}	   
Room_Shape_Info[11].RoomWeight = {50, 1, 10, 30, 50, }	   
	   
Room_Shape_Info[12] = {}
Room_Shape_Info[12].Name = "Shape12"
Room_Shape_Info[12].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[12].Probability = 100
Room_Shape_Info[12].StartRoom = "4,1"	   
Room_Shape_Info[12].RoomCount = 5	   
Room_Shape_Info[12].Composition = {"1,1","2,1","3,1","4,1","5,1",}	   
Room_Shape_Info[12].RoomWeight = {50, 30, 10, 1, 50, }	   
	   


--------------------------------------------------
-- ㄱ 자 형
--------------------------------------------------

Room_Shape_Info[13] = {}
Room_Shape_Info[13].Name = "Shape13"
Room_Shape_Info[13].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[13].Probability = 100
Room_Shape_Info[13].StartRoom = "3,1"	   
Room_Shape_Info[13].RoomCount = 4	   
Room_Shape_Info[13].Composition = {"3,1","1,2","2,2","3,2",}	   
Room_Shape_Info[13].RoomWeight = {1, 50, 40, 20, }	   
	   
Room_Shape_Info[14] = {}
Room_Shape_Info[14].Name = "Shape14"
Room_Shape_Info[14].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[14].Probability = 100
Room_Shape_Info[14].StartRoom = "4,1"	   
Room_Shape_Info[14].RoomCount = 5	   
Room_Shape_Info[14].Composition = {"4,1","1,2","2,2","3,2","4,2",}	   
Room_Shape_Info[14].RoomWeight = {1, 50, 40, 40, 20, }	   
	   
Room_Shape_Info[15] = {}
Room_Shape_Info[15].Name = "Shape15"
Room_Shape_Info[15].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[15].Probability = 100
Room_Shape_Info[15].StartRoom = "2,1"	   
Room_Shape_Info[15].RoomCount = 4	   
Room_Shape_Info[15].Composition = {"2,1","2,2","1,3","2,3",}	   
Room_Shape_Info[15].RoomWeight = {1, 20, 50, 20, }	   
	   
Room_Shape_Info[16] = {}
Room_Shape_Info[16].Name = "Shape16"
Room_Shape_Info[16].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[16].Probability = 100
Room_Shape_Info[16].StartRoom = "3,1"	   
Room_Shape_Info[16].RoomCount = 5	   
Room_Shape_Info[16].Composition = {"3,1","3,2","1,3","2,3","3,3",}	   
Room_Shape_Info[16].RoomWeight = {1, 20, 50, 40, 20, }	   
	   
Room_Shape_Info[17] = {}
Room_Shape_Info[17].Name = "Shape17"
Room_Shape_Info[17].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[17].Probability = 100
Room_Shape_Info[17].StartRoom = "4,1"	   
Room_Shape_Info[17].RoomCount = 6	   
Room_Shape_Info[17].Composition = {"4,1","4,2","1,3","2,3","3,3","4,3",}	   
Room_Shape_Info[17].RoomWeight = {1, 20, 50, 30, 40, 30, }	   
	   
Room_Shape_Info[18] = {}
Room_Shape_Info[18].Name = "Shape18"
Room_Shape_Info[18].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[18].Probability = 100
Room_Shape_Info[18].StartRoom = "2,1"	   
Room_Shape_Info[18].RoomCount = 5	   
Room_Shape_Info[18].Composition = {"2,1","2,2","2,3","1,4","2,4",}	   
Room_Shape_Info[18].RoomWeight = {1, 20, 20, 50, 30, }	   
	   
Room_Shape_Info[19] = {}
Room_Shape_Info[19].Name = "Shape19"
Room_Shape_Info[19].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[19].Probability = 100
Room_Shape_Info[19].StartRoom = "3,1"	   
Room_Shape_Info[19].RoomCount = 6	   
Room_Shape_Info[19].Composition = {"3,1","3,2","3,3","1,4","2,4","3,4",}	   
Room_Shape_Info[19].RoomWeight = {1, 20, 20, 50, 40, 40, }	   
	   
Room_Shape_Info[20] = {}
Room_Shape_Info[20].Name = "Shape20"
Room_Shape_Info[20].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[20].Probability = 100
Room_Shape_Info[20].StartRoom = "2,1"	   
Room_Shape_Info[20].RoomCount = 6	   
Room_Shape_Info[20].Composition = {"2,1","2,2","2,3","2,4","1,5","2,5",}	   
Room_Shape_Info[20].RoomWeight = {1, 20, 30, 30, 60, 30, }	   
	   


--------------------------------------------------
-- Γ 자 형
--------------------------------------------------

Room_Shape_Info[21] = {}
Room_Shape_Info[21].Name = "Shape21"
Room_Shape_Info[21].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[21].Probability = 100
Room_Shape_Info[21].StartRoom = "1,1"	   
Room_Shape_Info[21].RoomCount = 4	   
Room_Shape_Info[21].Composition = {"1,1","1,2","2,2","3,2",}	   
Room_Shape_Info[21].RoomWeight = {1, 20, 40, 50, }	   
	   
Room_Shape_Info[22] = {}
Room_Shape_Info[22].Name = "Shape22"
Room_Shape_Info[22].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[22].Probability = 100
Room_Shape_Info[22].StartRoom = "1,1"	   
Room_Shape_Info[22].RoomCount = 5	   
Room_Shape_Info[22].Composition = {"1,1","1,2","2,2","3,2","4,2",}	   
Room_Shape_Info[22].RoomWeight = {1, 20, 40, 40, 50, }	   
	   
Room_Shape_Info[23] = {}
Room_Shape_Info[23].Name = "Shape23"
Room_Shape_Info[23].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[23].Probability = 100
Room_Shape_Info[23].StartRoom = "1,1"	   
Room_Shape_Info[23].RoomCount = 4	   
Room_Shape_Info[23].Composition = {"1,1","1,2","1,3","2,3",}	   
Room_Shape_Info[23].RoomWeight = {1, 20, 20, 50, }	   
	   
Room_Shape_Info[24] = {}
Room_Shape_Info[24].Name = "Shape24"
Room_Shape_Info[24].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[24].Probability = 100
Room_Shape_Info[24].StartRoom = "1,1"	   
Room_Shape_Info[24].RoomCount = 5	   
Room_Shape_Info[24].Composition = {"1,1","1,2","1,3","2,3","3,3",}	   
Room_Shape_Info[24].RoomWeight = {1, 20, 20, 40, 50, }	   
	   
Room_Shape_Info[25] = {}
Room_Shape_Info[25].Name = "Shape25"
Room_Shape_Info[25].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[25].Probability = 100
Room_Shape_Info[25].StartRoom = "1,1"	   
Room_Shape_Info[25].RoomCount = 6	   
Room_Shape_Info[25].Composition = {"1,1","1,2","1,3","2,3","3,3","4,3",}	   
Room_Shape_Info[25].RoomWeight = {1, 20, 30, 40, 30, 50, }	   
	   
Room_Shape_Info[26] = {}
Room_Shape_Info[26].Name = "Shape26"
Room_Shape_Info[26].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[26].Probability = 100
Room_Shape_Info[26].StartRoom = "1,1"	   
Room_Shape_Info[26].RoomCount = 5	   
Room_Shape_Info[26].Composition = {"1,1","1,2","1,3","1,4","2,4",}	   
Room_Shape_Info[26].RoomWeight = {1, 20, 20, 30, 50, }	   
	   
Room_Shape_Info[27] = {}
Room_Shape_Info[27].Name = "Shape27"
Room_Shape_Info[27].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[27].Probability = 100
Room_Shape_Info[27].StartRoom = "1,1"	   
Room_Shape_Info[27].RoomCount = 6	   
Room_Shape_Info[27].Composition = {"1,1","1,2","1,3","1,4","2,4","3,4",}	   
Room_Shape_Info[27].RoomWeight = {1, 20, 20, 40, 40, 50, }	   
	   
Room_Shape_Info[28] = {}
Room_Shape_Info[28].Name = "Shape28"
Room_Shape_Info[28].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[28].Probability = 100
Room_Shape_Info[28].StartRoom = "1,1"	   
Room_Shape_Info[28].RoomCount = 6	   
Room_Shape_Info[28].Composition = {"1,1","1,2","1,3","1,4","1,5","2,5",}	   
Room_Shape_Info[28].RoomWeight = {1, 20, 30, 30, 30, 60, }	   
	   


--------------------------------------------------
-- T 자 형
--------------------------------------------------

Room_Shape_Info[29] = {}
Room_Shape_Info[29].Name = "Shape29"
Room_Shape_Info[29].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[29].Probability = 100
Room_Shape_Info[29].StartRoom = "2,1"	   
Room_Shape_Info[29].RoomCount = 4	   
Room_Shape_Info[29].Composition = {"2,1","1,2","2,2","3,2",}	   
Room_Shape_Info[29].RoomWeight = {1, 50, 20, 50, }	   
	   
Room_Shape_Info[30] = {}
Room_Shape_Info[30].Name = "Shape30"
Room_Shape_Info[30].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[30].Probability = 100
Room_Shape_Info[30].StartRoom = "3,1"	   
Room_Shape_Info[30].RoomCount = 6	   
Room_Shape_Info[30].Composition = {"3,1","1,2","2,2","3,2","4,2","5,2",}	   
Room_Shape_Info[30].RoomWeight = {1, 50, 30, 10, 30, 50, }	   
	   
Room_Shape_Info[31] = {}
Room_Shape_Info[31].Name = "Shape31"
Room_Shape_Info[31].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[31].Probability = 100
Room_Shape_Info[31].StartRoom = "2,1"	   
Room_Shape_Info[31].RoomCount = 5	   
Room_Shape_Info[31].Composition = {"2,1","2,2","1,3","2,3","3,3",}	   
Room_Shape_Info[31].RoomWeight = {1, 10, 50, 20, 50, }	   
	   
Room_Shape_Info[32] = {}
Room_Shape_Info[32].Name = "Shape32"
Room_Shape_Info[32].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[32].Probability = 100
Room_Shape_Info[32].StartRoom = "3,1"	   
Room_Shape_Info[32].RoomCount = 7	   
Room_Shape_Info[32].Composition = {"3,1","3,2","1,3","2,3","3,3","4,3","5,3",}	   
Room_Shape_Info[32].RoomWeight = {1, 10, 50, 30, 20, 30, 50, }	   
	   
Room_Shape_Info[33] = {}
Room_Shape_Info[33].Name = "Shape33"
Room_Shape_Info[33].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[33].Probability = 100
Room_Shape_Info[33].StartRoom = "2,1"	   
Room_Shape_Info[33].RoomCount = 6	   
Room_Shape_Info[33].Composition = {"2,1","2,2","2,3","1,4","2,4","3,4",}	   
Room_Shape_Info[33].RoomWeight = {1, 10, 20, 50, 20, 50, }	   
	   
Room_Shape_Info[34] = {}
Room_Shape_Info[34].Name = "Shape34"
Room_Shape_Info[34].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[34].Probability = 100
Room_Shape_Info[34].StartRoom = "2,1"	   
Room_Shape_Info[34].RoomCount = 7	   
Room_Shape_Info[34].Composition = {"2,1","2,2","2,3","1,4","2,4","3,4","4,4",}	   
Room_Shape_Info[34].RoomWeight = {1, 10, 20, 50, 20, 20, 50, }	   
	   
Room_Shape_Info[35] = {}
Room_Shape_Info[35].Name = "Shape35"
Room_Shape_Info[35].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[35].Probability = 100
Room_Shape_Info[35].StartRoom = "3,1"	   
Room_Shape_Info[35].RoomCount = 7	   
Room_Shape_Info[35].Composition = {"3,1","3,2","3,3","1,4","2,4","3,4","4,4",}	   
Room_Shape_Info[35].RoomWeight = {1, 10, 20, 50, 20, 20, 50, }	   
	   
Room_Shape_Info[36] = {}
Room_Shape_Info[36].Name = "Shape36"
Room_Shape_Info[36].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[36].Probability = 100
Room_Shape_Info[36].StartRoom = "2,1"	   
Room_Shape_Info[36].RoomCount = 7	   
Room_Shape_Info[36].Composition = {"2,1","2,2","2,3","2,4","1,5","2,5","3,5",}	   
Room_Shape_Info[36].RoomWeight = {1, 10, 20, 30, 40, 20, 40, }	   
	   


--------------------------------------------------
-- +자형
--------------------------------------------------

Room_Shape_Info[37] = {}
Room_Shape_Info[37].Name = "Shape37"
Room_Shape_Info[37].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[37].Probability = 100
Room_Shape_Info[37].StartRoom = "2,1"	   
Room_Shape_Info[37].RoomCount = 7	   
Room_Shape_Info[37].Composition = {"2,1","1,2","2,2","3,2","2,3","2,4","2,5",}	   
Room_Shape_Info[37].RoomWeight = {1, 40, 10, 40, 20, 30, 20, }	   
	   
Room_Shape_Info[38] = {}
Room_Shape_Info[38].Name = "Shape38"
Room_Shape_Info[38].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[38].Probability = 100
Room_Shape_Info[38].StartRoom = "2,1"	   
Room_Shape_Info[38].RoomCount = 7	   
Room_Shape_Info[38].Composition = {"2,1","2,2","1,3","2,3","3,3","2,4","2,5",}	   
Room_Shape_Info[38].RoomWeight = {1, 10, 50, 20, 50, 30, 20, }	   
	   
Room_Shape_Info[39] = {}
Room_Shape_Info[39].Name = "Shape39"
Room_Shape_Info[39].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[39].Probability = 100
Room_Shape_Info[39].StartRoom = "2,1"	   
Room_Shape_Info[39].RoomCount = 7	   
Room_Shape_Info[39].Composition = {"2,1","2,2","2,3","1,4","2,4","3,4","2,5",}	   
Room_Shape_Info[39].RoomWeight = {1, 10, 20, 50, 30, 50, 20, }	   
	   
Room_Shape_Info[40] = {}
Room_Shape_Info[40].Name = "Shape40"
Room_Shape_Info[40].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[40].Probability = 100
Room_Shape_Info[40].StartRoom = "3,1"	   
Room_Shape_Info[40].RoomCount = 8	   
Room_Shape_Info[40].Composition = {"3,1","1,2","2,2","3,2","4,2","5,2","3,3","3,4",}	   
Room_Shape_Info[40].RoomWeight = {1, 40, 20, 10, 20, 40, 20, 30, }	   
	   
Room_Shape_Info[41] = {}
Room_Shape_Info[41].Name = "Shape41"
Room_Shape_Info[41].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[41].Probability = 100
Room_Shape_Info[41].StartRoom = "3,1"	   
Room_Shape_Info[41].RoomCount = 8	   
Room_Shape_Info[41].Composition = {"3,1","3,2","1,3","2,3","3,3","4,3","5,3","3,4",}	   
Room_Shape_Info[41].RoomWeight = {1, 10, 40, 20, 20, 20, 40, 30, }	   
	   
Room_Shape_Info[42] = {}
Room_Shape_Info[42].Name = "Shape42"
Room_Shape_Info[42].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[42].Probability = 100
Room_Shape_Info[42].StartRoom = "2,1"	   
Room_Shape_Info[42].RoomCount = 7	   
Room_Shape_Info[42].Composition = {"2,1","1,2","2,2","3,2","4,2","2,3","2,4",}	   
Room_Shape_Info[42].RoomWeight = {1, 40, 10, 20, 40, 20, 30, }	   
	   
Room_Shape_Info[43] = {}
Room_Shape_Info[43].Name = "Shape43"
Room_Shape_Info[43].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[43].Probability = 100
Room_Shape_Info[43].StartRoom = "2,1"	   
Room_Shape_Info[43].RoomCount = 7	   
Room_Shape_Info[43].Composition = {"2,1","2,2","1,3","2,3","3,3","4,3","2,4",}	   
Room_Shape_Info[43].RoomWeight = {1, 10, 40, 20, 20, 40, 30, }	   
	   
Room_Shape_Info[44] = {}
Room_Shape_Info[44].Name = "Shape44"
Room_Shape_Info[44].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[44].Probability = 100
Room_Shape_Info[44].StartRoom = "3,1"	   
Room_Shape_Info[44].RoomCount = 7	   
Room_Shape_Info[44].Composition = {"3,1","1,2","2,2","3,2","4,2","3,3","3,4",}	   
Room_Shape_Info[44].RoomWeight = {1, 40, 20, 10, 40, 20, 30, }	   
	   
Room_Shape_Info[45] = {}
Room_Shape_Info[45].Name = "Shape45"
Room_Shape_Info[45].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[45].Probability = 100
Room_Shape_Info[45].StartRoom = "3,1"	   
Room_Shape_Info[45].RoomCount = 7	   
Room_Shape_Info[45].Composition = {"3,1","3,2","1,3","2,3","3,3","4,3","3,4",}	   
Room_Shape_Info[45].RoomWeight = {1, 10, 40, 20, 20, 40, 30, }	   
	   


--------------------------------------------------
-- ■ 자 형
--------------------------------------------------

Room_Shape_Info[46] = {}
Room_Shape_Info[46].Name = "Shape46"
Room_Shape_Info[46].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[46].Probability = 100
Room_Shape_Info[46].StartRoom = "2,1"	   
Room_Shape_Info[46].RoomCount = 6	   
Room_Shape_Info[46].Composition = {"1,1","2,1","3,1","1,2","2,2","3,2",}	   
Room_Shape_Info[46].RoomWeight = {30, 1, 30, 40, 10, 40, }	   
	   
Room_Shape_Info[47] = {}
Room_Shape_Info[47].Name = "Shape47"
Room_Shape_Info[47].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[47].Probability = 100
Room_Shape_Info[47].StartRoom = "1,1"	   
Room_Shape_Info[47].RoomCount = 6	   
Room_Shape_Info[47].Composition = {"1,1","2,1","3,1","1,2","2,2","3,2",}	   
Room_Shape_Info[47].RoomWeight = {1, 20, 40, 10, 30, 30, }	   
	   
Room_Shape_Info[48] = {}
Room_Shape_Info[48].Name = "Shape48"
Room_Shape_Info[48].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[48].Probability = 100
Room_Shape_Info[48].StartRoom = "3,1"	   
Room_Shape_Info[48].RoomCount = 6	   
Room_Shape_Info[48].Composition = {"1,1","2,1","3,1","1,2","2,2","3,2",}	   
Room_Shape_Info[48].RoomWeight = {40, 20, 1, 30, 30, 10, }	   
	   
Room_Shape_Info[49] = {}
Room_Shape_Info[49].Name = "Shape49"
Room_Shape_Info[49].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[49].Probability = 100
Room_Shape_Info[49].StartRoom = "1,1"	   
Room_Shape_Info[49].RoomCount = 10	   
Room_Shape_Info[49].Composition = {"1,1","2,1","3,1","4,1","5,1","1,2","2,2","3,2","4,2","5,2",}	   
Room_Shape_Info[49].RoomWeight = {1, 20, 30, 30, 30, 10, 20, 30, 30, 30, }	   
	   
Room_Shape_Info[50] = {}
Room_Shape_Info[50].Name = "Shape50"
Room_Shape_Info[50].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[50].Probability = 100
Room_Shape_Info[50].StartRoom = "2,1"	   
Room_Shape_Info[50].RoomCount = 10	   
Room_Shape_Info[50].Composition = {"1,1","2,1","3,1","4,1","5,1","1,2","2,2","3,2","4,2","5,2",}	   
Room_Shape_Info[50].RoomWeight = {40, 1, 20, 30, 30, 40, 10, 20, 30, 30, }	   
	   
Room_Shape_Info[51] = {}
Room_Shape_Info[51].Name = "Shape51"
Room_Shape_Info[51].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[51].Probability = 100
Room_Shape_Info[51].StartRoom = "3,1"	   
Room_Shape_Info[51].RoomCount = 10	   
Room_Shape_Info[51].Composition = {"1,1","2,1","3,1","4,1","5,1","1,2","2,2","3,2","4,2","5,2",}	   
Room_Shape_Info[51].RoomWeight = {30, 20, 1, 20, 30, 30, 10, 10, 10, 30, }	   
	   
Room_Shape_Info[52] = {}
Room_Shape_Info[52].Name = "Shape52"
Room_Shape_Info[52].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[52].Probability = 100
Room_Shape_Info[52].StartRoom = "4,1"	   
Room_Shape_Info[52].RoomCount = 10	   
Room_Shape_Info[52].Composition = {"1,1","2,1","3,1","4,1","5,1","1,2","2,2","3,2","4,2","5,2",}	   
Room_Shape_Info[52].RoomWeight = {30, 30, 20, 1, 40, 30, 30, 20, 10, 40, }	   
	   
Room_Shape_Info[53] = {}
Room_Shape_Info[53].Name = "Shape53"
Room_Shape_Info[53].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[53].Probability = 100
Room_Shape_Info[53].StartRoom = "5,1"	   
Room_Shape_Info[53].RoomCount = 10	   
Room_Shape_Info[53].Composition = {"1,1","2,1","3,1","4,1","5,1","1,2","2,2","3,2","4,2","5,2",}	   
Room_Shape_Info[53].RoomWeight = {30, 30, 30, 20, 1, 30, 30, 30, 20, 10, }	   
	   
Room_Shape_Info[54] = {}
Room_Shape_Info[54].Name = "Shape54"
Room_Shape_Info[54].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[54].Probability = 100
Room_Shape_Info[54].StartRoom = "2,1"	   
Room_Shape_Info[54].RoomCount = 9	   
Room_Shape_Info[54].Composition = {"1,1","2,1","3,1","1,2","2,2","3,2","1,3","2,3","3,3",}	   
Room_Shape_Info[54].RoomWeight = {30, 1, 30, 30, 10, 30, 30, 20, 30, }	   
	   
Room_Shape_Info[55] = {}
Room_Shape_Info[55].Name = "Shape55"
Room_Shape_Info[55].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[55].Probability = 100
Room_Shape_Info[55].StartRoom = "1,1"	   
Room_Shape_Info[55].RoomCount = 9	   
Room_Shape_Info[55].Composition = {"1,1","2,1","3,1","1,2","2,2","3,2","1,3","2,3","3,3",}	   
Room_Shape_Info[55].RoomWeight = {1, 20, 30, 10, 30, 30, 20, 30, 30, }	   
	   
Room_Shape_Info[56] = {}
Room_Shape_Info[56].Name = "Shape56"
Room_Shape_Info[56].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[56].Probability = 100
Room_Shape_Info[56].StartRoom = "3,1"	   
Room_Shape_Info[56].RoomCount = 9	   
Room_Shape_Info[56].Composition = {"1,1","2,1","3,1","1,2","2,2","3,2","1,3","2,3","3,3",}	   
Room_Shape_Info[56].RoomWeight = {30, 20, 1, 30, 20, 10, 30, 30, 20, }	   
	   


--------------------------------------------------
-- ㅓ 자 배열
--------------------------------------------------

Room_Shape_Info[57] = {}
Room_Shape_Info[57].Name = "Shape57"
Room_Shape_Info[57].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[57].Probability = 100
Room_Shape_Info[57].StartRoom = "2,1"	   
Room_Shape_Info[57].RoomCount = 4	   
Room_Shape_Info[57].Composition = {"2,1","1,2","2,2","2,3",}	   
Room_Shape_Info[57].RoomWeight = {1, 50, 20, 40, }	   
	   
Room_Shape_Info[58] = {}
Room_Shape_Info[58].Name = "Shape58"
Room_Shape_Info[58].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[58].Probability = 100
Room_Shape_Info[58].StartRoom = "3,1"	   
Room_Shape_Info[58].RoomCount = 5	   
Room_Shape_Info[58].Composition = {"3,1","1,2","2,2","3,2","3,3",}	   
Room_Shape_Info[58].RoomWeight = {1, 50, 30, 20, 40, }	   
	   
Room_Shape_Info[59] = {}
Room_Shape_Info[59].Name = "Shape59"
Room_Shape_Info[59].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[59].Probability = 100
Room_Shape_Info[59].StartRoom = "4,1"	   
Room_Shape_Info[59].RoomCount = 6	   
Room_Shape_Info[59].Composition = {"4,1","1,2","2,2","3,2","4,2","4,3",}	   
Room_Shape_Info[59].RoomWeight = {1, 40, 40, 30, 10, 40, }	   
	   
Room_Shape_Info[60] = {}
Room_Shape_Info[60].Name = "Shape60"
Room_Shape_Info[60].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[60].Probability = 100
Room_Shape_Info[60].StartRoom = "2,1"	   
Room_Shape_Info[60].RoomCount = 5	   
Room_Shape_Info[60].Composition = {"2,1","2,2","1,3","2,3","2,4",}	   
Room_Shape_Info[60].RoomWeight = {1, 20, 50, 20, 40, }	   
	   
Room_Shape_Info[61] = {}
Room_Shape_Info[61].Name = "Shape61"
Room_Shape_Info[61].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[61].Probability = 100
Room_Shape_Info[61].StartRoom = "3,1"	   
Room_Shape_Info[61].RoomCount = 6	   
Room_Shape_Info[61].Composition = {"3,1","3,2","1,3","2,3","3,3","3,4",}	   
Room_Shape_Info[61].RoomWeight = {1, 20, 40, 30, 20, 40, }	   
	   
Room_Shape_Info[62] = {}
Room_Shape_Info[62].Name = "Shape62"
Room_Shape_Info[62].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[62].Probability = 100
Room_Shape_Info[62].StartRoom = "2,1"	   
Room_Shape_Info[62].RoomCount = 6	   
Room_Shape_Info[62].Composition = {"2,1","2,2","1,3","2,3","2,4","2,5",}	   
Room_Shape_Info[62].RoomWeight = {1, 20, 50, 20, 20, 40, }	   
	   
Room_Shape_Info[63] = {}
Room_Shape_Info[63].Name = "Shape63"
Room_Shape_Info[63].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[63].Probability = 100
Room_Shape_Info[63].StartRoom = "2,1"	   
Room_Shape_Info[63].RoomCount = 6	   
Room_Shape_Info[63].Composition = {"2,1","2,2","2,3","1,4","2,4","2,5",}	   
Room_Shape_Info[63].RoomWeight = {1, 20, 20, 50, 20, 40, }	   
	   


--------------------------------------------------
-- ㅏ 자 형
--------------------------------------------------

Room_Shape_Info[64] = {}
Room_Shape_Info[64].Name = "Shape64"
Room_Shape_Info[64].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[64].Probability = 100
Room_Shape_Info[64].StartRoom = "1,1"	   
Room_Shape_Info[64].RoomCount = 4	   
Room_Shape_Info[64].Composition = {"1,1","1,2","2,2","1,3",}	   
Room_Shape_Info[64].RoomWeight = {1, 20, 50, 40, }	   
	   
Room_Shape_Info[65] = {}
Room_Shape_Info[65].Name = "Shape65"
Room_Shape_Info[65].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[65].Probability = 100
Room_Shape_Info[65].StartRoom = "1,1"	   
Room_Shape_Info[65].RoomCount = 5	   
Room_Shape_Info[65].Composition = {"1,1","1,2","2,2","3,2","1,3",}	   
Room_Shape_Info[65].RoomWeight = {1, 20, 30, 50, 40, }	   
	   
Room_Shape_Info[66] = {}
Room_Shape_Info[66].Name = "Shape66"
Room_Shape_Info[66].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[66].Probability = 100
Room_Shape_Info[66].StartRoom = "1,1"	   
Room_Shape_Info[66].RoomCount = 6	   
Room_Shape_Info[66].Composition = {"1,1","1,2","2,2","3,2","4,2","1,3",}	   
Room_Shape_Info[66].RoomWeight = {1, 10, 40, 30, 40, 40, }	   
	   
Room_Shape_Info[67] = {}
Room_Shape_Info[67].Name = "Shape67"
Room_Shape_Info[67].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[67].Probability = 100
Room_Shape_Info[67].StartRoom = "1,1"	   
Room_Shape_Info[67].RoomCount = 5	   
Room_Shape_Info[67].Composition = {"1,1","1,2","1,3","2,3","1,4",}	   
Room_Shape_Info[67].RoomWeight = {1, 20, 20, 50, 40, }	   
	   
Room_Shape_Info[68] = {}
Room_Shape_Info[68].Name = "Shape68"
Room_Shape_Info[68].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[68].Probability = 100
Room_Shape_Info[68].StartRoom = "1,1"	   
Room_Shape_Info[68].RoomCount = 6	   
Room_Shape_Info[68].Composition = {"1,1","1,2","1,3","2,3","3,3","1,4",}	   
Room_Shape_Info[68].RoomWeight = {1, 20, 20, 40, 30, 40, }	   
	   
Room_Shape_Info[69] = {}
Room_Shape_Info[69].Name = "Shape69"
Room_Shape_Info[69].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[69].Probability = 100
Room_Shape_Info[69].StartRoom = "1,1"	   
Room_Shape_Info[69].RoomCount = 6	   
Room_Shape_Info[69].Composition = {"1,1","1,2","1,3","2,3","1,4","1,5",}	   
Room_Shape_Info[69].RoomWeight = {1, 20, 20, 50, 20, 40, }	   
	   
Room_Shape_Info[70] = {}
Room_Shape_Info[70].Name = "Shape70"
Room_Shape_Info[70].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[70].Probability = 100
Room_Shape_Info[70].StartRoom = "1,1"	   
Room_Shape_Info[70].RoomCount = 6	   
Room_Shape_Info[70].Composition = {"1,1","1,2","1,3","1,4","2,4","1,5",}	   
Room_Shape_Info[70].RoomWeight = {1, 20, 20, 20, 50, 40, }	   
	   


--------------------------------------------------
-- ㅗ 자 형
--------------------------------------------------

Room_Shape_Info[71] = {}
Room_Shape_Info[71].Name = "Shape71"
Room_Shape_Info[71].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[71].Probability = 100
Room_Shape_Info[71].StartRoom = "2,1"	   
Room_Shape_Info[71].RoomCount = 4	   
Room_Shape_Info[71].Composition = {"1,1","2,1","3,1","2,2",}	   
Room_Shape_Info[71].RoomWeight = {40, 1, 40, 30, }	   
	   
Room_Shape_Info[72] = {}
Room_Shape_Info[72].Name = "Shape72"
Room_Shape_Info[72].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[72].Probability = 100
Room_Shape_Info[72].StartRoom = "3,1"	   
Room_Shape_Info[72].RoomCount = 6	   
Room_Shape_Info[72].Composition = {"1,1","2,1","3,1","4,1","5,1","3,2",}	   
Room_Shape_Info[72].RoomWeight = {40, 20, 1, 20, 40, 30, }	   
	   
Room_Shape_Info[73] = {}
Room_Shape_Info[73].Name = "Shape73"
Room_Shape_Info[73].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[73].Probability = 100
Room_Shape_Info[73].StartRoom = "2,1"	   
Room_Shape_Info[73].RoomCount = 5	   
Room_Shape_Info[73].Composition = {"1,1","2,1","3,1","2,2","2,3",}	   
Room_Shape_Info[73].RoomWeight = {40, 1, 40, 10, 30, }	   
	   
Room_Shape_Info[74] = {}
Room_Shape_Info[74].Name = "Shape74"
Room_Shape_Info[74].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[74].Probability = 100
Room_Shape_Info[74].StartRoom = "3,1"	   
Room_Shape_Info[74].RoomCount = 7	   
Room_Shape_Info[74].Composition = {"1,1","2,1","3,1","4,1","5,1","3,2","3,3",}	   
Room_Shape_Info[74].RoomWeight = {40, 20, 1, 20, 40, 10, 30, }	   
	   
Room_Shape_Info[75] = {}
Room_Shape_Info[75].Name = "Shape75"
Room_Shape_Info[75].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[75].Probability = 100
Room_Shape_Info[75].StartRoom = "2,1"	   
Room_Shape_Info[75].RoomCount = 7	   
Room_Shape_Info[75].Composition = {"1,1","2,1","3,1","4,1","5,1","2,2","2,3",}	   
Room_Shape_Info[75].RoomWeight = {40, 1, 20, 30, 40, 10, 30, }	   
	   
Room_Shape_Info[76] = {}
Room_Shape_Info[76].Name = "Shape76"
Room_Shape_Info[76].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[76].Probability = 100
Room_Shape_Info[76].StartRoom = "4,1"	   
Room_Shape_Info[76].RoomCount = 7	   
Room_Shape_Info[76].Composition = {"1,1","2,1","3,1","4,1","5,1","4,2","4,3",}	   
Room_Shape_Info[76].RoomWeight = {40, 30, 20, 1, 40, 10, 30, }	   
	   
Room_Shape_Info[77] = {}
Room_Shape_Info[77].Name = "Shape77"
Room_Shape_Info[77].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[77].Probability = 100
Room_Shape_Info[77].StartRoom = "1,1"	   
Room_Shape_Info[77].RoomCount = 7	   
Room_Shape_Info[77].Composition = {"1,1","2,1","3,1","4,1","5,1","3,2","3,3",}	   
Room_Shape_Info[77].RoomWeight = {1, 10, 10, 20, 40, 10, 30, }	   
	   
Room_Shape_Info[78] = {}
Room_Shape_Info[78].Name = "Shape78"
Room_Shape_Info[78].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[78].Probability = 100
Room_Shape_Info[78].StartRoom = "2,1"	   
Room_Shape_Info[78].RoomCount = 7	   
Room_Shape_Info[78].Composition = {"1,1","2,1","3,1","4,1","5,1","3,2","3,3",}	   
Room_Shape_Info[78].RoomWeight = {30, 1, 10, 10, 40, 10, 30, }	   
	   
Room_Shape_Info[79] = {}
Room_Shape_Info[79].Name = "Shape79"
Room_Shape_Info[79].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[79].Probability = 100
Room_Shape_Info[79].StartRoom = "4,1"	   
Room_Shape_Info[79].RoomCount = 7	   
Room_Shape_Info[79].Composition = {"1,1","2,1","3,1","4,1","5,1","3,2","3,3",}	   
Room_Shape_Info[79].RoomWeight = {40, 30, 20, 1, 30, 10, 30, }	   
	   
Room_Shape_Info[80] = {}
Room_Shape_Info[80].Name = "Shape80"
Room_Shape_Info[80].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[80].Probability = 100
Room_Shape_Info[80].StartRoom = "5,1"	   
Room_Shape_Info[80].RoomCount = 7	   
Room_Shape_Info[80].Composition = {"1,1","2,1","3,1","4,1","5,1","3,2","3,3",}	   
Room_Shape_Info[80].RoomWeight = {40, 20, 10, 10, 1, 10, 30, }	   
	   
Room_Shape_Info[81] = {}
Room_Shape_Info[81].Name = "Shape81"
Room_Shape_Info[81].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[81].Probability = 100
Room_Shape_Info[81].StartRoom = "1,1"	   
Room_Shape_Info[81].RoomCount = 6	   
Room_Shape_Info[81].Composition = {"1,1","2,1","3,1","4,1","1,2","1,3",}	   
Room_Shape_Info[81].RoomWeight = {1, 20, 20, 30, 20, 30, }	   
	   
Room_Shape_Info[82] = {}
Room_Shape_Info[82].Name = "Shape82"
Room_Shape_Info[82].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[82].Probability = 100
Room_Shape_Info[82].StartRoom = "1,1"	   
Room_Shape_Info[82].RoomCount = 6	   
Room_Shape_Info[82].Composition = {"1,1","2,1","3,1","1,2","1,3","1,4",}	   
Room_Shape_Info[82].RoomWeight = {1, 20, 30, 20, 20, 30, }	   
	   
Room_Shape_Info[83] = {}
Room_Shape_Info[83].Name = "Shape83"
Room_Shape_Info[83].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[83].Probability = 100
Room_Shape_Info[83].StartRoom = "1,1"	   
Room_Shape_Info[83].RoomCount = 7	   
Room_Shape_Info[83].Composition = {"1,1","2,1","3,1","4,1","1,2","1,3","1,4",}	   
Room_Shape_Info[83].RoomWeight = {1, 20, 20, 30, 20, 20, 30, }	   
	   
 
Room_Shape_Info[84] = {}
Room_Shape_Info[84].Name = "Shape84"
Room_Shape_Info[84].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[84].Probability = 100
Room_Shape_Info[84].StartRoom = "1,1"	   
Room_Shape_Info[84].RoomCount = 7	   
Room_Shape_Info[84].Composition = {"1,1","2,1","3,1","1,2","1,3","1,4","1,5",}	   
Room_Shape_Info[84].RoomWeight = {1, 20, 40, 20, 40, 20, 50, }	   
	   
Room_Shape_Info[85] = {}
Room_Shape_Info[85].Name = "Shape85"
Room_Shape_Info[85].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[85].Probability = 100
Room_Shape_Info[85].StartRoom = "1,1"	   
Room_Shape_Info[85].RoomCount = 7	   
Room_Shape_Info[85].Composition = {"1,1","2,1","3,1","4,1","5,1","1,2","1,3",}	   
Room_Shape_Info[85].RoomWeight = {1, 20, 40, 20, 50, 20, 40, }	   
	   
Room_Shape_Info[86] = {}
Room_Shape_Info[86].Name = "Shape86"
Room_Shape_Info[86].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[86].Probability = 100
Room_Shape_Info[86].StartRoom = "2,1"	   
Room_Shape_Info[86].RoomCount = 3	   
Room_Shape_Info[86].Composition = {"1,1","2,1","2,2",}	   
Room_Shape_Info[86].RoomWeight = {30, 1, 30, }	   
	   
Room_Shape_Info[87] = {}
Room_Shape_Info[87].Name = "Shape87"
Room_Shape_Info[87].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[87].Probability = 100
Room_Shape_Info[87].StartRoom = "3,1"	   
Room_Shape_Info[87].RoomCount = 4	   
Room_Shape_Info[87].Composition = {"1,1","2,1","3,1","3,2",}	   
Room_Shape_Info[87].RoomWeight = {30, 20, 1, 30, }	   
	   
Room_Shape_Info[88] = {}
Room_Shape_Info[88].Name = "Shape88"
Room_Shape_Info[88].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[88].Probability = 100
Room_Shape_Info[88].StartRoom = "3,1"	   
Room_Shape_Info[88].RoomCount = 5	   
Room_Shape_Info[88].Composition = {"1,1","2,1","3,1","3,2","3,3",}	   
Room_Shape_Info[88].RoomWeight = {30, 20, 1, 20, 30, }	   
	   
Room_Shape_Info[89] = {}
Room_Shape_Info[89].Name = "Shape89"
Room_Shape_Info[89].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[89].Probability = 100
Room_Shape_Info[89].StartRoom = "4,1"	   
Room_Shape_Info[89].RoomCount = 6	   
Room_Shape_Info[89].Composition = {"1,1","2,1","3,1","4,1","4,2","4,3",}	   
Room_Shape_Info[89].RoomWeight = {30, 20, 20, 1, 20, 30, }	   
	   
Room_Shape_Info[90] = {}
Room_Shape_Info[90].Name = "Shape90"
Room_Shape_Info[90].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[90].Probability = 100
Room_Shape_Info[90].StartRoom = "3,1"	   
Room_Shape_Info[90].RoomCount = 6	   
Room_Shape_Info[90].Composition = {"1,1","2,1","3,1","3,2","3,3","3,4",}	   
Room_Shape_Info[90].RoomWeight = {30, 20, 1, 20, 20, 30, }	   
	   
Room_Shape_Info[91] = {}
Room_Shape_Info[91].Name = "Shape91"
Room_Shape_Info[91].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[91].Probability = 100
Room_Shape_Info[91].StartRoom = "4,1"	   
Room_Shape_Info[91].RoomCount = 7	   
Room_Shape_Info[91].Composition = {"1,1","2,1","3,1","4,1","4,2","4,3","4,4",}	   
Room_Shape_Info[91].RoomWeight = {30, 20, 20, 1, 20, 20, 30, }	   
	   
Room_Shape_Info[92] = {}
Room_Shape_Info[92].Name = "Shape92"
Room_Shape_Info[92].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[92].Probability = 100
Room_Shape_Info[92].StartRoom = "3,1"	   
Room_Shape_Info[92].RoomCount = 7	   
Room_Shape_Info[92].Composition = {"1,1","2,1","3,1","3,2","3,3","3,4","3,5",}	   
Room_Shape_Info[92].RoomWeight = {40, 20, 1, 20, 40, 20, 50, }	   
	   
Room_Shape_Info[93] = {}
Room_Shape_Info[93].Name = "Shape93"
Room_Shape_Info[93].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[93].Probability = 100
Room_Shape_Info[93].StartRoom = "5,1"	   
Room_Shape_Info[93].RoomCount = 7	   
Room_Shape_Info[93].Composition = {"1,1","2,1","3,1","4,1","5,1","5,2","5,3",}	   
Room_Shape_Info[93].RoomWeight = {50, 20, 40, 20, 1, 20, 40, }	   
	   


--------------------------------------------------
-- ┌┐자 형
--------------------------------------------------

Room_Shape_Info[94] = {}
Room_Shape_Info[94].Name = "Shape94"
Room_Shape_Info[94].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[94].Probability = 100
Room_Shape_Info[94].StartRoom = "1,1"	   
Room_Shape_Info[94].RoomCount = 6	   
Room_Shape_Info[94].Composition = {"1,1","4,1","1,2","2,2","3,2","4,2",}	   
Room_Shape_Info[94].RoomWeight = {1, 50, 10, 20, 20, 20, }	   
	   
Room_Shape_Info[95] = {}
Room_Shape_Info[95].Name = "Shape95"
Room_Shape_Info[95].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[95].Probability = 100
Room_Shape_Info[95].StartRoom = "4,1"	   
Room_Shape_Info[95].RoomCount = 6	   
Room_Shape_Info[95].Composition = {"1,1","4,1","1,2","2,2","3,2","4,2",}	   
Room_Shape_Info[95].RoomWeight = {50, 1, 10, 20, 20, 20, }	   
	   


--------------------------------------------------
-- ┌┐자 형
--------------------------------------------------

Room_Shape_Info[96] = {}
Room_Shape_Info[96].Name = "Shape96"
Room_Shape_Info[96].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[96].Probability = 100
Room_Shape_Info[96].StartRoom = "1,1"	   
Room_Shape_Info[96].RoomCount = 7	   
Room_Shape_Info[96].Composition = {"1,1","3,1","1,2","3,2","1,3","2,3","3,3",}	   
Room_Shape_Info[96].RoomWeight = {1, 50, 10, 30, 10, 30, 10, }	   
	   
Room_Shape_Info[97] = {}
Room_Shape_Info[97].Name = "Shape97"
Room_Shape_Info[97].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[97].Probability = 100
Room_Shape_Info[97].StartRoom = "3,1"	   
Room_Shape_Info[97].RoomCount = 7	   
Room_Shape_Info[97].Composition = {"1,1","3,1","1,2","3,2","1,3","2,3","3,3",}	   
Room_Shape_Info[97].RoomWeight = {50, 1, 30, 10, 10, 30, 10, }	   
	   
Room_Shape_Info[98] = {}
Room_Shape_Info[98].Name = "Shape98"
Room_Shape_Info[98].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[98].Probability = 100
Room_Shape_Info[98].StartRoom = "1,1"	   
Room_Shape_Info[98].RoomCount = 7	   
Room_Shape_Info[98].Composition = {"1,1","1,2","1,3","3,3","1,4","2,4","3,4",}	   
Room_Shape_Info[98].RoomWeight = {1, 10, 10, 50, 30, 30, 10, }	   
	   
Room_Shape_Info[99] = {}
Room_Shape_Info[99].Name = "Shape99"
Room_Shape_Info[99].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[99].Probability = 100
Room_Shape_Info[99].StartRoom = "3,1"	   
Room_Shape_Info[99].RoomCount = 7	   
Room_Shape_Info[99].Composition = {"3,1","3,2","1,3","3,3","1,4","2,4","3,4",}	   
Room_Shape_Info[99].RoomWeight = {1, 10, 50, 10, 10, 30, 30, }	   
	   


--------------------------------------------------
-- ┌┘자 형
--------------------------------------------------

Room_Shape_Info[100] = {}
Room_Shape_Info[100].Name = "Shape100"
Room_Shape_Info[100].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[100].Probability = 100
Room_Shape_Info[100].StartRoom = "1,1"	   
Room_Shape_Info[100].RoomCount = 6	   
Room_Shape_Info[100].Composition = {"1,1","1,2","2,2","3,2","3,3","3,4",}	   
Room_Shape_Info[100].RoomWeight = {1, 10, 20, 20, 50, 20, }	   
	   
Room_Shape_Info[101] = {}
Room_Shape_Info[101].Name = "Shape101"
Room_Shape_Info[101].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[101].Probability = 127
Room_Shape_Info[101].StartRoom = "1,1"	   
Room_Shape_Info[101].RoomCount = 5	   
Room_Shape_Info[101].Composition = {"1,1","1,2","2,2","2,3","2,4",}	   
Room_Shape_Info[101].RoomWeight = {1, 10, 20, 20, 50, }	   
	   
Room_Shape_Info[102] = {}
Room_Shape_Info[102].Name = "Shape102"
Room_Shape_Info[102].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[102].Probability = 128
Room_Shape_Info[102].StartRoom = "1,1"	   
Room_Shape_Info[102].RoomCount = 7	   
Room_Shape_Info[102].Composition = {"1,1","1,2","1,3","2,3","3,3","3,4","3,5",}	   
Room_Shape_Info[102].RoomWeight = {1, 10, 10, 20, 20, 50, 20, }	   
	   
Room_Shape_Info[103] = {}
Room_Shape_Info[103].Name = "Shape103"
Room_Shape_Info[103].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[103].Probability = 129
Room_Shape_Info[103].StartRoom = "1,1"	   
Room_Shape_Info[103].RoomCount = 6	   
Room_Shape_Info[103].Composition = {"1,1","1,2","1,3","2,3","2,4","2,5",}	   
Room_Shape_Info[103].RoomWeight = {1, 10, 20, 20, 50, 20, }	   
	   


--------------------------------------------------
-- └┐자형
--------------------------------------------------

Room_Shape_Info[104] = {}
Room_Shape_Info[104].Name = "Shape104"
Room_Shape_Info[104].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[104].Probability = 103
Room_Shape_Info[104].StartRoom = "3,1"	   
Room_Shape_Info[104].RoomCount = 6	   
Room_Shape_Info[104].Composition = {"3,1","1,2","2,2","3,2","1,3","1,4",}	   
Room_Shape_Info[104].RoomWeight = {1, 20, 20, 10, 50, 20, }	   
	   
Room_Shape_Info[105] = {}
Room_Shape_Info[105].Name = "Shape105"
Room_Shape_Info[105].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[105].Probability = 104
Room_Shape_Info[105].StartRoom = "2,1"	   
Room_Shape_Info[105].RoomCount = 5	   
Room_Shape_Info[105].Composition = {"2,1","1,2","2,2","1,3","1,4",}	   
Room_Shape_Info[105].RoomWeight = {1, 20, 10, 20, 50, }	   
	   
Room_Shape_Info[106] = {}
Room_Shape_Info[106].Name = "Shape106"
Room_Shape_Info[106].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[106].Probability = 105
Room_Shape_Info[106].StartRoom = "3,1"	   
Room_Shape_Info[106].RoomCount = 7	   
Room_Shape_Info[106].Composition = {"3,1","3,2","1,3","2,3","3,3","1,4","1,5",}	   
Room_Shape_Info[106].RoomWeight = {1, 10, 20, 20, 10, 50, 20, }	   
	   
Room_Shape_Info[107] = {}
Room_Shape_Info[107].Name = "Shape107"
Room_Shape_Info[107].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[107].Probability = 106
Room_Shape_Info[107].StartRoom = "2,1"	   
Room_Shape_Info[107].RoomCount = 6	   
Room_Shape_Info[107].Composition = {"2,1","2,2","1,3","2,3","1,4","1,5",}	   
Room_Shape_Info[107].RoomWeight = {1, 10, 20, 20, 50, 20, }	   
	   


--------------------------------------------------
-- ┌┴┐자형
--------------------------------------------------

Room_Shape_Info[108] = {}
Room_Shape_Info[108].Name = "Shape108"
Room_Shape_Info[108].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[108].Probability = 100
Room_Shape_Info[108].StartRoom = "1,1"	   
Room_Shape_Info[108].RoomCount = 7	   
Room_Shape_Info[108].Composition = {"1,1","4,1","1,2","2,2","3,2","4,2","2,3",}	   
Room_Shape_Info[108].RoomWeight = {1, 50, 10, 20, 20, 20, 40, }	   
	   
Room_Shape_Info[109] = {}
Room_Shape_Info[109].Name = "Shape109"
Room_Shape_Info[109].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[109].Probability = 100
Room_Shape_Info[109].StartRoom = "1,1"	   
Room_Shape_Info[109].RoomCount = 7	   
Room_Shape_Info[109].Composition = {"1,1","4,1","1,2","2,2","3,2","4,2","3,3",}	   
Room_Shape_Info[109].RoomWeight = {1, 50, 10, 20, 20, 20, 40, }	   
	   
Room_Shape_Info[110] = {}
Room_Shape_Info[110].Name = "Shape110"
Room_Shape_Info[110].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[110].Probability = 100
Room_Shape_Info[110].StartRoom = "4,1"	   
Room_Shape_Info[110].RoomCount = 7	   
Room_Shape_Info[110].Composition = {"1,1","4,1","1,2","2,2","3,2","4,2","3,3",}	   
Room_Shape_Info[110].RoomWeight = {50, 1, 10, 20, 20, 20, 40, }	   
	   
Room_Shape_Info[111] = {}
Room_Shape_Info[111].Name = "Shape111"
Room_Shape_Info[111].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[111].Probability = 107
Room_Shape_Info[111].StartRoom = "4,1"	   
Room_Shape_Info[111].RoomCount = 7	   
Room_Shape_Info[111].Composition = {"1,1","4,1","1,2","2,2","3,2","4,2","2,3",}	   
Room_Shape_Info[111].RoomWeight = {50, 1, 10, 20, 20, 20, 40, }	   
	   
Room_Shape_Info[112] = {}
Room_Shape_Info[112].Name = "Shape112"
Room_Shape_Info[112].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[112].Probability = 100
Room_Shape_Info[112].StartRoom = "1,1"	   
Room_Shape_Info[112].RoomCount = 8	   
Room_Shape_Info[112].Composition = {"1,1","3,1","1,2","3,2","1,3","2,3","3,3","2,4",}	   
Room_Shape_Info[112].RoomWeight = {1, 50, 10, 20, 10, 20, 10, 50, }	   
	   
Room_Shape_Info[113] = {}
Room_Shape_Info[113].Name = "Shape113"
Room_Shape_Info[113].StageType = STAGE_TYPE_BATTLE	   
Room_Shape_Info[113].Probability = 100
Room_Shape_Info[113].StartRoom = "3,1"	   
Room_Shape_Info[113].RoomCount = 8	   
Room_Shape_Info[113].Composition = {"1,1","3,1","1,2","3,2","1,3","2,3","3,3","2,4",}	   
Room_Shape_Info[113].RoomWeight = {50, 1, 20, 10, 10, 20, 10, 50, }	 

	   

--------------------------------------------------
-- 트랩형
--------------------------------------------------
Room_Shape_Info[114] = {}
Room_Shape_Info[114].Name = "Trap01"
Room_Shape_Info[114].StageType = STAGE_TYPE_PUZZLE
Room_Shape_Info[114].Probability = 0
Room_Shape_Info[114].StartRoom = "2,1"
Room_Shape_Info[114].RoomCount = 3
Room_Shape_Info[114].Composition = {"2,1","2,2","2,3",}
Room_Shape_Info[114].RoomWeight = {10, 20, 10, }
 
Room_Shape_Info[115] = {}
Room_Shape_Info[115].Name = "Trap02"
Room_Shape_Info[115].StageType = STAGE_TYPE_PUZZLE	   
Room_Shape_Info[115].Probability = 0
Room_Shape_Info[115].StartRoom = "2,1"	   
Room_Shape_Info[115].RoomCount = 4	   
Room_Shape_Info[115].Composition = {"2,1","2,2","2,3","2,4",}	   
Room_Shape_Info[115].RoomWeight = {10, 20, 20, 10, }
 
Room_Shape_Info[116] = {}
Room_Shape_Info[116].Name = "Trap03"
Room_Shape_Info[116].StageType = STAGE_TYPE_PUZZLE	   
Room_Shape_Info[116].Probability = 0
Room_Shape_Info[116].StartRoom = "2,1"	   
Room_Shape_Info[116].RoomCount = 5	   
Room_Shape_Info[116].Composition = {"2,1","2,2","2,3","2,4","2,5",}	   
Room_Shape_Info[116].RoomWeight = {10, 20, 20, 20, 10, }
 
Room_Shape_Info[117] = {}
Room_Shape_Info[117].Name = "Trap04"
Room_Shape_Info[117].StageType = STAGE_TYPE_PUZZLE	   
Room_Shape_Info[117].Probability = 0
Room_Shape_Info[117].StartRoom = "2,1"	   
Room_Shape_Info[117].RoomCount = 4	   
Room_Shape_Info[117].Composition = {"1,1","2,1","1,2","1,3",}	   
Room_Shape_Info[117].RoomWeight = {10, 10, 20, 10, }
 
Room_Shape_Info[118] = {}
Room_Shape_Info[118].Name = "Trap05"
Room_Shape_Info[118].StageType = STAGE_TYPE_PUZZLE	   
Room_Shape_Info[118].Probability = 0
Room_Shape_Info[118].StartRoom = "2,1"	   
Room_Shape_Info[118].RoomCount = 6	   
Room_Shape_Info[118].Composition = {"1,1","2,1","1,2","1,3","1,4","1,5",}	   
Room_Shape_Info[118].RoomWeight = {10, 10, 30, 20, 30, 10, }
 
Room_Shape_Info[119] = {}
Room_Shape_Info[119].Name = "Trap06"
Room_Shape_Info[119].StageType = STAGE_TYPE_PUZZLE	   
Room_Shape_Info[119].Probability = 0
Room_Shape_Info[119].StartRoom = "2,1"	   
Room_Shape_Info[119].RoomCount = 6	   
Room_Shape_Info[119].Composition = {"2,1","2,2","1,3","2,3","1,4","1,5",}	   
Room_Shape_Info[119].RoomWeight = {10, 20, 10, 10, 30, 10, }
 
Room_Shape_Info[120] = {}
Room_Shape_Info[120].Name = "Trap07"
Room_Shape_Info[120].StageType = STAGE_TYPE_PUZZLE	   
Room_Shape_Info[120].Probability = 0
Room_Shape_Info[120].StartRoom = "2,1"	   
Room_Shape_Info[120].RoomCount = 4	   
Room_Shape_Info[120].Composition = {"2,1","3,1","3,2","3,3",}	   
Room_Shape_Info[120].RoomWeight = {10, 10, 30, 10, }
 
Room_Shape_Info[121] = {}
Room_Shape_Info[121].Name = "Trap08"
Room_Shape_Info[121].StageType = STAGE_TYPE_PUZZLE	   
Room_Shape_Info[121].Probability = 0
Room_Shape_Info[121].StartRoom = "2,1"	   
Room_Shape_Info[121].RoomCount = 6	   
Room_Shape_Info[121].Composition = {"2,1","3,1","3,2","3,3","3,4","3,5",}	   
Room_Shape_Info[121].RoomWeight = {10, 10, 30, 20, 30, 10, }
 
Room_Shape_Info[122] = {}
Room_Shape_Info[122].Name = "Trap09"
Room_Shape_Info[122].StageType = STAGE_TYPE_PUZZLE	   
Room_Shape_Info[122].Probability = 0
Room_Shape_Info[122].StartRoom = "2,1"	   
Room_Shape_Info[122].RoomCount = 6	   
Room_Shape_Info[122].Composition = {"2,1","2,2","2,3","3,3","3,4","3,5",}	   
Room_Shape_Info[122].RoomWeight = {10, 20, 10, 10, 30, 10, }



----------------------------------------------------------------------------------------------------
-- 방 모양 정보가 저장되어 있는 배열 이름을 반환한다.
----------------------------------------------------------------------------------------------------
function GetRoomShapeListName()

	strRoomShapeListName = "Room_Shape_Info"

	return strRoomShapeListName
end

----------------------------------------------------------------------------------------------------
-- 방 모양 정보가 저장되어 있는 배열의 갯수를 반환한다. 배열변수 앞에 #을 붙이면 갯수가 반환된다.
----------------------------------------------------------------------------------------------------
function GetRoomShapeListCount()

	nCount = #Room_Shape_Info

	return nCount
end


----------------------------------------------------------------------------------------------------
-- 아이템 타입을 정의한다. 클라이언트의 ElevatorEscapeDefine.h EItemType과 같아야한다.
-- ITEM_TYPE_PRI_WEAPON : 주무기
-- ITEM_TYPE_SECONDARY_WEAPON : 보조무기
-- ITEM_TYPE_MELEE_WEAPON : 근접무기
-- ITEM_TYPE_THROW_WEAPON : 투척무기
-- ITEM_TYPE_AMMO : 탄약
-- ITEM_TYPE_BOX : 상자
-- ITEM_TYPE_SKILL : 스킬
-- ITEM_TYPE_AMMOBAG : 탄통
-- ITEM_TYPE_HPKIT : 회복킷
-- ITEM_TYPE_HP_INCREASE : HP증가
-- ITEM_TYPE_DAMAGE_STAT : 대미지
-- ITEM_TYPE_ACCURACY_RATE_STAT : 명중률
-- ITEM_TYPE_EVASION_RATE_STAT : 회피률
-- ITEM_TYPE_MAGAZINE_INCREASE : 탄창 증가
-- ITEM_TYPE_AMMO_CLIP_INCREASE : 삽탄 증가
-- ITEM_TYPE_CRITICAL_PROBABILITY : 크리티컬 확률
-- ITEM_TYPE_CRITICAL_DAMAGE_MULTIPLE : 크리티컬 대미지
-- ITEM_TYPE_INCREASE_SKILL_TIME : 스킬 지속 시간을 증가
-- ITEM_TYPE_INCREASE_ENCHANT_VALUE : 강화 수치 증가
-- ITEM_TYPE_INCREASE_ENCHANT_SUCCESS : 강화 성공 증가
-- ITEM_TYPE_INCREASE_RARE_REWARD : 희귀   증가
-- ITEM_TYPE_PERK : 퍽
----------------------------------------------------------------------------------------------------
ITEM_TYPE_NOTHING = 0
ITEM_TYPE_PRI_WEAPON = 1
ITEM_TYPE_SECONDARY_WEAPON = 2
ITEM_TYPE_MELEE_WEAPON = 3
ITEM_TYPE_THROW_WEAPON = 4
ITEM_TYPE_AMMO = 5
ITEM_TYPE_BOX = 6
ITEM_TYPE_SKILL = 7
ITEM_TYPE_AMMOBAG = 8
ITEM_TYPE_HPKIT = 9
ITEM_TYPE_HP_INCREASE = 10
ITEM_TYPE_DAMAGE_STAT = 11
ITEM_TYPE_ACCURACY_RATE_STAT = 12
ITEM_TYPE_EVASION_RATE_STAT = 13
ITEM_TYPE_MAGAZINE_INCREASE = 14
ITEM_TYPE_AMMO_IN_CLIP_INCREASE = 15
ITEM_TYPE_CRITICAL_PROBABILITY = 16
ITEM_TYPE_CRITICAL_DAMAGE_MULTIPLE = 17
ITEM_TYPE_INCREASE_SKILL_TIME = 18
ITEM_TYPE_INCREASE_ENCHANT_VALUE = 19
ITEM_TYPE_INCREASE_ENCHANT_SUCCESS = 20
ITEM_TYPE_INCREASE_RARE_REWARD = 21
ITEM_TYPE_PERK = 22

----------------------------------------------------------------------------------------------------
-- 아이템 등급을 정의한다. 클라이언트의 ElevatorEscapeDefine.h EItemGrade와 같아야한다.
----------------------------------------------------------------------------------------------------
ITEM_GRADE_NORMAL = 1
ITEM_GRADE_RARE = 2
ITEM_GRADE_LEGEND = 3
ITEM_GRADE_SPECIAL = 4

ItemTypeInfo = {}
--ItemTypeInfo[ITEM_TYPE_PRI_WEAPON] = {Toucth=true}
--ItemTypeInfo[ITEM_TYPE_SECONDARY_WEAPON] = {Toucth=true}
--ItemTypeInfo[ITEM_TYPE_MELEE_WEAPON] = {Toucth=true}
--ItemTypeInfo[ITEM_TYPE_THROW_WEAPON] = {Toucth=true}
--ItemTypeInfo[ITEM_TYPE_AMMO] = {Toucth=true}
--ItemTypeInfo[ITEM_TYPE_BOX] = {Toucth=true}
--ItemTypeInfo[ITEM_TYPE_SKILL] = {Toucth=true}
--ItemTypeInfo[ITEM_TYPE_AMMOBAG] = {Toucth=true}
--ItemTypeInfo[ITEM_TYPE_HPKIT] = {Toucth=true}

----------------------------------------------------------------------------------------------------
-- 아이템 정보가 설정되어 있는 배열.
----------------------------------------------------------------------------------------------------
Item_Info = {}
 
--------------------------------------------------
-- 주무기
--------------------------------------------------

Item_Info[1] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 4, Name="M4A1", Grade = ITEM_GRADE_NORMAL}            --M4A1을 획득합니다.	   
Item_Info[2] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 9, Name="AK47", Grade = ITEM_GRADE_NORMAL}            --AK47을 획득합니다.	   
Item_Info[3] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 22, Name="TRG21", Grade = ITEM_GRADE_RARE}            --TRG21을 획득합니다.	   
Item_Info[4] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 1107, Name="lightning gatling", Grade = ITEM_GRADE_LEGEND}            --lightning gatling을 획득합니다.	   
Item_Info[5] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 2257, Name="sg_870_v3", Grade = ITEM_GRADE_NORMAL}            --sg_870_v3을 획득합니다.	   
Item_Info[6] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 3067, Name="AK103(IS)_관통탄", Grade = ITEM_GRADE_LEGEND}            --AK103(IS)_관통탄을 획득합니다.	   
Item_Info[7] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 744, Name="유탄발사기", Grade = ITEM_GRADE_LEGEND}            --유탄발사기을 획득합니다.	   
Item_Info[8] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 1105, Name="로켓런처", Grade = ITEM_GRADE_LEGEND}            --로켓런처을 획득합니다.	   
Item_Info[9] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 3068, Name="화염방사기", Grade = ITEM_GRADE_LEGEND}            --화염방사기을 획득합니다.	   
Item_Info[10] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 1175, Name="MP7", Grade = ITEM_GRADE_NORMAL}            --MP7을 획득합니다.	   
--------------------------------------------------
-- 보조 무기
--------------------------------------------------

Item_Info[11] = {Type = ITEM_TYPE_SECONDARY_WEAPON, Index = 1, Name="D_Eagle", Grade = ITEM_GRADE_RARE}            --D_Eagle을 획득합니다.	   
Item_Info[12] = {Type = ITEM_TYPE_SECONDARY_WEAPON, Index = 1958, Name="G18", Grade = ITEM_GRADE_LEGEND}            --G18을 획득합니다.	   
Item_Info[13] = {Type = ITEM_TYPE_SECONDARY_WEAPON, Index = 1588, Name="C.USP(S) Scorpion", Grade = ITEM_GRADE_NORMAL}            --C.USP(S) Scorpion을 획득합니다.	   
Item_Info[14] = {Type = ITEM_TYPE_SECONDARY_WEAPON, Index = 2, Name="C.Anaconda", Grade = ITEM_GRADE_NORMAL}            --C.Anaconda을 획득합니다.	   
--------------------------------------------------
-- 근접무기
--------------------------------------------------

Item_Info[15] = {Type = ITEM_TYPE_MELEE_WEAPON, Index = 28, Name="Gurkhan Knife", Grade = ITEM_GRADE_RARE}            --Gurkhan Knife을 획득합니다.	   
Item_Info[16] = {Type = ITEM_TYPE_MELEE_WEAPON, Index = 48, Name="AXE Knife", Grade = ITEM_GRADE_NORMAL}            --AXE Knife을 획득합니다.	   
Item_Info[17] = {Type = ITEM_TYPE_MELEE_WEAPON, Index = 49, Name="Tiger Stripe", Grade = ITEM_GRADE_NORMAL}            --Tiger Stripe을 획득합니다.	   
Item_Info[18] = {Type = ITEM_TYPE_MELEE_WEAPON, Index = 0, Name="Knife", Grade = ITEM_GRADE_NORMAL}            --Knife을 획득합니다.	   
Item_Info[19] = {Type = ITEM_TYPE_THROW_WEAPON, Index = 3065, Name="G400", Grade = ITEM_GRADE_NORMAL}            --G400을 획득합니다.	   
--------------------------------------------------
-- 탄창
--------------------------------------------------

Item_Info[20] = {Type = ITEM_TYPE_AMMO, Index = 1, Name="탄창", Grade = ITEM_GRADE_NORMAL}            --탄창을 획득합니다.	   
--------------------------------------------------
-- 탄약통
--------------------------------------------------

Item_Info[21] = {Type = ITEM_TYPE_AMMOBAG, Index = 3066, Name="탄약통", Grade = ITEM_GRADE_NORMAL}            --탄약통을 획득합니다.	   
--------------------------------------------------
-- 회복키트
--------------------------------------------------

Item_Info[22] = {Type = ITEM_TYPE_HPKIT, Index = 3064, Name="회복키트", Grade = ITEM_GRADE_NORMAL}            --회복키트을 획득합니다.	   
--------------------------------------------------
-- 아이템 상자
--------------------------------------------------

Item_Info[23] = {Type = ITEM_TYPE_BOX, Index = 1, Name="FALSE", Grade = ITEM_GRADE_NORMAL}            --FALSE	   
--------------------------------------------------
-- 1회성 버프 스킬
--------------------------------------------------

Item_Info[24] = {Type = ITEM_TYPE_SKILL, Index = 4, Name="무적", Grade = ITEM_GRADE_NORMAL}            --10초 동안 무적 적용	   
Item_Info[25] = {Type = ITEM_TYPE_SKILL, Index = 1, Name="오토에임", Grade = ITEM_GRADE_NORMAL}            --10초 동안 오토에임 적용	   
Item_Info[26] = {Type = ITEM_TYPE_SKILL, Index = 2, Name="무반동", Grade = ITEM_GRADE_NORMAL}            --10초 동안 무반동 적용	   
Item_Info[27] = {Type = ITEM_TYPE_SKILL, Index = 3, Name="무한탄창", Grade = ITEM_GRADE_NORMAL}            --10초 동안 무한탄창 적용	   
Item_Info[28] = {Type = ITEM_TYPE_SKILL, Index = 5, Name="HP회복", Grade = ITEM_GRADE_NORMAL}            --10초 동안 HP회복 적용	   
Item_Info[29] = {Type = ITEM_TYPE_SKILL, Index = 6, Name="공격력 상승", Grade = ITEM_GRADE_NORMAL}            --10초 동안 공격력 상승 적용	   
Item_Info[30] = {Type = ITEM_TYPE_SKILL, Index = 7, Name="명중률 상승", Grade = ITEM_GRADE_NORMAL}            --10초 동안 명중률 상승 적용	   
Item_Info[31] = {Type = ITEM_TYPE_SKILL, Index = 8, Name="크리티컬 상승", Grade = ITEM_GRADE_NORMAL}            --10초 동안 크리티컬 상승 적용	   
--------------------------------------------------
-- 명중률 증가
--------------------------------------------------

Item_Info[32] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 1, Name="명중률", Grade = ITEM_GRADE_NORMAL}            --특수총 명중률이 5% 증가합니다.	   
Item_Info[33] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 2, Name="명중률", Grade = ITEM_GRADE_NORMAL}            --특수총 명중률이 10% 증가합니다.	   
Item_Info[34] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 3, Name="명중률", Grade = ITEM_GRADE_RARE}            --특수총 명중률이 15% 증가합니다.	   
Item_Info[35] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 4, Name="명중률", Grade = ITEM_GRADE_RARE}            --특수총 명중률이 20% 증가합니다.	   
Item_Info[36] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 5, Name="명중률", Grade = ITEM_GRADE_RARE}            --특수총 명중률이 25% 증가합니다.	   
Item_Info[37] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 6, Name="명중률", Grade = ITEM_GRADE_LEGEND}            --특수총 명중률이 30% 증가합니다.	   
Item_Info[38] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 7, Name="명중률", Grade = ITEM_GRADE_NORMAL}            --돌격소총 명중률이 5% 증가합니다.	   
Item_Info[39] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 8, Name="명중률", Grade = ITEM_GRADE_NORMAL}            --돌격소총 명중률이 10% 증가합니다.	   
Item_Info[40] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 9, Name="명중률", Grade = ITEM_GRADE_RARE}            --돌격소총 명중률이 15% 증가합니다.	   
Item_Info[41] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 10, Name="명중률", Grade = ITEM_GRADE_RARE}            --돌격소총 명중률이 20% 증가합니다.	   
Item_Info[42] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 11, Name="명중률", Grade = ITEM_GRADE_RARE}            --돌격소총 명중률이 25% 증가합니다.	   
Item_Info[43] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 12, Name="명중률", Grade = ITEM_GRADE_LEGEND}            --돌격소총 명중률이 30% 증가합니다.	   
Item_Info[44] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 13, Name="명중률", Grade = ITEM_GRADE_NORMAL}            --보조무기 명중률이 5% 증가합니다.	   
Item_Info[45] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 14, Name="명중률", Grade = ITEM_GRADE_NORMAL}            --보조무기 명중률이 7% 증가합니다.	   
Item_Info[46] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 15, Name="명중률", Grade = ITEM_GRADE_RARE}            --보조무기 명중률이 10% 증가합니다.	   
Item_Info[47] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 16, Name="명중률", Grade = ITEM_GRADE_RARE}            --보조무기 명중률이 15% 증가합니다.	   
Item_Info[48] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 17, Name="명중률", Grade = ITEM_GRADE_RARE}            --보조무기 명중률이 20% 증가합니다.	   
Item_Info[49] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 18, Name="명중률", Grade = ITEM_GRADE_LEGEND}            --보조무기 명중률이 25% 증가합니다.	   
Item_Info[50] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 19, Name="명중률", Grade = ITEM_GRADE_NORMAL}            --저격소총 명중률이 5% 증가합니다.	   
Item_Info[51] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 20, Name="명중률", Grade = ITEM_GRADE_NORMAL}            --저격소총 명중률이 10% 증가합니다.	   
Item_Info[52] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 21, Name="명중률", Grade = ITEM_GRADE_RARE}            --저격소총 명중률이 15% 증가합니다.	   
Item_Info[53] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 22, Name="명중률", Grade = ITEM_GRADE_RARE}            --저격소총 명중률이 20% 증가합니다.	   
Item_Info[54] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 23, Name="명중률", Grade = ITEM_GRADE_RARE}            --저격소총 명중률이 25% 증가합니다.	   
Item_Info[55] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 24, Name="명중률", Grade = ITEM_GRADE_LEGEND}            --저격소총 명중률이 30% 증가합니다.	   
Item_Info[56] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 25, Name="명중률", Grade = ITEM_GRADE_NORMAL}            --근접무기 명중률이 5% 증가합니다.	   
Item_Info[57] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 26, Name="명중률", Grade = ITEM_GRADE_NORMAL}            --근접무기 명중률이 7% 증가합니다.	   
Item_Info[58] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 27, Name="명중률", Grade = ITEM_GRADE_RARE}            --근접무기 명중률이 10% 증가합니다.	   
Item_Info[59] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 28, Name="명중률", Grade = ITEM_GRADE_RARE}            --근접무기 명중률이 15% 증가합니다.	   
Item_Info[60] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 29, Name="명중률", Grade = ITEM_GRADE_RARE}            --근접무기 명중률이 20% 증가합니다.	   
Item_Info[61] = {Type = ITEM_TYPE_ACCURACY_RATE_STAT, Index = 30, Name="명중률", Grade = ITEM_GRADE_LEGEND}            --근접무기 명중률이 25% 증가합니다.	   
--------------------------------------------------
-- 대미지 증가
--------------------------------------------------

Item_Info[62] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 1, Name="대미지", Grade = ITEM_GRADE_NORMAL}            --특수총 대미지가 10% 증가합니다.	   
Item_Info[63] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 2, Name="대미지", Grade = ITEM_GRADE_NORMAL}            --특수총 대미지가 15% 증가합니다.	   
Item_Info[64] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 3, Name="대미지", Grade = ITEM_GRADE_RARE}            --특수총 대미지가 20% 증가합니다.	   
Item_Info[65] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 4, Name="대미지", Grade = ITEM_GRADE_RARE}            --특수총 대미지가 25% 증가합니다.	   
Item_Info[66] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 5, Name="대미지", Grade = ITEM_GRADE_RARE}            --특수총 대미지가 30% 증가합니다.	   
Item_Info[67] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 6, Name="대미지", Grade = ITEM_GRADE_LEGEND}            --특수총 대미지가 35% 증가합니다.	   
Item_Info[68] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 7, Name="대미지", Grade = ITEM_GRADE_NORMAL}            --돌격소총 대미지가 10% 증가합니다.	   
Item_Info[69] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 8, Name="대미지", Grade = ITEM_GRADE_NORMAL}            --돌격소총 대미지가 15% 증가합니다.	   
Item_Info[70] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 9, Name="대미지", Grade = ITEM_GRADE_RARE}            --돌격소총 대미지가 20% 증가합니다.	   
Item_Info[71] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 10, Name="대미지", Grade = ITEM_GRADE_RARE}            --돌격소총 대미지가 25% 증가합니다.	   
Item_Info[72] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 11, Name="대미지", Grade = ITEM_GRADE_RARE}            --돌격소총 대미지가 30% 증가합니다.	   
Item_Info[73] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 12, Name="대미지", Grade = ITEM_GRADE_LEGEND}            --돌격소총 대미지가 35% 증가합니다.	   
Item_Info[74] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 13, Name="대미지", Grade = ITEM_GRADE_NORMAL}            --저격소총 대미지가 10% 증가합니다.	   
Item_Info[75] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 14, Name="대미지", Grade = ITEM_GRADE_NORMAL}            --저격소총 대미지가 15% 증가합니다.	   
Item_Info[76] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 15, Name="대미지", Grade = ITEM_GRADE_RARE}            --저격소총 대미지가 20% 증가합니다.	   
Item_Info[77] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 16, Name="대미지", Grade = ITEM_GRADE_RARE}            --저격소총 대미지가 25% 증가합니다.	   
Item_Info[78] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 17, Name="대미지", Grade = ITEM_GRADE_RARE}            --저격소총 대미지가 30% 증가합니다.	   
Item_Info[79] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 18, Name="대미지", Grade = ITEM_GRADE_LEGEND}            --저격소총 대미지가 35% 증가합니다.	   
Item_Info[80] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 19, Name="대미지", Grade = ITEM_GRADE_NORMAL}            --보조무기 대미지가 5% 증가합니다.	   
Item_Info[81] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 20, Name="대미지", Grade = ITEM_GRADE_NORMAL}            --보조무기 대미지가 7% 증가합니다.	   
Item_Info[82] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 21, Name="대미지", Grade = ITEM_GRADE_RARE}            --보조무기 대미지가 10% 증가합니다.	   
Item_Info[83] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 22, Name="대미지", Grade = ITEM_GRADE_RARE}            --보조무기 대미지가 15% 증가합니다.	   
Item_Info[84] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 23, Name="대미지", Grade = ITEM_GRADE_RARE}            --보조무기 대미지가 20% 증가합니다.	   
Item_Info[85] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 24, Name="대미지", Grade = ITEM_GRADE_LEGEND}            --보조무기 대미지가 25% 증가합니다.	   
Item_Info[86] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 25, Name="대미지", Grade = ITEM_GRADE_NORMAL}            --근접무기 대미지가 5% 증가합니다.	   
Item_Info[87] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 26, Name="대미지", Grade = ITEM_GRADE_NORMAL}            --근접무기 대미지가 7% 증가합니다.	   
Item_Info[88] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 27, Name="대미지", Grade = ITEM_GRADE_RARE}            --근접무기 대미지가 10% 증가합니다.	   
Item_Info[89] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 28, Name="대미지", Grade = ITEM_GRADE_RARE}            --근접무기 대미지가 15% 증가합니다.	   
Item_Info[90] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 29, Name="대미지", Grade = ITEM_GRADE_RARE}            --근접무기 대미지가 20% 증가합니다.	   
Item_Info[91] = {Type = ITEM_TYPE_DAMAGE_STAT, Index = 30, Name="대미지", Grade = ITEM_GRADE_LEGEND}            --근접무기 대미지가 25% 증가합니다.	   
--------------------------------------------------
-- 예비장탄 증가
--------------------------------------------------

Item_Info[92] = {Type = ITEM_TYPE_MAGAZINE_INCREASE, Index = 1, Name="예비장탄 증가", Grade = ITEM_GRADE_NORMAL}            --예비장탄이 50% 증가합니다.	   
Item_Info[93] = {Type = ITEM_TYPE_MAGAZINE_INCREASE, Index = 2, Name="예비장탄 증가", Grade = ITEM_GRADE_RARE}            --예비장탄이 100% 증가합니다.	   
Item_Info[94] = {Type = ITEM_TYPE_MAGAZINE_INCREASE, Index = 3, Name="예비장탄 증가", Grade = ITEM_GRADE_LEGEND}            --예비탄창이 150% 증가합니다.	   
--------------------------------------------------
-- 강화 성공 값 증가
--------------------------------------------------

Item_Info[95] = {Type = ITEM_TYPE_INCREASE_ENCHANT_VALUE, Index = 1, Name="강화 성공 값 증가", Grade = ITEM_GRADE_NORMAL}            --강화 성공 값이 5% 증가합니다.	   
Item_Info[96] = {Type = ITEM_TYPE_INCREASE_ENCHANT_VALUE, Index = 2, Name="강화 성공 값 증가", Grade = ITEM_GRADE_NORMAL}            --강화 성공 값이 10% 증가합니다.	   
Item_Info[97] = {Type = ITEM_TYPE_INCREASE_ENCHANT_VALUE, Index = 3, Name="강화 성공 값 증가", Grade = ITEM_GRADE_RARE}            --강화 성공 값이 15% 증가합니다.	   
Item_Info[98] = {Type = ITEM_TYPE_INCREASE_ENCHANT_VALUE, Index = 4, Name="강화 성공 값 증가", Grade = ITEM_GRADE_RARE}            --강화 성공 값이 20% 증가합니다.	   
Item_Info[99] = {Type = ITEM_TYPE_INCREASE_ENCHANT_VALUE, Index = 5, Name="강화 성공 값 증가", Grade = ITEM_GRADE_RARE}            --강화 성공 값이 25% 증가합니다.	   
Item_Info[100] = {Type = ITEM_TYPE_INCREASE_ENCHANT_VALUE, Index = 6, Name="강화 성공 값 증가", Grade = ITEM_GRADE_LEGEND}            --강화 성공 값이 30% 증가합니다.	   
--------------------------------------------------
-- 크리티컬 발생 확률
--------------------------------------------------

Item_Info[101] = {Type = ITEM_TYPE_CRITICAL_PROBABILITY, Index = 1, Name="크리티컬 발생 확률", Grade = ITEM_GRADE_NORMAL}            --크리티컬 발생 확률이 3% 증가합니다.	   
Item_Info[102] = {Type = ITEM_TYPE_CRITICAL_PROBABILITY, Index = 2, Name="크리티컬 발생 확률", Grade = ITEM_GRADE_NORMAL}            --크리티컬 발생 확률이 5% 증가합니다.	   
Item_Info[103] = {Type = ITEM_TYPE_CRITICAL_PROBABILITY, Index = 3, Name="크리티컬 발생 확률", Grade = ITEM_GRADE_RARE}            --크리티컬 발생 확률이 10% 증가합니다.	   
Item_Info[104] = {Type = ITEM_TYPE_CRITICAL_PROBABILITY, Index = 4, Name="크리티컬 발생 확률", Grade = ITEM_GRADE_RARE}            --크리티컬 발생 확률이 15% 증가합니다.	   
Item_Info[105] = {Type = ITEM_TYPE_CRITICAL_PROBABILITY, Index = 5, Name="크리티컬 발생 확률", Grade = ITEM_GRADE_RARE}            --크리티컬 발생 확률이 20% 증가합니다.	   
Item_Info[106] = {Type = ITEM_TYPE_CRITICAL_PROBABILITY, Index = 6, Name="크리티컬 발생 확률", Grade = ITEM_GRADE_LEGEND}            --크리티컬 발생 확률이 30% 증가합니다.	   
--------------------------------------------------
-- 강화성공률 증가
--------------------------------------------------

Item_Info[107] = {Type = ITEM_TYPE_INCREASE_ENCHANT_SUCCESS, Index = 1, Name="강화성공률", Grade = ITEM_GRADE_NORMAL}            --강화성공률이 3% 증가합니다.	   
Item_Info[108] = {Type = ITEM_TYPE_INCREASE_ENCHANT_SUCCESS, Index = 2, Name="강화성공률", Grade = ITEM_GRADE_NORMAL}            --강화성공률이 5% 증가합니다.	   
Item_Info[109] = {Type = ITEM_TYPE_INCREASE_ENCHANT_SUCCESS, Index = 3, Name="강화성공률", Grade = ITEM_GRADE_RARE}            --강화성공률이 10% 증가합니다.	   
Item_Info[110] = {Type = ITEM_TYPE_INCREASE_ENCHANT_SUCCESS, Index = 4, Name="강화성공률", Grade = ITEM_GRADE_RARE}            --강화성공률이 15% 증가합니다.	   
Item_Info[111] = {Type = ITEM_TYPE_INCREASE_ENCHANT_SUCCESS, Index = 5, Name="강화성공률", Grade = ITEM_GRADE_RARE}            --강화성공률이 20% 증가합니다.	   
Item_Info[112] = {Type = ITEM_TYPE_INCREASE_ENCHANT_SUCCESS, Index = 6, Name="강화성공률", Grade = ITEM_GRADE_LEGEND}            --강화성공률이 30% 증가합니다.	   
--------------------------------------------------
-- 회피율 증가
--------------------------------------------------

Item_Info[113] = {Type = ITEM_TYPE_EVASION_RATE_STAT, Index = 1, Name="회피율", Grade = ITEM_GRADE_NORMAL}            --회피율이 3% 증가합니다.	   
Item_Info[114] = {Type = ITEM_TYPE_EVASION_RATE_STAT, Index = 2, Name="회피율", Grade = ITEM_GRADE_NORMAL}            --회피율이 5% 증가합니다.	   
Item_Info[115] = {Type = ITEM_TYPE_EVASION_RATE_STAT, Index = 3, Name="회피율", Grade = ITEM_GRADE_RARE}            --회피율이 10% 증가합니다.	   
Item_Info[116] = {Type = ITEM_TYPE_EVASION_RATE_STAT, Index = 4, Name="회피율", Grade = ITEM_GRADE_RARE}            --회피율이 15% 증가합니다.	   
Item_Info[117] = {Type = ITEM_TYPE_EVASION_RATE_STAT, Index = 5, Name="회피율", Grade = ITEM_GRADE_RARE}            --회피율이 20% 증가합니다.	   
Item_Info[118] = {Type = ITEM_TYPE_EVASION_RATE_STAT, Index = 6, Name="회피율", Grade = ITEM_GRADE_LEGEND}            --회피율이 30% 증가합니다.	   
--------------------------------------------------
-- 최대 HP 증가
--------------------------------------------------

Item_Info[119] = {Type = ITEM_TYPE_HP_INCREASE, Index = 1, Name="최대 HP 증가", Grade = ITEM_GRADE_RARE}            --최대 HP가 100 증가합니다.	   
Item_Info[120] = {Type = ITEM_TYPE_HP_INCREASE, Index = 2, Name="최대 HP 증가", Grade = ITEM_GRADE_LEGEND}            --최대 HP가 200 증가합니다.	   
Item_Info[121] = {Type = ITEM_TYPE_HP_INCREASE, Index = 3, Name="최대 HP 증가", Grade = ITEM_GRADE_LEGEND}            --최대 HP가 300 증가합니다.	   
--------------------------------------------------
-- 삽탄 증가
--------------------------------------------------
	   
Item_Info[122] = {Type = ITEM_TYPE_AMMO_IN_CLIP_INCREASE, Index = 1, Name="삽탄 증가", Grade = ITEM_GRADE_LEGEND}            --삽탄이 100% 증가합니다.	   
Item_Info[123] = {Type = ITEM_TYPE_AMMO_IN_CLIP_INCREASE, Index = 2, Name="삽탄 증가", Grade = ITEM_GRADE_LEGEND}            --삽탄이 150% 증가합니다.	 

--------------------------------------------------
-- 크리티컬 배수
--------------------------------------------------

Item_Info[124] = {Type = ITEM_TYPE_CRITICAL_DAMAGE_MULTIPLE, Index = 1, Name="크리티컬 배수 증가", Grade = ITEM_GRADE_LEGEND}            --크리티컬 배수가 0.25배 증가합니다.   
Item_Info[125] = {Type = ITEM_TYPE_CRITICAL_DAMAGE_MULTIPLE, Index = 2, Name="크리티컬 배수 증가", Grade = ITEM_GRADE_LEGEND}          --크리티컬 배수가 0.50배 증가합니다.	   


--------------------------------------------------
-- 추가 무기
--------------------------------------------------
Item_Info[126] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 13, Name="ASG-12_v2", Grade = ITEM_GRADE_RARE}            --ASG-12_v2을 획득합니다.	   
Item_Info[127] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 36, Name="SOCOM-K", Grade = ITEM_GRADE_NORMAL}            --Socom-K을 획득합니다.	 
Item_Info[128] = {Type = ITEM_TYPE_MELEE_WEAPON, Index = 3079, Name="Long Sword", Grade = ITEM_GRADE_RARE}            --Long Sword을 획득합니다.	 

--------------------------------------------------
-- 2차 추가 무기(5월 16일 업데이트)
--------------------------------------------------  
Item_Info[129] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 2848, Name="NA-94", Grade = ITEM_GRADE_RARE}            --NA-94 획득합니다.	 
Item_Info[130] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 2959, Name="GSR-6", Grade = ITEM_GRADE_RARE}            --GSR-6 획득합니다.
Item_Info[131] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 3104, Name="SG-12", Grade = ITEM_GRADE_RARE}            --SG-12 획득합니다.	 
Item_Info[132] = {Type = ITEM_TYPE_SECONDARY_WEAPON, Index = 1831, Name="PNR-10", Grade = ITEM_GRADE_LEGEND}            --PNR-10 획득합니다.
Item_Info[133] = {Type = ITEM_TYPE_MELEE_WEAPON, Index = 2622, Name="전기충격기", Grade = ITEM_GRADE_RARE}            --전기충격기 획득합니다.

--------------------------------------------------
-- 퍽(ATTACK) 서브타입1
--------------------------------------------------

Item_Info[200] = {Type = ITEM_TYPE_PERK, Index = 1, Name="특수총(대미지)", Grade = ITEM_GRADE_SPECIAL}              --특수총(대미지) 퍽
Item_Info[201] = {Type = ITEM_TYPE_PERK, Index = 2, Name="돌격소총(대미지)", Grade = ITEM_GRADE_SPECIAL}            --돌격소총(대미지) 퍽
Item_Info[202] = {Type = ITEM_TYPE_PERK, Index = 3, Name="저격소총(대미지)", Grade = ITEM_GRADE_SPECIAL}            --저격소총(대미지) 퍽
Item_Info[203] = {Type = ITEM_TYPE_PERK, Index = 4, Name="보조무기(대미지)", Grade = ITEM_GRADE_SPECIAL}            --보조무기(대미지) 퍽
Item_Info[204] = {Type = ITEM_TYPE_PERK, Index = 5, Name="근접무기(대미지)", Grade =ITEM_GRADE_SPECIAL}            --근접무기(대미지) 퍽

--------------------------------------------------
-- 퍽(CHANCE) 서브타입3	
--------------------------------------------------

Item_Info[205] = {Type = ITEM_TYPE_PERK, Index = 6, Name="크리티컬 발생 확률", Grade = ITEM_GRADE_SPECIAL}              --크리티컬 발생 확률
Item_Info[206] = {Type = ITEM_TYPE_PERK, Index = 7, Name="강화성공률", Grade = ITEM_GRADE_SPECIAL}                      --강화성공률
Item_Info[207] = {Type = ITEM_TYPE_PERK, Index = 8, Name="레어선택지 등장확률", Grade = ITEM_GRADE_SPECIAL}             --레어선택지 등장확률
Item_Info[208] = {Type = ITEM_TYPE_PERK, Index = 9, Name="회피율", Grade = ITEM_GRADE_SPECIAL}                          --회피율

--------------------------------------------------
-- 퍽(SPECIAL) 서브타입2
--------------------------------------------------

Item_Info[209] = {Type = ITEM_TYPE_PERK, Index = 10, Name="최대HP 증가", Grade = ITEM_GRADE_SPECIAL}                    --최대HP 증가
Item_Info[210] = {Type = ITEM_TYPE_PERK, Index = 11, Name="삽탄 증가", Grade = ITEM_GRADE_SPECIAL}                      --삽탄 증가
Item_Info[211] = {Type = ITEM_TYPE_PERK, Index = 12, Name="크리티컬 배수 증가", Grade = ITEM_GRADE_SPECIAL}             --크리티컬 배수 증가
Item_Info[212] = {Type = ITEM_TYPE_PERK, Index = 13, Name="버프지속 시간 증가", Grade = ITEM_GRADE_SPECIAL}             --버프지속 시간

----------------------------------------------------------------------------------------------------
-- 아이템 정보를 넘겨준다.
----------------------------------------------------------------------------------------------------
function GetItemInfo(nItemInfoIndex)

	nType = ITEM_TYPE_NOTHING
	nGrade = ITEM_GRADE_NOTHING
	nIndex = -1
	strName = ""

	if Item_Info[nItemInfoIndex] ~= nil then

		nType = Item_Info[nItemInfoIndex].Type
		nIndex = Item_Info[nItemInfoIndex].Index
		strName = Item_Info[nItemInfoIndex].Name
		nGrade = Item_Info[nItemInfoIndex].Grade

	end

	return nType, nIndex, strName, nGrade
end

----------------------------------------------------------------------------------------------------
-- 무기ID로 Item_Info의 인덱스를 넘겨준다.
----------------------------------------------------------------------------------------------------
function GetItemInfoIndexByWeaponID(nWeaponID)

    for k, v in pairs(Item_Info) do

        if v.Index == nWeaponID and (v.Type == ITEM_TYPE_PRI_WEAPON or v.Type == ITEM_TYPE_SECONDARY_WEAPON or v.Type == ITEM_TYPE_MELEE_WEAPON) then
            return k;
        end
       end

    return -1
end


----------------------------------------------------------------------------------------------------------------
-- 희귀 보상 확률 증가의 대상이 되는 보상군의 갯수를 넘겨준다. ITEM_TYPE_INCREASE_RARE_REWARD : 희귀 보상 증가 획득시 호출.
----------------------------------------------------------------------------------------------------------------
function GetRareRewarCount()
	
	nCount = 1	

	return nCount
end

----------------------------------------------------------------------------------------------------------------
-- 희귀 보상 확률 증가의 대상이 되는 보상군의 이름을 넘겨준다. ITEM_TYPE_INCREASE_RARE_REWARD : 희귀 보상 증가 획득시 호출.
----------------------------------------------------------------------------------------------------------------
function GetRareRewardName(nIndex)

	strName = ""

	if nIndex == 1		then
		strName = "RewardType_Rare"
	end
	
	return strName
end


----------------------------------------------------------------------------------------------------
-- 총알 정보가 설정되어 있는 배열.
----------------------------------------------------------------------------------------------------
Ammo_Info = {}

Ammo_Info[1] =
{
	Model = "sa_weapons/models/20_tv/sv_rifle_magazine_3p.ltb",
	Skin = "sa_weapons/SKINS/tv/sv_rifle_magazine_3p.dtx",
}

----------------------------------------------------------------------------------------------------
-- 상자 정보가 설정되어 있는 배열.
----------------------------------------------------------------------------------------------------
Box_Info = {}

Box_Info[1] =
{
	Model = "sa_props/models/survival_xmas/xmas_box.ltb",
	Skin = "sa_props/skins/survival_xmas/present_box_01a.dtx",
}

----------------------------------------------------------------------------------------------------
-- 회복킷 정보가 설정되어 있는 배열.
----------------------------------------------------------------------------------------------------
HPKit_Info = {}
HPKit_Info[3064] =
{
	Model = "sa_weapons/models/20_tv/sv_first_aid_b_3p.ltb",
	Skin = "sa_weapons/SKINS/tv/sv_first_aid_orange.dtx",
}
HPKit_Info[2067] =
{
	Model = "sa_weapons/models/20_tv/sv_first_aid_b_3p.ltb",
	Skin = "sa_weapons/SKINS/tv/sv_first_aid_green.dtx",
}

----------------------------------------------------------------------------------------------------
-- 스킬 타입을 정의한다. 클라이언트와 같아야한다.
----------------------------------------------------------------------------------------------------
SKILL_TYPE_NOTHING = 0
SKILL_TYPE_AUTO_AIM = 1						-- 오토에임
SKILL_TYPE_RECOILLESS = 2					-- 무반동
SKILL_TYPE_INFINITE_AMMO = 3					-- 무한탄창
SKILL_TYPE_INVINCIBLE = 4					-- 무적
SKILL_TYPE_HP_RECOVERY = 5					-- HP회복
SKILL_TYPE_ATTACK_POWER = 6					-- 공격력
SKILL_TYPE_ACCURACY_RATE = 7					-- 명중률 100%
SKILL_TYPE_CRITICAL = 8						-- 크리티컬

----------------------------------------------------------------------------------------------------
-- 스킬에 따른 추가 값.
----------------------------------------------------------------------------------------------------
SKILL_ATTACK_POWER_MULTIPLE = 2					-- 공격력 스킬의 배수
SKILL_CRITICAL_DAMAGE_MULTIPLE = 2				-- 크리티컬 획득 시 대미지 배수

----------------------------------------------------------------------------------------------------
-- 스킬 획득시 유지되는 시간을 넘겨준다.
----------------------------------------------------------------------------------------------------
function GetSkillActiveTime( nSkillType )

	nActiveTime = 10	

	if nSkillType == SKILL_TYPE_AUTO_AIM	then
		nActiveTime = 10

	elseif nSkillType == SKILL_TYPE_RECOILLESS	then
		nActiveTime = 10

	elseif nSkillType == SKILL_TYPE_INFINITE_AMMO	then
		nActiveTime = 7

	elseif nSkillType == SKILL_TYPE_INVINCIBLE	then
		nActiveTime = 7
	
	elseif nSkillType == SKILL_TYPE_HP_RECOVERY	then
		nActiveTime = 10
	
	elseif nSkillType == SKILL_TYPE_ATTACK_POWER	then
		nActiveTime = 10	

	elseif nSkillType == SKILL_TYPE_ACCURACY_RATE	then
		nActiveTime = 10

	elseif nSkillType == SKILL_TYPE_CRITICAL	then
		nActiveTime = 10
		
	end

	return nActiveTime
end

----------------------------------------------------------------------------------------------------
-- 전투 클리어 보상이 설정되어 있는 배열.
-- 서버로 이전하면서 삭제
----------------------------------------------------------------------------------------------------
Reward_Info = {}
----------------------------------------------------------------------------------------------------
-- 보상 정보가 저장되어 있는 배열 이름을 반환한다.
----------------------------------------------------------------------------------------------------
function GetRewardListName()

	strRewardListName = "Reward_Info"

	return strRewardListName
end

----------------------------------------------------------------------------------------------------
-- 보상 정보가 저장되어 있는 배열의 갯수를 반환한다. 배열변수 앞에 #을 붙이면 갯수가 반환된다.
----------------------------------------------------------------------------------------------------
function GetRewardListCount()

	nCount = #Reward_Info

	return nCount
end

----------------------------------------------------------------------------------------------------
-- 보상을 위한 아이템 인포 인덱스를 반환한다.
-- 보상 군 확장 (자율)가능.
-- 아이템 정의는 총 3단계로 진행
-- 1. 카드(기능) 정의
-- 2. 아이템 형태 정의
-- 3. 리워드 정의
-- 4. 리워드 타입 정의
----------------------------------------------------------------------------------------------------
function GetItemInfoIndexForReward( strRewardType )

	nItemInfoIndex = -1

	if strRewardType == "RewardType_Normal"	then

		nRandom = math.random( 1, #RewardType_Normal )
		nItemInfoIndex = RewardType_Normal[nRandom]

	elseif strRewardType == "RewardType_Rare" then

		nRandom = math.random( 1, #RewardType_Rare )
		nItemInfoIndex = RewardType_Rare[nRandom]
		
	elseif strRewardType == "RewardType_Legend" then

		nRandom = math.random( 1, #RewardType_Legend )
		nItemInfoIndex = RewardType_Legend[nRandom]

	end

	return nItemInfoIndex
end

----------------------------------------------------------------------------------------------------
-- 아이템 스폰 정보가 설정되어 있는 배열.
-- 나중에는 패시브만 등록 해야 함.
-- 맵 배치 스킬
----------------------------------------------------------------------------------------------------
Item_Spawn_Info = {}

Item_Spawn_Info[1] = {}
Item_Spawn_Info[1].MaxScore = 100
Item_Spawn_Info[1].MinScor = 0
Item_Spawn_Info[1].MaxSpawnPointCount = 3
Item_Spawn_Info[1].MinSpawnPointCount = 2
Item_Spawn_Info[1].ItemInfoCount = 8

Item_Spawn_Info[1].ItemInfo_1 = 24
Item_Spawn_Info[1].Probability_1 = 10

Item_Spawn_Info[1].ItemInfo_2 = 25
Item_Spawn_Info[1].Probability_2 = 10

Item_Spawn_Info[1].ItemInfo_3 = 26
Item_Spawn_Info[1].Probability_3 = 10

Item_Spawn_Info[1].ItemInfo_4 = 27
Item_Spawn_Info[1].Probability_4 = 10

Item_Spawn_Info[1].ItemInfo_5 = 28
Item_Spawn_Info[1].Probability_5 = 0

Item_Spawn_Info[1].ItemInfo_6 = 29
Item_Spawn_Info[1].Probability_6 = 10

Item_Spawn_Info[1].ItemInfo_7 = 30
Item_Spawn_Info[1].Probability_7 = 10

Item_Spawn_Info[1].ItemInfo_8 = 31
Item_Spawn_Info[1].Probability_8 = 10


Item_Spawn_Info[2] = {}
Item_Spawn_Info[2].MaxScore = 200
Item_Spawn_Info[2].MinScor = 101
Item_Spawn_Info[2].MaxSpawnPointCount = 4
Item_Spawn_Info[2].MinSpawnPointCount = 3
Item_Spawn_Info[2].ItemInfoCount = 8

Item_Spawn_Info[2].ItemInfo_1 = 24
Item_Spawn_Info[2].Probability_1 = 10

Item_Spawn_Info[2].ItemInfo_2 = 25
Item_Spawn_Info[2].Probability_2 = 10

Item_Spawn_Info[2].ItemInfo_3 = 26
Item_Spawn_Info[2].Probability_3 = 10

Item_Spawn_Info[2].ItemInfo_4 = 27
Item_Spawn_Info[2].Probability_4 = 10

Item_Spawn_Info[2].ItemInfo_5 = 28
Item_Spawn_Info[2].Probability_5 = 0

Item_Spawn_Info[2].ItemInfo_6 = 29
Item_Spawn_Info[2].Probability_6 = 10

Item_Spawn_Info[2].ItemInfo_7 = 30
Item_Spawn_Info[2].Probability_7 = 10

Item_Spawn_Info[2].ItemInfo_8 = 31
Item_Spawn_Info[2].Probability_8 = 10


Item_Spawn_Info[3] = {}
Item_Spawn_Info[3].MaxScore = 300
Item_Spawn_Info[3].MinScor = 201
Item_Spawn_Info[3].MaxSpawnPointCount = 5
Item_Spawn_Info[3].MinSpawnPointCount = 4
Item_Spawn_Info[3].ItemInfoCount = 8

Item_Spawn_Info[3].ItemInfo_1 = 24
Item_Spawn_Info[3].Probability_1 = 10

Item_Spawn_Info[3].ItemInfo_2 = 25
Item_Spawn_Info[3].Probability_2 = 10

Item_Spawn_Info[3].ItemInfo_3 = 26
Item_Spawn_Info[3].Probability_3 = 10

Item_Spawn_Info[3].ItemInfo_4 = 27
Item_Spawn_Info[3].Probability_4 = 10

Item_Spawn_Info[3].ItemInfo_5 = 28
Item_Spawn_Info[3].Probability_5 = 0

Item_Spawn_Info[3].ItemInfo_6 = 29
Item_Spawn_Info[3].Probability_6 = 10

Item_Spawn_Info[3].ItemInfo_7 = 30
Item_Spawn_Info[3].Probability_7 = 10

Item_Spawn_Info[3].ItemInfo_8 = 31
Item_Spawn_Info[3].Probability_8 = 10



Item_Spawn_Info[4] = {}
Item_Spawn_Info[4].MaxScore = 1000
Item_Spawn_Info[4].MinScor = 301
Item_Spawn_Info[4].MaxSpawnPointCount = 6
Item_Spawn_Info[4].MinSpawnPointCount = 4
Item_Spawn_Info[4].ItemInfoCount = 8

Item_Spawn_Info[4].ItemInfo_1 = 24
Item_Spawn_Info[4].Probability_1 = 10

Item_Spawn_Info[4].ItemInfo_2 = 25
Item_Spawn_Info[4].Probability_2 = 10

Item_Spawn_Info[4].ItemInfo_3 = 26
Item_Spawn_Info[4].Probability_3 = 10

Item_Spawn_Info[4].ItemInfo_4 = 27
Item_Spawn_Info[4].Probability_4 = 10

Item_Spawn_Info[4].ItemInfo_5 = 28
Item_Spawn_Info[4].Probability_5 = 0

Item_Spawn_Info[4].ItemInfo_6 = 29
Item_Spawn_Info[4].Probability_6 = 10

Item_Spawn_Info[4].ItemInfo_7 = 30
Item_Spawn_Info[4].Probability_7 = 10

Item_Spawn_Info[4].ItemInfo_8 = 31
Item_Spawn_Info[4].Probability_8 = 10


----------------------------------------------------------------------------------------------------
-- 아이템 스폰 정보가 저장되어 있는 배열 이름을 반환한다.
----------------------------------------------------------------------------------------------------
function GetItemSpawnInfoListName()

	strItemSpawnInfoListName = "Item_Spawn_Info"

	return strItemSpawnInfoListName
end

----------------------------------------------------------------------------------------------------
-- 아이템 스폰 정보가 저장되어 있는 배열의 갯수를 반환한다. 배열변수 앞에 #을 붙이면 갯수가 반환된다.
----------------------------------------------------------------------------------------------------
function GetItemSpawnInfoListCount()

	nCount = #Item_Spawn_Info

	return nCount
end

----------------------------------------------------------------------------------------------------
-- 무기 타입을 정의한다. 주무기, 보조무기, 근접무기 외에 세부적으로 나누기 위해 정의한다. 클라이언트와 같아야한다.
----------------------------------------------------------------------------------------------------
WEAPON_TYPE_NOTHING = 0
WEAPON_TYPE_PRIMARY_1 = 1  -- 샷건, 특수무기
WEAPON_TYPE_PRIMARY_2 = 2  -- 라이플, SMG
WEAPON_TYPE_PRIMARY_3 = 3  -- 스나이퍼
WEAPON_TYPE_SECONDARY = 4
WEAPON_TYPE_MELEE = 5
WEAPON_TYPE_THROW = 6

----------------------------------------------------------------------------------------------------
-- 무기 정보를 설정한다. Weapon_Info 배열 인덱스 값([4])과 Item_Info에 있는 Index 값(Index = 4)을 같은 값으로 해야한다.
-- 현재 무기 아이콘은 weapon스크립트의 아이콘을 사용하고 있는데... 사용형 무기 같은 경우 인벤토리에서 정사각 아이콘으로 표시되기 때문에 따로 아이콘 요소를 추가함.
-- Item_Info[1] = {Type = ITEM_TYPE_PRI_WEAPON, Index = 4}, Weapon_Info[4]
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

 
 
--------------------------------------------------
-- 주무기 획득 카드
--------------------------------------------------

Weapon_Info = {}

Weapon_Info[4] = {}
Weapon_Info[4].SubType = WEAPON_TYPE_PRIMARY_2
Weapon_Info[4].WeaponID = 4
Weapon_Info[4].FireSpeed = 0.4
Weapon_Info[4].AccuracyRate = 5
Weapon_Info[4].Description = "M4A1을 획득합니다."
Weapon_Info[4].Icon = "sa_interface/weapon/ClassicM4A1_IN.DTX"
	   
Weapon_Info[9] = {}
Weapon_Info[9].SubType = WEAPON_TYPE_PRIMARY_2
Weapon_Info[9].WeaponID = 9
Weapon_Info[9].FireSpeed = 0.4
Weapon_Info[9].AccuracyRate = 5
Weapon_Info[9].Description = "AK47을 획득합니다."
Weapon_Info[9].Icon = "sa_interface/weapon/ak47_in.dtx"
	   
Weapon_Info[22] = {}
Weapon_Info[22].SubType = WEAPON_TYPE_PRIMARY_3
Weapon_Info[22].WeaponID = 22
Weapon_Info[22].FireSpeed = 0.4
Weapon_Info[22].AccuracyRate = 5
Weapon_Info[22].Description = "TRG21을 획득합니다."
Weapon_Info[22].Icon = "sa_interface/weapon/trg21_in.dtx"
	   
Weapon_Info[1107] = {}
Weapon_Info[1107].SubType = WEAPON_TYPE_PRIMARY_1
Weapon_Info[1107].WeaponID = 1107
Weapon_Info[1107].FireSpeed = 0.4
Weapon_Info[1107].AccuracyRate = 5
Weapon_Info[1107].Description = "lightning gatling을 획득합니다."
Weapon_Info[1107].Icon = "sa_interface/weapon/S_Lightning_Gatling_in.dtx"
	   
Weapon_Info[2257] = {}
Weapon_Info[2257].SubType = WEAPON_TYPE_PRIMARY_1
Weapon_Info[2257].WeaponID = 2257
Weapon_Info[2257].FireSpeed = 0.4
Weapon_Info[2257].AccuracyRate = 5
Weapon_Info[2257].Description = "sg_870_v3을 획득합니다."
Weapon_Info[2257].Icon = "sa_interface/weapon/sg_870_v3_in.dtx"
	   
Weapon_Info[3067] = {}
Weapon_Info[3067].SubType = WEAPON_TYPE_PRIMARY_2
Weapon_Info[3067].WeaponID = 3067
Weapon_Info[3067].FireSpeed = 0.4
Weapon_Info[3067].AccuracyRate = 5
Weapon_Info[3067].Description = "AK103(IS)_관통탄을 획득합니다."
Weapon_Info[3067].Icon = "sa_interface/weapon/ak103(is)_goblin_in.dtx"
	   
Weapon_Info[744] = {}
Weapon_Info[744].SubType = WEAPON_TYPE_PRIMARY_1
Weapon_Info[744].WeaponID = 744
Weapon_Info[744].FireSpeed = 0.4
Weapon_Info[744].AccuracyRate = 5
Weapon_Info[744].Description = "유탄발사기을 획득합니다."
Weapon_Info[744].Icon = "sa_interface/weapon/S_Rocket_launcher_in.dtx"
	   
Weapon_Info[1105] = {}
Weapon_Info[1105].SubType = WEAPON_TYPE_PRIMARY_1
Weapon_Info[1105].WeaponID = 1105
Weapon_Info[1105].FireSpeed = 0.4
Weapon_Info[1105].AccuracyRate = 5
Weapon_Info[1105].Description = "로켓런처을 획득합니다."
Weapon_Info[1105].Icon = "sa_interface/weapon/S_Rocket_launcher_in.dtx"
	   
Weapon_Info[3068] = {}
Weapon_Info[3068].SubType = WEAPON_TYPE_PRIMARY_1
Weapon_Info[3068].WeaponID = 3068
Weapon_Info[3068].FireSpeed = 0.4
Weapon_Info[3068].AccuracyRate = 5
Weapon_Info[3068].Description = "화염방사기을 획득합니다."
Weapon_Info[3068].Icon = "sa_interface/weapon/flamethrower_in.dtx"
	   
Weapon_Info[1175] = {}
Weapon_Info[1175].SubType = WEAPON_TYPE_PRIMARY_1
Weapon_Info[1175].WeaponID = 1175
Weapon_Info[1175].FireSpeed = 0.4
Weapon_Info[1175].AccuracyRate = 5
Weapon_Info[1175].Description = "MP7을 획득합니다."
Weapon_Info[1175].Icon = "sa_interface/weapon/MP7_in.dtx"
	   
Weapon_Info[13] = {}
Weapon_Info[13].SubType = WEAPON_TYPE_PRIMARY_1
Weapon_Info[13].WeaponID = 13
Weapon_Info[13].FireSpeed = 0.4
Weapon_Info[13].AccuracyRate = 5
Weapon_Info[13].Description = "ASG-12_v2을 획득합니다."
Weapon_Info[13].Icon = "sa_interface/weapon/asg12_v2_in.dtx"
	   
Weapon_Info[36] = {}
Weapon_Info[36].SubType = WEAPON_TYPE_PRIMARY_3
Weapon_Info[36].WeaponID = 36
Weapon_Info[36].FireSpeed = 0.4
Weapon_Info[36].AccuracyRate = 5
Weapon_Info[36].Description = "SOCOM-K을 획득합니다."
Weapon_Info[36].Icon = "sa_interface/weapon/SOCOM.dtx"
	   
Weapon_Info[2848] = {}
Weapon_Info[2848].SubType = WEAPON_TYPE_PRIMARY_2
Weapon_Info[2848].WeaponID = 2848
Weapon_Info[2848].FireSpeed = 0.4
Weapon_Info[2848].AccuracyRate = 5
Weapon_Info[2848].Description = "NA-94를 획득합니다."
Weapon_Info[2848].Icon = "sa_interface/weapon/na94_in.dtx"

Weapon_Info[2959] = {}
Weapon_Info[2959].SubType = WEAPON_TYPE_PRIMARY_3
Weapon_Info[2959].WeaponID = 2959
Weapon_Info[2959].FireSpeed = 0.4
Weapon_Info[2959].AccuracyRate = 5
Weapon_Info[2959].Description = "GSR-6를 획득합니다."
Weapon_Info[2959].Icon = "sa_interface/weapon/gsr_6_in.dtx"		   

Weapon_Info[3104] = {}
Weapon_Info[3104].SubType = WEAPON_TYPE_PRIMARY_1
Weapon_Info[3104].WeaponID = 3104
Weapon_Info[3104].FireSpeed = 0.4
Weapon_Info[3104].AccuracyRate = 5
Weapon_Info[3104].Description = "SG-12를 획득합니다."
Weapon_Info[3104].Icon = "sa_interface/weapon/saiga_12_in.dtx"		   
--------------------------------------------------
-- 보조무기 획득 카드
--------------------------------------------------

Weapon_Info[1] = {}
Weapon_Info[1].SubType = WEAPON_TYPE_SECONDARY
Weapon_Info[1].WeaponID = 1
Weapon_Info[1].FireSpeed = 0.4
Weapon_Info[1].AccuracyRate = 5
Weapon_Info[1].Description = "D_Eagle을 획득합니다."
Weapon_Info[1].Icon = "sa_interface/weapon/d_eagle_in.dtx"
	   
Weapon_Info[1958] = {}
Weapon_Info[1958].SubType = WEAPON_TYPE_SECONDARY
Weapon_Info[1958].WeaponID = 1958
Weapon_Info[1958].FireSpeed = 0.4
Weapon_Info[1958].AccuracyRate = 5
Weapon_Info[1958].Description = "G18을 획득합니다."
Weapon_Info[1958].Icon = "sa_interface/weapon/G18_in.dtx"
	   
Weapon_Info[1588] = {}
Weapon_Info[1588].SubType = WEAPON_TYPE_SECONDARY
Weapon_Info[1588].WeaponID = 1588
Weapon_Info[1588].FireSpeed = 0.4
Weapon_Info[1588].AccuracyRate = 5
Weapon_Info[1588].Description = "C.USP(S) Scorpion을 획득합니다."
Weapon_Info[1588].Icon = "sa_interface/weapon/ak47_in.dtx"
	   
Weapon_Info[2] = {}
Weapon_Info[2].SubType = WEAPON_TYPE_SECONDARY
Weapon_Info[2].WeaponID = 2
Weapon_Info[2].FireSpeed = 0.4
Weapon_Info[2].AccuracyRate = 5
Weapon_Info[2].Description = "C.Anaconda을 획득합니다."
Weapon_Info[2].Icon = "sa_interface/weapon/c_anaconda_in.dtx"
	 
Weapon_Info[1831] = {}
Weapon_Info[1831].SubType = WEAPON_TYPE_SECONDARY
Weapon_Info[1831].WeaponID = 1831
Weapon_Info[1831].FireSpeed = 0.4
Weapon_Info[1831].AccuracyRate = 5
Weapon_Info[1831].Description = "PNR-10을 획득합니다."
Weapon_Info[1831].Icon = "sa_interface/weapon/pnr10_in.dtx"
	 
--------------------------------------------------
-- 근접무기 획득 카드
--------------------------------------------------

Weapon_Info[28] = {}
Weapon_Info[28].SubType = WEAPON_TYPE_MELEE
Weapon_Info[28].WeaponID = 28
Weapon_Info[28].FireSpeed = 0.4
Weapon_Info[28].AccuracyRate = 5
Weapon_Info[28].Description = "Gurkhan Knife을 획득합니다."
Weapon_Info[28].Icon = "sa_interface/weapon/rare_gurkha_in.dtx.dtx"
	   
Weapon_Info[48] = {}
Weapon_Info[48].SubType = WEAPON_TYPE_MELEE
Weapon_Info[48].WeaponID = 48
Weapon_Info[48].FireSpeed = 0.4
Weapon_Info[48].AccuracyRate = 5
Weapon_Info[48].Description = "AXE Knife을 획득합니다."
Weapon_Info[48].Icon = "sa_interface/weapon/golden_axe_in.dtx"
	   
Weapon_Info[49] = {}
Weapon_Info[49].SubType = WEAPON_TYPE_MELEE
Weapon_Info[49].WeaponID = 49
Weapon_Info[49].FireSpeed = 0.4
Weapon_Info[49].AccuracyRate = 5
Weapon_Info[49].Description = "Tiger Stripe을 획득합니다."
Weapon_Info[49].Icon = "sa_interface/weapon/tiger_stripe_in.dtx"
	   
Weapon_Info[0] = {}
Weapon_Info[0].SubType = WEAPON_TYPE_MELEE
Weapon_Info[0].WeaponID = 0
Weapon_Info[0].FireSpeed = 0.4
Weapon_Info[0].AccuracyRate = 5
Weapon_Info[0].Description = "Knife을 획득합니다."
Weapon_Info[0].Icon = "sa_interface/weapon/machete_in.dtx"
	   
Weapon_Info[3079] = {}
Weapon_Info[3079].SubType = WEAPON_TYPE_MELEE
Weapon_Info[3079].WeaponID = 3079
Weapon_Info[3079].FireSpeed = 0.4
Weapon_Info[3079].AccuracyRate = 5
Weapon_Info[3079].Description = "Long Sword을 획득합니다."
Weapon_Info[3079].Icon = "sa_interface/weapon/LongSword_in.dtx"

Weapon_Info[2622] = {}
Weapon_Info[2622].SubType = WEAPON_TYPE_MELEE
Weapon_Info[2622].WeaponID = 2622
Weapon_Info[2622].FireSpeed = 0.4
Weapon_Info[2622].AccuracyRate = 5
Weapon_Info[2622].Description = "전기충격기를 획득합니다."
Weapon_Info[2622].Icon = "sa_interface/weapon/tase_in.dtx"
	   
Weapon_Info[3065] = {}
Weapon_Info[3065].SubType = WEAPON_TYPE_THROW
Weapon_Info[3065].WeaponID = 3065
Weapon_Info[3065].FireSpeed = 0.4
Weapon_Info[3065].AccuracyRate = 5
Weapon_Info[3065].Description = "G400을 획득합니다."
Weapon_Info[3065].Icon = "sa_interface/weapon/machete_in.dtx"
	   
--------------------------------------------------
-- 탄창 획득 카드
--------------------------------------------------

	   
--------------------------------------------------
-- 탄약통 획득 카드
--------------------------------------------------

Weapon_Info[3066] = {}
Weapon_Info[3066].SubType = WEAPON_TYPE_MELEE
Weapon_Info[3066].WeaponID = 3066
Weapon_Info[3066].FireSpeed = 0.4
Weapon_Info[3066].AccuracyRate = 5
Weapon_Info[3066].Description = "탄약통을 획득합니다."
Weapon_Info[3066].Icon = "sa_interface2/hud/elevator/Icon/RG_Cartridge.dtx"
	   
--------------------------------------------------
-- 회복킷
--------------------------------------------------

Weapon_Info[3064] = {}
Weapon_Info[3064].SubType = WEAPON_TYPE_MELEE
Weapon_Info[3064].WeaponID = 3064
Weapon_Info[3064].FireSpeed = 0.4
Weapon_Info[3064].AccuracyRate = 5
Weapon_Info[3064].Description = "회복키트을 획득합니다."
Weapon_Info[3064].Icon = "sa_interface2/hud/elevator/Icon/RG_survival_kit.dtx"
	   
--------------------------------------------------
-- 아이템 박스
--------------------------------------------------

	   
--------------------------------------------------
-- 스킬 정보가 설정되어 있는 배열.
--------------------------------------------------

Skill_Info = {}

Skill_Info[4] = {}
Skill_Info[4].Type = SKILL_TYPE_INVINCIBLE
Skill_Info[4].Model = "sa_props/models/Elevator/Hologram.ltb"
Skill_Info[4].Skin = "sa_props/skins/Elevator/hologram.dtx"
Skill_Info[4].Fx = "Elevator_Buff_Immotal"
Skill_Info[4].Icon = "sa_interface2/hud/elevator/Icon/RG_Buff_Immotal.dtx"
Skill_Info[4].Description = "7초 동안 무적 적용"
	   
Skill_Info[1] = {}
Skill_Info[1].Type = SKILL_TYPE_AUTO_AIM
Skill_Info[1].Model = "sa_props/models/Elevator/Hologram.ltb"
Skill_Info[1].Skin = "sa_props/skins/Elevator/hologram.dtx"
Skill_Info[1].Fx = "Elevator_Buff_Autoaim"
Skill_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Buff_AutoAim.dtx"
Skill_Info[1].Description = "10초 동안 오토에임 적용"
	   
Skill_Info[2] = {}
Skill_Info[2].Type = SKILL_TYPE_RECOILLESS
Skill_Info[2].Model = "sa_props/models/Elevator/Hologram.ltb"
Skill_Info[2].Skin = "sa_props/skins/Elevator/hologram.dtx"
Skill_Info[2].Fx = "Elevator_Buff_NonRecoil"
Skill_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Buff_NonRecoil.dtx"
Skill_Info[2].Description = "10초 동안 무반동 적용"
	   
Skill_Info[3] = {}
Skill_Info[3].Type = SKILL_TYPE_INFINITE_AMMO
Skill_Info[3].Model = "sa_props/models/Elevator/Hologram.ltb"
Skill_Info[3].Skin = "sa_props/skins/Elevator/hologram.dtx"
Skill_Info[3].Fx = "Elevator_Buff_InfiniteAmmo"
Skill_Info[3].Icon = "sa_interface2/hud/elevator/Icon/RG_Buff_InfiniteAmmo.dtx"
Skill_Info[3].Description = "7초 동안 무한탄창 적용"
	   
Skill_Info[5] = {}
Skill_Info[5].Type = SKILL_TYPE_HP_RECOVERY
Skill_Info[5].Model = "sa_props/models/Elevator/Hologram.ltb"
Skill_Info[5].Skin = "sa_props/skins/Elevator/hologram.dtx"
Skill_Info[5].Fx = "Elevator_Buff_HPrecovery"
Skill_Info[5].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_HPRecovery_1.dtx"
Skill_Info[5].Description = "10초 동안 HP회복 적용"
	   
Skill_Info[6] = {}
Skill_Info[6].Type = SKILL_TYPE_ATTACK_POWER
Skill_Info[6].Model = "sa_props/models/Elevator/Hologram.ltb"
Skill_Info[6].Skin = "sa_props/skins/Elevator/hologram.dtx"
Skill_Info[6].Fx = "Elevator_Buff_InfiniteDamage"
Skill_Info[6].Icon = "sa_interface2/hud/elevator/Icon/RG_Buff_InfiniteDamage.dtx"
Skill_Info[6].Description = "10초 동안 공격력 상승 적용"
	   
Skill_Info[7] = {}
Skill_Info[7].Type = SKILL_TYPE_ACCURACY_RATE
Skill_Info[7].Model = "sa_props/models/Elevator/Hologram.ltb"
Skill_Info[7].Skin = "sa_props/skins/Elevator/hologram.dtx"
Skill_Info[7].Fx = "Elevator_Buff_Accincrese"
Skill_Info[7].Icon = "sa_interface2/hud/elevator/Icon/RG_Buff_AccIncrese.dtx"
Skill_Info[7].Description = "10초 동안 명중률 상승 적용"
	   
Skill_Info[8] = {}
Skill_Info[8].Type = SKILL_TYPE_CRITICAL
Skill_Info[8].Model = "sa_props/models/Elevator/Hologram.ltb"
Skill_Info[8].Skin = "sa_props/skins/Elevator/hologram.dtx"
Skill_Info[8].Fx = "Elevator_Buff_Critical"
Skill_Info[8].Icon = "sa_interface2/hud/elevator/Icon/RG_Buff_Critical.dtx"
Skill_Info[8].Description = "10초 동안 크리티컬 상승 적용"
	   
--------------------------------------------------
-- 명중률 정보가 설정되어 있는 배열.
--------------------------------------------------

Accuracy_Rate_Info = {}

Accuracy_Rate_Info[1] = {}
Accuracy_Rate_Info[1].Type = WEAPON_TYPE_PRIMARY_1
Accuracy_Rate_Info[1].Rate = 5
Accuracy_Rate_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Accuracy_Rate_Info[1].Description = "특수총 명중률이 5% 증가합니다."
	   
Accuracy_Rate_Info[2] = {}
Accuracy_Rate_Info[2].Type = WEAPON_TYPE_PRIMARY_1
Accuracy_Rate_Info[2].Rate = 10
Accuracy_Rate_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Accuracy_Rate_Info[2].Description = "특수총 명중률이 10% 증가합니다."
	   
Accuracy_Rate_Info[3] = {}
Accuracy_Rate_Info[3].Type = WEAPON_TYPE_PRIMARY_1
Accuracy_Rate_Info[3].Rate = 15
Accuracy_Rate_Info[3].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Accuracy_Rate_Info[3].Description = "특수총 명중률이 15% 증가합니다."
	   
Accuracy_Rate_Info[4] = {}
Accuracy_Rate_Info[4].Type = WEAPON_TYPE_PRIMARY_1
Accuracy_Rate_Info[4].Rate = 20
Accuracy_Rate_Info[4].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Accuracy_Rate_Info[4].Description = "특수총 명중률이 20% 증가합니다."
	   
Accuracy_Rate_Info[5] = {}
Accuracy_Rate_Info[5].Type = WEAPON_TYPE_PRIMARY_1
Accuracy_Rate_Info[5].Rate = 25
Accuracy_Rate_Info[5].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Accuracy_Rate_Info[5].Description = "특수총 명중률이 25% 증가합니다."
	   
Accuracy_Rate_Info[6] = {}
Accuracy_Rate_Info[6].Type = WEAPON_TYPE_PRIMARY_1
Accuracy_Rate_Info[6].Rate = 30
Accuracy_Rate_Info[6].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Accuracy_Rate_Info[6].Description = "특수총 명중률이 30% 증가합니다."
	   
Accuracy_Rate_Info[7] = {}
Accuracy_Rate_Info[7].Type = WEAPON_TYPE_PRIMARY_2
Accuracy_Rate_Info[7].Rate = 5
Accuracy_Rate_Info[7].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialAcc_1.dtx"
Accuracy_Rate_Info[7].Description = "돌격소총 명중률이 5% 증가합니다."
	   
Accuracy_Rate_Info[8] = {}
Accuracy_Rate_Info[8].Type = WEAPON_TYPE_PRIMARY_2
Accuracy_Rate_Info[8].Rate = 10
Accuracy_Rate_Info[8].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialAcc_1.dtx"
Accuracy_Rate_Info[8].Description = "돌격소총 명중률이 10% 증가합니다."
	   
Accuracy_Rate_Info[9] = {}
Accuracy_Rate_Info[9].Type = WEAPON_TYPE_PRIMARY_2
Accuracy_Rate_Info[9].Rate = 15
Accuracy_Rate_Info[9].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialAcc_1.dtx"
Accuracy_Rate_Info[9].Description = "돌격소총 명중률이 15% 증가합니다."
	   
Accuracy_Rate_Info[10] = {}
Accuracy_Rate_Info[10].Type = WEAPON_TYPE_PRIMARY_2
Accuracy_Rate_Info[10].Rate = 20
Accuracy_Rate_Info[10].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialAcc_1.dtx"
Accuracy_Rate_Info[10].Description = "돌격소총 명중률이 20% 증가합니다."
	   
Accuracy_Rate_Info[11] = {}
Accuracy_Rate_Info[11].Type = WEAPON_TYPE_PRIMARY_2
Accuracy_Rate_Info[11].Rate = 25
Accuracy_Rate_Info[11].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialAcc_1.dtx"
Accuracy_Rate_Info[11].Description = "돌격소총 명중률이 25% 증가합니다."
	   
Accuracy_Rate_Info[12] = {}
Accuracy_Rate_Info[12].Type = WEAPON_TYPE_PRIMARY_2
Accuracy_Rate_Info[12].Rate = 30
Accuracy_Rate_Info[12].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialAcc_1.dtx"
Accuracy_Rate_Info[12].Description = "돌격소총 명중률이 30% 증가합니다."
	   
Accuracy_Rate_Info[13] = {}
Accuracy_Rate_Info[13].Type = WEAPON_TYPE_SECONDARY
Accuracy_Rate_Info[13].Rate = 5
Accuracy_Rate_Info[13].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Accuracy_Rate_Info[13].Description = "보조무기 명중률이 5% 증가합니다."
	   
Accuracy_Rate_Info[14] = {}
Accuracy_Rate_Info[14].Type = WEAPON_TYPE_SECONDARY
Accuracy_Rate_Info[14].Rate = 7
Accuracy_Rate_Info[14].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Accuracy_Rate_Info[14].Description = "보조무기 명중률이 7% 증가합니다."
	   
Accuracy_Rate_Info[15] = {}
Accuracy_Rate_Info[15].Type = WEAPON_TYPE_SECONDARY
Accuracy_Rate_Info[15].Rate = 10
Accuracy_Rate_Info[15].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Accuracy_Rate_Info[15].Description = "보조무기 명중률이 10% 증가합니다."
	   
Accuracy_Rate_Info[16] = {}
Accuracy_Rate_Info[16].Type = WEAPON_TYPE_SECONDARY
Accuracy_Rate_Info[16].Rate = 15
Accuracy_Rate_Info[16].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Accuracy_Rate_Info[16].Description = "보조무기 명중률이 15% 증가합니다."
	   
Accuracy_Rate_Info[17] = {}
Accuracy_Rate_Info[17].Type = WEAPON_TYPE_SECONDARY
Accuracy_Rate_Info[17].Rate = 20
Accuracy_Rate_Info[17].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Accuracy_Rate_Info[17].Description = "보조무기 명중률이 20% 증가합니다."
	   
Accuracy_Rate_Info[18] = {}
Accuracy_Rate_Info[18].Type = WEAPON_TYPE_SECONDARY
Accuracy_Rate_Info[18].Rate = 25
Accuracy_Rate_Info[18].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Accuracy_Rate_Info[18].Description = "보조무기 명중률이 25% 증가합니다."
	   
Accuracy_Rate_Info[19] = {}
Accuracy_Rate_Info[19].Type = WEAPON_TYPE_PRIMARY_3
Accuracy_Rate_Info[19].Rate = 5
Accuracy_Rate_Info[19].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRAccIncrese_1.dtx"
Accuracy_Rate_Info[19].Description = "저격소총 명중률이 5% 증가합니다."
	   
Accuracy_Rate_Info[20] = {}
Accuracy_Rate_Info[20].Type = WEAPON_TYPE_PRIMARY_3
Accuracy_Rate_Info[20].Rate = 10
Accuracy_Rate_Info[20].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRAccIncrese_1.dtx"
Accuracy_Rate_Info[20].Description = "저격소총 명중률이 10% 증가합니다."
	   
Accuracy_Rate_Info[21] = {}
Accuracy_Rate_Info[21].Type = WEAPON_TYPE_PRIMARY_3
Accuracy_Rate_Info[21].Rate = 15
Accuracy_Rate_Info[21].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRAccIncrese_1.dtx"
Accuracy_Rate_Info[21].Description = "저격소총 명중률이 15% 증가합니다."
	   
Accuracy_Rate_Info[22] = {}
Accuracy_Rate_Info[22].Type = WEAPON_TYPE_PRIMARY_3
Accuracy_Rate_Info[22].Rate = 20
Accuracy_Rate_Info[22].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRAccIncrese_1.dtx"
Accuracy_Rate_Info[22].Description = "저격소총 명중률이 20% 증가합니다."
	   
Accuracy_Rate_Info[23] = {}
Accuracy_Rate_Info[23].Type = WEAPON_TYPE_PRIMARY_3
Accuracy_Rate_Info[23].Rate = 25
Accuracy_Rate_Info[23].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRAccIncrese_1.dtx"
Accuracy_Rate_Info[23].Description = "저격소총 명중률이 25% 증가합니다."
	   
Accuracy_Rate_Info[24] = {}
Accuracy_Rate_Info[24].Type = WEAPON_TYPE_PRIMARY_3
Accuracy_Rate_Info[24].Rate = 30
Accuracy_Rate_Info[24].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRAccIncrese_1.dtx"
Accuracy_Rate_Info[24].Description = "저격소총 명중률이 30% 증가합니다."
	   
Accuracy_Rate_Info[25] = {}
Accuracy_Rate_Info[25].Type = WEAPON_TYPE_MELEE
Accuracy_Rate_Info[25].Rate = 5
Accuracy_Rate_Info[25].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Accuracy_Rate_Info[25].Description = "근접무기 명중률이 5% 증가합니다."
	   
Accuracy_Rate_Info[26] = {}
Accuracy_Rate_Info[26].Type = WEAPON_TYPE_MELEE
Accuracy_Rate_Info[26].Rate = 7
Accuracy_Rate_Info[26].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Accuracy_Rate_Info[26].Description = "근접무기 명중률이 7% 증가합니다."
	   
Accuracy_Rate_Info[27] = {}
Accuracy_Rate_Info[27].Type = WEAPON_TYPE_MELEE
Accuracy_Rate_Info[27].Rate = 10
Accuracy_Rate_Info[27].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Accuracy_Rate_Info[27].Description = "근접무기 명중률이 10% 증가합니다."
	   
Accuracy_Rate_Info[28] = {}
Accuracy_Rate_Info[28].Type = WEAPON_TYPE_MELEE
Accuracy_Rate_Info[28].Rate = 15
Accuracy_Rate_Info[28].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Accuracy_Rate_Info[28].Description = "근접무기 명중률이 15% 증가합니다."
	   
Accuracy_Rate_Info[29] = {}
Accuracy_Rate_Info[29].Type = WEAPON_TYPE_MELEE
Accuracy_Rate_Info[29].Rate = 20
Accuracy_Rate_Info[29].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Accuracy_Rate_Info[29].Description = "근접무기 명중률이 20% 증가합니다."
	   
Accuracy_Rate_Info[30] = {}
Accuracy_Rate_Info[30].Type = WEAPON_TYPE_MELEE
Accuracy_Rate_Info[30].Rate = 25
Accuracy_Rate_Info[30].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Accuracy_Rate_Info[30].Description = "근접무기 명중률이 25% 증가합니다."
	   
--------------------------------------------------
-- 대미지 스텟 정보가 설정되어 있는 배열.
--------------------------------------------------

Damage_Stat_Info = {}

Damage_Stat_Info[1] = {}
Damage_Stat_Info[1].Type = WEAPON_TYPE_PRIMARY_1
Damage_Stat_Info[1].Count = 10
Damage_Stat_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialDamage_1.dtx"
Damage_Stat_Info[1].Description = "특수총 대미지가 10% 증가합니다."
	   
Damage_Stat_Info[2] = {}
Damage_Stat_Info[2].Type = WEAPON_TYPE_PRIMARY_1
Damage_Stat_Info[2].Count = 15
Damage_Stat_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialDamage_1.dtx"
Damage_Stat_Info[2].Description = "특수총 대미지가 15% 증가합니다."
	   
Damage_Stat_Info[3] = {}
Damage_Stat_Info[3].Type = WEAPON_TYPE_PRIMARY_1
Damage_Stat_Info[3].Count = 20
Damage_Stat_Info[3].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialDamage_1.dtx"
Damage_Stat_Info[3].Description = "특수총 대미지가 20% 증가합니다."
	   
Damage_Stat_Info[4] = {}
Damage_Stat_Info[4].Type = WEAPON_TYPE_PRIMARY_1
Damage_Stat_Info[4].Count = 25
Damage_Stat_Info[4].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialDamage_1.dtx"
Damage_Stat_Info[4].Description = "특수총 대미지가 25% 증가합니다."
	   
Damage_Stat_Info[5] = {}
Damage_Stat_Info[5].Type = WEAPON_TYPE_PRIMARY_1
Damage_Stat_Info[5].Count = 30
Damage_Stat_Info[5].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialDamage_1.dtx"
Damage_Stat_Info[5].Description = "특수총 대미지가 30% 증가합니다."
	   
Damage_Stat_Info[6] = {}
Damage_Stat_Info[6].Type = WEAPON_TYPE_PRIMARY_1
Damage_Stat_Info[6].Count = 35
Damage_Stat_Info[6].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialDamage_1.dtx"
Damage_Stat_Info[6].Description = "특수총 대미지가 35% 증가합니다."
	   
Damage_Stat_Info[7] = {}
Damage_Stat_Info[7].Type = WEAPON_TYPE_PRIMARY_2
Damage_Stat_Info[7].Count = 10
Damage_Stat_Info[7].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_RifleSMGDamage_1.dtx"
Damage_Stat_Info[7].Description = "돌격소총 대미지가 10% 증가합니다."
	   
Damage_Stat_Info[8] = {}
Damage_Stat_Info[8].Type = WEAPON_TYPE_PRIMARY_2
Damage_Stat_Info[8].Count = 15
Damage_Stat_Info[8].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_RifleSMGDamage_1.dtx"
Damage_Stat_Info[8].Description = "돌격소총 대미지가 15% 증가합니다."
	   
Damage_Stat_Info[9] = {}
Damage_Stat_Info[9].Type = WEAPON_TYPE_PRIMARY_2
Damage_Stat_Info[9].Count = 20
Damage_Stat_Info[9].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_RifleSMGDamage_1.dtx"
Damage_Stat_Info[9].Description = "돌격소총 대미지가 20% 증가합니다."
	   
Damage_Stat_Info[10] = {}
Damage_Stat_Info[10].Type = WEAPON_TYPE_PRIMARY_2
Damage_Stat_Info[10].Count = 25
Damage_Stat_Info[10].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_RifleSMGDamage_1.dtx"
Damage_Stat_Info[10].Description = "돌격소총 대미지가 25% 증가합니다."
	   
Damage_Stat_Info[11] = {}
Damage_Stat_Info[11].Type = WEAPON_TYPE_PRIMARY_2
Damage_Stat_Info[11].Count = 30
Damage_Stat_Info[11].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_RifleSMGDamage_1.dtx"
Damage_Stat_Info[11].Description = "돌격소총 대미지가 30% 증가합니다."
	   
Damage_Stat_Info[12] = {}
Damage_Stat_Info[12].Type = WEAPON_TYPE_PRIMARY_2
Damage_Stat_Info[12].Count = 35
Damage_Stat_Info[12].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_RifleSMGDamage_1.dtx"
Damage_Stat_Info[12].Description = "돌격소총 대미지가 35% 증가합니다."
	   
Damage_Stat_Info[13] = {}
Damage_Stat_Info[13].Type = WEAPON_TYPE_PRIMARY_3
Damage_Stat_Info[13].Count = 10
Damage_Stat_Info[13].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRDamage_1.dtx"
Damage_Stat_Info[13].Description = "저격소총 대미지가 10% 증가합니다."
	   
Damage_Stat_Info[14] = {}
Damage_Stat_Info[14].Type = WEAPON_TYPE_PRIMARY_3
Damage_Stat_Info[14].Count = 15
Damage_Stat_Info[14].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRDamage_1.dtx"
Damage_Stat_Info[14].Description = "저격소총 대미지가 15% 증가합니다."
	   
Damage_Stat_Info[15] = {}
Damage_Stat_Info[15].Type = WEAPON_TYPE_PRIMARY_3
Damage_Stat_Info[15].Count = 20
Damage_Stat_Info[15].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRDamage_1.dtx"
Damage_Stat_Info[15].Description = "저격소총 대미지가 20% 증가합니다."
	   
Damage_Stat_Info[16] = {}
Damage_Stat_Info[16].Type = WEAPON_TYPE_PRIMARY_3
Damage_Stat_Info[16].Count = 25
Damage_Stat_Info[16].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRDamage_1.dtx"
Damage_Stat_Info[16].Description = "저격소총 대미지가 25% 증가합니다."
	   
Damage_Stat_Info[17] = {}
Damage_Stat_Info[17].Type = WEAPON_TYPE_PRIMARY_3
Damage_Stat_Info[17].Count = 30
Damage_Stat_Info[17].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRDamage_1.dtx"
Damage_Stat_Info[17].Description = "저격소총 대미지가 30% 증가합니다."
	   
Damage_Stat_Info[18] = {}
Damage_Stat_Info[18].Type = WEAPON_TYPE_PRIMARY_3
Damage_Stat_Info[18].Count = 35
Damage_Stat_Info[18].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRDamage_1.dtx"
Damage_Stat_Info[18].Description = "저격소총 대미지가 35% 증가합니다."
	   
Damage_Stat_Info[19] = {}
Damage_Stat_Info[19].Type = WEAPON_TYPE_SECONDARY
Damage_Stat_Info[19].Count = 5
Damage_Stat_Info[19].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryDamage_1.dtx"
Damage_Stat_Info[19].Description = "보조무기 대미지가 5% 증가합니다."
	   
Damage_Stat_Info[20] = {}
Damage_Stat_Info[20].Type = WEAPON_TYPE_SECONDARY
Damage_Stat_Info[20].Count = 7
Damage_Stat_Info[20].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryDamage_1.dtx"
Damage_Stat_Info[20].Description = "보조무기 대미지가 7% 증가합니다."
	   
Damage_Stat_Info[21] = {}
Damage_Stat_Info[21].Type = WEAPON_TYPE_SECONDARY
Damage_Stat_Info[21].Count = 10
Damage_Stat_Info[21].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryDamage_1.dtx"
Damage_Stat_Info[21].Description = "보조무기 대미지가 10% 증가합니다."
	   
Damage_Stat_Info[22] = {}
Damage_Stat_Info[22].Type = WEAPON_TYPE_SECONDARY
Damage_Stat_Info[22].Count = 15
Damage_Stat_Info[22].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryDamage_1.dtx"
Damage_Stat_Info[22].Description = "보조무기 대미지가 15% 증가합니다."
	   
Damage_Stat_Info[23] = {}
Damage_Stat_Info[23].Type = WEAPON_TYPE_SECONDARY
Damage_Stat_Info[23].Count = 20
Damage_Stat_Info[23].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryDamage_1.dtx"
Damage_Stat_Info[23].Description = "보조무기 대미지가 20% 증가합니다."
	   
Damage_Stat_Info[24] = {}
Damage_Stat_Info[24].Type = WEAPON_TYPE_SECONDARY
Damage_Stat_Info[24].Count = 25
Damage_Stat_Info[24].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryDamage_1.dtx"
Damage_Stat_Info[24].Description = "보조무기 대미지가 25% 증가합니다."
	   
	   
Damage_Stat_Info[25] = {}
Damage_Stat_Info[25].Type = WEAPON_TYPE_MELEE
Damage_Stat_Info[25].Count = 5
Damage_Stat_Info[25].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeDamage_1.dtx"
Damage_Stat_Info[25].Description = "근접무기 대미지가 5% 증가합니다."
	   
Damage_Stat_Info[26] = {}
Damage_Stat_Info[26].Type = WEAPON_TYPE_MELEE
Damage_Stat_Info[26].Count = 7
Damage_Stat_Info[26].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeDamage_1.dtx"
Damage_Stat_Info[26].Description = "근접무기 대미지가 7% 증가합니다."
	   
Damage_Stat_Info[27] = {}
Damage_Stat_Info[27].Type = WEAPON_TYPE_MELEE
Damage_Stat_Info[27].Count = 10
Damage_Stat_Info[27].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeDamage_1.dtx"
Damage_Stat_Info[27].Description = "근접무기 대미지가 10% 증가합니다."
	   
Damage_Stat_Info[28] = {}
Damage_Stat_Info[28].Type = WEAPON_TYPE_MELEE
Damage_Stat_Info[28].Count = 15
Damage_Stat_Info[28].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeDamage_1.dtx"
Damage_Stat_Info[28].Description = "근접무기 대미지가 15% 증가합니다."
	   
Damage_Stat_Info[29] = {}
Damage_Stat_Info[29].Type = WEAPON_TYPE_MELEE
Damage_Stat_Info[29].Count = 20
Damage_Stat_Info[29].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeDamage_1.dtx"
Damage_Stat_Info[29].Description = "근접무기 대미지가 20% 증가합니다."
	   
Damage_Stat_Info[30] = {}
Damage_Stat_Info[30].Type = WEAPON_TYPE_MELEE
Damage_Stat_Info[30].Count = 25
Damage_Stat_Info[30].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeDamage_1.dtx"
Damage_Stat_Info[30].Description = "근접무기 대미지가 25% 증가합니다."
	   
--------------------------------------------------
-- 탄창 증가률 정보. ITEM_TYPE_MAGAZINE_INCREASE : 탄창 증가 획득 시 호출. 100프로 기준으로 설정.
--------------------------------------------------

MagazineIncreaseRate_Info = {}

MagazineIncreaseRate_Info[1] = {}
MagazineIncreaseRate_Info[1].Rate = 50
MagazineIncreaseRate_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_MaxAmmo_1.dtx"
MagazineIncreaseRate_Info[1].Description = "예비장탄이 50% 증가합니다."
	   
MagazineIncreaseRate_Info[2] = {}
MagazineIncreaseRate_Info[2].Rate = 100
MagazineIncreaseRate_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_MaxAmmo_1.dtx"
MagazineIncreaseRate_Info[2].Description = "예비장탄이 100% 증가합니다."
	   
MagazineIncreaseRate_Info[3] = {}
MagazineIncreaseRate_Info[3].Rate = 150
MagazineIncreaseRate_Info[3].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_MaxAmmo_1.dtx"
MagazineIncreaseRate_Info[3].Description = "예비탄창이 150% 증가합니다."
	   
--------------------------------------------------
-- 강화 수치 증가 정보. ITEM_TYPE_INCREASE_ENCHANT_VALUE : 강화 수치 증가 획득시 호출. 100프로 기준으로 설정.
--------------------------------------------------

IncreaseEnchantValue_Info = {}

IncreaseEnchantValue_Info[1] = {}
IncreaseEnchantValue_Info[1].Rate = 5
IncreaseEnchantValue_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleValue_1.dtx"
IncreaseEnchantValue_Info[1].Description = "강화 성공 값이 5% 증가합니다."
	   
IncreaseEnchantValue_Info[2] = {}
IncreaseEnchantValue_Info[2].Rate = 10
IncreaseEnchantValue_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleValue_1.dtx"
IncreaseEnchantValue_Info[2].Description = "강화 성공 값이 10% 증가합니다."
	   
IncreaseEnchantValue_Info[3] = {}
IncreaseEnchantValue_Info[3].Rate = 15
IncreaseEnchantValue_Info[3].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleValue_1.dtx"
IncreaseEnchantValue_Info[3].Description = "강화 성공 값이 15% 증가합니다."
	   
IncreaseEnchantValue_Info[4] = {}
IncreaseEnchantValue_Info[4].Rate = 20
IncreaseEnchantValue_Info[4].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleValue_1.dtx"
IncreaseEnchantValue_Info[4].Description = "강화 성공 값이 20% 증가합니다."
	   
IncreaseEnchantValue_Info[5] = {}
IncreaseEnchantValue_Info[5].Rate = 25
IncreaseEnchantValue_Info[5].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleValue_1.dtx"
IncreaseEnchantValue_Info[5].Description = "강화 성공 값이 25% 증가합니다."
	   
IncreaseEnchantValue_Info[6] = {}
IncreaseEnchantValue_Info[6].Rate = 30
IncreaseEnchantValue_Info[6].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleValue_1.dtx"
IncreaseEnchantValue_Info[6].Description = "강화 성공 값이 30% 증가합니다."
	   
--------------------------------------------------
-- 크리티컬 확률 정보. ITEM_TYPE_CRITICAL_PROBABILITY : 크리티컬 확률 획득시 호출. 100프로 기준으로 설정.
--------------------------------------------------

CriticalProbability_Info = {}

CriticalProbability_Info[1] = {}
CriticalProbability_Info[1].Probability = 5
CriticalProbability_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalRate_1.dtx"
CriticalProbability_Info[1].Description = "크리티컬 발생 확률이 5% 증가합니다."
	   
CriticalProbability_Info[2] = {}
CriticalProbability_Info[2].Probability = 10
CriticalProbability_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalRate_1.dtx"
CriticalProbability_Info[2].Description = "크리티컬 발생 확률이 10% 증가합니다."
	   
CriticalProbability_Info[3] = {}
CriticalProbability_Info[3].Probability = 15
CriticalProbability_Info[3].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalRate_1.dtx"
CriticalProbability_Info[3].Description = "크리티컬 발생 확률이 15% 증가합니다."
	   
CriticalProbability_Info[4] = {}
CriticalProbability_Info[4].Probability = 20
CriticalProbability_Info[4].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalRate_1.dtx"
CriticalProbability_Info[4].Description = "크리티컬 발생 확률이 20% 증가합니다."
	   
CriticalProbability_Info[5] = {}
CriticalProbability_Info[5].Probability = 25
CriticalProbability_Info[5].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalRate_1.dtx"
CriticalProbability_Info[5].Description = "크리티컬 발생 확률이 25% 증가합니다."
	   
CriticalProbability_Info[6] = {}
CriticalProbability_Info[6].Probability = 30
CriticalProbability_Info[6].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalRate_1.dtx"
CriticalProbability_Info[6].Description = "크리티컬 발생 확률이 30% 증가합니다."
	   
--------------------------------------------------
-- 강화 성공 증가 정보. ITEM_TYPE_INCREASE_ENCHANT_SUCCESS : 강화 성공 증가 획득시 호출. 100프로 기준으로 설정.
--------------------------------------------------

IncreaseEnchantSuccess_Info = {}

IncreaseEnchantSuccess_Info[1] = {}
IncreaseEnchantSuccess_Info[1].Rate = 3
IncreaseEnchantSuccess_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleRate_1.dtx"
IncreaseEnchantSuccess_Info[1].Description = "강화성공률이 3% 증가합니다."
	   
IncreaseEnchantSuccess_Info[2] = {}
IncreaseEnchantSuccess_Info[2].Rate = 5
IncreaseEnchantSuccess_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleRate_1.dtx"
IncreaseEnchantSuccess_Info[2].Description = "강화성공률이 5% 증가합니다."
	   
IncreaseEnchantSuccess_Info[3] = {}
IncreaseEnchantSuccess_Info[3].Rate = 10
IncreaseEnchantSuccess_Info[3].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleRate_1.dtx"
IncreaseEnchantSuccess_Info[3].Description = "강화성공률이 10% 증가합니다."
	   
IncreaseEnchantSuccess_Info[4] = {}
IncreaseEnchantSuccess_Info[4].Rate = 15
IncreaseEnchantSuccess_Info[4].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleRate_1.dtx"
IncreaseEnchantSuccess_Info[4].Description = "강화성공률이 15% 증가합니다."
	   
IncreaseEnchantSuccess_Info[5] = {}
IncreaseEnchantSuccess_Info[5].Rate = 20
IncreaseEnchantSuccess_Info[5].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleRate_1.dtx"
IncreaseEnchantSuccess_Info[5].Description = "강화성공률이 20% 증가합니다."
	   
IncreaseEnchantSuccess_Info[6] = {}
IncreaseEnchantSuccess_Info[6].Rate = 30
IncreaseEnchantSuccess_Info[6].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleRate_1.dtx"
IncreaseEnchantSuccess_Info[6].Description = "강화성공률이 30% 증가합니다."
	   
--------------------------------------------------
-- 회피률 정보. ITEM_TYPE_EVASION_RATE_STAT 획득 시 호출. 100프로 기준으로 설정.
--------------------------------------------------

EvasionRate_Info = {}

EvasionRate_Info[1] = {}
EvasionRate_Info[1].Rate = 3
EvasionRate_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_Dodge_1.dtx"
EvasionRate_Info[1].Description = "회피율이 3% 증가합니다."
	   
EvasionRate_Info[2] = {}
EvasionRate_Info[2].Rate = 5
EvasionRate_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_Dodge_1.dtx"
EvasionRate_Info[2].Description = "회피율이 5% 증가합니다."
	   
EvasionRate_Info[3] = {}
EvasionRate_Info[3].Rate = 10
EvasionRate_Info[3].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_Dodge_1.dtx"
EvasionRate_Info[3].Description = "회피율이 10% 증가합니다."
	   
EvasionRate_Info[4] = {}
EvasionRate_Info[4].Rate = 15
EvasionRate_Info[4].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_Dodge_1.dtx"
EvasionRate_Info[4].Description = "회피율이 15% 증가합니다."
	   
EvasionRate_Info[5] = {}
EvasionRate_Info[5].Rate = 20
EvasionRate_Info[5].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_Dodge_1.dtx"
EvasionRate_Info[5].Description = "회피율이 20% 증가합니다."
	 
EvasionRate_Info[6] = {}
EvasionRate_Info[6].Rate = 30
EvasionRate_Info[6].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_Dodge_1.dtx"
EvasionRate_Info[6].Description = "회피율이 30% 증가합니다."
 
--------------------------------------------------
-- 최대 HP증가
--------------------------------------------------

HPIncrease_Info = {}

HPIncrease_Info[1] = {}
HPIncrease_Info[1].Increment = 100
HPIncrease_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_HPIncrese_1.dtx"
HPIncrease_Info[1].Description = "최대 HP가 100 증가합니다."

HPIncrease_Info[2] = {}
HPIncrease_Info[2].Increment = 200
HPIncrease_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_HPIncrese_1.dtx"
HPIncrease_Info[2].Description = "최대 HP가 200 증가합니다."

HPIncrease_Info[3] = {}
HPIncrease_Info[3].Increment = 300
HPIncrease_Info[3].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_HPIncrese_1.dtx"
HPIncrease_Info[3].Description = "최대 HP가 300 증가합니다."

--------------------------------------------------
-- 삽탄 증가
--------------------------------------------------

AmmoInClipIncreaseRate_Info = {}

AmmoInClipIncreaseRate_Info[1] = {}
AmmoInClipIncreaseRate_Info[1].Rate = 100
AmmoInClipIncreaseRate_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_AmmoIncrese_1.dtx"
AmmoInClipIncreaseRate_Info[1].Description = "삽탄이 100% 증가합니다."

AmmoInClipIncreaseRate_Info[2] = {}
AmmoInClipIncreaseRate_Info[2].Rate = 150
AmmoInClipIncreaseRate_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_AmmoIncrese_1.dtx"
AmmoInClipIncreaseRate_Info[2].Description = "삽탄이 150% 증가합니다."

--------------------------------------------------
-- 크리티컬 배수 증가
--------------------------------------------------

CriticalDamageMultiple_Info = {}

CriticalDamageMultiple_Info[1] = {}
CriticalDamageMultiple_Info[1].Multiple = 0.50
CriticalDamageMultiple_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalDamage_1.dtx"
CriticalDamageMultiple_Info[1].Description = "크리티컬 배수가 0.5배 증가합니다."

CriticalDamageMultiple_Info[2] = {}
CriticalDamageMultiple_Info[2].Multiple = 0.75
CriticalDamageMultiple_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalDamage_1.dtx"
CriticalDamageMultiple_Info[2].Description = "크리티컬 배수가 0.75배 증가합니다."


----------------------------------------------------------------------------------------------------
-- 무기타입을 반환한다.
----------------------------------------------------------------------------------------------------
function GetWeaponType(nWeaponIndex)

    nWeaponType = WEAPON_TYPE_NOTHING

    if Weapon_Info[nWeaponIndex] ~= nil    then

        nWeaponType = Weapon_Info[nWeaponIndex].SubType

    end

    return nWeaponType
end

----------------------------------------------------------------------------------------------------
-- 사용되고 있는 무기ID를 클라이언트에서 알기 위해서... WeaponID 배열을 클라이언트가 직접 접근한다.
----------------------------------------------------------------------------------------------------
WeaponID = {}

function SetWeaponID()

             for k, v in pairs(Weapon_Info) do
                           WeaponID[k] = v.WeaponID
             end
end
----------------------------------------------------------------------------------------------------
-- 강화를 진행하는 시간.
----------------------------------------------------------------------------------------------------
ENCHANT_PROGRESS_TIME = 4   -- 20190121 밸런스 차원에서 수정

----------------------------------------------------------------------------------------------------
-- 대미지 강화 실패시 마이너스가 되는데... 이때 최소 대미지 값을 정의한다.(기본대미지 * BASIC_DAMAGE_MIN_VALUE)
----------------------------------------------------------------------------------------------------
BASIC_DAMAGE_MIN_VALUE = 0.5

----------------------------------------------------------------------------------------------------
-- 강화 타입을 정의한다. 클라이언트와 같아야한다.
----------------------------------------------------------------------------------------------------
ENCHANT_TYPE_NOTHING = 0
ENCHANT_TYPE_DAMAGE = 1
ENCHANT_TYPE_ACCURACY_RATE = 2
ENCHANT_TYPE_DAMAGE_AND_ACCURACY_RATE = 3

----------------------------------------------------------------------------------------------------
-- 주무기 강화 정보가 들어가 있는 배열.
----------------------------------------------------------------------------------------------------
Primary_Enchant_Info = {}

Primary_Enchant_Info[1] = {}
Primary_Enchant_Info[1].Name = "대미지 강화"
Primary_Enchant_Info[1].Type = ENCHANT_TYPE_DAMAGE
Primary_Enchant_Info[1].NormalSelProb = 100		-- 일반 정비사 한테 나올 확률
Primary_Enchant_Info[1].SpecialSelProb = 0		-- 스페셜 정비사 한테 나올 확률
Primary_Enchant_Info[1].SuccessProb = 80
Primary_Enchant_Info[1].CorrectProb = 1
Primary_Enchant_Info[1].Damage = 10
Primary_Enchant_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialDamage_1.dtx"
Primary_Enchant_Info[1].Description = "대미지가 +%d%%(+%d) 상승합니다."

Primary_Enchant_Info[2] = {}
Primary_Enchant_Info[2].Name = "대미지 강화"
Primary_Enchant_Info[2].Type = ENCHANT_TYPE_DAMAGE
Primary_Enchant_Info[2].NormalSelProb = 100
Primary_Enchant_Info[2].SpecialSelProb = 0
Primary_Enchant_Info[2].SuccessProb = 60
Primary_Enchant_Info[2].CorrectProb = 1
Primary_Enchant_Info[2].Damage = 15
Primary_Enchant_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialDamage_1.dtx"
Primary_Enchant_Info[2].Description = "대미지가 +%d%%(+%d) 상승합니다."

Primary_Enchant_Info[3] = {}
Primary_Enchant_Info[3].Name = "대미지 강화"
Primary_Enchant_Info[3].Type = ENCHANT_TYPE_DAMAGE
Primary_Enchant_Info[3].NormalSelProb = 100
Primary_Enchant_Info[3].SpecialSelProb = 0
Primary_Enchant_Info[3].SuccessProb = 40
Primary_Enchant_Info[3].CorrectProb = 1
Primary_Enchant_Info[3].Damage = 25
Primary_Enchant_Info[3].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialDamage_1.dtx"
Primary_Enchant_Info[3].Description = "대미지가 +%d%%(+%d) 상승합니다."

Primary_Enchant_Info[4] = {}
Primary_Enchant_Info[4].Name = "대미지 강화"
Primary_Enchant_Info[4].Type = ENCHANT_TYPE_DAMAGE
Primary_Enchant_Info[4].NormalSelProb = 10
Primary_Enchant_Info[4].SpecialSelProb = 100
Primary_Enchant_Info[4].SuccessProb = 70
Primary_Enchant_Info[4].CorrectProb = 1
Primary_Enchant_Info[4].Damage = 30
Primary_Enchant_Info[4].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialDamage_1.dtx"
Primary_Enchant_Info[4].Description = "대미지가 +%d%%(+%d) 상승합니다."

Primary_Enchant_Info[5] = {}
Primary_Enchant_Info[5].Name = "명중률 강화"
Primary_Enchant_Info[5].Type = ENCHANT_TYPE_ACCURACY_RATE
Primary_Enchant_Info[5].NormalSelProb = 100
Primary_Enchant_Info[5].SpecialSelProb = 0
Primary_Enchant_Info[5].SuccessProb = 80
Primary_Enchant_Info[5].CorrectProb = 1
Primary_Enchant_Info[5].AccuracyRate = 5
Primary_Enchant_Info[5].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Primary_Enchant_Info[5].Description = "명중률이 +%d%% 상승합니다."

Primary_Enchant_Info[6] = {}
Primary_Enchant_Info[6].Name = "명중률 강화"
Primary_Enchant_Info[6].Type = ENCHANT_TYPE_ACCURACY_RATE
Primary_Enchant_Info[6].NormalSelProb = 100
Primary_Enchant_Info[6].SpecialSelProb = 0
Primary_Enchant_Info[6].SuccessProb = 60
Primary_Enchant_Info[6].CorrectProb = 1
Primary_Enchant_Info[6].AccuracyRate = 10
Primary_Enchant_Info[6].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Primary_Enchant_Info[6].Description = "명중률이 +%d%% 상승합니다."

Primary_Enchant_Info[7] = {}
Primary_Enchant_Info[7].Name = "명중률 강화"
Primary_Enchant_Info[7].Type = ENCHANT_TYPE_ACCURACY_RATE
Primary_Enchant_Info[7].NormalSelProb = 100
Primary_Enchant_Info[7].SpecialSelProb = 0
Primary_Enchant_Info[7].SuccessProb = 40
Primary_Enchant_Info[7].CorrectProb = 1
Primary_Enchant_Info[7].AccuracyRate = 20
Primary_Enchant_Info[7].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Primary_Enchant_Info[7].Description = "명중률이 +%d%% 상승합니다."

Primary_Enchant_Info[8] = {}
Primary_Enchant_Info[8].Name = "명중률 강화"
Primary_Enchant_Info[8].Type = ENCHANT_TYPE_ACCURACY_RATE
Primary_Enchant_Info[8].NormalSelProb = 10
Primary_Enchant_Info[8].SpecialSelProb = 100
Primary_Enchant_Info[8].SuccessProb = 70
Primary_Enchant_Info[8].CorrectProb = 1
Primary_Enchant_Info[8].AccuracyRate = 25
Primary_Enchant_Info[8].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Primary_Enchant_Info[8].Description = "명중률이 +%d%% 상승합니다."

Primary_Enchant_Info[9] = {}
Primary_Enchant_Info[9].Name = "전체 강화"
Primary_Enchant_Info[9].Type = ENCHANT_TYPE_DAMAGE_AND_ACCURACY_RATE 
Primary_Enchant_Info[9].NormalSelProb = 100
Primary_Enchant_Info[9].SpecialSelProb = 0
Primary_Enchant_Info[9].SuccessProb = 60
Primary_Enchant_Info[9].CorrectProb = 1
Primary_Enchant_Info[9].Damage = 10
Primary_Enchant_Info[9].AccuracyRate = 5
Primary_Enchant_Info[9].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAll_1.dtx"
Primary_Enchant_Info[9].Description = "대미지가 +%d%%(+%d), 명중률이 +%d%% 상승합니다."

Primary_Enchant_Info[10] = {}
Primary_Enchant_Info[10].Name = "전체 강화"
Primary_Enchant_Info[10].Type = ENCHANT_TYPE_DAMAGE_AND_ACCURACY_RATE 
Primary_Enchant_Info[10].NormalSelProb = 100
Primary_Enchant_Info[10].SpecialSelProb = 0
Primary_Enchant_Info[10].SuccessProb = 45
Primary_Enchant_Info[10].CorrectProb = 1
Primary_Enchant_Info[10].Damage = 15
Primary_Enchant_Info[10].AccuracyRate = 6
Primary_Enchant_Info[10].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAll_1.dtx"
Primary_Enchant_Info[10].Description = "대미지가 +%d%%(+%d), 명중률이 +%d%% 상승합니다."

Primary_Enchant_Info[11] = {}
Primary_Enchant_Info[11].Name = "전체 강화"
Primary_Enchant_Info[11].Type = ENCHANT_TYPE_DAMAGE_AND_ACCURACY_RATE 
Primary_Enchant_Info[11].NormalSelProb = 100
Primary_Enchant_Info[11].SpecialSelProb = 0
Primary_Enchant_Info[11].SuccessProb = 30
Primary_Enchant_Info[11].CorrectProb = 1
Primary_Enchant_Info[11].Damage = 25
Primary_Enchant_Info[11].AccuracyRate = 20
Primary_Enchant_Info[11].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAll_1.dtx"
Primary_Enchant_Info[11].Description = "대미지가 +%d%%(+%d), 명중률이 +%d%% 상승합니다."

Primary_Enchant_Info[12] = {}
Primary_Enchant_Info[12].Name = "전체 강화"
Primary_Enchant_Info[12].Type = ENCHANT_TYPE_DAMAGE_AND_ACCURACY_RATE 
Primary_Enchant_Info[12].NormalSelProb = 10
Primary_Enchant_Info[12].SpecialSelProb = 100
Primary_Enchant_Info[12].SuccessProb = 55
Primary_Enchant_Info[12].CorrectProb = 1
Primary_Enchant_Info[12].Damage = 30
Primary_Enchant_Info[12].AccuracyRate = 25
Primary_Enchant_Info[12].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAll_1.dtx"
Primary_Enchant_Info[12].Description = "대미지가 +%d%%(+%d), 명중률이 +%d%% 상승합니다."

----------------------------------------------------------------------------------------------------
-- 주무기 강화 정보가 저장되어 있는 배열의 갯수를 반환한다. 배열변수 앞에 #을 붙이면 갯수가 반환된다.
----------------------------------------------------------------------------------------------------
function GetPrimaryEnchantInfoListCount()

	nCount = #Primary_Enchant_Info

	return nCount
end

----------------------------------------------------------------------------------------------------
-- 보조무기 강화 정보가 들어가 있는 배열.
----------------------------------------------------------------------------------------------------
Secondary_Enchant_Info = {}


Secondary_Enchant_Info[1] = {}
Secondary_Enchant_Info[1].Name = "대미지 강화"
Secondary_Enchant_Info[1].Type = ENCHANT_TYPE_DAMAGE
Secondary_Enchant_Info[1].NormalSelProb = 100		-- 일반 정비사 한테 나올 확률
Secondary_Enchant_Info[1].SpecialSelProb = 0		-- 스페셜 정비사 한테 나올 확률
Secondary_Enchant_Info[1].SuccessProb = 80
Secondary_Enchant_Info[1].CorrectProb = 1
Secondary_Enchant_Info[1].Damage = 7
Secondary_Enchant_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryDamage_1.dtx"
Secondary_Enchant_Info[1].Description = "대미지가 +%d%%(+%d) 상승합니다."

Secondary_Enchant_Info[2] = {}
Secondary_Enchant_Info[2].Name = "대미지 강화"
Secondary_Enchant_Info[2].Type = ENCHANT_TYPE_DAMAGE
Secondary_Enchant_Info[2].NormalSelProb = 100
Secondary_Enchant_Info[2].SpecialSelProb = 0
Secondary_Enchant_Info[2].SuccessProb = 60
Secondary_Enchant_Info[2].CorrectProb = 1
Secondary_Enchant_Info[2].Damage = 10
Secondary_Enchant_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryDamage_1.dtx"
Secondary_Enchant_Info[2].Description = "대미지가 +%d%%(+%d) 상승합니다."

Secondary_Enchant_Info[3] = {}
Secondary_Enchant_Info[3].Name = "대미지 강화"
Secondary_Enchant_Info[3].Type = ENCHANT_TYPE_DAMAGE
Secondary_Enchant_Info[3].NormalSelProb = 100
Secondary_Enchant_Info[3].SpecialSelProb = 0
Secondary_Enchant_Info[3].SuccessProb = 40
Secondary_Enchant_Info[3].CorrectProb = 1
Secondary_Enchant_Info[3].Damage = 15
Secondary_Enchant_Info[3].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryDamage_1.dtx"
Secondary_Enchant_Info[3].Description = "대미지가 +%d%%(+%d) 상승합니다."

Secondary_Enchant_Info[4] = {}
Secondary_Enchant_Info[4].Name = "대미지 강화"
Secondary_Enchant_Info[4].Type = ENCHANT_TYPE_DAMAGE
Secondary_Enchant_Info[4].NormalSelProb = 10
Secondary_Enchant_Info[4].SpecialSelProb = 100
Secondary_Enchant_Info[4].SuccessProb = 70
Secondary_Enchant_Info[4].CorrectProb = 1
Secondary_Enchant_Info[4].Damage = 20
Secondary_Enchant_Info[4].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryDamage_1.dtx"
Secondary_Enchant_Info[4].Description = "대미지가 +%d%%(+%d) 상승합니다."

Secondary_Enchant_Info[5] = {}
Secondary_Enchant_Info[5].Name = "명중률 강화"
Secondary_Enchant_Info[5].Type = ENCHANT_TYPE_ACCURACY_RATE
Secondary_Enchant_Info[5].NormalSelProb = 100
Secondary_Enchant_Info[5].SpecialSelProb = 0
Secondary_Enchant_Info[5].SuccessProb = 80
Secondary_Enchant_Info[5].CorrectProb = 1
Secondary_Enchant_Info[5].AccuracyRate = 7
Secondary_Enchant_Info[5].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Secondary_Enchant_Info[5].Description = "명중률이 +%d%% 상승합니다."

Secondary_Enchant_Info[6] = {}
Secondary_Enchant_Info[6].Name = "명중률 강화"
Secondary_Enchant_Info[6].Type = ENCHANT_TYPE_ACCURACY_RATE
Secondary_Enchant_Info[6].NormalSelProb = 100
Secondary_Enchant_Info[6].SpecialSelProb = 0
Secondary_Enchant_Info[6].SuccessProb = 60
Secondary_Enchant_Info[6].CorrectProb = 1
Secondary_Enchant_Info[6].AccuracyRate = 10
Secondary_Enchant_Info[6].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Secondary_Enchant_Info[6].Description = "명중률이 +%d%% 상승합니다."

Secondary_Enchant_Info[7] = {}
Secondary_Enchant_Info[7].Name = "명중률 강화"
Secondary_Enchant_Info[7].Type = ENCHANT_TYPE_ACCURACY_RATE
Secondary_Enchant_Info[7].NormalSelProb = 100
Secondary_Enchant_Info[7].SpecialSelProb = 0
Secondary_Enchant_Info[7].SuccessProb = 40
Secondary_Enchant_Info[7].CorrectProb = 1
Secondary_Enchant_Info[7].AccuracyRate = 15
Secondary_Enchant_Info[7].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Secondary_Enchant_Info[7].Description = "명중률이 +%d%% 상승합니다."

Secondary_Enchant_Info[8] = {}
Secondary_Enchant_Info[8].Name = "명중률 강화"
Secondary_Enchant_Info[8].Type = ENCHANT_TYPE_ACCURACY_RATE
Secondary_Enchant_Info[8].NormalSelProb = 10
Secondary_Enchant_Info[8].SpecialSelProb = 100
Secondary_Enchant_Info[8].SuccessProb = 70
Secondary_Enchant_Info[8].CorrectProb = 1
Secondary_Enchant_Info[8].AccuracyRate = 20
Secondary_Enchant_Info[8].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Secondary_Enchant_Info[8].Description = "명중률이 +%d%% 상승합니다."

Secondary_Enchant_Info[9] = {}
Secondary_Enchant_Info[9].Name = "전체 강화"
Secondary_Enchant_Info[9].Type = ENCHANT_TYPE_DAMAGE_AND_ACCURACY_RATE 
Secondary_Enchant_Info[9].NormalSelProb = 100
Secondary_Enchant_Info[9].SpecialSelProb = 0
Secondary_Enchant_Info[9].SuccessProb = 60
Secondary_Enchant_Info[9].CorrectProb = 1
Secondary_Enchant_Info[9].Damage = 7
Secondary_Enchant_Info[9].AccuracyRate = 7
Secondary_Enchant_Info[9].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryAll_1.dtx"
Secondary_Enchant_Info[9].Description = "대미지가 +%d%%(+%d), 명중률이 +%d%% 상승합니다."

Secondary_Enchant_Info[10] = {}
Secondary_Enchant_Info[10].Name = "전체 강화"
Secondary_Enchant_Info[10].Type = ENCHANT_TYPE_DAMAGE_AND_ACCURACY_RATE 
Secondary_Enchant_Info[10].NormalSelProb = 100
Secondary_Enchant_Info[10].SpecialSelProb = 0
Secondary_Enchant_Info[10].SuccessProb = 45
Secondary_Enchant_Info[10].CorrectProb = 1
Secondary_Enchant_Info[10].Damage = 10
Secondary_Enchant_Info[10].AccuracyRate = 10
Secondary_Enchant_Info[10].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryAll_1.dtx"
Secondary_Enchant_Info[10].Description = "대미지가 +%d%%(+%d), 명중률이 +%d%% 상승합니다."

Secondary_Enchant_Info[11] = {}
Secondary_Enchant_Info[11].Name = "전체 강화"
Secondary_Enchant_Info[11].Type = ENCHANT_TYPE_DAMAGE_AND_ACCURACY_RATE 
Secondary_Enchant_Info[11].NormalSelProb = 100
Secondary_Enchant_Info[11].SpecialSelProb = 0
Secondary_Enchant_Info[11].SuccessProb = 30
Secondary_Enchant_Info[11].CorrectProb = 1
Secondary_Enchant_Info[11].Damage = 15
Secondary_Enchant_Info[11].AccuracyRate = 15
Secondary_Enchant_Info[11].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryAll_1.dtx"
Secondary_Enchant_Info[11].Description = "대미지가 +%d%%(+%d) 명중률이 +%d%% 상승합니다."

Secondary_Enchant_Info[12] = {}
Secondary_Enchant_Info[12].Name = "전체 강화"
Secondary_Enchant_Info[12].Type = ENCHANT_TYPE_DAMAGE_AND_ACCURACY_RATE 
Secondary_Enchant_Info[12].NormalSelProb = 10
Secondary_Enchant_Info[12].SpecialSelProb = 100
Secondary_Enchant_Info[12].SuccessProb = 55
Secondary_Enchant_Info[12].CorrectProb = 1
Secondary_Enchant_Info[12].Damage = 20
Secondary_Enchant_Info[12].AccuracyRate = 20
Secondary_Enchant_Info[12].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryAll_1.dtx"
Secondary_Enchant_Info[12].Description = "대미지가 +%d%%(+%d), 명중률이 +%d%% 상승합니다."


----------------------------------------------------------------------------------------------------
-- 보조무기 강화 정보가 저장되어 있는 배열의 갯수를 반환한다. 배열변수 앞에 #을 붙이면 갯수가 반환된다.
----------------------------------------------------------------------------------------------------
function GetSecondaryEnchantInfoListCount()

	nCount = #Secondary_Enchant_Info

	return nCount
end

----------------------------------------------------------------------------------------------------
-- 근접무기 강화 정보가 들어가 있는 배열.
----------------------------------------------------------------------------------------------------
Melee_Enchant_Info = {}

Melee_Enchant_Info[1] = {}
Melee_Enchant_Info[1].Name = "대미지 강화"
Melee_Enchant_Info[1].Type = ENCHANT_TYPE_DAMAGE
Melee_Enchant_Info[1].NormalSelProb = 100		-- 일반 정비사 한테 나올 확률
Melee_Enchant_Info[1].SpecialSelProb = 0		-- 스페셜 정비사 한테 나올 확률
Melee_Enchant_Info[1].SuccessProb = 80
Melee_Enchant_Info[1].CorrectProb = 1
Melee_Enchant_Info[1].Damage = 7
Melee_Enchant_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeDamage_1.dtx"
Melee_Enchant_Info[1].Description = "대미지가 +%d%%(+%d) 증가합니다."

Melee_Enchant_Info[2] = {}
Melee_Enchant_Info[2].Name = "대미지 강화"
Melee_Enchant_Info[2].Type = ENCHANT_TYPE_DAMAGE
Melee_Enchant_Info[2].NormalSelProb = 100
Melee_Enchant_Info[2].SpecialSelProb = 0
Melee_Enchant_Info[2].SuccessProb = 60
Melee_Enchant_Info[2].CorrectProb = 1
Melee_Enchant_Info[2].Damage = 10
Melee_Enchant_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeDamage_1.dtx"
Melee_Enchant_Info[2].Description = "대미지가 +%d%%(+%d) 증가합니다."

Melee_Enchant_Info[3] = {}
Melee_Enchant_Info[3].Name = "대미지 강화"
Melee_Enchant_Info[3].Type = ENCHANT_TYPE_DAMAGE
Melee_Enchant_Info[3].NormalSelProb = 100
Melee_Enchant_Info[3].SpecialSelProb = 0
Melee_Enchant_Info[3].SuccessProb = 40
Melee_Enchant_Info[3].CorrectProb = 1
Melee_Enchant_Info[3].Damage = 15
Melee_Enchant_Info[3].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeDamage_1.dtx"
Melee_Enchant_Info[3].Description = "대미지가 +%d%%(+%d) 증가합니다."

Melee_Enchant_Info[4] = {}
Melee_Enchant_Info[4].Name = "대미지 강화"
Melee_Enchant_Info[4].Type = ENCHANT_TYPE_DAMAGE
Melee_Enchant_Info[4].NormalSelProb = 10
Melee_Enchant_Info[4].SpecialSelProb = 100
Melee_Enchant_Info[4].SuccessProb = 70
Melee_Enchant_Info[4].CorrectProb = 1
Melee_Enchant_Info[4].Damage = 20
Melee_Enchant_Info[4].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeDamage_1.dtx"
Melee_Enchant_Info[4].Description = "대미지가 +%d%%(+%d) 증가합니다."

Melee_Enchant_Info[5] = {}
Melee_Enchant_Info[5].Name = "명중률 강화"
Melee_Enchant_Info[5].Type = ENCHANT_TYPE_ACCURACY_RATE
Melee_Enchant_Info[5].NormalSelProb = 100
Melee_Enchant_Info[5].SpecialSelProb = 0
Melee_Enchant_Info[5].SuccessProb = 80
Melee_Enchant_Info[5].CorrectProb = 1
Melee_Enchant_Info[5].AccuracyRate = 7
Melee_Enchant_Info[5].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Melee_Enchant_Info[5].Description = "명중률이 +%d%% 증가합니다."

Melee_Enchant_Info[6] = {}
Melee_Enchant_Info[6].Name = "명중률 강화"
Melee_Enchant_Info[6].Type = ENCHANT_TYPE_ACCURACY_RATE
Melee_Enchant_Info[6].NormalSelProb = 100
Melee_Enchant_Info[6].SpecialSelProb = 0
Melee_Enchant_Info[6].SuccessProb = 60
Melee_Enchant_Info[6].CorrectProb = 1
Melee_Enchant_Info[6].AccuracyRate = 10
Melee_Enchant_Info[6].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Melee_Enchant_Info[6].Description = "명중률이 +%d%% 증가합니다."

Melee_Enchant_Info[7] = {}
Melee_Enchant_Info[7].Name = "명중률 강화"
Melee_Enchant_Info[7].Type = ENCHANT_TYPE_ACCURACY_RATE
Melee_Enchant_Info[7].NormalSelProb = 100
Melee_Enchant_Info[7].SpecialSelProb = 0
Melee_Enchant_Info[7].SuccessProb = 40
Melee_Enchant_Info[7].CorrectProb = 1
Melee_Enchant_Info[7].AccuracyRate = 15
Melee_Enchant_Info[7].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Melee_Enchant_Info[7].Description = "명중률이 +%d%% 증가합니다."

Melee_Enchant_Info[8] = {}
Melee_Enchant_Info[8].Name = "명중률 강화"
Melee_Enchant_Info[8].Type = ENCHANT_TYPE_ACCURACY_RATE
Melee_Enchant_Info[8].NormalSelProb = 10
Melee_Enchant_Info[8].SpecialSelProb = 100
Melee_Enchant_Info[8].SuccessProb = 70
Melee_Enchant_Info[8].CorrectProb = 1
Melee_Enchant_Info[8].AccuracyRate = 20
Melee_Enchant_Info[8].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Melee_Enchant_Info[8].Description = "명중률이 +%d%% 증가합니다."

Melee_Enchant_Info[9] = {}
Melee_Enchant_Info[9].Name = "전체 강화"
Melee_Enchant_Info[9].Type = ENCHANT_TYPE_DAMAGE_AND_ACCURACY_RATE 
Melee_Enchant_Info[9].NormalSelProb = 100
Melee_Enchant_Info[9].SpecialSelProb = 0
Melee_Enchant_Info[9].SuccessProb = 60
Melee_Enchant_Info[9].CorrectProb = 1
Melee_Enchant_Info[9].Damage = 7
Melee_Enchant_Info[9].AccuracyRate = 7
Melee_Enchant_Info[9].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAll_1.dtx"
Melee_Enchant_Info[9].Description = "대미지가 +%d%%(+%d), 명중률이 +%d%% 증가합니다."

Melee_Enchant_Info[10] = {}
Melee_Enchant_Info[10].Name = "전체 강화"
Melee_Enchant_Info[10].Type = ENCHANT_TYPE_DAMAGE_AND_ACCURACY_RATE 
Melee_Enchant_Info[10].NormalSelProb = 100
Melee_Enchant_Info[10].SpecialSelProb = 0
Melee_Enchant_Info[10].SuccessProb = 45
Melee_Enchant_Info[10].CorrectProb = 1
Melee_Enchant_Info[10].Damage = 10
Melee_Enchant_Info[10].AccuracyRate = 10
Melee_Enchant_Info[10].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAll_1.dtx"
Melee_Enchant_Info[10].Description = "대미지가 +%d%%(+%d), 명중률이 +%d%% 증가합니다."

Melee_Enchant_Info[11] = {}
Melee_Enchant_Info[11].Name = "전체 강화"
Melee_Enchant_Info[11].Type = ENCHANT_TYPE_DAMAGE_AND_ACCURACY_RATE 
Melee_Enchant_Info[11].NormalSelProb = 100
Melee_Enchant_Info[11].SpecialSelProb = 0
Melee_Enchant_Info[11].SuccessProb = 30
Melee_Enchant_Info[11].CorrectProb = 1
Melee_Enchant_Info[11].Damage = 15
Melee_Enchant_Info[11].AccuracyRate = 15
Melee_Enchant_Info[11].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAll_1.dtx"
Melee_Enchant_Info[11].Description = "대미지가 +%d%%(+%d), 명중률이 +%d%% 증가합니다"

Melee_Enchant_Info[12] = {}
Melee_Enchant_Info[12].Name = "전체 강화"
Melee_Enchant_Info[12].Type = ENCHANT_TYPE_DAMAGE_AND_ACCURACY_RATE 
Melee_Enchant_Info[12].NormalSelProb = 10
Melee_Enchant_Info[12].SpecialSelProb = 100
Melee_Enchant_Info[12].SuccessProb = 55
Melee_Enchant_Info[12].CorrectProb = 1
Melee_Enchant_Info[12].Damage = 20
Melee_Enchant_Info[12].AccuracyRate = 20
Melee_Enchant_Info[12].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAll_1.dtx"
Melee_Enchant_Info[12].Description = "대미지가 +%d%%(+%d), 명중률이 +%d%% 증가합니다"

----------------------------------------------------------------------------------------------------
-- 근접무기 강화 정보가 저장되어 있는 배열의 갯수를 반환한다. 배열변수 앞에 #을 붙이면 갯수가 반환된다.
----------------------------------------------------------------------------------------------------
function GetMeleeEnchantInfoListCount()

	nCount = #Melee_Enchant_Info

	return nCount
end

----------------------------------------------------------------------------------------------------
-- 강화 결과를 정의한다. 클라이언트와 같아야한다.
----------------------------------------------------------------------------------------------------
ENCHANT_RESULT_NOTHING = 0
ENCHANT_RESULT_GREAT_SUCCESS = 1
ENCHANT_RESULT_SUCCESS = 2
ENCHANT_RESULT_MISTAKE = 3
ENCHANT_RESULT_FAIL = 4

----------------------------------------------------------------------------------------------------
-- 강화 결과를 반환한다. nSuccessProb는 0~100의 값이 들어온다.
----------------------------------------------------------------------------------------------------
function GetEnchantResult( nSuccessProb )

	nEnchantResult = ENCHANT_RESULT_NOTHING
	nRandom = math.random( 1, 100 )

	if nRandom <= (nSuccessProb * 0.1)	then
		nEnchantResult = ENCHANT_RESULT_GREAT_SUCCESS

	elseif (nSuccessProb * 0.1 + 1) < nRandom and nRandom <= nSuccessProb	then
		nEnchantResult = ENCHANT_RESULT_SUCCESS

	elseif (nSuccessProb + 1) < nRandom and nRandom <= (100 - (0.2 * (100 - nSuccessProb)))	then
		nEnchantResult = ENCHANT_RESULT_FAIL

	elseif ((100 - (0.2 * (100 - nSuccessProb))) + 1) < nRandom and nRandom <= 100	then
		nEnchantResult = ENCHANT_RESULT_MISTAKE

	end

	return nEnchantResult
end

----------------------------------------------------------------------------------------------------
-- 강화 성공 확률을 정의한다. 클라이언트와 같아야한다.
----------------------------------------------------------------------------------------------------
ENCHANT_SUCCESS_PROBABILITY_NOTHING = 0
ENCHANT_SUCCESS_PROBABILITY_VERY_HIGH = 1
ENCHANT_SUCCESS_PROBABILITY_HIGH = 2
ENCHANT_SUCCESS_PROBABILITY_NOMAL = 3
ENCHANT_SUCCESS_PROBABILITY_LOW = 4
ENCHANT_SUCCESS_PROBABILITY_VERY_LOW = 5

----------------------------------------------------------------------------------------------------
-- 강화 성공 확률을 반환한다. nSuccessProb는 0~100의 값이 들어온다.
----------------------------------------------------------------------------------------------------
function GetEnchantSuccessProbability( nSuccessProb )

	nEnchantSuccessProb = ENCHANT_SUCCESS_PROBABILITY_NOTHING

	if 80 < nSuccessProb	then
		nEnchantSuccessProb = ENCHANT_SUCCESS_PROBABILITY_VERY_HIGH

	elseif 60 < nSuccessProb and nSuccessProb <= 80	then
		nEnchantSuccessProb = ENCHANT_SUCCESS_PROBABILITY_HIGH

	elseif 40 < nSuccessProb and nSuccessProb <= 60	then
		nEnchantSuccessProb = ENCHANT_SUCCESS_PROBABILITY_NOMAL

	elseif 20 < nSuccessProb and nSuccessProb <= 40	then
		nEnchantSuccessProb = ENCHANT_SUCCESS_PROBABILITY_LOW

	elseif nSuccessProb <= 20	then
		nEnchantSuccessProb = ENCHANT_SUCCESS_PROBABILITY_VERY_LOW

	end

	return nEnchantSuccessProb
end

----------------------------------------------------------------------------------------------------
-- 무기상 npc에서 나올 무기 리스트.
----------------------------------------------------------------------------------------------------
Weapon_Npc_Iist_Info = {}

--Weapon_Npc_Iist_Info[1] = {}
--Weapon_Npc_Iist_Info[1].NormalSelProb = 100		-- 일반 무기상 한테 나올 확률
--Weapon_Npc_Iist_Info[1].SpecialSelProb = 100		-- 스페셜 무기상 한테 나올 확률
--Weapon_Npc_Iist_Info[1].WeaponInfoIndex = 1958

Weapon_Npc_Iist_Info[1] = {}
Weapon_Npc_Iist_Info[1].NormalSelProb = 100		-- 일반 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[1].SpecialSelProb = 30	    -- 스페셜 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[1].WeaponInfoIndex = 9

Weapon_Npc_Iist_Info[2] = {}
Weapon_Npc_Iist_Info[2].NormalSelProb = 100		-- 일반 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[2].SpecialSelProb = 30		-- 스페셜 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[2].WeaponInfoIndex = 4

Weapon_Npc_Iist_Info[3] = {}
Weapon_Npc_Iist_Info[3].NormalSelProb = 100		-- 일반 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[3].SpecialSelProb = 0		-- 스페셜 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[3].WeaponInfoIndex = 36

Weapon_Npc_Iist_Info[4] = {}
Weapon_Npc_Iist_Info[4].NormalSelProb = 100		-- 일반 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[4].SpecialSelProb = 0		-- 스페셜 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[4].WeaponInfoIndex = 13

Weapon_Npc_Iist_Info[5] = {}
Weapon_Npc_Iist_Info[5].NormalSelProb = 50		-- 일반 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[5].SpecialSelProb = 100	-- 스페셜 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[5].WeaponInfoIndex = 3104

Weapon_Npc_Iist_Info[6] = {}
Weapon_Npc_Iist_Info[6].NormalSelProb = 50		-- 일반 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[6].SpecialSelProb = 100	-- 스페셜 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[6].WeaponInfoIndex = 2848

Weapon_Npc_Iist_Info[7] = {}
Weapon_Npc_Iist_Info[7].NormalSelProb = 50		-- 일반 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[7].SpecialSelProb = 10	-- 스페셜 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[7].WeaponInfoIndex = 2959

Weapon_Npc_Iist_Info[8] = {}
Weapon_Npc_Iist_Info[8].NormalSelProb = 0		-- 일반 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[8].SpecialSelProb = 40	-- 스페셜 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[8].WeaponInfoIndex = 3068

Weapon_Npc_Iist_Info[9] = {}
Weapon_Npc_Iist_Info[9].NormalSelProb = 0		-- 일반 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[9].SpecialSelProb = 40	-- 스페셜 무기상 한테 나올 확률
Weapon_Npc_Iist_Info[9].WeaponInfoIndex = 1107
----------------------------------------------------------------------------------------------------
-- 무기상 npc가 가지고있는 무기 정보가 저장되어 있는 배열의 갯수를 반환한다. 배열변수 앞에 #을 붙이면 갯수가 반환된다.
----------------------------------------------------------------------------------------------------
function GetWeaponNpcListInfoCount()

	nCount = #Weapon_Npc_Iist_Info

	return nCount
end

----------------------------------------------------------------------------------------------------
-- 무기상 npc의 팝업창에 나올 탄약, hp회복에 대한 정보.
----------------------------------------------------------------------------------------------------
WEAPON_NPC_MAGAZINE_NAME = "탄약 전체 보급"
WEAPON_NPC_MAGAZINE_ICON = "sa_interface2/hud/elevator/Icon/RG_Icon_BulletSupply_1.dtx"
WEAPON_NPC_MAGAZINE_DESCRIPTION = "주무기의 탄약을 모두 채워준다."

WEAPON_NPC_HP_NAME = "HP 100 회복"
WEAPON_NPC_HP_ICON = "sa_interface2/hud/elevator/Icon/RG_Icon_HPRecovery_1.dtx"
WEAPON_NPC_HP_DESCRIPTION = "HP를 100 회복한다."

----------------------------------------------------------------------------------------------------
-- 인벤토리에 표시될 이동속도에 사용될 값. "총기의 무게 * MOVE_SPEED_MULTIPLY"로 표시된다.
----------------------------------------------------------------------------------------------------
PLAYER_MOVE_SPEED_MULTIPLY = 100



----------------------------------------------------------------------------------------------------
--    개별 무기 드랍이 가능한 무기의 ID
----------------------------------------------------------------------------------------------------
EachThrowWeaponCount = 1

EachThrowWeaponID = {}
EachThrowWeaponID[1] = 3064

function GetEachThrowWeaponID( nIndex )

    WeaponID = -1

    if EachThrowWeaponID[nIndex] ~= nil then
        WeaponID= EachThrowWeaponID[nIndex]
    end
    
    return WeaponID

end
----------------------------------------------------------------------------------------------------
--    무기 드랍했을때 크기 조정.
----------------------------------------------------------------------------------------------------
DropWeaponScale =  {}
        
DropWeaponScale[1] =  {}
DropWeaponScale[1].ID = 3064    --    무기ID
DropWeaponScale[1].Scale = 2    --    스케일

function GetDropWeaponScale( nWeaponID )

    for k, v in pairs(DropWeaponScale) do
        
        if nWeaponID == v.ID then
            return v.Scale
        end
        
    end    
    
    return 1

end






-------------------------