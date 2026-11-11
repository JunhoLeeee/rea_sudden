----------------------------------------------------------------------------------------------------
--  시즌전 기본 설정값
----------------------------------------------------------------------------------------------------
LayoutInfo		= "sa_worlds\\loading\\SurvivalSeason\\SurvivalSeason"





----------------------------------------------------------------------------------------------------
--	기록 타입. 낮은 값일 수록 우선순위가 높아져서 기록항목에서 앞에 위치하게 된다.
--	클라이언트와 같은 값을 사용하고 있다. 수정이나 추가시 클라이언트와 동기화 할것.
----------------------------------------------------------------------------------------------------
Type_Play_Count 			= 1			-- 플레이 횟수
Type_Best_Score 			= 2			-- 최고 점수	
Type_Best_Rank 				= 3			-- 최고 등수
Type_Win_Count 				= 4			-- 우승 횟수
Type_Average_Win_Rate 			= 5			-- 평균 우승 확률
Type_Average_Kill 			= 6			-- 평균 킬
Type_Average_Survival_Rate 		= 7			-- 평균 생존력
Type_Map_Survival_Rate 			= 8			-- 32구역 생존력
Type_Map_Model_Apartment_Rate 		= 9			-- 시범단지 생존력
Type_Map_China_Town_Rate 		= 10			-- 차이나 타운 생존력

----------------------------------------------------------------------------------------------------
--	등급값을 반환한다.
----------------------------------------------------------------------------------------------------
function GetGrade( Type, Value )
	
	Grade = 0

	if 	( Type == Type_Play_Count )			then
		Grade = GetPlayCountGrade( Value )

	elseif	( Type == Type_Best_Score )			then
		Grade = GetBestScoreGrade( Value )

	elseif	( Type == Type_Best_Rank )			then
		Grade = GetBestRankGrade( Value )

	elseif	( Type == Type_Win_Count )			then
		Grade = GetWinCountGrade( Value )

	elseif	( Type == Type_Average_Win_Rate )		then
		Grade = GetAverageWinRateGrade( Value )

	elseif	( Type == Type_Average_Kill )			then
		Grade = GetAverageKillGrade( Value )

	elseif	( Type == Type_Average_Survival_Rate )		then
		Grade = GetAverageSurvivalRateGrade( Value )

	elseif	( Type == Type_Map_Survival_Rate )		then
		Grade = GetMapSurvivalRateGrade( Value )

	elseif	( Type == Type_Map_Model_Apartment_Rate )	then
		Grade = GetMapModelApartmentRateGrade( Value )

	elseif	( Type == Type_Map_China_Town_Rate )		then
		Grade = GetMapChinaTownRateGrade( Value )

	end

	return Grade

end

----------------------------------------------------------------------------------------------------
--	플레이 횟수 등급값을 반환한다.
----------------------------------------------------------------------------------------------------
function GetPlayCountGrade( Value )
	
	Grade = 0

	if 	( 0 < Value and Value < 10 )	then
		Grade = 1
	elseif	( 10 <= Value and Value < 30 )	then
		Grade = 2
	elseif	( 30 <= Value and Value < 50 )	then
		Grade = 3
	elseif	( 50 <= Value and Value < 100 )	then
		Grade = 4
	elseif	( 100 <= Value ) 	then
		Grade = 5
	end

	return Grade

end

----------------------------------------------------------------------------------------------------
--	최고 점수 등급값을 반환한다.
----------------------------------------------------------------------------------------------------
function GetBestScoreGrade( Value )
	
	Grade = 0

	if 	( 1 <= Value and Value < 1000 )	then
		Grade = 1
	elseif	( 1000 <= Value and Value < 2000 )	then
		Grade = 2
	elseif	( 2000 <= Value and Value < 3000 )	then
		Grade = 3
	elseif	( 3000 <= Value and Value < 4000 )	then
		Grade = 4
	elseif	( 4000 <= Value )	then
		Grade = 5
	end

	return Grade

end

----------------------------------------------------------------------------------------------------
--	최고 등수 등급값을 반환한다.
----------------------------------------------------------------------------------------------------
function GetBestRankGrade( Value )
	
	Grade = 0

	if 	( Value == 1 )				then
		Grade = 5
	elseif	( Value == 2 )		                then
		Grade = 4
	elseif	( 2 < Value and 4 >= Value )		then
		Grade = 3
	elseif	( 4 < Value and 9 >= Value )		then
		Grade = 2
	elseif	( 9 < Value and 32 >= Value )		then
		Grade = 1
	end

	return Grade

end

----------------------------------------------------------------------------------------------------
--	우승 횟수 등급값을 반환한다.
----------------------------------------------------------------------------------------------------
function GetWinCountGrade( Value )
	
	Grade = 0

	if 	( Value == 1 )		then
		Grade = 1
	elseif	( 1 < Value and Value <= 4 )		then
		Grade = 2
	elseif	( 4 < Value and Value <= 9 )		then
		Grade = 3
	elseif	( 9 < Value and Value <= 19 )		then
		Grade = 4
	elseif	( 19 < Value )		then
		Grade = 5
	end

	return Grade

end

----------------------------------------------------------------------------------------------------
--	평균 우승 확률 등급값을 반환한다.
----------------------------------------------------------------------------------------------------
function GetAverageWinRateGrade( Value )
	
	Grade = 0

	if 	( 0 < Value and Value < 3 )		then
		Grade = 1
	elseif	( 3 <= Value and Value < 7 )		then
		Grade = 2
	elseif	( 7 <= Value and Value < 10 )		then
		Grade = 3
	elseif	( 10 <= Value and Value < 15 )		then
		Grade = 4
	elseif	( 15 <= Value)		then
		Grade = 5
	end

	return Grade

end

----------------------------------------------------------------------------------------------------
--	평균 킬 등급값을 반환한다.
----------------------------------------------------------------------------------------------------
function GetAverageKillGrade( Value )
	
	Grade = 0

	if 	( 0 < Value and Value < 0.5 )		then
		Grade = 1
	elseif	( 0.5 <= Value and Value < 1 )		then
		Grade = 2
	elseif	( 1 <= Value and Value < 2 )		then
		Grade = 3
	elseif	( 2 <= Value and Value < 3 )		then
		Grade = 4
	elseif	( 3 <= Value )		then
		Grade = 5
	end

	return Grade

end

----------------------------------------------------------------------------------------------------
--	평균 생존력 등급값을 반환한다.
----------------------------------------------------------------------------------------------------
function GetAverageSurvivalRateGrade( Value )
	
	Grade = 0

	if 	( 0 < Value and Value < 40 )		then
		Grade = 1
	elseif	( 40 <= Value and Value < 50 )		then
		Grade = 2
	elseif	( 50 <= Value and Value < 60 )		then
		Grade = 3
	elseif	( 60 <= Value and Value < 70 )		then
		Grade = 4
	elseif	( 70 <= Value )		then
		Grade = 5
	end

	return Grade

end

----------------------------------------------------------------------------------------------------
--	32구역 생존력 등급값을 반환한다.
----------------------------------------------------------------------------------------------------
function GetMapSurvivalRateGrade( Value )
	
	Grade = 0


	if 	( 0 < Value and Value < 40 )		then
		Grade = 1
	elseif	( 40 <= Value and Value < 50 )		then
		Grade = 2
	elseif	( 50 <= Value and Value < 60 )		then
		Grade = 3
	elseif	( 60 <= Value and Value < 70 )		then
		Grade = 4
	elseif	( 70 <= Value )		then
		Grade = 5
	end

	return Grade

end

----------------------------------------------------------------------------------------------------
--	시범단지 생존력 등급값을 반환한다.
----------------------------------------------------------------------------------------------------
function GetMapModelApartmentRateGrade( Value )
	
	Grade = 0

	if 	( 0 < Value and Value < 40 )		then
		Grade = 1
	elseif	( 40 <= Value and Value < 50 )		then
		Grade = 2
	elseif	( 50 <= Value and Value < 60 )		then
		Grade = 3
	elseif	( 60 <= Value and Value < 70 )		then
		Grade = 4
	elseif	( 70 <= Value )		then
		Grade = 5
	end

	return Grade

end

----------------------------------------------------------------------------------------------------
--	차이나 타운 생존력 등급값을 반환한다.
----------------------------------------------------------------------------------------------------
function GetMapChinaTownRateGrade( Value )
	
	Grade = 0


	if 	( 0 < Value and Value < 40 )		then
		Grade = 1
	elseif	( 40 <= Value and Value < 50 )		then
		Grade = 2
	elseif	( 50 <= Value and Value < 60 )		then
		Grade = 3
	elseif	( 60 <= Value and Value < 70 )		then
		Grade = 4
	elseif	( 70 <= Value )		then
		Grade = 5
	end

	return Grade

end

------------------------------------------------------------------------------------------------
--  로비 시즌전 버튼 설정
------------------------------------------------------------------------------------------------

SeasonStartNAniTexture = {}
SeasonStartNAniTexture[0] = "sa_interface2/menu/Survival/Lobby/LobbyBtn01_c_ani01.dtx"
SeasonStartNAniTexture[1] = "sa_interface2/menu/Survival/Lobby/LobbyBtn01_c_ani02.dtx"
SeasonStartNAniTexture[2] = "sa_interface2/menu/Survival/Lobby/LobbyBtn01_c_ani03.dtx"
SeasonStartNAniTexture[3] = "sa_interface2/menu/Survival/Lobby/LobbyBtn01_c_ani04.dtx"
SeasonStartNAniTexture[4] = "sa_interface2/menu/Survival/Lobby/LobbyBtn01_c_ani05.dtx"
SeasonStartNAniTexture[5] = "sa_interface2/menu/Survival/Lobby/LobbyBtn01_c_ani06.dtx"
SeasonStartNAniTexture[6] = "sa_interface2/menu/Survival/Lobby/LobbyBtn01_c_ani07.dtx"
SeasonStartNAniTexture[7] = "sa_interface2/menu/Survival/Lobby/LobbyBtn01_c_ani08.dtx"


SeasonTextureStartN = "sa_interface2/menu/Survival/Lobby/LobbyBtn01_n.dtx"
SeasonTextureStartS = "sa_interface2/menu/Survival/Lobby/LobbyBtn01_o.dtx"
SeasonTextureStartC = "sa_interface2/menu/Survival/Lobby/LobbyBtn01_c.dtx"
SeasonTextureStartD = "sa_interface2/menu/Survival/Lobby/LobbyBtn01_d.dtx"

SeasonTextureStopN = "sa_interface2/menu/Survival/Lobby/LobbyBtn03_n.dtx"
SeasonTextureStopS = "sa_interface2/menu/Survival/Lobby/LobbyBtn03_o.dtx"
SeasonTextureStopC = "sa_interface2/menu/Survival/Lobby/LobbyBtn03_c.dtx"
SeasonTextureStopD = "sa_interface2/menu/Survival/Lobby/LobbyBtn03_d.dtx"

NoSeasonTextureN = "sa_interface2/menu/Survival/Lobby/LobbyBtn04_n.dtx"
NoSeasonTextureS = "sa_interface2/menu/Survival/Lobby/LobbyBtn04_o.dtx"
NoSeasonTextureC = "sa_interface2/menu/Survival/Lobby/LobbyBtn04_c.dtx"
NoSeasonTextureD = "sa_interface2/menu/Survival/Lobby/LobbyBtn04_d.dtx"

SeasonAniFrameTime = 0.15
SeasonAniTotalFrame = 18





------------------------------------------------------------