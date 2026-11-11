--------------------------------------------------------------------
-- UI 세팅하는 부분...

-- 리턴 순서  x위치, y위치, x크기, y크기, 중앙정렬이면 1 우측정렬이면 2
function UIMainPosition(Index)
	if Index == 0 then	-- CaptureScore_BG0.dtx
		return 244, 0, 512, 32, 1
	end
	if Index == 1 then	-- CaptureScore_BG1.dtx
		return 244, 0, 512, 32, 1
	end
	if Index == 2 then	-- UIElem_CaptureScore_Empty
		return 366, 4, 128, 32, 1
	end
	if Index == 3 then	-- Capture_RED
		return 244, 140, 512, 64, 1
	end
	if Index == 4 then	-- Capture_BLUE
		return 244, 140, 512, 64, 1
	end
	if Index == 5 then	-- Capture_Flag0
		return 244, 140, 512, 64, 1
	end
	if Index == 6 then	-- Capture_Flag1
		return 244, 140, 512, 64, 1
	end
	if Index == 7 then	-- Capture_Flag2
		return 244, 140, 512, 64, 1
	end
	if Index == 8 then	-- SC_NotiNotuseditem
		return 244, 100, 512, 64, 1
	end
	if Index == 9 then	-- SC_NotiHookDistance
		return 244, 100, 512, 64, 1
	end
	if Index == 10 then	-- SC_Rating0
		return 200, 530, 512, 64, 1
	end
	if Index == 11 then	-- SC_Rating1
		return 200, 530, 512, 64, 1
	end
	if Index == 12 then	-- SC_Rating2
		return 200, 530, 512, 64, 1
	end
	if Index == 13 then	-- 점프스킬
		return 800-90, 430, 128, 128, 2
	end	
	if Index == 14 then	-- 점프스킬 2
		return 800-90, 430, 128, 128, 2
	end	
	if Index == 15 then	-- 그래플링 훅
		return 800-90, 430, 128, 128, 2
	end	
	if Index == 16 then	-- 그래플링 훅2
		return 800-90, 430, 128, 128, 2
	end	
	if Index == 17 then	-- 레이지
		return 800-90, 430, 128, 128, 2
	end	
	if Index == 18 then	-- 월핵2
		return 800-90, 430, 128, 128, 2
	end	
	if Index == 19 then	-- 체인지 스킬
		return 800-180, 430, 128, 128, 2
	end	
	if Index == 20 then	-- 스피드업
		return 400-64, 430, 128, 128, 2
	end	
	if Index == 21 then	-- SC_NotiCountDown
		return 400-156, 430, 512, 64, 2
	end		
	if Index == 22 then	-- 서든 데스
		return 400-400, 150, 512, 256, 2
	end
	if Index == 23 then	-- 서든 데스2
		return 400-400+512, 150, 512, 256, 2
	end
	if Index == 24 then	-- 서든 데스 시작
		return 400-400, 150, 512, 256, 2
	end
	if Index == 25 then	-- 서든 데스 시작2
		return 400-400+512, 150, 512, 256, 2
	end
	if Index == 26 then	-- 부팅 중
		return 366, 4, 128, 32, 1
	end	
	if Index == 27 then	-- 점령지가 선정되었습니다.
		return 600-400, 140, 512, 128, 2
	end	
	if Index == 28 then	-- 레드 세미콜론
		return 553-160, 6, 16, 32, 2
	end	
	if Index == 29 then	-- 블루 세미콜론
		return 553-160, 6, 16, 32, 2
	end	
	if Index == 30 then	-- Capture_RED_ex
		return 244, 220, 512, 64, 1
	end
	if Index == 31 then	-- Capture_BLUE_ex
		return 244, 220, 512, 64, 1
	end	
	if Index == 32 then	-- Capture_Score0
		return 485, 52, 32, 32, 1
	end	
	if Index == 33 then	-- Capture_Score1
		return 280, 52, 32, 32, 1
	end	
	if Index == 34 then	-- Capture_Score2
		return 280, 52, 32, 32, 1
	end	
	
-- 리턴 순서  x위치, y위치, x크기, y크기, 중앙정렬이면 1 우측정렬이면 2
	return 0, 0, 256, 256, 0
end

function UIOccupationPoint() --점령지 선정될때 출력되는 랜드마크 아이콘 
	return 200, 141, 128, 128, 2
end

--function UISkillTextPosition()	-- 스킬 설명 x, 스킬 아이콘 y 오프셋. 안그러면 해상도 지원이 안됨
--	return 800-176, 20 -- 두전째 값은 스킬 아이콘보다 20정도 위로 올린다.
--end

--function UIChangeSkillTextPosition()	-- 체인지스킬 설명 x, 스킬 아이콘 y 오프셋. 안그러면 해상도 지원이 안됨
--	return 800-266, 20 -- 두전째 값은 스킬 아이콘보다 20정도 위로 올린다.
--end

--function UIRedScorePosition()	-- 레드팀 스코어 x, y, 간격 -- CaptureScore_Normal0.dtx
--	return 275, 7, 15
--end

--function UIBlueScorePosition()	-- 블루팀 스코어 CaptureScore_Normal0.dtx
--	return 485, 7, 15
--end

--function UITimeCounterPosition() -- 중앙 시간 카운터, 분, 초, y, 간격 CaptureScore_Red0.dtx
--	return 365, 404, 6, 15
--end

--function UICountDownPosition() -- 카운트 다운 x, y Capture_Count0.dtx
--	return 375, 50
--end

function UIRedDotPosition()
	return 275, 30, 15
end

function UIBlueDotPosition()
	return 515, 30, -15				-- 왼쪽으로 칠해지므로 3번째 값은 반드시 마이너스여야 함.
end


--UITabSize = 512 + 128			-- 상황판 배경 실제 가로 사이즈. 이거 기반으로 중앙 정렬
--UITabY = 40     				-- 상황판 배경 최상단의 y위치, 이 값은 해상도에 따라 위치 변경시킴
--UITabItem_Y = 108				-- 상황판 배경에서 글자가 오는 y의 위치
--UITabItem_Line = 30				-- 상황판 라인의 오프셋
--UITabRedItem_Grade = 10			-- 상황판 레드팀 계급
--UITabRedItem_GradeY = -5		-- 상황판 레드팀 계급 y오프셋
--UITabRedItem_Name = 50			-- 상황판 레드팀 이름 오프셋
--UITabRedItem_Battle = 150		-- 상황판 레드팀 이름 전투평점
--UITabRedItem_Point = 170		-- 상황판 레드팀 이름 점령
--UITabRedItem_Kill = 215			-- 상황판 레드팀 이름 킬
--UITabRedItem_Assi = 245			-- 상황판 레드팀 이름 어시
--UITabRedItem_Ping = 290			-- 상황판 레드팀 이름 핑
--UITabRedItem_PingY = 0			-- 상황판 레드팀 이름 핑 y오프셋

--UITabBlueItem_Offset = 320		-- 블루팀은 레드팀에 비해 이 값을 오른쪽으로 더해준다.

--UIPoint_HostX = 10
--UIPoint_HostY = 12

-- 점령지 표시 아이콘 밖으로 나가지 않게 처리하기
UIPoint_IconX = 5
UIPoint_IconY = 5
UIPoint_IconX2 = 800 - 37
UIPoint_IconY2 = 600 - 37

-- 아래 숫자는 지우자.

--TabScoreRed = 215
--TabScoreBlue = 540
--TabScoreY = 350

--TabTitle = 64
--TabTitleY = 48

--ClanRed1 = 12				-- 클랜전 탭상황판UI 왼쪽 상단의 레드(mission)
--ClanRed1Y = 30				-- 위의 값의 y오프셋
--ClanRed2 = 12				-- 클랜전 kill
--ClanRed2Y = 50				-- 위의 값의 y오프셋

--ClanBlue1 = 110				-- 클랜전 탭상황판UI 왼쪽 상단의 블루(mission)
--ClanBlue2 = 110				-- 클랜전 kill

--OccupationAllyOffset = 160  --점령 중인 같은 편 UI 위로 올리는 값

--Medal = 12					-- 상황판의 메달
--MedalY = -5

--Clan_Name = 140				-- 클랜전 플레이어 이름
--Clan_Point = 228			-- 클랜전 플레이어 전투평점
--Clan_Kill = 253				-- 클랜전 플레이어 킬
--Clan_Ping = 295				-- 클랜전 플레이어 핑

--UIHealth_Num = 50
--UIHealth_NumY = 577
--UIHealth_Width = 13

--UIArmor_Num = 160
--UIArmor_NumY = 577
--UIArmor_Width = 13


--RageX = 800
--RageY = 600
--RageTick = 0.3	--0.3초마다 바뀜
--RageOverlap = 0.2 -- 이 시간은 텍스처들이 오버랩됨
--RageTick2 = 0.4	--0.3초마다 바뀜
--RageOverlap2 = 0.3 -- 이 시간은 텍스처들이 오버랩됨
--RageMinSpeed = 330	-- 내 속도가 이거보다 빠르면 alpha가 적용되기 시작
--RageMaxSpeed = 500	-- 내 속도가 이거 이상이면 alpha = 1임.
--------------------------------------------------------------------
-- UI 세팅하는 부분 끝








 









------------------------------------------------------------