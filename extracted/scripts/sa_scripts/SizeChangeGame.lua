-----------------------------------------------------------------------------
-- 게임 세팅
GameCountDown = 10				-- 카운트 다운 시간
BootingCountDown = 15			-- 부팅 카운트 시간
fOccupationTime = 60.0			-- 점령시작부터 완료까지의 시간
fOccupationRepeatTime = 10.0	-- 점령이 반복되면 시간이 줄어드는 정도
fMinOccupationTime = 30.0		-- 최소 점령시간
SuddenDeathTime = 180

nOccupationWinCount = 3			-- 몇 번 점령하면 승리하는지.

OccuBaseModel = "sa_props\\models\\sizechange\\sc_informachine.ltb"
OccuBaseSkin = "sa_props\\skins\\sizechange\\SC_off.dtx"
OccuActivateSkin = "sa_props\\skins\\sizechange\\SC_activated.spr"
OccuLoadingSkin = "sa_props\\skins\\sizechange\\SC_Loading.spr"
OccuCompleteSkin = "sa_props\\skins\\sizechange\\SC_Complete.spr"

-------------------------------------------------------------------------------
-- 전체 캐릭터 세팅
--JarCameraNormalPitchScale_Big = 0.05	-- 평소에 뚜까맞을때 위아래 흔들림 기존 무기 대비 비율
--JarCameraNormalYawScale_Big = 0.05   	-- 평소에 뚜까맞을때 좌우 흔들림 기존 무기 대비 비율
--JarCameraNormalPitchScale_Small = 1.0	-- 평소에 뚜까맞을때 위아래 흔들림 기존 무기 대비 비율
--JarCameraNormalYawScale_Small = 1.0		-- 평소에 뚜까맞을때 좌우 흔들림 기존 무기 대비 비율

JarCameraGadgetPitchScale_Big = 0.0		-- 타켓 점령시 얻어맞을때 위아래 흔들림 기존 무기 대비 비율
JarCameraGadgetYawScale_Big = 0.0		-- 타겟 점령시 얻어맞을때 좌우 흔들림 기존 무기 대비 비율
JarCameraGadgetPitchScale_Small = 0.0	-- 타켓 점령시 얻어맞을때 위아래 흔들림 기존 무기 대비 비율
JarCameraGadgetYawScale_Small = 0.0		-- 타겟 점령시 얻어맞을때 좌우 흔들림 기존 무기 대비 비율


----------------------------------
----------------------------------------------
---- 점령지 선정 공식
OccPoint = {}
OccPoint["ChangeFlag00"] = 0		-- 0이면 레드, 1이면 블루, 2이면 중립
OccPoint["ChangeFlag01"] = 1
OccPoint["ChangeFlag02"] = 2
OccPoint["ChangeFlag03"] = 0
OccPoint["ChangeFlag04"] = 1

OccIndex = {}
OccIndex["ChangeFlag00"] = 0		-- 인덱스를 설정해줘야 함. 제대로 설정하지 않으면 등록 안됨. 서버로 보내는 값임.
OccIndex["ChangeFlag01"] = 1
OccIndex["ChangeFlag02"] = 2
OccIndex["ChangeFlag03"] = 3
OccIndex["ChangeFlag04"] = 4

OccFlags = {}
OccFlags["MovableFXPoint00"] = 0		-- 점령지 포인트의 인덱스와 일치 OccIndex
OccFlags["MovableFXPoint01"] = 1
OccFlags["MovableFXPoint02"] = 2
OccFlags["MovableFXPoint03"] = 3
OccFlags["MovableFXPoint04"] = 4

BlockIndex = {}
BlockIndex["FlagBlocker00"] = 0		-- 인덱스를 설정해줘야 함. 블록이름과 인덱스를 맞춰줘야 함.
BlockIndex["FlagBlocker01"] = 1
BlockIndex["FlagBlocker02"] = 2
BlockIndex["FlagBlocker03"] = 3
BlockIndex["FlagBlocker04"] = 4

BlockContainerIndex = {}
BlockContainerIndex["FlagArea00"] = 0		-- 인덱스를 설정해줘야 함. 블록이름과 인덱스를 맞춰줘야 함.
BlockContainerIndex["FlagArea01"] = 1
BlockContainerIndex["FlagArea02"] = 2
BlockContainerIndex["FlagArea03"] = 3
BlockContainerIndex["FlagArea04"] = 4


OccWeights = {1, 1, 1000}	-- 가중치, (레드, 블루, 중립)

function GetOccPoint(RedPoint, BluePoint)
	local RedDiff =  BluePoint - RedPoint -- 레드가 얼마나 지고 있나.
	local BlueDiff = RedPoint - BluePoint -- 블루가 얼마나 지고 있나.
	local RedVal, BlueVal, Neutral = OccWeights[1], OccWeights[2], OccWeights[3]
	if RedDiff > 0 then -- 레드가 지고 있다면
		RedVal = RedVal + RedDiff * 10000
	elseif BlueDiff > 0 then -- 블루가 지고 있다면
		BlueVal = BlueVal + BlueDiff * 10000
	end
	
	return RedVal, BlueVal, Neutral
end

--- 점령지 이름에 따라 레드 블루 중립 세팅하는 부분.
function InitOccPoint(Name)
	local Point = OccPoint[Name]
	local Index = OccIndex[Name]
	if Index == nil then
		return 2, -1
	end
	if Point == nil then
		return 2, -1
	end
	return Point, Index
end

--- 점령지의 FX위치를 지정해준다.
function InitOccPointFlag(Name)
	local Index = OccFlags[Name]
	if Index == nil then
		return 0, 0		-- 뒤의 0은 못 찾은 것을 의미함.
	end
	return Index, 1
end

function InitBlockSetting(Name)
	local Index = BlockIndex[Name]
	if Index == nil then
		return 0, 0		-- 뒤의 0은 못 찾은 것을 의미함.
	end
	return Index, 1
end

function GetBlockContainer(Index)
	if Index == 0 then
		return "FlagArea00"
	end
	if Index == 1 then
		return "FlagArea01"
	end
	if Index == 2 then
		return "FlagArea02"
	end
	if Index == 3 then
		return "FlagArea03"
	end
	if Index == 4 then
		return "FlagArea04"
	end
	return "None"
end

-- 스킬 획득으로 인한 변신 시간
--ChangeScaleTime = 1.5
BodyScaleTime = 1.5							-- 시체가 변하는 시간

-- 5.5배 크기 캐릭터의 점프 스킬
--Glide_JumpRatio = 2.8  					    -- 점프하는 순간 속도의 배율
--Glide_GravityRatio = 0.17					-- 점프 할때 중력값 변동

--Glide_Factor = 7000						    -- 강습 값 조절
Glide_ShakingVal1 = 0  						-- 최소 흔들림 각도
Glide_ShakingVal2 = 0   					-- 최대 흔들림 각도
Glide_fShakingVel = 0						-- 1초에 이만큼 흔들림

Glide_CameraDist = 1000						-- 캐릭터와 카메라의 거리
Glide_CameraHeight = 100					-- 카메라가 바라보는 곳의 높이.
--Glide_CameraPitchMin = 25					-- 카메라 회전 최대한 낮은 각도.
--Glide_CameraPitchMax = 85					-- 카메라 회전 최대한 높은 각도
Glide_CameraTargetOffset = -500

--GlideAttack_PauseTime = 0.8         		-- 강습 공격하면 1초간 움직임에 락이 걸림
--GlideAttack_Distance = 850					-- 강습 공격 대미지 범위
GlideAttack_ImpactFX = "sc_skillimpact1"
GlideAttack_ImpactFX2 = "sc_skillimpact2"
--GlideAttack_AutoAttack = 1200
--GlideAttack_CheckTime = 1.2					-- 강습 공격이 이 시간내로 끝나버리면 대미지도 주지 않지만 쿨타임도 주지 않음.

--Glide_JumpDelay = 0.3						-- 강습 공격 버튼 누르고 애니메이션 때문에 주는 딜레이
Glide_JumpAniDelay = 1.8					-- 강습 점프 애니메이션 끝나고 다음 애니메이션 트는 시간
Glide_CoolTime = 30.0		                -- 쿨타임

--BigSkill_RunSpeed = 2.5                     -- 평소 이동속도
--BigSkill_ThrowSpeed = 1.25					-- 폭탄 던지기 속도
--BigSkill_MeleeAttackLen = 500				-- 밀리 어택 길이를 더해준다.
--BigSkill_CrouchOffset = 100					-- 큰 캐릭터가 앉기 동작할때 아래로 내리는 정도

-- 0.5배 크기 캐릭터의 갈고리 스킬
--HookSkill_FlySpeed = 2000				-- (지울 예정)갈고리 스킬로 날아가는 시간
HookSkill_AnimTime = 0.770				-- 갈고리 스킬 776프레임. 시간으로 표현함.
HookSkill_FixTime = 0.5					-- (이제는 안쓰임)갈고리에 딱 붙는 시간
HookSkill_MovingTime = 0.17				-- 갈고리를 던질 때 갈고리가 날아가는게 보여지는 시간. 이 시간이 지나면 날아감

--HookSkill_JumpRatio = 2					-- (이제는 안쓰임)갈고리 막판에 점프할때의 높이
--HookSkill_JumpAniTime = 0.734			-- (이제는 안쓰임)갈고리 막판에 점프할때 애니메이션 트는 부분. 그 이후에는 1인칭
--HookSkill_JumpDist = 200				-- (지울 예정)갈고리 타겟으로 날아가는 캐릭터가 거리 이내로 도달하면 점프한다.

HookSkill_CameraDist = 150				-- 캐릭터와 카메라의 거리
HookSkill_CameraHeight = 0   			-- 카메라가 바라보는 곳의 높이.
--HookSkill_CameraPitchMin = -25		 	-- 카메라 회전 최대한 낮은 각도.
--HookSkill_CameraPitchMax = 25			-- 카메라 회전 최대한 높은 각도

--HookSkill_MaxDist = 3000				-- (이제는 안쓰임)갈고리를 얼마나 멀리 날릴 수 있는지
--HookSkill_MinDist = 200					-- (이제는 안쓰임)갈고리가 너무 가까우면 못날리게 함.
HookSkill_NormalDist = 10				-- 갈고리를 벽에 닿을때 파묻혀서 날아갈 위치를 노말 앞으로 조금 당김

HookSkill_CoolTime = 1.0				-- 쿨타임


InChange_CameraDist = 500				-- 캐릭터와 카메라의 거리
InChange_CameraHeight = -50   			-- 카메라가 바라보는 곳의 높이.
InChange_CameraPitchMin = 8 		 	-- 카메라 회전 최대한 낮은 각도.
InChange_CameraPitchMax = 25			-- 카메라 회전 최대한 높은 각도

-- 레이지 스킬
RageSkill_CoolTime = 23					-- 레이지 스킬 쿨타임
--Rage_RunSpeed = 1.3                     -- ()평소 이동속도
--RageFastRun = 2.5   					-- ()레이지 스킬 사용시 이동속도
--RageFastRunTime = 7			        	-- (이제는 안쓰임)레이지 스킬 사용시간

-- 중간 캐릭터 이속증가 버프
--FastRunTime = 3.5						-- (이제는 안쓰임)이 시간 동안 빨리 달림
--FastRun = 2.5	        				-- (이제는 안쓰임)이만큼 빨리 달림.

------- 아이템 스폰 방식 변수 --------------------------------
--ItemSpawnTick = 10.0					-- n초마다 아이템 랜덤 스폰, 만약 아이템이 존재할 경우에는 생성 무시
--ItemValue_Plus = 1						-- 플러스 아이템 생성시 값
--ItemValue_Minus = 1						-- 마이너스 아이템 생성시 값
--ItemPack_Plus = "God_Itembox_Blue"		-- 플러스 아이템 프롭 네임
--ItemPack_Minus = "God_Itembox_Red"		-- 마이너스 아이템 프롭 네임

-------------------------------------------------------------------
ID_OccupationPoint = 0		-- 점령지 포인트 이거는 절대로 바꿔서는 안됨.
ID_OccupationFlag = 1		-- 점령지 포인트 위에 FX를 표시하는 위치
ID_OccupationBlocker = 2	-- 점령지 못 들어가게 블로커 처리
--ID_ItemPack = 2

--------- 사이즈 체인지 크기----------------------------------------
---------- 소스코드와 일치시켰음-----------------------------------
ID_Player_Base = 0			-- 사이즈 체인지를 하지 않음. 기본 스킬이 추가될 수 있음.
ID_Player_Big = 1			-- 플레이어의 크기이자, 아이템의 종류. (아이템은 빠질수도 있음) 절대 0으로 세팅하면 안됨. 그건 캐릭터 기본 값임.
ID_Player_Small = 2
ID_Player_Medium = 3

--function MakeItemPack(ItemIndex, ItemName)
--	if string.find(ItemName, "MovableModel") then		-- 맵툴 클래스에 해당 이름이 포함되었다면..
--		if math.random(1, 2) == 1 then -- 1과 2를 랜덤으로해서 1이라면..
--			return ID_ItemPack, "God_Itembox_Blue"
--		end
--		return ID_ItemPack, "God_Itembox_Red"
--	end
--	if math.random(1, 2) == 1 then -- 1과 2를 랜덤으로해서 1이라면..
--		return ID_ItemPack, "God_Itembox_Blue"
--	end
--	return ID_ItemPack, "God_Itembox_Red"	
--end

-- 사이즈 체인지 세팅
-- input : ItemID
-- output : Size, HP, AP, MaxHP, MaxAP
--          Size - 결과 플레이어 크기
--          HP, AP, MaxHP, MaxAP 결과 체력, 아머값
function OnSizeChange(ItemID)
	if ItemID == ID_Player_Big then
		return 5.5, 2000, 2000, 2000, 2000
	end
	if ItemID == ID_Player_Small then
		return 0.6, 100, 0, 100, 0
	end
	if ItemID == ID_Player_Medium then
		local num = math.random(15, 15) -- 랜덤 함수가 정수 밖에 안됨. 그래서 아래에 0.1을 곱해야 함.
		num = num * 0.1
		return num, 500, 500, 500, 500
	end	
	return 1.0, 100, 100, 100, 100
end

-------------------------------------------------------------------
-- 이벤트 에어리어를 떠날때 불리는 함수
function OnLeaveEventArea(AreaName)
	--AddChatInputStr(AreaName, 0)
	if string.find(AreaName, "EventAreaPlus") then
		return ID_Player_Big
	end
	if string.find(AreaName, "EventAreaMedium") then
		return ID_Player_Medium
	end
	if string.find(AreaName, "EventAreaMinus") then
		return ID_Player_Small
	end
	return ID_Player_Base
end

-- 강습으로 공격하는 함수. 거리 및 높이를 파악하여 대미지를 가한다.
-- DistSqr: 플레이어의 거리제곱, Height 타겟높이 - 공격자높이
function DoWindFallHitDamage(SameTeam)
	if SameTeam == 1 then
		--AddChatInputStr("지나가다 부딪침 같은팀", 0)
		return 0, 0
	end
	--AddChatInputStr("지나가다 부딪침", 0)
	return 1, 250			-- 1이면 대미지를 가하며 100의 대미지를 가한다.
end

-- 강습으로 공격하는 함수. 거리 및 높이를 파악하여 대미지를 가한다.
-- DistSqr: 플레이어의 거리제곱, Height 타겟높이 - 공격자높이
function DoWindFallDamage(DistSqr, Height, SameTeam)
	local GlideAttack_Distance = 850
	local DamageSqr = GlideAttack_Distance * GlideAttack_Distance
	if SameTeam == 1 then
		return 0, 0
	end
	if math.abs(Height) > 128*10 then		-- 높이차는 최대한 크게 잡았음.
		return 0, 0
	end
	if DistSqr > DamageSqr then
		return 0, 0
	end
	
	return 1, 300			-- 1이면 대미지를 가하며 100의 대미지를 가한다.
end

function DoDamage(WeaponClass, AniType, HeadShot, Damage, SpecialFire)
	--AddChatInput( string.format("WeaponClass %d AniType %d HeadShot %d Damage %.1f SpecialFire %d",
	--				WeaponClass, AniType, HeadShot, Damage, SpecialFire) )
	if HeadShot == 0 then	--헤드샷이 아닐 경우에는 대미지를 바꾸지 않음.
		return Damage
	end
	
	-- 여기 부터는 무조건 헤드샷
	if WeaponClass ~= 1 then
		return Damage
	end

	if SpecialFire == 1 then
		if AniType == 20 then
			return Damage * 0.3333
		end
		return Damage
	end

	if AniType == 4 or AniType == 7 or AniType == 11 or AniType == 26 then
		--AddChatInput("스나 헤드샷이다")
		return Damage * 0.3333
	end
	
	return Damage
end

--------------------------------------------------------------

--PlayerJumpFactor = 1					-- GetPlayerJumpFactor 함수에서 변경
--PlayerJumpMin = 1
--PlayerJumpMax = 4.0


-- 캐릭터 스케일이 3일때 공식: result = 1 + (2 * PlayerFactor)
-- 캐릭터 스케일이 0.3일때 공식: result = 1 - (0.7 * PlayerFactor)
function GetPlayerMovementFactor()
	return 0.4
end

-- result값의 Min, Max (1일 경우, 기본 캐릭터의 이동속도, 점프높이다.)
function GetPlayerMovementMin()
	return 1
end

function GetPlayerMovementMax()
	return 2.0
end

function GetPlayerHP()
	return 100
end

function GetPlayerAP()
	return 100
end

-- 아래 값을 참고로 해서 바꾸면 됨.
--ID_Player_Base = 0			-- 사이즈 체인지를 하지 않음. 기본 스킬이 추가될 수 있음.
--ID_Player_Big = 1			-- 플레이어의 크기이자, 아이템의 종류. (아이템은 빠질수도 있음) 절대 0으로 세팅하면 안됨. 그건 캐릭터 기본 값임.
--ID_Player_Small = 2
--ID_Player_Medium = 3
function GetScaleFX(nPrevID, nSkillID) -- 이펙트 세팅
	if nPrevID == ID_Player_Base and nSkillID == ID_Player_Big then
		return "SC_Scale_Up_1"
	end
	if nPrevID == ID_Player_Medium and nSkillID == ID_Player_Big then
		return "SC_Scale_Up_1"
	end
    if nPrevID == ID_Player_Medium and nSkillID == ID_Player_Small then
		return "SC_Scale_Down_1"
	end
	if nPrevID == ID_Player_Base and nSkillID == ID_Player_Small then
		return "SC_Scale_Down_1"
	end
	if nPrevID == ID_Player_Big and nSkillID == ID_Player_Small then
		return "SC_Scale_Down_2"
	end
	if nPrevID == ID_Player_Small and nSkillID == ID_Player_Big then
		return "SC_Scale_Up_2"
	end
	return "SC_Scale_Up_3"
end

function SetEdgeColor(nSameTeam, GadgetTarget) -- r, g, b, 두께 리터
	if GadgetTarget == 1 then --점령지 점령 중일때
		return 0.898, 0.329, 1, 0.002
	end
	if nSameTeam == 1 then	-- 같은 팀일 경우
		return 0, 1, 0, 0.002
	end
	return 1, 0.6, 0.6, 0.006
end










 









------------------------------------------------------------