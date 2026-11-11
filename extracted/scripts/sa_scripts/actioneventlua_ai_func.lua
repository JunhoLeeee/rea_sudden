
-----------------------------------------------------------------------------------------------------------------
-- 봇 AI 업데이트 함수
function AIFunc_Walk( objHandle, baseID, stateID, level, x, y, z, velocity )
	if stateID == StateID_Death then return 0 end
	playerHandle, dist = UpdateSearchTarget(objHandle, baseID, level, x, y, z)
	if AIData.Object[objHandle].Act == nil then
		if playerHandle ~= nil then
			UpdateAction(objHandle, dist)
		end
	end
	if AIData.Object[objHandle].StartAct ~= true then
		if playerHandle ~= nil then
			AITable = AIData[baseID].AI[level]
			AERunPath(objHandle, AEGetPosOfPlayer(playerHandle))
			if dist > AITable.DistToOpponent then	stateID = StateID_Walk
			else									stateID = StateID_Stop	end
			AEState(objHandle, stateID)
		else
			AERunToPos(objHandle, x, y, z, true)
			AEState(objHandle, StateID_Stop)
		end
	end
	return 1
end

function AIFunc_Run( objHandle, baseID, stateID, level, x, y, z, velocity )
	if stateID == StateID_Death then return 0 end
	playerHandle, dist = UpdateSearchTarget(objHandle, baseID, level, x, y, z)
	if AIData.Object[objHandle].Act == nil then
		if playerHandle ~= nil then
			UpdateAction(objHandle, dist)
		end
	end
	if AIData.Object[objHandle].StartAct ~= true then
		if playerHandle ~= nil then
			AITable = AIData[baseID].AI[level]
			AERunPath(objHandle, AEGetPosOfPlayer(playerHandle))
			if dist > AITable.DistToOpponent then	stateID = StateID_Run
			else 									stateID = StateID_Stop	end
			AEState(objHandle, stateID)
		else
			AERunToPos(objHandle, x, y, z, true)
			AEState(objHandle, StateID_Stop)
		end
	end
	return 1
end

function AIFunc_WalkAndRun( objHandle, baseID, stateID, level, x, y, z, velocity )
	if stateID == StateID_Death then return 0 end
	playerHandle, dist = UpdateSearchTarget(objHandle, baseID, level, x, y, z)
	if AIData.Object[objHandle].Act == nil then
		if playerHandle ~= nil then
			UpdateAction(objHandle, dist)
		end
	end
	if AIData.Object[objHandle].StartAct ~= true then
		if playerHandle ~= nil then
			AERunPath(objHandle, AEGetPosOfPlayer(playerHandle))	-- x,y,z = AEGetPosOfPlayer(playerHandle)
			AITable = AIData[baseID].AI[level]
			if dist > AITable.DistToOpponent then
				if dist < AITable.RunDist then	stateID = StateID_Run
				else							stateID = StateID_Walk	end
			else								stateID = StateID_Stop	end
			AEState(objHandle, stateID)
		else
			AERunToPos(objHandle, x, y, z, true)
			AEState(objHandle, StateID_Stop)
		end
	end
	return 1
end

function AIFunc_RunAndWalk( objHandle, baseID, stateID, level, x, y, z, velocity )
	if stateID == StateID_Death then return 0 end
	playerHandle, dist = UpdateSearchTarget(objHandle, baseID, level, x, y, z)
	if AIData.Object[objHandle].Act == nil then
		if playerHandle ~= nil then
			UpdateAction(objHandle, dist)
		end
	end
	if AIData.Object[objHandle].StartAct ~= true then
		if playerHandle ~= nil then
			AERunPath(objHandle, AEGetPosOfPlayer(playerHandle))	-- x,y,z = AEGetPosOfPlayer(playerHandle)
			AITable = AIData[baseID].AI[level]
			if dist > AITable.DistToOpponent then
				if dist < AITable.WalkDist then	stateID = StateID_Walk
				else							stateID = StateID_Run	end
			else								stateID = StateID_Stop	end
			AEState(objHandle, stateID)
		else
			AERunToPos(objHandle, x, y, z, true)
			AEState(objHandle, StateID_Stop)
		end
	end
	return 1
end

function AIFunc_MoveTrap( objHandle, baseID, stateID, level, x, y, z, velocity )
	if AIData.Object[objHandle].Act == nil then
		return AIFunc_MoveTriggerTrap( objHandle, baseID, stateID, level, x, y, z, velocity )
	end
	return 1
end

function AIFunc_MoveTriggerTrap( objHandle, baseID, stateID, level, x, y, z, velocity )
	if stateID == StateID_Death then return 0 end
	AITable = AIData[baseID].AI[level]
	x = AEGetData(objHandle, DataKey_X)+AITable.CheckPos[1]
	y = AEGetData(objHandle, DataKey_Y)+AITable.CheckPos[2]
	z = AEGetData(objHandle, DataKey_Z)+AITable.CheckPos[3]
	playerHandle, dist = AEGetPlayerClosestToPos(x,y,z)
	
	---[[디버깅용 메시지전달
	originalHandle = AEGetData(objHandle, DataKey_O)
	if originalHandle > 0 and objHandle == originalHandle then
		AECallbackEvent("DebugPos", objHandle, x,y,z, 255, 0, 0)
	end
	--]]

	if playerHandle ~= nil then
		UpdateAction(objHandle, dist)
	end
	return 1
end

-----------------------------------------------------------------------------------------------------------------
-- 봇 애니 업데이트
function AniFunc_Default( objHandle, baseID, stateID, level, x, y, z, velocity )
	-- 봇 이동상태 업데이트
	if AIData.Object[objHandle].StartAct ~= true then
		if stateID == StateID_Run then
			AEAniBase(objHandle, GetObjectAni(objHandle, AIData[baseID].Ani.Run), false, true)
		elseif stateID == StateID_Walk or velocity > 0.2 then
			AEAniBase(objHandle, GetObjectAni(objHandle, AIData[baseID].Ani.Walk), false, true)
		elseif stateID == StateID_Stop then
			AEAniBase(objHandle, GetObjectAni(objHandle, AIData[baseID].Ani.Idle), false, true)
		else
			AEAniBase(objHandle, GetObjectAni(objHandle, AIData[baseID].Ani.Idle), true, true)
		end
		UpdateMoveOption(objHandle, baseID, stateID)
	else
		if velocity <= 0.2 then
			if stateID == StateID_Stop or stateID == StateID_Walk or stateID == StateID_Run then
				AEAniBase(objHandle, GetObjectAni(objHandle, AIData[baseID].Ani.Idle), false, true)
			end
		end
	end
	return 1
end

function AniFunc_Transformer( objHandle, baseID, stateID, level, x, y, z, velocity )
	if level == 1 then
		hp = AEGetBotHP(objHandle)
		if hp > 0 and hp < AIData[baseID].AI.Factor1 then
			AEVisiblePiece(objHandle, false, "Line011")
			AIData.Object[objHandle].Act = nil
			
			playAni = GetObjectAni(objHandle, AIData[baseID].Ani.Ani1)
			if playAni ~= nil then	aniTime = AEGetAnimLength(objHandle, playAni)
			else					aniTime = 0	end
			AEAniPlay(objHandle, playAni)	--로컬애니이며 한번만재생: 봇인덱스, 애니이름, reserve적용
			AEMoveOption(objHandle, 100, 1, 0.0, 0.0, 100, 1)	-- 회전및 이동불가. StateID_Death
			--AEMoveOption(objHandle, 100, 4, 0, 0, 5, 1)
			TimeAction(objHandle, "AniFunc_Transformer_HidePiece", aniTime/3)
			TimeAction(objHandle, "AniFunc_Transformer_Change", aniTime)
			return 1
		end
	else
		AniFunc_Transformer_HidePiece( objHandle, baseID, stateID, level, x, y, z, velocity )
		-- 가끔 타겟을 바꾸는 함수를 호출하게 해야 한다.
		if AIData.Object[objHandle].Act == nil then
			AITable = AIData[baseID].AI[level]
			obj = AIData.Object[objHandle]
			nowTime = AEGetTime()
			if obj.ChangeTargetTime == nil or obj.ChangeTargetTime < nowTime then
				if obj.ChangeTargetTime == nil and obj.Target ~= nil then
					target = obj.Target
					dist = GetPositionDist(x,y,z, AEGetPosOfPlayer(target))
				else
					target, dist = AEGetPlayerClosestToPos(x,y,z,obj.Target)
				end
				if target~=nil then
					AbilitySearchTarget(objHandle, baseID, level, target, dist, true)
					UpdateAIAction(objHandle, dist, baseID, 1)
				end
				obj.ChangeTargetTime = nowTime + math.random(AITable.AggroTime, AITable.AggroTime+5)
			end
		end
	end

	return AniFunc_Default( objHandle, baseID, stateID, level, x, y, z, velocity )
end
function AniFunc_Transformer_HidePiece( objHandle, baseID, stateID, level, x, y, z, velocity )
	if AIData.Object[objHandle].HidePiece == nil then
		AIData.Object[objHandle].HidePiece = true
		AEVisiblePiece(objHandle, false, "Line011", "Front_mesh", "Back_mesh", "Head_Mesh")
	end
end
function AniFunc_Transformer_Change( objHandle, baseID, stateID, level, x, y, z, velocity )
	AEUpdateFunc(objHandle, AIData[baseID].AI[level].AIFunc, -1)
	AEState(objHandle, StateID_Stop, 2)
end

function AniFunc_Suicider( objHandle, baseID, stateID, level, x, y, z, velocity )
	if level == 1 then
		hp = AEGetBotHP(objHandle)
		if hp < AIData[baseID].AI.Factor1 then
			AIData.Object[objHandle].Act = nil
			AEUpdateFunc(objHandle, AIData[baseID].AI[level].AIFunc, -1)
			AEState(objHandle, StateID_Stop, 2)
			return 1
		end
	end

	return AniFunc_Default( objHandle, baseID, stateID, level, x, y, z, velocity )
end

function AniFunc_None( objHandle, baseID, stateID, level, x, y, z, velocity )
	UpdateMoveOption(objHandle, baseID, stateID)
	AEClientAni(objHandle)
	--AEAniBase(objHandle, GetObjectAni(objHandle, AIData[baseID].Ani.Idle), true, true)
--	return 0
end

function AniFunc_AIBot( objHandle, baseID, stateID, level, x, y, z, velocity )
	aibotFlag = 0
	if velocity > 0.2 then
		aibotFlag = BC_CFLG_FORWARD
		if stateID == StateID_Run then
			aibotFlag = aibotFlag + BC_CFLG_RUN
		end
	end
	if AEFindFunc(objHandle, "ActFunc_ContinuousFire") == true then
		aibotFlag = aibotFlag + BC_CFLG_FIRING
	end
	AESetAniFlag(objHandle, aibotFlag)

	AEPitchTarget(objHandle, AIData.Object[objHandle].Target, 50)
	
	UpdateMoveOption(objHandle, baseID, stateID)

	return 1
end

function AniFunc_MoveTrap( objHandle, baseID, stateID, level, x, y, z, velocity )
	-- 봇 이동상태 업데이트
	obj = AIData.Object[objHandle]
	if obj.Act == nil then
		if stateID == StateID_Run then
			AEAniBase(objHandle, GetObjectAni(objHandle, AIData[baseID].Ani.Run), false, true)
		elseif stateID == StateID_Walk or velocity > 0.2 then
			AEAniBase(objHandle, GetObjectAni(objHandle, AIData[baseID].Ani.Walk), false, true)
		elseif stateID == StateID_Stop then
			AEAniBase(objHandle, GetObjectAni(objHandle, AIData[baseID].Ani.Idle), false, true)
		else
			AEAniBase(objHandle, GetObjectAni(objHandle, AIData[baseID].Ani.Idle), true, true)
		end
	end

	t = GetActionTime(objHandle)
	if obj.RotateTotal ~= nil and obj.RotateFactor ~= nil then
		obj.LastRotateTotal = obj.RotateTotal + obj.RotateFactor * GetActionTime(objHandle)
		r = obj.LastRotateTotal + AEGetData(objHandle, DataKey_R)
		AESetRotate(objHandle, 0.0, r)
	else
		r = AEGetData(objHandle, DataKey_R)
		AESetRotate(objHandle, 0.0, r)
	end
	AEMoveOption(objHandle, 100, 0, 0, 0, 100, 2)

	return 1
end

-----------------------------------------------------------------------------------------------------------------
-- 봇 액션
function ActFunc_Stop( objHandle, baseID, stateID, level, x, y, z, velocity )
	AIData.Object[objHandle].Act = nil
	AIData.Object[objHandle].WeaponAct = nil
	AIData.Object[objHandle].StartAct = false
end
function ActFunc_CoolTime( objHandle, baseID, stateID, level, x, y, z, velocity )
	AIData.Object[objHandle].StartAct = false
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	TimeAction(objHandle, "ActFunc_Stop", GetRndClamp(objectAct.CoolTime))
end
function ActFunc_TargetTrackingUpdate( objHandle, baseID, stateID, level, x, y, z, velocity )	-- 업데이트
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	target = AIData.Object[objHandle].Target
	if target == nil then	return end
	tx,ty,tz = AEGetPosOfPlayer(target)
	AERunToPos(objHandle, tx,ty,tz, true)
	return 1
end

-- 일반공격
function ActFunc_AttackDefault( objHandle, baseID, stateID, level, x, y, z, velocity )
	AIData.Object[objHandle].StartAct = true
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	
	AEAniBase(objHandle, GetObjectAni(objHandle, AIData[baseID].Ani.Idle), true, true)

	---[[
	target = AIData.Object[objHandle].Target
	if target ~= nil then
		px,py,pz = AEGetPosOfPlayer(target)
		AERunToPos(objHandle, px, py, pz, true)
	end
	--]]
	--if objectAct.FX1 ~= nil then	AEFX(objHandle, false, objectAct.FX1.Name, objectAct.FX1.Socket)	end
	AEState(objHandle, StateID_Act1)
	playAni = GetObjectAni(objHandle, objectAct.Ani1)
	if playAni ~= nil then	aniTime = AEGetAnimLength(objHandle, playAni)
	else					aniTime = 0	end
	AEAniPlay(objHandle, playAni)	--로컬애니이며 한번만재생: 봇인덱스, 애니이름, reserve적용
	AEMoveOption(objHandle, 0, 4, AIData[baseID].AI.RotateSpeed, 0, 5, 1)		--회전만 가능하게
	SetActionTime(objHandle)
	TimeAction(objHandle, "ActFunc_CoolTime", aniTime)
end

-- 방사기공격
function ActFunc_AttackEjector( objHandle, baseID, stateID, level, x, y, z, velocity )
	AIData.Object[objHandle].StartAct = true
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	AEState(objHandle, StateID_Act1)
	playAni = GetObjectAni(objHandle, objectAct.Ani1)
	if playAni ~= nil then	aniTime = AEGetAnimLength(objHandle, playAni)
	else					aniTime = 0	end
	
	CreateFX(objHandle, objectAct.FX1, x, y, z, aniTime)
	---[[
	target = AIData.Object[objHandle].Target
	if target ~= nil then
		px,py,pz = AEGetPosOfPlayer(target)
		AERunToPos(objHandle, px, py, pz, true)
	end
	--]]
	AEAniPlay(objHandle, playAni)	--로컬애니이며 한번만재생: 봇인덱스, 애니이름, reserve적용
	AEMoveOption(objHandle, 0, 4, AIData[baseID].AI.RotateSpeed, 0, 5, 1)		--회전만 가능하게
	SetActionTime(objHandle)
	TimeAction(objHandle, "ActFunc_AttackEjectorUpdate", objectAct.WorkEx.EjectTime)
end
function ActFunc_AttackEjectorUpdate( objHandle, baseID, stateID, level, x, y, z, velocity )
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	AIData.Object[objHandle].ProjectileThrow = true
	AEProjectile(objHandle, objectAct.Work.Point[2], false, objectAct.WorkEx.AmmoID, objectAct.Work.DistRange, objectAct.Work.AngleRange, GetRndClamp(objectAct.Work.Damage), objectAct.WorkEx.Ani)--
	
	playAni = GetObjectAni(objHandle, objectAct.Ani1)
	if playAni ~= nil then	aniTime = AEGetAnimLength(objHandle, playAni)
	else					aniTime = 0	end
	if GetActionTime(objHandle) >= aniTime then
		AEAniBase(objHandle, GetObjectAni(objHandle, objectAct.Ani2), false, true)
		TimeAction(objHandle, "ActFunc_CoolTime", 0)
		return 0
	end
	return 1
end

--프로젝타일공격
function ActFunc_ProjectileAttack( objHandle, baseID, stateID, level, x, y, z, velocity )
	AIData.Object[objHandle].StartAct = true
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	AIData.Object[objHandle].ProjectileThrow = true
	AEProjectile(objHandle, objectAct.Work.Point[2], true, objectAct.WorkEx.AmmoID, objectAct.Work.DistRange, objectAct.Work.AngleRange, GetRndClamp(objectAct.Work.Damage), objectAct.WorkEx.Ani)
	SetActionTime(objHandle)
	TimeAction(objHandle, "ActFunc_CoolTime", 0)
end

-- 자폭공격
function ActFunc_AttackSuicideBombing( objHandle, baseID, stateID, level, x, y, z, velocity )	-- 준비
	AIData.Object[objHandle].StartAct = true
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	AEState(objHandle, StateID_Act2)
	playAni = GetObjectAni(objHandle, objectAct.Ani1)
	if playAni ~= nil then	aniTime = AEGetAnimLength(objHandle, playAni)
	else					aniTime = 0	end
	AEAniPlay(objHandle, playAni)
	AEMoveOption(objHandle, 100, 4, AIData[baseID].AI.RotateSpeed, 0, 5, 1)		--회전만 가능하게
	TimeAction(objHandle, "ActFunc_AttackSuicideBombing_2", aniTime)
end
function ActFunc_AttackSuicideBombing_2( objHandle, baseID, stateID, level, x, y, z, velocity )
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	playAni = GetObjectAni(objHandle, objectAct.Ani2)
	AEAniBase(objHandle, playAni, false, true)
	AEMoveOption(objHandle, 100, 4, AIData[baseID].AI.RotateSpeed, objectAct.WorkEx.Move, 5, 1)
	TimeAction(objHandle, "ActFunc_TargetTrackingUpdate", 0.5)
	TimeAction(objHandle, "ActFunc_AttackSuicideBombing_3", objectAct.WorkEx.MoveTime)
end
function ActFunc_AttackSuicideBombing_3( objHandle, baseID, stateID, level, x, y, z, velocity )
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	playAni = GetObjectAni(objHandle, objectAct.Ani3)
	if playAni ~= nil then	aniTime = (AEGetAnimLength(objHandle, playAni))
	else					aniTime = 0	end
	AEAniPlay(objHandle, playAni)
	TimeAction(objHandle, "ActFunc_AttackSuicideBombingEnd", aniTime)
end
function ActFunc_AttackSuicideBombingEnd( objHandle, baseID, stateID, level, x, y, z, velocity )
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	if objectAct.Type == "Direct" then
		--AEDamage(objHandle, x,y,z,0,0,1, objectAct.Work.DistRange, objectAct.Work.AngleRange, GetRndClamp(objectAct.Work.Damage), DT_EXPLODE, objectAct.Work.DamageNum)--2,4,7,13,37,38,39,42,46,47,51
		--CreateFX(objHandle, objectAct.FX1, x, y, z, 0)
		ActivateDamage("Direct", objHandle, objectAct, DT_EXPLODE)
		
		if objectAct.WorkEx.refAct ~= nil then
			refActData = AIData[baseID].Act[objectAct.WorkEx.refAct]
			if refActData ~= nil then
				AIData.Object[objHandle].ProjectileThrow = true
				AEProjectile(objHandle, refActData.Work.Point[2], true, refActData.WorkEx.AmmoID, refActData.Work.DistRange, refActData.Work.AngleRange, GetRndClamp(refActData.Work.Damage), refActData.WorkEx.Ani)
			end
		end
	end
	

	AEDeleteBot(objHandle)
end


-- 넉백공격
function ActFunc_AttackKnockback( objHandle, baseID, stateID, level, x, y, z, velocity )	-- 준비
	AIData.Object[objHandle].StartAct = true
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	--if objectAct.FX1 ~= nil then	AEFX(objHandle, false, objectAct.FX1.Name, objectAct.FX1.Socket)	end
	AEState(objHandle, StateID_Act2)
	playAni = GetObjectAni(objHandle, objectAct.Ani1)
	if playAni ~= nil then	aniTime = AEGetAnimLength(objHandle, playAni)
	else					aniTime = 0	end
	AEAniPlay(objHandle, playAni)
	AEMoveOption(objHandle, 100, 4, AIData[baseID].AI.RotateSpeed, 0, 5, 1)		--회전만 가능하게
	TimeAction(objHandle, "ActFunc_AttackKnockbackStart", aniTime)
end
function ActFunc_AttackKnockbackStart( objHandle, baseID, stateID, level, x, y, z, velocity )	-- 시작
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	if objectAct.Type == "Direct" then
		tx, ty, tz = AEGetPosOfPlayer(AIData.Object[objHandle].Target)
		if tx~=nil and ty~=nil and tz~= nil then
			norx, nory, norz = Normalize(GetVector(x,y,z, tx, ty, tz))
			movx, movy, movz = GetVectorMul(norx, nory, norz, objectAct.WorkEx.Move)
			AERunToPos(objHandle, x + movx, y + movy, z + movz, true)
		else	AIData.Object[objHandle].Target = nil	end
		AEMoveOption(objHandle, 100, 4, 40.0, objectAct.WorkEx.Move/objectAct.WorkEx.MoveTime, 100, 1)
	end
	AEAniPlay(objHandle, GetObjectAni(objHandle, objectAct.Ani2))
	SetActionTime(objHandle)
	TimeAction(objHandle, "ActFunc_AttackKnockbackUpdate", 0.2)
end
function ActFunc_AttackKnockbackUpdate( objHandle, baseID, stateID, level, x, y, z, velocity )	-- 업데이트
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	AEAniPlay(objHandle, GetObjectAni(objHandle, objectAct.Ani2))
	--resultNum = AEDamage(objHandle, objectAct.Work.Point[1], objectAct.Work.Point[2], objectAct.Work.DistRange, objectAct.Work.AngleRange, GetRndClamp(objectAct.Work.Damage), DT_MELEE, objectAct.Work.DamageNum)--2,4,7,13,37,38,39,42,46,47,51
	resultNum = 0
	if objectAct.Type == "Direct" then
		resultNum = ActivateDamage("Direct", objHandle, objectAct, DT_MELEE)
	else
		target = AIData.Object[objHandle].Target
		tx,ty,tz = AEGetPosOfPlayer(target)
		dist = GetPositionDist(x,y,z, tx,y,tz)
		if dist == nil or dist < 100 then
			resultNum = 1
		else
			AERunToPos(objHandle, tx,ty,tz, true)
			AEMoveOption(objHandle, 100, 4, AIData[baseID].AI.RotateSpeed, objectAct.WorkEx.Move, 5, 1)
		end
	end
	
	if resultNum >= 1 or GetActionTime(objHandle) >= objectAct.WorkEx.MoveTime then
		aniTime = 0
		if objectAct.Ani3 ~= nil then
			playAni = GetObjectAni(objHandle, objectAct.Ani3)
			if playAni ~= nil then	aniTime = AEGetAnimLength(objHandle, playAni)	end
			AEAniPlay(objHandle, playAni)
		end
		AEMoveOption(objHandle, 100, 1, 0.0, 0, 100, 1)	-- 회전및 이동불가. StateID_Death
		TimeAction(objHandle, "ActFunc_CoolTime", aniTime)
		return 0
	end

	return 1
end

-- 프로젝타일무기공격
function ActFunc_AttackPrjectileWeapon( objHandle, baseID, stateID, level, x, y, z, velocity )
	AIData.Object[objHandle].StartAct = true
	objectAct = AIData.Object[objHandle].WeaponAct
	if objectAct == nil then	return	end
	if AEChangeWeapon(objHandle, objectAct.AIWeapon.WeaponID) == true then
		AEUpdateFunc(objHandle, "ActFunc_AttackPrjectileWeapon", 1.0 )
		return
	end
	
	nextTime = GetRndClamp(objectAct.AIWeapon.ContinuousFireTime)
	TimeAction(objHandle, "ActFunc_ContinuousFire", nextTime)
	TimeAction(objHandle, "ActFunc_ProjectileFire", nextTime+objectAct.AIWeapon.InterruptedFireTime)
end
function ActFunc_ProjectileFire( objHandle, baseID, stateID, level, x, y, z, velocity )
	objectAct = AIData.Object[objHandle].WeaponAct
	if objectAct == nil or objectAct.WorkEx == nil then	return	end
	AIData.Object[objHandle].ProjectileThrow = true
	AEProjectile(objHandle, objectAct.Work.Point[2], true, objectAct.WorkEx.AmmoID, objectAct.Work.DistRange, objectAct.Work.AngleRange, GetRndClamp(objectAct.Work.Damage), objectAct.WorkEx.Ani)
end

-- 일반무기공격
function ActFunc_AttackDefaultWeapon( objHandle, baseID, stateID, level, x, y, z, velocity )
	AIData.Object[objHandle].StartAct = true
	objectAct = AIData.Object[objHandle].WeaponAct
	if objectAct == nil then	return	end
	if AEChangeWeapon(objHandle, objectAct.AIWeapon.WeaponID) == true then
		AEUpdateFunc(objHandle, "ActFunc_AttackDefaultWeapon", 1.0 )
		return
	end

--	px,py,pz,dx,dy,dz = AEGetAITransform(objHandle, objectAct.Work.Point[1], objectAct.Work.Point[2])
--	tx,ty,tz = AEGetPosOfPlayer(AIData.Object[objHandle].Target)
--	if ty ~= nil then ty = ty + 30	end
--	angle = GetAngle(px,py,pz,dx,dy,dz,tx,ty,tz)
	--angle = AEGetAngle(objHandle, AIData.Object[objHandle].Target)
--	if angle > objectAct.Work.AngleRange then
--		TimeAction(objHandle, "ActFunc_Stop", GetRndClamp(objectAct.CoolTime))
--		return
--	end
	
	TimeAction(objHandle, "ActFunc_WeaponFire", objectAct.AIWeapon.InterruptedFireTime)
	TimeAction(objHandle, "ActFunc_ContinuousFire", GetRndClamp(objectAct.AIWeapon.ContinuousFireTime))
	ActFunc_WeaponFire( objHandle, baseID, stateID, level, x, y, z, velocity )
end

function ActFunc_ContinuousFire( objHandle, baseID, stateID, level, x, y, z, velocity )
	objectAct = AIData.Object[objHandle].WeaponAct
	if objectAct == nil then	return	end
	TimeAction(objHandle, "ActFunc_Stop", GetRndClamp(objectAct.CoolTime))
end

function ActFunc_WeaponFire( objHandle, baseID, stateID, level, x, y, z, velocity )
	objectAct = AIData.Object[objHandle].WeaponAct
	if objectAct == nil then	return	end
	if AEFindFunc(objHandle, "ActFunc_ContinuousFire") == false then	return	end
	ActivateDamage("Weapon", objHandle, objectAct, DT_BULLET)
	return 1
end

-- 투스탭일반공격
function ActFunc_TwoStepAttack( objHandle, baseID, stateID, level, x, y, z, velocity )
	AIData.Object[objHandle].StartAct = true
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	AEAniBase(objHandle, GetObjectAni(objHandle, AIData[baseID].Ani.Idle), true, true)
	--if objectAct.FX1 ~= nil then	AEFX(objHandle, false, objectAct.FX1.Name, objectAct.FX1.Socket)	end
	AEState(objHandle, StateID_Act1)
	playAni = GetObjectAni(objHandle, objectAct.Ani1)
	if playAni ~= nil then	aniTime = AEGetAnimLength(objHandle, playAni)
	else					aniTime = 0	end
	AEAniPlay(objHandle, playAni)
	AEMoveOption(objHandle, 0, 4, AIData[baseID].AI.RotateSpeed, 0, 10, 1)		--회전만 가능하게
	SetActionTime(objHandle)
	TimeAction(objHandle, "ActFunc_TargetTrackingUpdate", 0.5)
	TimeAction(objHandle, "ActFunc_TwoStepAttackEnd", aniTime)
end
function ActFunc_TwoStepAttackEnd( objHandle, baseID, stateID, level, x, y, z, velocity )
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	playAni = GetObjectAni(objHandle, objectAct.Ani2)
	if playAni ~= nil then	aniTime = (AEGetAnimLength(objHandle, playAni))
	else					aniTime = 0	end
	AEAniPlay(objHandle, playAni)
	TimeAction(objHandle, "ActFunc_CoolTime", aniTime)
end

-- 투스탭끌어당기기공격
function ActFunc_Pull( objHandle, baseID, stateID, level, x, y, z, velocity )
	AIData.Object[objHandle].StartAct = true
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	--if objectAct.FX1 ~= nil then	AEFX(objHandle, false, objectAct.FX1.Name, objectAct.FX1.Socket)	end
	AEState(objHandle, StateID_Act1)
	AEMoveOption(objHandle, 0, 4, AIData[baseID].AI.RotateSpeed, 0, 10, 1)		--회전만 가능하게
	playAni = GetObjectAni(objHandle, objectAct.Ani1)
	if playAni ~= nil then	aniTime = AEGetAnimLength(objHandle, playAni)
	else					aniTime = 0	end
	AEAniBase(objHandle, playAni, false, false)
	TimeAction(objHandle, "ActFunc_TargetTrackingUpdate", 0.3)
	TimeAction(objHandle, "ActFunc_Pull_2", aniTime)
end
function ActFunc_Pull_2( objHandle, baseID, stateID, level, x, y, z, velocity )
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	AEAniBase(objHandle, GetObjectAni(objHandle, objectAct.Ani2), false, false)
	SetActionTime(objHandle)
	TimeAction(objHandle, "ActFunc_PullUpdate1", 0)
end
function ActFunc_PullUpdate1( objHandle, baseID, stateID, level, x, y, z, velocity )	-- 업데이트
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	result = false
	---[[
	target = AIData.Object[objHandle].Target
	if target ~= nil then
		tx,ty,tz = AEGetPosOfPlayer(target)
		px,py,pz,dx,dy,dz = AEGetAITransform(objHandle, objectAct.Work.Point[1], objectAct.Work.Point[2])
		dx,dy,dz = AEGetForwardOfBot(objHandle)
		if dx~=nil and dz ~= nil then
			px = px + dx * 80
			pz = pz + dz * 80
		end
		result, dist1 = AEGetWorldIntersect(x,y,z, px,y,pz)
		dist2 = GetPositionDist(x,y,z, tx,y,tz)
		if dist1 ~= nil and dist2 ~= nil and dist1 > dist2 then
			result = true
			TimeAction(objHandle, "ActFunc_PullUpdate2", 0)
		end
	end
	--]]

	playAni = GetObjectAni(objHandle, objectAct.Ani2)
	if playAni ~= nil then	aniTime = (AEGetAnimLength(objHandle, playAni))
	else					aniTime = 0	end
	actionTime = GetActionTime(objHandle)
	if result == true or actionTime > aniTime then
		startTime = math.max(0, aniTime - actionTime)
		playAni = GetObjectAni(objHandle, objectAct.Ani3)
		if playAni ~= nil then	aniTime = AEGetAnimLength(objHandle, playAni)
		else					aniTime = 0	end
		AEAniBase(objHandle, playAni, false, false)
		AESetAniTime(objHandle, 1, startTime)
		TimeAction(objHandle, "ActFunc_Pull_3", aniTime-startTime)
		return 0
	end

	return 1
end
function ActFunc_PullUpdate2( objHandle, baseID, stateID, level, x, y, z, velocity )	-- 업데이트
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	target = AIData.Object[objHandle].Target
	if target == nil then	return	end
	
	px,py,pz,dx,dy,dz = AEGetAITransform(objHandle, objectAct.Work.Point[1], objectAct.Work.Point[2])
	tx,ty,tz = AEGetPosOfPlayer(target)
	dx,dy,dz = AEGetForwardOfBot(objHandle)
	if dx~=nil and dz ~= nil then
		tx = (tx + px + dx * 80) * 0.5
		tz = (tz + pz + dz * 80) * 0.5
		AESetPosOfPlayer(target, tx,ty,tz)
	end
	return 1
end
function ActFunc_Pull_3( objHandle, baseID, stateID, level, x, y, z, velocity )
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end
	AEUpdateFunc(objHandle, "ActFunc_PullUpdate2", -1)
	AEAniBase(objHandle, GetObjectAni(objHandle, AIData[baseID].Ani.Idle), true, true)
	playAni = GetObjectAni(objHandle, objectAct.Ani4)
	if playAni ~= nil then	aniTime = AEGetAnimLength(objHandle, playAni)
	else					aniTime = 0	end
	AEAniPlay(objHandle, playAni)
	TimeAction(objHandle, "ActFunc_CoolTime", aniTime)
end

-- 트랩
function ActFunc_TrapNext( objHandle, baseID, stateID, level, x, y, z, velocity )
	objectAct = AIData.Object[objHandle].Act
	if objectAct == nil then	return	end

	actIdx = GetRndTable(objectAct.Work.Next)
	if actIdx == nil then
		TimeAction(objHandle, "ActFunc_Stop", 0)
	else
		SetAction(objHandle, AIData[baseID].Act[actIdx])
	end
end

-- 무브트랩
function ActFunc_MoveTrap( objHandle, baseID, stateID, level, x, y, z, velocity )
	obj = AIData.Object[objHandle]
	objectAct = obj.Act
	if objectAct == nil then	return	end

	SetActionTime(objHandle)
	
	dataX = AEGetData(objHandle, DataKey_X)
	dataY = AEGetData(objHandle, DataKey_Y)
	dataZ = AEGetData(objHandle, DataKey_Z)
	x = dataX+objectAct.Work.GO[1]
	y = dataY+objectAct.Work.GO[2]
	z = dataZ+objectAct.Work.GO[3]
	if obj.LastRotateTotal ~= nil then	obj.RotateTotal = obj.LastRotateTotal
	else							obj.RotateTotal = AEGetYawAngle(objHandle) - AEGetData(objHandle, DataKey_R)	end
	obj.RotateFactor = GetRndClamp(objectAct.Work.RotSpeed)
	obj.CoolTime = GetRndClamp(objectAct.CoolTime)
	obj.GO = objectAct.Work.GO
	AEGo(objHandle, x,y,z,obj.CoolTime)
	
	if objectAct.Work.TrapSound ~= nil then
		AECallbackEvent("TrapSound", objHandle, objectAct.Work.TrapSound)
	end

	TimeAction(objHandle, "ActFunc_TrapNext", obj.CoolTime)
end

-- 복사트랩
function ActFunc_CopyTrap( objHandle, baseID, stateID, level, x, y, z, velocity )
	obj = AIData.Object[objHandle]
	objectAct = obj.Act
	if objectAct == nil then	return	end
	obj.CopyRotateFactor = GetRndClamp(objectAct.Work.RotSpeed)
	TimeAction(objHandle, "ActFunc_TrapNext", GetRndClamp(objectAct.CoolTime))
	TimeAction(objHandle, "ActFunc_CopyTrapUpdate", 0)
end

function ActFunc_CopyTrapUpdate( objHandle, baseID, stateID, level, x, y, z, velocity )
	obj = AIData.Object[objHandle]
	objectAct = obj.Act
	if objectAct == nil then	return	end
	if objectAct.ActFunc ~= "ActFunc_CopyTrap" then
		obj.GO = nil
		return 0
	end
	
	AITable = AIData[baseID].AI[level]
	mirrorX = objectAct.Work.GO[1]
	mirrorY = objectAct.Work.GO[2]
	mirrorZ = objectAct.Work.GO[3]
	if obj.CopyRotateFactor == nil then obj.CopyRotateFactor = 1	end

	originalHandle = AEGetData(objHandle, DataKey_O)
	if originalHandle > 0 then
		origObj = AIData.Object[originalHandle]
		if origObj ~= nil then
			obj.ActTime = origObj.ActTime

			if origObj.RotateTotal ~= nil then
				obj.RotateTotal = origObj.RotateTotal * obj.CopyRotateFactor
			else
				obj.RotateTotal = nil
			end
			if origObj.RotateFactor ~= nil then
				obj.RotateFactor = origObj.RotateFactor * obj.CopyRotateFactor
			else
				obj.RotateFactor = nil
			end

			if origObj.Act ~= nil and origObj.CoolTime ~= nil then
				if obj.GO ~= origObj.GO then
					obj.GO = origObj.GO

					dataX = AEGetData(objHandle, DataKey_X)
					dataY = AEGetData(objHandle, DataKey_Y)
					dataZ = AEGetData(objHandle, DataKey_Z)
					x = dataX + obj.GO[1] * mirrorX
					y = dataY + obj.GO[2] * mirrorY
					z = dataZ + obj.GO[3] * mirrorZ
					AEGo(objHandle, x, y, z, origObj.CoolTime)
				end
			end
		end
	end
	return 1
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
