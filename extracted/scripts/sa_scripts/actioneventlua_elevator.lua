-----------------------------------------------------------------------------------------
-- 기본 외부 정의 함수
-----------------------------------------------------------------------------------------
function Setup()
	AEInclude("sa_scripts/ActionEventLua_AI_Data.lua")
	AEInclude("sa_scripts/ActionEventLua_AI_Func.lua")
	AEInclude("sa_scripts/ActionEventLua_AI_Table.lua")
end

function Init(mandate)
	AIDataStageTable = {RoomList={},RoomMapping={},SpawnRoomList={}}
end

function OnBotInit(objHandle, baseID)
	AIData.Object[objHandle] = {}
	if AIData[baseID].Ani ~= nil then
		AEUpdateFunc(objHandle, AIData[baseID].Ani.AniFunc)        -- 유저가 정의한 타이머 함수 연결 ( 봇ID, 함수, 시간:음수이면함수비활성)
	end
end

function OnChangeState(objHandle, baseID, stateID, level)
	if level == -1 then	return	end
	AIData.Object[objHandle].BaseID = baseID
	AIData.Object[objHandle].Level = level
	if stateID ~= StateID_Death then
		ai = AIData[baseID].AI[level]
		---[[디버깅용 메시지전달
		if ai == nil then
			AECallbackEvent("ErrorMsg", "AI없음,".."BaseID:"..baseID..",AI:"..level..",StateID:"..stateID)
		end
		--]]
		AEUpdateFunc(objHandle, ai.AIFunc, GetRndClamp({0.1,0.5}))    -- 유저가 정의한 타이머 함수 연결 ( 봇ID, 함수, 시간:음수이면함수비활성)
	end
end

function OnDeath(objHandle, baseID, dir)	-- dir(0:후방에서맞음, 1:전방에서 맞음)
	infoIdx = math.floor(objHandle/100)-- AEGetData(objHandle, DataKey_I)
--	itemID = GetDropItem(infoIdx)
--	if itemID ~=nil then	AECallbackEvent("DropItem", itemID, AEGetPosOfBot(objHandle))	end

	AEState(objHandle, StateID_Death)
	AEMoveOption(objHandle, 100, 1, 0, 0, 100, 1)	-- 회전및 이동불가. StateID_Death
	AEUpdateFunc(objHandle, nil)	-- 기존에 AI에 연결된 함수들을 모두 제거한다.
	if dir == 0 then	aniTable = AIData[baseID].Ani.FDeath
	else				aniTable = AIData[baseID].Ani.BDeath	end
	AEAniPlay(objHandle)
	AEAniBase(objHandle, GetObjectAni(objHandle, aniTable))
	AEUpdateFunc(objHandle, "RemoveBot", 3 )
end

function OnDamage(playerHandle, weapon, damage, objHandle, baseID, stateID, level)
	if playerHandle ~= -1 then	SetTarget(objHandle, baseID, level, playerHandle, true)	end
end

function OnModelKey(objHandle, baseID, stateID, level, x, y, z, key)
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return end
	if key == "create_key" then
		if objectAct.WorkEx ~= nil and objectAct.WorkEx.AmmoID ~= nil and objectAct.WorkEx.AmmoID > -1 then
			AIData.Object[objHandle].ProjectileThrow = false
			AEProjectile(objHandle, objectAct.Work.Point[2], true, objectAct.WorkEx.AmmoID, 0, 0, 0, objectAct.WorkEx.Ani)
		end
	end
	if key ~= "fire_key" then return	end
	if AIData.Object[objHandle].ProjectileThrow == false then
		AIData.Object[objHandle].ProjectileThrow = true
		AEProjectile(objHandle, objectAct.Work.Point[2], true, objectAct.WorkEx.AmmoID, objectAct.Work.DistRange, objectAct.Work.AngleRange, GetRndClamp(objectAct.Work.Damage), objectAct.WorkEx.Ani)
	else
		ActivateDamage("Key", objHandle, objectAct, DT_MELEE)
	end
end

function OnProjectileImpact(objHandle, x, y, z, ammoID, range, damage)
	fx = AIData.AmmoFX[ammoID]
	CreateFX(objHandle, fx, x,y,z, 0)
	AEDamage(objHandle, x,y,z, 0,0,0, range, 360, damage, DT_EXPLODE, 16)--2,4,7,13,37,38,39,42,46,47,51
end

function OnProjectileDot(objHandle, x, y, z, ammoID, range, damage)
	AEDamage(objHandle, x,y,z, 0,0,0, range, 360, damage, DT_EXPLODE, 16)--2,4,7,13,37,38,39,42,46,47,51
end

function OnTouchOBB(objHandle, playerHandle)
	TouchAction(objHandle, playerHandle)
end

function IsProjectileThrow(objHandle)
	return AIData.Object[objHandle].ProjectileThrow == true
end


-----------------------------------------------------------------------------------------------------------------
-- 사용자 정의
-----------------------------------------------------------------------------------------

function StageReset()
	AIDataStageTable = {RoomList={},RoomMapping={},SpawnRoomList={}}
	AEDeleteBot()
end

function StageStart(level, stageType, roomShapeName, point)
	AIDataFloorLevel = level
	AIDataStageType = stageType
	AIDataRoomShapeName = roomShapeName
	AIDataTotalPoint = point
--	AIDataStageType = StageType_Farming

	if 	AIDataStageType ~= StageType_Puzzle then
		if 	AIDataStageType == StageType_Battle then
			floorTable = AIData.BattleFloor
		elseif 	AIDataStageType == StageType_Farming then
			floorTable = AIData.FarmingFloor
		end
		i = 0
		while i < floorTable.SpawnRoomCount do
			i = i + 1
			TestAddSpawnRoom()
		end
	end
end

function SetStageRoom(roomName, roomWeight, x, z)
	ridx = #AIDataStageTable.RoomList + 1
	AIDataStageTable.RoomList[ridx] = {Name=roomName, Weight=roomWeight, GroupX = x, GroupY = nil, GroupZ = z, PointList={}}
	AIDataStageTable.RoomMapping[roomName] = ridx
end

function SetStagePoint(roomName, pointName)
	ridx = AIDataStageTable.RoomMapping[roomName]
	pidx = #AIDataStageTable.RoomList[ridx].PointList + 1
	AIDataStageTable.RoomList[ridx].PointList[pidx] = pointName
end

function GetDamagePenalty(objHandle)
	obj = AIData.Object[objHandle]
	if obj == nil then return 0,0 end
	objectAct = obj.Act
	if objectAct == nil or objectAct.DamagePenalty == nil then	return 0,0 end
	return objectAct.DamagePenalty[1], objectAct.DamagePenalty[2]-- objectAct.DamagePenalty-- 0.9, 5 -- 패널티,시간
end

-----------------------------------------------------------------------------------------------------------------
-- 내부 사용
AIDataStageTable = nil
AIDataFloorLevel = nil
AIDataStageType = nil
AIDataRoomShapeName = nil
AIDataTotalPoint = nil

AIDataGroupPointTable=	-- 군락생성 되는 포인트를 기준으로, 상대 포지션 값을 설정한다.
{
	{0,0,0},
	{70,0,0},	{-70,0,0},		{0,0,70},	{0,0,-70},		{60,0,60},		{-60,0,-60},	{-60,0,60},		{60,0,-60},
	{130,0,0},	{-130,0,0},		{0,0,130},	{0,0,-130},		{60,0,120},		{-60,0,-120},	{120,0,60},		{-120,0,-60},
	{-60,0,120},{60,0,-120},	{-120,0,60},{120,0,-60},	{120,0,120},	{-120,0,-120},	{-120,0,120},	{120,0,-120},
	{190,0,0},	{-190,0,0},		{0,0,190},	{0,0,-190},		{180,0,180},	{-180,0,-180},	{-180,0,180},	{180,0,-180},
}

--시스템이랑 중복되지 않게 10~15만
DataKey_X = 10
DataKey_Y = 11
DataKey_Z = 12
DataKey_R = 13
DataKey_O = 14--원본핸들
--DataKey_I = 15--Info아이디

RT_Single = 1
RT_Group = 2

StageType_Battle = 1
StageType_Farming = 2
StageType_Puzzle = 4

DT_BULLET = 2
DT_CHOKE = 4	-- water, hostile atmosphere
DT_CRUSH = 5 -- (falling, crushing, collision)
DT_EXPLODE = 7
DT_MELEE = 13

BC_CFLG_FORWARD = 1
BC_CFLG_RUN		= 512
BC_CFLG_FIRING	= 1024


-- 전체 업데이트 함수

function SpawnBot(objHandle, botBaseID, aiID, x, y, z, r)
	objNewHandle = AECreateBot(objHandle, botBaseID, x, y, z, AIData[ botBaseID ].AI.HP)                   -- 봇 인덱스를 호출. index(nil:랜덤), BotID, 생성위치("PointName" or x,y,z)
	if objNewHandle ~= nil then
		if aiID ~= nil then	AEState(objNewHandle, StateID_Stop, aiID)	end
		AESetRotate(objNewHandle, 0.0, r)
		AESetData(objNewHandle, DataKey_X, x)
		AESetData(objNewHandle, DataKey_Y, y)
		AESetData(objNewHandle, DataKey_Z, z)
		AESetData(objNewHandle, DataKey_R, r)
	end
	return objNewHandle
end

function SpawnMonster(objHandle)
	aiInfoIndex = math.floor(objHandle/100)

	ai = AIData.AIInfo[aiInfoIndex]
	if ai ~= nil then
		botBaseID = ai[1]
		aiID = GetRndTable(ai.AI)
		if aiID == nil then
			aiCount = #AIData[ botBaseID ].AI
			if aiCount > 0 then	aiID = math.random(1, aiCount)	end
		end
		x,y,z = GetPosFromRoomList()
		r = 0
		if ai.Set ~= nil then
			x = x + ai.Set[1]
			y = y + ai.Set[2]
			z = z + ai.Set[3]
			r = ai.Set[4]
		else
			r = math.random(0,360)
		end
		
		SpawnBot(objHandle, botBaseID, aiID, x, y, z, r)

		--[[디버깅용 메시지전달
		debugMsg = "유효 인덱스: "..objHandle..", info:"..aiInfoIndex..",x="..x..",y="..y..",z="..z
		AECallbackEvent("DebugMsg", debugMsg)
		--]]
	else
		---[[디버깅용 메시지전달
		debugMsg = "없는 인덱스: "..objHandle..", info:"..aiInfoIndex
		AECallbackEvent("DebugMsg", debugMsg)
		--]]
	end
end

function FindRoom(roomTable, room)
	for _, v in pairs(roomTable) do	if v == room then	return true	end	end
	return false
end

function GetWeightRoom()
	totalWeight = 0
	for _, v in pairs(AIDataStageTable.RoomList) do
		if FindRoom(AIDataStageTable.SpawnRoomList, v) == false then
			totalWeight = totalWeight + v.Weight
			roomInfo = AIData.RoomInfo[v.Name]
			if roomInfo ~= nil then	totalWeight = totalWeight + roomInfo[1]	end
		end
	end
	rndWeight = math.random(1, totalWeight)
	for _, v in pairs(AIDataStageTable.RoomList) do
		if FindRoom(AIDataStageTable.SpawnRoomList, v) == false then
			rndWeight = rndWeight - v.Weight
			roomInfo = AIData.RoomInfo[v.Name]
			if roomInfo ~= nil then	rndWeight = rndWeight - roomInfo[1]	end
			if rndWeight < 1 then
				return v
			end
		end
	end
	return nil
end

function TestAddSpawnRoom()
	idx = #AIDataStageTable.SpawnRoomList + 1
	
	room = GetWeightRoom()
	if room == nil then
		---[[디버깅용 메시지전달
		debugMsg = "실패!! 룸리스트수: "..#AIDataStageTable.RoomList
		AECallbackEvent("DebugMsg", debugMsg)
		--]]
		return
	end
	--[[
	room = GetRndTable(AIDataStageTable.RoomList)
	errorCount = 0
	while FindRoom(AIDataStageTable.SpawnRoomList, room) == true or #room.PointList == 0 do
		room = GetRndTable(AIDataStageTable.RoomList)
		errorCount = errorCount + 1
		if errorCount > 20 then
			return
		end
	end
	]]
	
	---[[디버깅용 메시지전달
	debugMsg = "AddSpawnRoom"
	AECallbackEvent("DebugMsg", debugMsg)
	--]]

	AIDataStageTable.SpawnRoomList[idx] = room
	AIDataStageTable.SpawnRoomList[idx].Count = 0

	roomInfo = AIData.RoomInfo[AIDataStageTable.SpawnRoomList[idx].Name]
	if roomInfo ~= nil and roomInfo.Type == RT_Group then
		gp = GetRndTable(AIDataStageTable.SpawnRoomList[idx].PointList)
		if gp ~= nil then
			x,y,z = AEGetPointPos(gp)
			--AIDataStageTable.SpawnRoomList[idx].GroupX = x
			AIDataStageTable.SpawnRoomList[idx].GroupY = y
			--AIDataStageTable.SpawnRoomList[idx].GroupZ = z
		end
	end
end

function GetTrapRoulette(floorLevel, floorPoint)
	floorRoulette = GetFloorRouletteTable(AIData.PuzzleFloor, floorLevel)
	useListTable = GetAITableList(floorRoulette, floorPoint)
				
	if useListTable ~= nil then
		trapList = GetRndTable(useListTable)
		if trapList ~= nil then
			return trapList[1], trapList[math.random(2, #trapList)]
		end
	end
	
	---[[디버깅용 메시지전달
	debugMsg = "선택된 인덱스가 없습니다, 넘어온점수: "..floorPoint
	AECallbackEvent("ErrorMsg", debugMsg)
	--]]

	return "", -1
end

function GetVector(sx, sy, sz, ex, ey, ez)
	if sx==nil or sy==nil or sz==nil or ex==nil or ey==nil or ez==nil then
		return nil
	end
	x=ex-sx
	y=ey-sy
	z=ez-sz
	return x,y,z
end

function GetVectorLength(x, y, z)
	if x==nil or y==nil or z==nil then	return nil	end
	return math.sqrt(((x*x) + (y*y) + (z*z)))
end

function GetVectorMul(x, y, z, scalar)
	if x==nil or y==nil or z==nil or scalar==nil then
		return nil
	end
	return x * scalar, y * scalar, z * scalar
end

function DotVector(x1, y1, z1, x2, y2, z2)
	if x1==nil or y1==nil or z1==nil or x2==nil or y2==nil or z2==nil then	return nil	end
	return (x1*x2) + (y1*y2) + (z1*z2)
end

function Normalize(x, y, z)
	if x==nil or y==nil or z==nil then	return nil	end
	length = GetVectorLength(x, y, z)
	return x / length, y / length, z / length
end

function GetAngle(px,py,pz,dx,dy,dz,tx,ty,tz)
	x,y,z = GetVector(px,py,pz,tx,ty,tz)
	if x==nil or y==nil or z==nil or dx==nil or dy==nil or dz==nil then return nil end
	x,y,z = Normalize(x,y,z)
	targetRadian = math.acos(DotVector(x,y,z,dx,dy,dz)) * 2.0
	return targetRadian * 57.2957795130967
end

function GetPositionDist(sx, sy, sz, ex, ey, ez)
	return GetVectorLength(GetVector(sx, sy, sz, ex, ey, ez))
end

function GetRndClampv(minv, maxv)
	return math.random(minv * 100, maxv * 100)*0.01
end

function RemoveBot( objHandle, baseID, stateID, level, x, y, z, velocity )
	AEDeleteBot(objHandle)
end

function UpdateMoveOption(objHandle, baseID, stateID)
	ai = AIData[baseID].AI
	if ai.RotateSpeed == nil or ai.WalkSpeed==nil or ai.RunSpeed==nil then
		AEMoveOption(objHandle, 100, 1, 0.0, 0.0, 100, 1)	-- 회전및 이동불가. StateID_Death
	else
		if	stateID == StateID_Walk	then
			AEMoveOption(objHandle, 100, 1, ai.RotateSpeed, ai.WalkSpeed, 5, 1)	--이동및 회전 가능하게
		elseif	stateID == StateID_Run	then
			AEMoveOption(objHandle, 100, 1, ai.RotateSpeed, ai.RunSpeed, 5, 1)	--이동및 회전 가능하게
		elseif	stateID == StateID_Stop	then
			AEMoveOption(objHandle, 100, 1, ai.RotateSpeed, 0.0, 5, 1)		--회전만 가능하게
		else
			AEMoveOption(objHandle, 100, 1, 0.0, 0.0, 100, 1)	-- 회전및 이동불가. StateID_Death
		end
	end
end

function TimeAction(objHandle, funcName, delayTime)
	if AEFindFunc(objHandle, funcName) == false and delayTime >= 0 then
		AEUpdateFunc(objHandle, funcName, delayTime)
		return true
	end
	return false
end

function SetActionTime(objHandle)
	AIData.Object[objHandle].ActTime = AEGetTime()
end

function GetActionTime(objHandle)
	if AIData.Object[objHandle].ActTime == nil then return 0 end
	return AEGetTime()-AIData.Object[objHandle].ActTime
end

function AbilitySearchTarget(objHandle, baseID, level, target, dist, direct)
	if objHandle==nil or target==nil or dist==nil then	return	end
	aiTable = AIData[baseID].AI
	if dist > aiTable[level].Sense then
		target, dist = AEGetBotVisiblePlayer(objHandle, aiTable.ViewAngle)
		if target==nil or dist > aiTable.ViewDist then	return	end
	end
	SetTarget(objHandle, baseID, level, target, direct)
end

function SetTarget( objHandle, baseID, level, target, direct )
	if target==nil then	return	end
	AITable = AIData[baseID].AI[level]
	if AITable ~= nil and AITable.ReactionTime ~= nil then
		aggroFuncName = "TargetFunc_Aggro"
		if AEFindFunc(objHandle, aggroFuncName) == false then
			AEUpdateFunc(objHandle, aggroFuncName, GetRndClamp(AITable.ReactionTime))
			AIData.Object[objHandle].AggroTarget = target
			AIData.Object[objHandle].Direct = direct
		end
	end
end

function TargetFunc_Aggro( objHandle, baseID, stateID, level, x, y, z, velocity )
	if AIData.Object[objHandle].AggroTarget ~= nil then
		if AIData.Object[objHandle].Target == nil or AIData.Object[objHandle].Direct == true then	-- 타겟이 없거나 직접 맞은 경우 타겟 세팅
			AIData.Object[objHandle].Target = AIData.Object[objHandle].AggroTarget
		elseif AIData.Object[objHandle].Target ~= AIData.Object[objHandle].AggroTarget then
			if AIData.Object[objHandle].AggroTime ~= nil and AIData.Object[objHandle].AggroTime < AEGetTime() then	-- 기억시간 초과일때 타겟 변경
				AIData.Object[objHandle].Target = AIData.Object[objHandle].AggroTarget
				AIData.Object[objHandle].AggroTime = nil
			end
		end
		if AIData.Object[objHandle].Direct == true then
			AIData.Object[objHandle].AggroTime = nil	-- 직접 맞은 경우 무한 기억인 nil
			AENotifyTarget("OnNotifyAggro", AIData.Object[objHandle].AggroTarget, x, y, z)	-- 다른봇에도 알린다.
		else
			AIData.Object[objHandle].AggroTime = AEGetTime()+AIData[baseID].AI[level].AggroTime
		end
	end
	AIData.Object[objHandle].AggroTarget = nil
	AIData.Object[objHandle].Direct = false
end

function OnNotifyAggro( objHandle, baseID, level, playerHandle, x, y, z )
	if AIData.Object[objHandle].AggroTarget == nil then
		notifyDist = GetPositionDist(x,y,z, AEGetPosOfBot(objHandle))
		AbilitySearchTarget(objHandle, baseID, level, playerHandle, notifyDist, false)
	end
end

function UpdateSearchTarget( objHandle, baseID, level, x, y, z )
--	if AEGetTime() < 10 then	return 	end
	px,py,pz = AEGetPosOfPlayer(AIData.Object[objHandle].Target)
	--py = y
	targetDist = GetPositionDist(x,y,z,px,py,pz)
	if targetDist == nil then
		targetHandle = nil
		target, dist = AEGetPlayerClosestToPos(x,y,z)
		AbilitySearchTarget(objHandle, baseID, level, target, dist, true)
	else	targetHandle = AIData.Object[objHandle].Target	end
	if targetHandle==nil then	AIData.Object[objHandle].Target = nil	end	--타겟이 없는게 확실하다면 nil
	return targetHandle, targetDist
end

function GetObjectAni(objHandle, aniTable)
	if AIData.Object[objHandle].AniTable ~= aniTable then
		AIData.Object[objHandle].AniTable = aniTable
		AIData.Object[objHandle].Ani = GetRndTable(aniTable)
	end
	return AIData.Object[objHandle].Ani
end

function SetAction(objHandle, act)
	if act ~= nil then
		if act.Type == "Weapon" then
			AIData.Object[objHandle].WeaponAct = act
		else
			AIData.Object[objHandle].Act = act
		end
		AIData.Object[objHandle].StartAct = false
		TimeAction(objHandle, act.ActFunc, GetRndClamp(act.ActTime))
	end
end

function SetActionByIndex(objHandle, baseID, actIdx)
	SetAction(objHandle, AIData[baseID].Act[actIdx+1])
end

function UpdateAIAction(objHandle, dist, baseID, level)
	actTable = AIData[baseID].Act
	useAct = AIData[baseID].AI[level].UseAct
	if actTable ~= nil and #actTable > 0 and useAct ~= nil and dist ~= nil then
		actList = {}
		for _, v in pairs(useAct) do
			checkAct = actTable[v]
			if checkAct ~= nil then
				if checkAct.Range[1] <= dist and dist <= checkAct.Range[2] then
					actList[#actList+1] = checkAct
				end
			---[[디버깅용 메시지전달
			else
				debugMsg = v.."번은 없는 액션입니다.(봇ID"..baseID..")"
				AECallbackEvent("ErrorMsg", debugMsg)
			--]]
			end
		end
		SetAction(objHandle, GetRndTable(actList))
	end
end

function UpdateAction(objHandle, dist)
	obj = AIData.Object[objHandle]
	if obj == nil then return end
	baseID = obj.BaseID
	level = obj.Level
	if baseID == nil or level == nil or obj.WeaponAct ~= nil then return end
	UpdateAIAction(objHandle, dist, baseID, level)
end

function CreateFX(objHandle, fxinfo, x, y, z, fxTime)
	if objHandle == nil or fxinfo == nil then	return	end
	if fxinfo.Socket == nil then
		AEFX(nil, x, y, z, fxinfo.Name)
	else
		AEFX(objHandle, fxTime, fxinfo.Name, fxinfo.Socket)
	end
end

function ActivateDamage(typeName, objHandle, objectAct, damageType)
	if objectAct == nil then	return	end
	if objectAct.Type ~= typeName then	return	end
	
	px,py,pz,dx,dy,dz = AEGetAITransform(objHandle, objectAct.Work.Point[1], objectAct.Work.Point[2])

	if objectAct.WorkEx ~= nil and objectAct.WorkEx.AmmoID ~= nil then
		fx = AIData.AmmoFX[objectAct.WorkEx.AmmoID]
		CreateFX(objHandle, fx, px,py,pz, 0)
	end
	--if objectAct.FXD ~= nil then	CreateFX(objHandle, objectAct.FXD, x, y, z, 0)	end
	
	return AEDamage(objHandle, px,py,pz,dx,dy,dz, objectAct.Work.DistRange, objectAct.Work.AngleRange, GetRndClamp(objectAct.Work.Damage), damageType, objectAct.Work.DamageNum)--2,4,7,13,37,38,39,42,46,47,51
end

function GetFloorRouletteTable(floorTable, floorLevel)
    for _, v in pairs(floorTable) do
		if v.MaxFloor >= floorLevel then
			return v.Roulette
		end
    end        
	return nil
end

function GetAITableList(floorRoulette, totalPoint)
	if floorRoulette ~= nil then
		totalWeight = 0
		rt = {}
		for k, v in pairs(floorRoulette) do
			if v.PointRange[1] <= totalPoint and v.PointRange[2] >= totalPoint then
				totalWeight = totalWeight + v.Weight
				rt[k] = v
			end
		end
		if totalWeight > 0 then
			rndWeight = math.random(1, totalWeight)
			for k, v in pairs(rt) do
				rndWeight = rndWeight - v.Weight
				if rndWeight < 1 then

					---[[디버깅용 메시지전달
					debugMsg = "선택된인덱스: "..k..", 넘어온점수: "..totalPoint
					AECallbackEvent("DebugMsg", debugMsg)
					--]]

					return v.List
				end
			end
		end
	end
	return nil
end

function GetPosFromRoomList()
	roomTable = GetRndTable(AIDataStageTable.SpawnRoomList)
	roomTable.Count = roomTable.Count + 1
	x = 0
	y = 0
	z = 0
	if roomTable.GroupX~=nil and roomTable.GroupY~=nil and roomTable.GroupZ~=nil then
		if roomTable.Count > #AIDataGroupPointTable then
			roomTable.Count = roomTable.Count - #AIDataGroupPointTable
		end
		
		offsetPos = {0,0,0}
		roomInfo = AIData.RoomInfo[roomTable.Name]
		if roomInfo ~= nil and roomInfo.Offset ~= nil then
			offsetPos = roomInfo.Offset
		end

		gp = AIDataGroupPointTable[roomTable.Count]
		if gp ~= nil then
			x = roomTable.GroupX+offsetPos[1]+gp[1]
			y = roomTable.GroupY+offsetPos[2]+gp[2]
			z = roomTable.GroupZ+offsetPos[3]+gp[3]
		else
			x = roomTable.GroupX+offsetPos[1]
			y = roomTable.GroupY+offsetPos[2]
			z = roomTable.GroupZ+offsetPos[3]
		end
	else
		if roomTable.Count > #roomTable.PointList then
			roomTable.Count = roomTable.Count - #roomTable.PointList
		end
		pointName = roomTable.PointList[roomTable.Count]
		x,y,z = AEGetPointPos(pointName)
	end
	return x,y,z
end

function GetSpawnTrapList(id)
	aiList = {}
	if id ~= nil then
		---[[디버깅용 메시지전달
		debugMsg = "함정: "..AIDataRoomShapeName..","..id
		AECallbackEvent("DebugMsg", debugMsg)
		--]]
		grounTable = AIData.GroupTable[AIDataRoomShapeName]
		trapSet = grounTable[id]
		if trapSet ~= nil and trapSet.Set ~= nil then
			for _, area in pairs(trapSet.Set) do
				ridx = AIDataStageTable.RoomMapping[area[1]]
				roomTable = AIDataStageTable.RoomList[ridx]
				--roomTable = AIDataStageTable.RoomList[1]
				x,y,z = AEGetPointPos(roomTable.PointList[1])

				---[[디버깅용 메시지전달
				debugMsg = roomTable.Name
				--]]
				
				trap = area[2]
				for _, tset in pairs(trap) do
					---[[디버깅용 메시지전달
					debugMsg = debugMsg..","..tset[1]
					--]]
					setInfo = AIData.AIInfo[tset[1]]
					setX = x + tset[2]
					setY = y + tset[3]
					setZ = z + tset[4]

					for key, v in pairs(setInfo) do
						idx = #aiList + 1
						if key == 1 then	originalType = true
						else				originalType = false	end
						aiList[idx] = {tset[1], v, setX,setY,setZ, originalType}
					end
				end
				
				---[[디버깅용 메시지전달
				AECallbackEvent("DebugMsg", debugMsg)
				--]]

			end
		end
	end
	return aiList
end

function CreateTrapAI(id)
	
	aiList = GetSpawnTrapList(id)

	-- AI리스트의 AI들을 생성하고 배치한다
	originalHandle = nil
	for _, ai in pairs(aiList) do
	
		v = ai[2]
		r = 1

		botBaseID = v[1]
		botIndex = ai[1]*100 + _

		-- 스크립트에서 스폰 위치가 들어가 있으면 우선 세팅
		pointName = GetRndTable(AIData[ botBaseID ].SpawnPoint)
		if pointName ~= nil then
			x,y,z = AEGetPointPos(pointName)
		else
			x = ai[3]
			y = ai[4]
			z = ai[5]
		end
		
		if v.Set ~= nil then
			x = x + v.Set[1]
			y = y + v.Set[2]
			z = z + v.Set[3]
			r = v.Set[4]
		end
		aiID = GetRndTable(v.AI)
		if aiID == nil then
			aiCount = #AIData[ botBaseID ].AI
			if aiCount > 0 then	aiID = math.random(1, aiCount)	end
		end

		---[[디버깅용 메시지전달
		if ai == nil then
			AECallbackEvent("ErrorMsg", "AIData없음,".."BaseID:"..botBaseID)
		end
		--]]
		
		objNewHandle = SpawnBot(botIndex, botBaseID, aiID, x, y, z, r)
		if ai[6] == true then	originalHandle = objNewHandle	end
		if objNewHandle ~= nil then
			AESetData(objNewHandle, DataKey_O, originalHandle)
		end
	end
	
	-- 몇초짜리인지 알려준다
	if id ~= nil then
		grounTable = AIData.GroupTable[AIDataRoomShapeName]
		trapSet = grounTable[id]
		if trapSet ~= nil and trapSet.Time ~= nil then
			return trapSet.Time
		end
	end
	return 120
end


function GetSpawnAIList(floorTable, totalPoint)
	aiList = {}
	floorRoulette = GetFloorRouletteTable(floorTable, AIDataFloorLevel)
	useListTable = GetAITableList(floorRoulette, totalPoint)
	if	useListTable ~= nil then
		--일단 ai테이블리스트의 전체비율을 구한다
		totalRate = 0
		for k, v in pairs(useListTable) do
			totalRate = totalRate + v[2]
		end
		if totalRate > 0 then
			for k, v in pairs(useListTable) do
				rate = v[2] / totalRate			--뿌려질 ai들 중 해당 ai의 비율값을 구한다(0~1)
				usePoint = totalPoint * rate	--해당 ai가 사용가능한 포인트를 구한다
				subPoint = AIData.Table[ v[1] ].Point
				IDList = AIData.Table[ v[1] ].ID

				---[[디버깅용 메시지전달
				debugMsg = "AI: "..tostring(v[1])..", 할당점수: "..usePoint
				AECallbackEvent("DebugMsg", debugMsg)
				--]]

				while usePoint >= subPoint do
					usePoint = usePoint - subPoint
					idx = #aiList+1
					infoIdx = GetRndTable(IDList)
					ai = AIData.AIInfo[infoIdx]
					x,y,z = GetPosFromRoomList()
					aiList[idx] = {infoIdx, ai, x,y,z, true}
				end
			end
		end
	end
	return aiList
end

function GetDropItem(infoIdx)
	itemDrop = AIData.ItemDrop[infoIdx]
	if itemDrop ~=nil then
		totalWeight = 0
		for k, v in pairs(itemDrop) do
			totalWeight = totalWeight + v[2]
		end
		rndWeight = math.random(1, totalWeight)
		for k, v in pairs(itemDrop) do
			rndWeight = rndWeight - v[2]
			if rndWeight < 1 then
				return v[1]
			end
		end
	end
	return nil
end

function TouchAction(objHandle, playerHandle)
	baseID = AIData.Object[objHandle].BaseID
	if baseID == nil then return end
	if AIData[baseID].AI.TouchCoolTime == nil then return end

	originalHandle = AEGetData(objHandle, DataKey_O)
	if originalHandle == 0 then return end
	
	origObj = AIData.Object[originalHandle]
	origObjAct = origObj.Act
	if origObjAct == nil then	return	end
	if origObj.TouchSleep == nil then
		--if origObjAct.FXD ~= nil then	CreateFX(objHandle, origObjAct.FXD, x, y, z, 0)	end
		objectAct = AIData.Object[objHandle].Act
		if objectAct ~= nil then
			damage = GetRndClamp(objectAct.Work.Damage)
		else
			damage = GetRndClamp(origObjAct.Work.Damage)
		end
		if damage > 0 then
			AEPlayerDamage(objHandle, playerHandle, damage, DT_CRUSH)
		end
		if origObjAct.Type == "Restart" then
			AECallbackEvent("Restart", playerHandle)
		end
		
		origObj.TouchSleep = true
		AEUpdateFunc(originalHandle, "TouchSleep", AIData[baseID].AI.TouchCoolTime )
		
		---[[디버깅용 메시지전달
		debugMsg = "Touch: "..origObjAct.Type..","..damage
		AECallbackEvent("DebugMsg", debugMsg)
		--]]
	end
end

function TouchSleep( objHandle, baseID, stateID, level, x, y, z, velocity )
	obj = AIData.Object[objHandle]
	obj.TouchSleep = nil
end

function SetForceTarget(objHandle, objTarget)
	AIData.Object[objHandle].Target = objTarget
end

-----------------------------------------------------------------------------------------------------------------
--[[ 외부 지원 함수
function Init(mandate)									-- 게임시작 혹은 위임시 호출
function OnBotInit(baseID, objHandle)
function OnChangeState(baseID, stateID)					--상태변경이벤트
function OnDeath(objHandle, baseID, dir)				--봇이죽으면 호출 dir(0:후방에서맞음, 1:전방에서 맞음)
function OnDamage(playerHandle, weapon, damage, objHandle, baseID, stateID, level)	--공격유저, 무기, 대미지, 봇핸들, 봇ID, 봇상태, 봇레벨
function OnModelKey(objHandle, baseID, stateID, level, x, y, z, key)

AEMoveOption(ObjHandle, 50, 1, 1.0, 600.0, 15, 0)		--리턴값이 무브옵션임
															봇핸들
															타겟범위(0.1~99999)
															이동옵션(0,3:그냥이동 - 1,4:회전방향으로 이동 - 2,5:회전후 이동)
															회전속도(0.1~100)
															이동속도(0.1~99999)
															미끄러짐(0.1~100)	
															회전옵션(0: 타겟방향회전, 1:타겟방향Y축고정회전, 2:회전속도값으로 Y축회전)
AEInclude("sa_scripts/ActionEventLua_Base_Func.lua")	--루아스크립트 추가
AETimer("UpdateMain", 1.0, true)
AEAniBase(objHandle, aniName)							--기본애니: 봇인덱스, 애니이름, reserve적용, 반복재생
AEAniPlay(objHandle, "Attack0", true)					--로컬애니이며 한번만재생: 봇인덱스, 애니이름, reserve적용
AEState(objHandle, StateID_Stop, level)					-- level:디폴트는 -1이고 이때에는 세팅되지 않는다
AEUpdateFunc(objHandle, "callbackFunction", 3 )			--봇ID, 호출될함수(nil이면 등록된 함수 모두해제), 타이머(-1이면 해당함수 해제)
															callbackFunction(objHandle, baseID, stateID, level, x, y, z, velocity)
															callbackFunction 리턴값을 1로 주면 반복호출됨
true == AEFindFunc(objHandle, "UpdateAttackStart")		-- 등록된 함수가 존재하는지 여부를 리턴
handle = AECreateBot(nil, 1223, "Point01", 100)			-- 봇생성. index(nil:랜덤), BotID, 생성위치("PointName" or x,y,z), HP
handle = AECreateBotEx(nil, 1223, 100, 100, "Point01")	-- 봇생성. index(nil:랜덤), BotID, MaxHP, HP, 생성위치("PointName")
AEDeleteBot(objHandle)
name, dist = AEGetClearPoint(objHandle)     		    --목적지에 도착하면 그 포인트 이름과 목적지와의 정확한 거리를 반환
x,y,z = AEGetPosOfBot(objHandle)						--봇의 위치값
x,y,z = AEGetForwardOfBot(objHandle)						--봇의 위치값
playerHandle, dist = AEGetPlayerClosestToPos(x,y,z,-1)		--가까운 플레이어 ID, 거리반환(x,y,z,필터ID:-1이면 모두)
x,y,z = AEGetPosOfPlayer(playerHandle)					--플레이어의 위치값
dx,dy,dz = AEGetForwardOfPlayer(playerHandle)
handle = AEGetPointClosestToPos(x,y,z)					--가까운포인트
handle = AEPointID("Point01")
AERunToPointID(objHandle, true, hPoint1, ..)			--봇을 해당포인트로 이동(BotID, 기존Reset, 포인트,...)
AERunToPoint(objHandle, "Point02", "Point03", ..)		--가급적 사용하지말자.. 봇을 해당포인트로 이동(BotID, 포인트네임,...)
AERunToPos(objHandle, movx, movy, movz, direct)			--봇을이동(BotID,x,y,z,가이드없이이동)
AERunPath(objHandle, movx, movy, movz)
AEGetBotCount()											--봇수
count = AEDamage(objHandle, px,py,pz, dx,dy,dz, dist, angle, damage, type, num)	--대미지줌(실제대상갯수 = 공격봇ID, (위치,방향), 네임, 범위, 대미지, 대미지타입, 대상갯수)
time = AEGetAnimLength(objHandle, "idle")				--봇의특정애니메이션시간(초)
time = AEGetTime()										--호스트의 흐른시간
AENotifyTarget("OnNotifyAggro", playerHandle,x,y,z)			--모든봇에게 유저함수로 문제를 일으킨 플레이어와 위치를 알린다.
															callbackFunction(objHandle, baseID, level, playerHandle,x,y,z)
x,y,z = AEGetPointPos(pointName)						--포인트의 위치
player, dist = AEGetBotVisiblePlayer(objHandle, angle, Team)	--보이는 플레이어(봇, 각도, 체크할팀:-1이면 모든팀)
AECallbackEvent(?,?,?,?,...)							--ServerMissionMgr에 값을 전달한다
AESetData(objHandle, DataKey, 1234)					--DataKey는 시스템정의랑 중복되지않게 10~15만 사용하도록 한다
value = AEGetData(objHandle, DataKey)
AEFX(nil, x, y, z, fxinfo.Name)							--FX를 월드에 호출
AEFX(objHandle, fxTime, fxinfo.Name, fxinfo.Socket)		--FX를 봇소켓에 호출 타임이 0이 아니면 시간만큼루프
AEProjectile(objHandle, szSocket, bBaseDir, ammoID, distRange, heightAngle, damage, aniName)
AEClientAni(objHandle)
true = AEChangeWeapon(objHandle, 0)
AESetAniFlag(objHandle, 0)
AEPitchTarget(objHandle, TargetPlayer)
angle = AEGetAngle(objHandle, targetPlayer)
px,py,pz,dx,dy,dz = AEGetAITransform(objHandle, "Socket", "LeftHand")
AESetRotate(handle, pitch, yaw)
angle = AEGetYawAngle(handle)
AEGo(handle, x,y,z, time)
AEPlayerDamage(handle,playerHandle,damage,damageType)
hp = AEGetBotHP(handle)
addhp = AEAddBotHP(playerHandle, botHandle, addHP)
AEVisiblePiece(objHandle, false, "Front_mesh", "Back_mesh", ..)
AESetAniTime(objHandle, 1, startTime)
AEGetAniName(objHandle)
time = AEGetAniTime(objHandle)
AESetPosOfPlayer(target, tx,ty,tz)
intersect, dist1 = AEGetWorldIntersect(sx,sy,sz, ex,ey,ez)

]]
-----------------------------------------------------------------------------------------------------------------

