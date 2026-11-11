---------------------------------------------------------------------------------------------------------------------
-- AI Data
--	AI
--		AIFunc_Walk				: 타겟에 걷기로 접근
--		AIFunc_Run				: 타겟에 뛰기로 접근
--		AIFunc_WalkAndRun		: 타겟에 걷기로 접근하다가 일정거리에 들어오면 뛰기로 접근
--		AIFunc_RunAndWalk		: 타겟에 뛰기로 접근하다가 일정거리에 들어오면 걷기로 접근
--	Ani
--		AniFunc_Default			: 일반적인 봇의 애니메이션
--	Act
--		ActFunc_AttackDefault	: 일반공격(StateID_Act1)
--		ActFunc_AttackKnockback	: 넉백공격(StateID_Act2)
--
---------------------------------------------------------------------------------------------------------------------
-- 상태변수
AIData = {}
AIData.Object = {}

-- ai상태는 여기서도 사용하므로 정의를 여기서 해야 한다.
StateID_Stop = 0
StateID_Death = 1
StateID_Walk = 2
StateID_Run = 3
StateID_Act1 = 4
StateID_Act2 = 5
StateID_Act3 = 6
StateID_Act4 = 7


-- 이건 다른곳에도 공유되는거라 여기서 해야만 한다
function GetRndTable(myTable)
	if myTable == nil or #myTable == 0 then
		return nil
	end
	return myTable[math.random( 1, #myTable )]
end
function GetRndClamp(myTable)
	if myTable == nil or #myTable ~= 2 then
		return nil
	end
	return math.random(myTable[1] * 100, myTable[2] * 100)*0.01
end
function GetInteractionSpeech(baseID)
	speech = GetRndTable(AIData[baseID].InteractionSpeech)
	if speech == nil then	return "", "", 1, ""	end
	return AIData[baseID].InteractionSound, speech[1], speech[2], speech[3]
end
function GetDefaultSpeech(baseID)
	speech = GetRndTable(AIData[baseID].DefaultSpeech)
	if speech == nil then	return "", 1, ""	end
	return speech[1], speech[2], speech[3]
end
function GetEnchantSpeech(baseID)
	speech = GetRndTable(AIData[baseID].EnchantSpeech)
	if speech == nil then	return "", 1, ""	end
	return speech[1], speech[2], speech[3]
end
function GetSuccessSpeech(baseID)
	speech = GetRndTable(AIData[baseID].SuccessSpeech)
	if speech == nil then	return "", 1, ""	end
	return speech[1], speech[2], speech[3]
end
function GetFailSpeech(baseID)
	speech = GetRndTable(AIData[baseID].FailSpeech)
	if speech == nil then	return "", 1, ""	end
	return speech[1], speech[2], speech[3]
end
function GetIdleAni(baseID)
	if speech == nil then	return "", 1, ""	end
	return GetRndTable(AIData[baseID].Ani.Idle)
end
function GetStealthState(baseID, aniName)
	stealth = AIData[baseID].Ani.Stealth
	if stealth ~= nil then
		for _, v in pairs(stealth) do
			if v == aniName then
				return 1
			end
		end
		if #stealth > 0 then
			return -1
		end
	end
	return 0
end
function GetPlaySoundName(baseID, objHandle, stateID, nowTime)
	if AIData.Object[objHandle] == nil then
		AIData.Object[objHandle] = {}
		AIData.Object[objHandle].PlaySoundTime = 0
	end
	baseSound = AIData.Sound[baseID]
	if baseSound ~= nil then
		playSound = baseSound[stateID]
		if playSound ~= nil then
			if AIData.Object[objHandle].PlaySoundTime < nowTime then
				AIData.Object[objHandle].PlaySoundTime = nowTime + GetRndClamp(baseSound.CoolTime)
				return baseSound.Path..GetRndTable(playSound)
			end
		end
	end
	return ""
end
function GetTrapSoundName(id)
	if AIData.TrapSound[id] == nil then
		return ""
	end
	return AIData.TrapSound.Path..AIData.TrapSound[id]
end
function GetTargetInfo(grade)
	if grade >= 8 then
		return 255,255,255, true
	elseif grade >= 5 then
		return 255,128,2, false
	else
		return 255,0,0, false	 -- nameR, nameG, nameB, visible gauge
	end
end


AIData.AmmoFX =
{
	[153]=	{	Socket=nil, Name="Zom_Vomit_Ground"	},
	[551]=	{	Socket=nil, Name="Elevator_fanatic_Poison"	},
	[552]=  {   Socket=nil, Name="Ep_TNT_Explosion"    },
	[553]=  {   Socket=nil, Name="SA_Exp_SmokeGrenade"    },
	[554]=  {   Socket=nil, Name="Ep_TNT_Explosion"    },
	[555]=  {   Socket=nil, Name="Elevator_fanatic_Poison" },
	[556]=  {   Socket=nil, Name="Zom_Vomit_Ground" },
	[557]=  {   Socket=nil, Name="Zombi8_suicide_attack" },
	[558]=  {   Socket=nil, Name="Elevator_fanatic_Gas" },
	}

AIData.Sound = 
{
	[1242]=
	{
		CoolTime = {8,20}, Path = "sa_interface2/snd/zombie/zombie_move/",
		[StateID_Stop] = {"Defence_walk.wav",},
		[StateID_Walk] = {"Defence_walk.wav",},
		[StateID_Run] = {"Defence_run.wav",},
	},
}
AIData.TrapSound =
{
	Path = "sa_props/snd/DeathRun/",
	[1] = "STG1/Run_STG1_01_1.wav",
	[101] = "STG1/Run_STG1_01_1.wav",
	[2] = "STG1/Run_STG1_04.wav",
	[3] = "STG1/Run_STG1_06_1.wav",
	[4] = "STG2/Run_STG2_10.wav",
	[5] = "STG2/Run_STG2_03.wav",
	[6] = "STG2/Run_STG2_04_1.wav",
	[601] = "STG2/Run_STG2_04_2.wav",
	[7] = "STG2/Run_STG2_08_2.wav",
	[8] = "STG2/Run_STG2_10.wav",
	[9] = "STG2/Run_STG2_16_1.wav",
	[10] = "STG2/Run_STG2_05.wav",
	[11] = "STG1/Run_STG1_16.wav",
	[12] = "STG2/Run_STG2_01.wav",
	[13] = "STG2/Run_STG2_02.wav"
}

AIData[1223]=	-- 정비사 
{
	Interaction=1, SpawnPoint={"ActionEventPointB1110", },
	Image = "sa_interface2/hud/elevator/Gamble/EXIT_NPC_1223.dtx",
	InteractionSound="sa_characters/customvoice/1433/radio/nice_shot_kor.wav",
	InteractionSpeech={{"",2,"안녕!\r\n오늘 컨디션 최고인데?\r\n무기 강화 한번 해볼까?\r\n"},},
	DefaultSpeech={{"",1,"내가 어떻게 살아남을 수 있었냐고?\r\n그건 말이지..\r\n"},},
	EnchantSpeech={{"",3,"총기를 잃어버리면\r\n강화 능력치도 사라지니 조심해야해!\r\n"}, {"Social_idle3",3,"한 번 선택하면\r\n되돌릴 수 없어요.\r\n"}, {"Social_idle3",3,"강화는 어차피\r\n운이라는거 알고 있지?\r\n"}},
	SuccessSpeech={{"Em2",4,"만족??\r\n너가 만족 하면 나도 만족♥\r\n"},},
	FailSpeech={{"Social_idle3",2,"아이코 손이!!!\r\n"},},
	AI={HP=100}, Ani={AniFunc="AniFunc_None"},
}--------------------------------------------------------------------------------------------------------------------
AIData[1224]=	-- 무기상 
{
	Interaction=3, SpawnPoint={"ActionEventPointB1111", },
	Image = "sa_interface2/hud/elevator/Gamble/EXIT_NPC_1224.dtx",
	InteractionSound="sa_characters/customvoice/1/radio\nice_shot_kor.wav",
	InteractionSpeech={{"Social_idle1",4,"좋은 물건 들어왔는데\r\n한번 보고 갈래?\r\n"},},
	DefaultSpeech={{"",1,"어디서 났을까?\r\n비밀..!\r\n"},},
	EnchantSpeech={{"",3,""},},
	SuccessSpeech={{"",4,"어디서 났을까?\r\n비밀..!\r\n"},},
	FailSpeech={{"",2,"실패했다~!\r\n"},},
	AI={HP=100}, Ani={AniFunc="AniFunc_None"},
}--------------------------------------------------------------------------------------------------------------------
AIData[1225]=	-- 스페셜 정비사
{
	Interaction=2, SpawnPoint={"ActionEventPointB1110", },
	Image = "sa_interface2/hud/elevator/Gamble/EXIT_NPC_1225.dtx",
	InteractionSound="sa_characters/customvoice/1433/radio/nice_shot_kor.wav",
	InteractionSpeech={{"",2,"난 최고의 정비사!\r\n날 만난건 행운이야!\r\n"},},
	DefaultSpeech={{"",1,"아직 생존자가 남아있다니,\r\n정말 다행이야..\r\n"},},
	EnchantSpeech={{"",3,"총기를 잃어버리면\r\n강화 능력치도 사라지니 조심해야해!\r\n"}, {"Social_idle3",3,"한 번 선택하면\r\n되돌릴 수 없어요.\r\n"}, {"Social_idle3",3,"강화는 어차피\r\n운이라는거 알고 있지?\r\n"}},
	SuccessSpeech={{"Em2",4,"나는 실패를 모른다고!\r\n"},},
	FailSpeech={{"Social_idle0",2,"앗!!!\r\n누구신지....\r\n"},},
	AI={HP=100}, Ani={AniFunc="AniFunc_None"},
}--------------------------------------------------------------------------------------------------------------------
AIData[1226]=	-- 스페셜 무기상
{
	Interaction=4, SpawnPoint={"ActionEventPointB1111", },
	Image = "sa_interface2/hud/elevator/Gamble/EXIT_NPC_1226.dtx",
	InteractionSound="sa_characters/customvoice/1/radio/nice_shot_kor.wav",
	InteractionSpeech={{"Social_idle1",4,"좋은 물건 들어왔는데\r\n한번 보고 갈래?\r\n"},},
	DefaultSpeech={{"",1,"어디서 났을까?\r\n비밀..!\r\n"},},
	EnchantSpeech={{"",3,""},},
	SuccessSpeech={{"",4,"어디서 났을까?\r\n비밀..!\r\n"},},
	FailSpeech={{"",2,"실패했다~!\r\n"},},
	AI={HP=100}, Ani={AniFunc="AniFunc_None"},
}--------------------------------------------------------------------------------------------------------------------
 
 
 
  
 
 
 
 
AIData[1227]=        --기본좀비A    파란색
{
    AI=
    {    HP=360, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA"},
        Walk={"WalkA"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={6,7}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1228]=        --기본좀비B    파란색
{
    AI=
    {    HP=360, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunB"},
        Walk={"WalkB"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={6,7}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1229]=        --기본좀비C    파란색
{
    AI=
    {    HP=360, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunC"},
        Walk={"WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={6,7}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1230]=        --기본좀비A    녹색
{
    AI=
    {    HP=540, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA"},
        Walk={"WalkA"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={8,10}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1231]=        --기본좀비B    녹색
{
    AI=
    {    HP=540, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunB"},
        Walk={"WalkB"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={8,10}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1232]=        --기본좀비C    녹색
{
    AI=
    {    HP=540, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunC"},
        Walk={"WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={8,10}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1233]=        --기본좀비A    노란색
{
    AI=
    {    HP=684, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA"},
        Walk={"WalkA"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={10,12}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1234]=        --기본좀비B    노란색
{
    AI=
    {    HP=684, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunB"},
        Walk={"WalkB"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={10,12}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1235]=        --기본좀비C    노란색
{
    AI=
    {    HP=684, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunC"},
        Walk={"WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={10,12}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1236]=        --기본좀비A    오렌지색
{
    AI=
    {    HP=828, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA"},
        Walk={"WalkA"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={11,13}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1237]=        --기본좀비B    오렌지색
{
    AI=
    {    HP=828, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunB"},
        Walk={"WalkB"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={11,13}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1238]=        --기본좀비C    오렌지색
{
    AI=
    {    HP=828, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunC"},
        Walk={"WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={11,13}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1239]=        --기본좀비A    빨간색
{
    AI=
    {    HP=972, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA"},
        Walk={"WalkA"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={13,16}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1240]=        --기본좀비B    빨간색
{
    AI=
    {    HP=972, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunB"},
        Walk={"WalkB"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={13,16}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1241]=        --기본좀비C    빨간색
{
    AI=
    {    HP=972, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunC"},
        Walk={"WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={13,16}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1242]=        --방어좀비A    파란색
{
    AI=
    {    HP=4320, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={9,11}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={7,8}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1243]=        --방어좀비A    녹색
{
    AI=
    {    HP=6480, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={12,14}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={9,11}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1244]=        --방어좀비A    노란색
{
    AI=
    {    HP=8208, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={14,17}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={12,14}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1245]=        --방어좀비A    오렌지색
{
    AI=
    {    HP=9936, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={17,20}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={14,17}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1246]=        --방어좀비A    빨간색
{
    AI=
    {    HP=11664, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={20,24}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={16,19}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1247]=        --방어좀비B    파란색
{
    AI=
    {    HP=4320, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={9,11}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={7,8}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1248]=        --방어좀비B    녹색
{
    AI=
    {    HP=6480, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={12,14}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={9,11}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1249]=        --방어좀비B    노란색
{
    AI=
    {    HP=8208, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={14,17}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={12,14}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1250]=        --방어좀비B    오렌지색
{
    AI=
    {    HP=9936, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={17,20}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={14,17}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1251]=        --방어좀비B    빨간색
{
    AI=
    {    HP=11664, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={20,24}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={16,19}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1252]=        --방어좀비C    파란색
{
    AI=
    {    HP=4320, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={9,11}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={7,8}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1253]=        --방어좀비C    녹색
{
    AI=
    {    HP=6480, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={12,14}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={9,11}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1254]=        --방어좀비C    노란색
{
    AI=
    {    HP=8208, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={14,17}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={12,14}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1255]=        --방어좀비C    오렌지색
{
    AI=
    {    HP=9936, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={17,20}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={14,17}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	 
 
AIData[1256]=        --방어좀비C    빨간색
{
    AI=
    {    HP=11664, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={20,24}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={16,19}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1257]=        --곰돌이좀비    파란색
{
    AI=
    {    HP=360, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={6,7}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1258]=        --곰돌이좀비    녹색
{
    AI=
    {    HP=540, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={8,10}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1259]=        --곰돌이좀비    노란색
{
    AI=
    {    HP=684, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={10,12}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1260]=        --곰돌이좀비    오렌지색
{
    AI=
    {    HP=828, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={11,13}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1261]=        --곰돌이좀비    빨간색
{
    AI=
    {    HP=972, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={13,16}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1262]=        --포이즌좀비    파란색
{
    AI=
    {    HP=720, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={8,12}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1263]=        --포이즌좀비    노란색
{
    AI=
    {    HP=1368, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={12,17}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1264]=        --포이즌좀비    빨간색
{
    AI=
    {    HP=1944, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={17,24}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1265]=        --포이즌좀비    검정색
{
    AI=
    {    HP=2232, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={20,29}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1266]=        --넉백좀비    파란색
{
    AI=
    {    HP=2160, RotateSpeed=7, WalkSpeed=160, RunSpeed=240, ViewDist=2000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=15, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={11,13}},
            Ani1={"Attack1","Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Direct", Range={110,1200}, ActTime={1.0,1.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=133, AngleRange=360, Damage={13,16}},
            Ani1={"S_ATK1 Ready1"},
            Ani2={"S_ATK1"},
            Ani3={"Tired"},
                DamagePenalty ={0.6,1},

               WorkEx={Move=1400, MoveTime=1},
        },
    },
}--------------------------------------------------	   
AIData[1267]=        --넉백좀비    노란색
{
    AI=
    {    HP=4104, RotateSpeed=7, WalkSpeed=160, RunSpeed=240, ViewDist=2000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=15, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={17,20}},
            Ani1={"Attack1","Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Direct", Range={110,1200}, ActTime={1.0,1.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=133, AngleRange=360, Damage={21,25}},
            Ani1={"S_ATK1 Ready1"},
            Ani2={"S_ATK1"},
            Ani3={"Tired"},
                DamagePenalty ={0.6,1},

               WorkEx={Move=1400, MoveTime=1},
        },
    },
}--------------------------------------------------	   
AIData[1268]=        --넉백좀비    빨간색
{
    AI=
    {    HP=5832, RotateSpeed=7, WalkSpeed=160, RunSpeed=240, ViewDist=2000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=15, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={24,29}},
            Ani1={"Attack1","Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Direct", Range={110,1200}, ActTime={1.0,1.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=133, AngleRange=360, Damage={29,35}},
            Ani1={"S_ATK1 Ready1"},
            Ani2={"S_ATK1"},
            Ani3={"Tired"},
                DamagePenalty ={0.6,1},

               WorkEx={Move=1400, MoveTime=1},
        },
    },
}--------------------------------------------------	   
AIData[1269]=        --도살자    파란색
{
    AI=
    {    HP=10800, RotateSpeed=10, WalkSpeed=150, RunSpeed=450, ViewDist=2000, ViewAngle=90, AvoidRate=20, Factor1=5400,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1,2}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={3}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Transformer",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Ani1={"ArmorBreak"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_TwoStepAttack", Type="Key", Range={0,200}, ActTime={0.0,0.0}, CoolTime={2.0,2.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=300, AngleRange=360, Damage={36,52}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},
        },
        [2]={
            ActFunc="ActFunc_Pull", Type="Key", Range={150,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_L_D1"}, DamageNum=1, DistRange=250, AngleRange=360, Damage={6,9}},
            Ani1={"SAttack"},
            Ani2={"SAttack_Throw"},
            Ani3={"SAttack_RThrow"},
            Ani4={"SAttack_PO"},
                DamagePenalty ={0.8,2},
        },
        [3]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,180}, ActTime={0.2,0.2}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=200, AngleRange=360, Damage={12,17}},
            Ani1={"Attack_Run"},
        },
    },
}--------------------------------------------------	   
AIData[1270]=        --도살자    녹색
{
    AI=
    {    HP=16200, RotateSpeed=10, WalkSpeed=150, RunSpeed=450, ViewDist=2000, ViewAngle=90, AvoidRate=20, Factor1=8100,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1,2}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={3}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Transformer",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Ani1={"ArmorBreak"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_TwoStepAttack", Type="Key", Range={0,200}, ActTime={0.0,0.0}, CoolTime={2.0,2.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=300, AngleRange=360, Damage={47,68}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},
        },
        [2]={
            ActFunc="ActFunc_Pull", Type="Key", Range={150,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_L_D1"}, DamageNum=1, DistRange=250, AngleRange=360, Damage={8,12}},
            Ani1={"SAttack"},
            Ani2={"SAttack_Throw"},
            Ani3={"SAttack_RThrow"},
            Ani4={"SAttack_PO"},
                DamagePenalty ={0.8,2},
        },
        [3]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,180}, ActTime={0.2,0.2}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=200, AngleRange=360, Damage={16,23}},
            Ani1={"Attack_Run"},
        },
    },
}--------------------------------------------------	   
AIData[1271]=        --도살자    노란색
{
    AI=
    {    HP=20520, RotateSpeed=10, WalkSpeed=150, RunSpeed=450, ViewDist=2000, ViewAngle=90, AvoidRate=20, Factor1=10260,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1,2}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={3}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Transformer",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Ani1={"ArmorBreak"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_TwoStepAttack", Type="Key", Range={0,200}, ActTime={0.0,0.0}, CoolTime={2.0,2.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=300, AngleRange=360, Damage={58,84}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},
        },
        [2]={
            ActFunc="ActFunc_Pull", Type="Key", Range={150,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_L_D1"}, DamageNum=1, DistRange=250, AngleRange=360, Damage={10,14}},
            Ani1={"SAttack"},
            Ani2={"SAttack_Throw"},
            Ani3={"SAttack_RThrow"},
            Ani4={"SAttack_PO"},
                DamagePenalty ={0.8,2},
        },
        [3]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,180}, ActTime={0.2,0.2}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=200, AngleRange=360, Damage={19,27}},
            Ani1={"Attack_Run"},
        },
    },
}--------------------------------------------------	   
AIData[1272]=        --도살자    오렌지색
{
    AI=
    {    HP=24840, RotateSpeed=10, WalkSpeed=150, RunSpeed=450, ViewDist=2000, ViewAngle=90, AvoidRate=20, Factor1=12420,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1,2}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={3}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Transformer",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Ani1={"ArmorBreak"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_TwoStepAttack", Type="Key", Range={0,200}, ActTime={0.0,0.0}, CoolTime={2.0,2.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=300, AngleRange=360, Damage={68,98}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},
        },
        [2]={
            ActFunc="ActFunc_Pull", Type="Key", Range={150,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_L_D1"}, DamageNum=1, DistRange=250, AngleRange=360, Damage={11,16}},
            Ani1={"SAttack"},
            Ani2={"SAttack_Throw"},
            Ani3={"SAttack_RThrow"},
            Ani4={"SAttack_PO"},
                DamagePenalty ={0.8,2},
        },
        [3]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,180}, ActTime={0.2,0.2}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=200, AngleRange=360, Damage={23,33}},
            Ani1={"Attack_Run"},
        },
    },
}--------------------------------------------------	   
AIData[1273]=        --도살자    빨간색
{
    AI=
    {    HP=29160, RotateSpeed=10, WalkSpeed=150, RunSpeed=450, ViewDist=2000, ViewAngle=90, AvoidRate=20, Factor1=14580,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1,2}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={3}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Transformer",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Ani1={"ArmorBreak"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_TwoStepAttack", Type="Key", Range={0,200}, ActTime={0.0,0.0}, CoolTime={2.0,2.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=300, AngleRange=360, Damage={79,114}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},
        },
        [2]={
            ActFunc="ActFunc_Pull", Type="Key", Range={150,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_L_D1"}, DamageNum=1, DistRange=250, AngleRange=360, Damage={13,19}},
            Ani1={"SAttack"},
            Ani2={"SAttack_Throw"},
            Ani3={"SAttack_RThrow"},
            Ani4={"SAttack_PO"},
                DamagePenalty ={0.8,2},
        },
        [3]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,180}, ActTime={0.2,0.2}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=200, AngleRange=360, Damage={26,37}},
            Ani1={"Attack_Run"},
        },
    },
}--------------------------------------------------	   
AIData[1274]=        --자객    파란색
{
    AI=
    {    HP=810, RotateSpeed=7, WalkSpeed=150, RunSpeed=210, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Stealth={"Idle_Ai","Walk","Run"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,140}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={9,13}},
            Ani1={"Attack0","Attack1"},
        },
    },
}--------------------------------------------------	   
AIData[1275]=        --자객    녹색
{
    AI=
    {    HP=1215, RotateSpeed=7, WalkSpeed=150, RunSpeed=210, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Stealth={"Idle_Ai","Walk","Run"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,140}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={12,17}},
            Ani1={"Attack0","Attack1"},
        },
    },
}--------------------------------------------------	   
AIData[1276]=        --자객    노란색
{
    AI=
    {    HP=1539, RotateSpeed=7, WalkSpeed=150, RunSpeed=210, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Stealth={"Idle_Ai","Walk","Run"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,140}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={14,20}},
            Ani1={"Attack0","Attack1"},
        },
    },
}--------------------------------------------------	   
AIData[1277]=        --자객    오렌지색
{
    AI=
    {    HP=1863, RotateSpeed=7, WalkSpeed=150, RunSpeed=210, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Stealth={"Idle_Ai","Walk","Run"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,140}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={17,24}},
            Ani1={"Attack0","Attack1"},
        },
    },
}--------------------------------------------------	   
AIData[1278]=        --자객    빨간색
{
    AI=
    {    HP=2187, RotateSpeed=7, WalkSpeed=150, RunSpeed=210, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Stealth={"Idle_Ai","Walk","Run"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,140}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={20,29}},
            Ani1={"Attack0","Attack1"},
        },
    },
}--------------------------------------------------	   
AIData[1279]=        --연금술사    파란색
{
    AI=
    {    HP=1350, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2,3,4}, AggroTime=6, DistToOpponent=800, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death3", "Death4", "Death5"},
        BDeath={"Death0", "Death1", "Death2"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,150}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={9,11}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={150,600}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=28, Damage={11,13}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=551, Ani="right_left"},
        },
        [3]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={600,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=32, Damage={11,13}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=555, Ani="right_left"},
        },
        [4]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={900,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "R"}, DamageNum=1, DistRange=180, AngleRange=35, Damage={7,8}},
            Ani1={"Attack2_Ready"},
            Ani2={"Attack2"},

               WorkEx={AmmoID=558, Ani="right_left"},
        },
    },
}--------------------------------------------------	   
AIData[1280]=        --연금술사    녹색
{
    AI=
    {    HP=2025, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2,3,4}, AggroTime=6, DistToOpponent=800, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death3", "Death4", "Death5"},
        BDeath={"Death0", "Death1", "Death2"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,150}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={12,14}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={150,600}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=28, Damage={14,17}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=551, Ani="right_left"},
        },
        [3]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={600,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=32, Damage={14,17}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=555, Ani="right_left"},
        },
        [4]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={900,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "R"}, DamageNum=1, DistRange=180, AngleRange=35, Damage={9,11}},
            Ani1={"Attack2_Ready"},
            Ani2={"Attack2"},

               WorkEx={AmmoID=558, Ani="right_left"},
        },
    },
}--------------------------------------------------	 
 
AIData[1281]=        --연금술사    노란색
{
    AI=
    {    HP=2565, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2,3,4}, AggroTime=6, DistToOpponent=800, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death3", "Death4", "Death5"},
        BDeath={"Death0", "Death1", "Death2"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,150}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={14,17}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={150,600}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=28, Damage={17,20}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=551, Ani="right_left"},
        },
        [3]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={600,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=32, Damage={17,20}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=555, Ani="right_left"},
        },
        [4]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={900,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "R"}, DamageNum=1, DistRange=180, AngleRange=35, Damage={12,14}},
            Ani1={"Attack2_Ready"},
            Ani2={"Attack2"},

               WorkEx={AmmoID=558, Ani="right_left"},
        },
    },
}--------------------------------------------------	   
AIData[1282]=        --연금술사    오렌지색
{
    AI=
    {    HP=3105, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2,3,4}, AggroTime=6, DistToOpponent=800, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death3", "Death4", "Death5"},
        BDeath={"Death0", "Death1", "Death2"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,150}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={17,20}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={150,600}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=28, Damage={21,25}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=551, Ani="right_left"},
        },
        [3]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={600,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=32, Damage={21,25}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=555, Ani="right_left"},
        },
        [4]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={900,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "R"}, DamageNum=1, DistRange=180, AngleRange=35, Damage={14,17}},
            Ani1={"Attack2_Ready"},
            Ani2={"Attack2"},

               WorkEx={AmmoID=558, Ani="right_left"},
        },
    },
}--------------------------------------------------	   
AIData[1283]=        --연금술사    빨간색
{
    AI=
    {    HP=3645, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2,3,4}, AggroTime=6, DistToOpponent=800, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death3", "Death4", "Death5"},
        BDeath={"Death0", "Death1", "Death2"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,150}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={20,24}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={150,600}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=28, Damage={24,29}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=551, Ani="right_left"},
        },
        [3]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={600,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=32, Damage={24,29}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=555, Ani="right_left"},
        },
        [4]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={900,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "R"}, DamageNum=1, DistRange=180, AngleRange=35, Damage={16,19}},
            Ani1={"Attack2_Ready"},
            Ani2={"Attack2"},

               WorkEx={AmmoID=558, Ani="right_left"},
        },
    },
}--------------------------------------------------	   
AIData[1284]=        --코믹 뱀파이어(RED)    AIBot
{
    AI=
    {    HP=648, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,150}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=162, AngleRange=15, Damage={8,10}},
            AIWeapon={WeaponID=328, InterruptedFireTime=0.4, ContinuousFireTime={0.4,0.4}},
        },
    },
}--------------------------------------------------	   
AIData[1285]=        --코믹 뱀파이어(BLUE)    AIBot
{
    AI=
    {    HP=486, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,100}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=110, AngleRange=15, Damage={4,5}},
            AIWeapon={WeaponID=156, InterruptedFireTime=0.4, ContinuousFireTime={0.4,0.4}},
        },
    },
}--------------------------------------------------	   
AIData[1286]=        --라이칸    AIBot
{
    AI=
    {    HP=4374, RotateSpeed=10, WalkSpeed=150, RunSpeed=310, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,140}, ActTime={0.0,0.2}, CoolTime={0.1,0.2},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=160, AngleRange=15, Damage={35,50}},
            AIWeapon={WeaponID=1549, InterruptedFireTime=0.8, ContinuousFireTime={0.8,0.8}},
        },
    },
}--------------------------------------------------	   
AIData[1287]=        --황금잔호크    AIBot
{
    AI=
    {    HP=5400, RotateSpeed=10, WalkSpeed=150, RunSpeed=310, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,140}, ActTime={0.0,0.2}, CoolTime={0.1,0.2},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=160, AngleRange=15, Damage={38,55}},
            AIWeapon={WeaponID=1610, InterruptedFireTime=0.8, ContinuousFireTime={0.8,0.8}},
        },
    },
}--------------------------------------------------	   
AIData[1288]=        --처녀귀신    AIBot
{
    AI=
    {    HP=648, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,120}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=150, AngleRange=15, Damage={8,10}},
            AIWeapon={WeaponID=1277, InterruptedFireTime=0.4, ContinuousFireTime={0.4,0.4}},
        },
    },
}--------------------------------------------------	   
AIData[1289]=        --저승사자    AIBot
{
    AI=
    {    HP=864, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,120}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=150, AngleRange=15, Damage={10,12}},
            AIWeapon={WeaponID=1117, InterruptedFireTime=0.4, ContinuousFireTime={0.4,0.4}},
        },
    },
}--------------------------------------------------	   
AIData[1290]=        --프랑켄슈타인(Red)    AIBot
{
    AI=
    {    HP=4320, RotateSpeed=10, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=600, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={3.0,3.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={6,9}},
            AIWeapon={WeaponID=753, InterruptedFireTime=0.1, ContinuousFireTime={1,2}},
        },
    },
}--------------------------------------------------	   
AIData[1291]=        --프랑켄슈타인(Blue)    AIBot
{
    AI=
    {    HP=3888, RotateSpeed=10, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=600, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={3.0,3.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={4,6}},
            AIWeapon={WeaponID=23, InterruptedFireTime=0.13, ContinuousFireTime={1.3,2.6}},
        },
    },
}--------------------------------------------------	   
AIData[1292]=        --미라(Red)    AIBot
{
    AI=
    {    HP=2916, RotateSpeed=10, WalkSpeed=150, RunSpeed=220, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=1000, Sense=2000, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_RunAndWalk", UseAct={1}, AggroTime=6, DistToOpponent=1000, Sense=2000, ReactionTime={0.1,0.6}, WalkDist=800,},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1500}, ActTime={0.0,0.2}, CoolTime={1.0,1.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=5000, AngleRange=10, Damage={24,43}},
            AIWeapon={WeaponID=2680, InterruptedFireTime=2, ContinuousFireTime={2,4}},
        },
    },
}--------------------------------------------------	   
AIData[1293]=        --미라(Blue)    AIBot
{
    AI=
    {    HP=2592, RotateSpeed=10, WalkSpeed=150, RunSpeed=220, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=1000, Sense=2000, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_RunAndWalk", UseAct={1}, AggroTime=6, DistToOpponent=1000, Sense=2000, ReactionTime={0.1,0.6}, WalkDist=800,},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1500}, ActTime={0.0,0.2}, CoolTime={1.0,1.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=5000, AngleRange=10, Damage={22,40}},
            AIWeapon={WeaponID=391, InterruptedFireTime=2, ContinuousFireTime={2,4}},
        },
    },
}--------------------------------------------------	   
AIData[1294]=        --백사(RED)    AIBot
{
    AI=
    {    HP=864, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=400, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,700}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={7,8}},
            AIWeapon={WeaponID=508, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	   
AIData[1295]=        --생존(BLUE)    AIBot
{
    AI=
    {    HP=216, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=400, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,700}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={3,4}},
            AIWeapon={WeaponID=19, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	   
AIData[1296]=        --백사(BLUE)    AIBot
{
    AI=
    {    HP=648, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=400, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,700}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={9,11}},
            AIWeapon={WeaponID=430, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	   
AIData[1297]=        --생존(RED)    AIBot
{
    AI=
    {    HP=432, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=400, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,700}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={6,7}},
            AIWeapon={WeaponID=1586, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	   
AIData[1298]=        --여도둑(RED)    AIBot
{
    AI=
    {    HP=432, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=500, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,800}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={6,7}},
            AIWeapon={WeaponID=2681, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	   
AIData[1299]=        --여도둑(BLUE)    AIBot
{
    AI=
    {    HP=216, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=500, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,800}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={3,4}},
            AIWeapon={WeaponID=2210, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	   
AIData[1300]=        --청마(BLUE)    AIBot
{
    AI=
    {    HP=540, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=500, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={7,8}},
            AIWeapon={WeaponID=1353, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	   
AIData[1301]=        --인디언(RED)    AIBot
{
    AI=
    {    HP=648, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,120}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=150, AngleRange=15, Damage={4,5}},
            AIWeapon={WeaponID=1658, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1}},
        },
    },
}--------------------------------------------------	   
AIData[1302]=        --인디안(BLUE)    AIBot
{
    AI=
    {    HP=648, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,130}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=160, AngleRange=15, Damage={8,10}},
            AIWeapon={WeaponID=1435, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1}},
        },
    },
}--------------------------------------------------	   
AIData[1303]=        --스켈레톤    AIBot
{
    AI=
    {    HP=1134, RotateSpeed=10, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=700, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={6,7}},
            AIWeapon={WeaponID=947, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1.5}},
        },
    },
}--------------------------------------------------	   
AIData[1304]=        --호박마녀    AIBot
{
    AI=
    {    HP=648, RotateSpeed=10, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=700, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={4,5}},
            AIWeapon={WeaponID=11, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1.5}},
        },
    },
}--------------------------------------------------	   
AIData[1305]=        --뱀파이어(RED)    AIBot
{
    AI=
    {    HP=1296, RotateSpeed=10, WalkSpeed=150, RunSpeed=220, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=700, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={7,10}},
            AIWeapon={WeaponID=2469, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1.5}},
        },
    },
}--------------------------------------------------	   
AIData[1306]=        --뱀파이어(BLUE)    AIBot
{
    AI=
    {    HP=810, RotateSpeed=10, WalkSpeed=150, RunSpeed=220, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=700, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={5,7}},
            AIWeapon={WeaponID=1054, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1.5}},
        },
    },
}--------------------------------------------------	   
AIData[1307]=        --악마(RED)    AIBot
{
    AI=
    {    HP=1890, RotateSpeed=10, WalkSpeed=150, RunSpeed=220, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=700, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={6,7}},
            AIWeapon={WeaponID=766, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1.5}},
        },
    },
}--------------------------------------------------	   
AIData[1308]=        --악마(BLUE)    AIBot
{
    AI=
    {    HP=1080, RotateSpeed=10, WalkSpeed=150, RunSpeed=220, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=700, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={4,5}},
            AIWeapon={WeaponID=478, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1.5}},
        },
    },
}--------------------------------------------------	 
 
AIData[1309]=        --슬레이어(RED)    AIBot
{
    AI=
    {    HP=3888, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=90, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,180}, ActTime={0.2,0.5}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=220, AngleRange=15, Damage={19,34}},
            AIWeapon={WeaponID=1553, InterruptedFireTime=1, ContinuousFireTime={1,1}},
        },
    },
}--------------------------------------------------	   
AIData[1310]=        --슬레이어(BLUE)    AIBot
{
    AI=
    {    HP=2592, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=90, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,180}, ActTime={0.2,0.5}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=220, AngleRange=15, Damage={14,25}},
            AIWeapon={WeaponID=1550, InterruptedFireTime=1, ContinuousFireTime={1,1}},
        },
    },
}--------------------------------------------------	   
AIData[1311]=        --닌자(RED)    AIBot
{
    AI=
    {    HP=3024, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=90, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,130}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=160, AngleRange=15, Damage={15,18}},
            AIWeapon={WeaponID=281, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1}},
        },
        [2]={
            ActFunc="ActFunc_AttackPrjectileWeapon", Type="Weapon", Range={300,600}, ActTime={0.0,0.5}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "RightHand"}, DamageNum=1, DistRange=300, AngleRange=25, Damage={4,5}},
            AIWeapon={WeaponID=26, InterruptedFireTime=0.3, ContinuousFireTime={0.5,1}},

               WorkEx={AmmoID=553, Ani=""},
        },
    },
}--------------------------------------------------	   
AIData[1312]=        --닌자(BLUE)    AIBot
{
    AI=
    {    HP=1512, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=90, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,130}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=160, AngleRange=15, Damage={12,14}},
            AIWeapon={WeaponID=281, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1}},
        },
        [2]={
            ActFunc="ActFunc_AttackPrjectileWeapon", Type="Weapon", Range={300,600}, ActTime={0.0,0.5}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "RightHand"}, DamageNum=1, DistRange=300, AngleRange=25, Damage={3,4}},
            AIWeapon={WeaponID=26, InterruptedFireTime=0.3, ContinuousFireTime={0.5,1}},

               WorkEx={AmmoID=553, Ani=""},
        },
    },
}--------------------------------------------------	   
AIData[1313]=        --임프좀비    파란색
{
    AI=
    {    HP=1080, RotateSpeed=20, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=90, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,110}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={9,13}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Key", Range={200,1000}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={9,13}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"S_Atk1"},
            Ani3={"Attack1", "Attack2"},

               WorkEx={Move=1400, MoveTime=2},
        },
    },
}--------------------------------------------------	   
AIData[1314]=        --임프좀비    오렌지색
{
    AI=
    {    HP=2484, RotateSpeed=20, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=90, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,130}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={17,24}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Key", Range={200,1000}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={17,24}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"S_Atk1"},
            Ani3={"Attack1", "Attack2"},

               WorkEx={Move=1400, MoveTime=2},
        },
    },
}--------------------------------------------------	   
AIData[1315]=        --임프좀비    빨간색
{
    AI=
    {    HP=2916, RotateSpeed=20, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=90, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,130}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={20,29}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Key", Range={200,1000}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={20,29}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"S_Atk1"},
            Ani3={"Attack1", "Attack2"},

               WorkEx={Move=1400, MoveTime=2},
        },
    },
}--------------------------------------------------	   
AIData[1316]=        --임프좀비    검정색
{
    AI=
    {    HP=3348, RotateSpeed=20, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=90, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,130}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={23,33}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Key", Range={200,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={23,33}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"S_Atk1"},
            Ani3={"Attack1", "Attack2"},

               WorkEx={Move=1400, MoveTime=2},
        },
    },
}--------------------------------------------------	   
AIData[1317]=        --마피아 잔호크(RED)    AIBot
{
    AI=
    {    HP=1296, RotateSpeed=10, WalkSpeed=120, RunSpeed=220, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=700, Sense=1200, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,400}, ActTime={0.1,0.3}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=150, AngleRange=10, Damage={10,14}},
            AIWeapon={WeaponID=52, InterruptedFireTime=0.3, ContinuousFireTime={0.6,0.6}},
        },
        [2]={
            ActFunc="ActFunc_AttackPrjectileWeapon", Type="Weapon", Range={300,800}, ActTime={0.5,1.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "RightHand"}, DamageNum=1, DistRange=200, AngleRange=27, Damage={10,14}},
            AIWeapon={WeaponID=2207, InterruptedFireTime=0.3, ContinuousFireTime={0.5,1}},

               WorkEx={AmmoID=554, Ani=""},
        },
    },
}--------------------------------------------------	   
AIData[1318]=        --마피아 잔호크(BLUE)    AIBot
{
    AI=
    {    HP=648, RotateSpeed=10, WalkSpeed=120, RunSpeed=220, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=800, Sense=1200, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,400}, ActTime={0.1,0.3}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=150, AngleRange=10, Damage={7,10}},
            AIWeapon={WeaponID=52, InterruptedFireTime=0.4, ContinuousFireTime={0.4,0.4}},
        },
        [2]={
            ActFunc="ActFunc_AttackPrjectileWeapon", Type="Weapon", Range={300,1000}, ActTime={0.5,1.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "RightHand"}, DamageNum=1, DistRange=200, AngleRange=27, Damage={7,10}},
            AIWeapon={WeaponID=470, InterruptedFireTime=0.3, ContinuousFireTime={0.5,1}},

               WorkEx={AmmoID=552, Ani=""},
        },
    },
}--------------------------------------------------	   
AIData[1319]=        --브라더(RED)    AIBot
{
    AI=
    {    HP=1080, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=100, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,200}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=250, AngleRange=15, Damage={10,18}},
            AIWeapon={WeaponID=1630, InterruptedFireTime=0.7, ContinuousFireTime={0.7,0.7}},
        },
    },
}--------------------------------------------------	   
AIData[1320]=        --브라더(BLUE)    AIBot
{
    AI=
    {    HP=540, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=100, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,200}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=250, AngleRange=15, Damage={7,13}},
            AIWeapon={WeaponID=1629, InterruptedFireTime=0.9, ContinuousFireTime={0.9,0.9}},
        },
    },
}--------------------------------------------------	   
AIData[1321]=        --블랙쉐도우(RED)    AIBot
{
    AI=
    {    HP=972, RotateSpeed=10, WalkSpeed=120, RunSpeed=220, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=1200, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
        Stealth={"UR2Am"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,2000}, ActTime={0.0,0.2}, CoolTime={0.2,0.5},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=5000, AngleRange=15, Damage={14,25}},
            AIWeapon={WeaponID=2474, InterruptedFireTime=2, ContinuousFireTime={2,6}},
        },
    },
}--------------------------------------------------	   
AIData[1322]=        --블랙쉐도우(BLUE)    AIBot
{
    AI=
    {    HP=486, RotateSpeed=10, WalkSpeed=120, RunSpeed=220, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=1200, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
        Stealth={"UR2Am"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,2000}, ActTime={0.0,0.2}, CoolTime={0.2,0.5},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=5000, AngleRange=15, Damage={12,22}},
            AIWeapon={WeaponID=391, InterruptedFireTime=2, ContinuousFireTime={2,4}},
        },
    },
}--------------------------------------------------	   
AIData[1323]=        --잔호크    AIBot
{
    AI=
    {    HP=2646, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=200, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,200}, ActTime={0.0,0.2}, CoolTime={0.2,0.2},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=250, AngleRange=15, Damage={12,22}},
            AIWeapon={WeaponID=1630, InterruptedFireTime=0.7, ContinuousFireTime={0.7,0.7}},
        },
    },
}--------------------------------------------------	   
AIData[1324]=        --카를로스    AIBot
{
    AI=
    {    HP=1890, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=200, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,200}, ActTime={0.0,0.2}, CoolTime={0.2,0.2},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=250, AngleRange=15, Damage={12,22}},
            AIWeapon={WeaponID=1629, InterruptedFireTime=0.9, ContinuousFireTime={0.9,0.9}},
        },
    },
}--------------------------------------------------	   
AIData[1325]=        --세르게이    AIBot
{
    AI=
    {    HP=864, RotateSpeed=10, WalkSpeed=150, RunSpeed=270, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=400, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,800}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={3,4}},
            AIWeapon={WeaponID=2628, InterruptedFireTime=0.09, ContinuousFireTime={0.9,1.8}},
        },
    },
}--------------------------------------------------	   
AIData[1326]=        --쉴트    AIBot
{
    AI=
    {    HP=756, RotateSpeed=10, WalkSpeed=150, RunSpeed=270, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=400, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,800}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={2,2}},
            AIWeapon={WeaponID=1176, InterruptedFireTime=0.08, ContinuousFireTime={0.8,1.6}},
        },
    },
}--------------------------------------------------	   
AIData[1327]=        --자폭좀비    흰색
{
    AI=
    {    HP=1350, RotateSpeed=10, WalkSpeed=100, RunSpeed=150, ViewDist=2000, ViewAngle=60, AvoidRate=20, Factor1=0,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=100, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={2,3}, AggroTime=6, DistToOpponent=100, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Suicider",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=160, AngleRange=360, Damage={9,13}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackSuicideBombing", Type="Direct", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={9,13}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"Run"},
            Ani3={"S_Atk1"},

               WorkEx={Move=0, MoveTime=0, AmmoID=557, Ani="", refAct=4},
        },
        [3]={
            ActFunc="ActFunc_AttackSuicideBombing", Type="Direct", Range={200,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={9,13}},
            Ani1={"S_ATk2 Ready1"},
            Ani2={"Run"},
            Ani3={"S_Atk2"},

               WorkEx={Move=2000, MoveTime=2, AmmoID=557, Ani="", refAct=4},
        },
        [4]={
            ActFunc="", Type="", Range={0,0}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={5,7}},


               WorkEx={AmmoID=556, Ani="", },
        },
    },
}--------------------------------------------------	   
AIData[1328]=        --자폭좀비    빨간색
{
    AI=
    {    HP=3645, RotateSpeed=10, WalkSpeed=100, RunSpeed=150, ViewDist=2000, ViewAngle=60, AvoidRate=20, Factor1=0,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=100, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={2,3}, AggroTime=6, DistToOpponent=100, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Suicider",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=160, AngleRange=360, Damage={20,29}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackSuicideBombing", Type="Direct", Range={0,400}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={20,29}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"Run"},
            Ani3={"S_Atk1"},

               WorkEx={Move=0, MoveTime=0, AmmoID=557, Ani="", refAct=4},
        },
        [3]={
            ActFunc="ActFunc_AttackSuicideBombing", Type="Direct", Range={400,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={20,29}},
            Ani1={"S_ATk2 Ready1"},
            Ani2={"Run"},
            Ani3={"S_Atk2"},

               WorkEx={Move=2000, MoveTime=2, AmmoID=557, Ani="", refAct=4},
        },
        [4]={
            ActFunc="", Type="", Range={0,0}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={10,14}},


               WorkEx={AmmoID=556, Ani="", },
        },
    },
}--------------------------------------------------	   
AIData[1329]=        --자폭좀비    검정색
{
    AI=
    {    HP=4185, RotateSpeed=10, WalkSpeed=100, RunSpeed=150, ViewDist=2000, ViewAngle=60, AvoidRate=20, Factor1=0,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=100, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={2,3}, AggroTime=6, DistToOpponent=100, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Suicider",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=160, AngleRange=360, Damage={23,33}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackSuicideBombing", Type="Direct", Range={0,400}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={23,33}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"Run"},
            Ani3={"S_Atk1"},

               WorkEx={Move=0, MoveTime=0, AmmoID=557, Ani="", refAct=4},
        },
        [3]={
            ActFunc="ActFunc_AttackSuicideBombing", Type="Direct", Range={400,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={23,33}},
            Ani1={"S_ATk2 Ready1"},
            Ani2={"Run"},
            Ani3={"S_Atk2"},

               WorkEx={Move=2000, MoveTime=2, AmmoID=557, Ani="", refAct=4},
        },
        [4]={
            ActFunc="", Type="", Range={0,0}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={11,16}},


               WorkEx={AmmoID=556, Ani="", },
        },
    },
}--------------------------------------------------	 


------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------


 
AIData[1427]=        --[C]기본좀비A    파란색
{
    AI=
    {    HP=720, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA"},
        Walk={"WalkA"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={17,20}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1428]=        --[C]기본좀비B    파란색
{
    AI=
    {    HP=720, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunB"},
        Walk={"WalkB"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={17,20}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1429]=        --[C]기본좀비C    파란색
{
    AI=
    {    HP=720, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunC"},
        Walk={"WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={17,20}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1430]=        --[C]기본좀비A    녹색
{
    AI=
    {    HP=1080, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA"},
        Walk={"WalkA"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={19,23}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1431]=        --[C]기본좀비B    녹색
{
    AI=
    {    HP=1080, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunB"},
        Walk={"WalkB"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={19,23}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1432]=        --[C]기본좀비C    녹색
{
    AI=
    {    HP=1080, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunC"},
        Walk={"WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={19,23}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1433]=        --[C]기본좀비A    노란색
{
    AI=
    {    HP=1368, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA"},
        Walk={"WalkA"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={20,24}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1434]=        --[C]기본좀비B    노란색
{
    AI=
    {    HP=1368, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunB"},
        Walk={"WalkB"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={20,24}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1435]=        --[C]기본좀비C    노란색
{
    AI=
    {    HP=1368, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunC"},
        Walk={"WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={20,24}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1436]=        --[C]기본좀비A    오렌지색
{
    AI=
    {    HP=1656, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA"},
        Walk={"WalkA"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={22,26}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1437]=        --[C]기본좀비B    오렌지색
{
    AI=
    {    HP=1656, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunB"},
        Walk={"WalkB"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={22,26}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1438]=        --[C]기본좀비C    오렌지색
{
    AI=
    {    HP=1656, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunC"},
        Walk={"WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={22,26}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1439]=        --[C]기본좀비A    빨간색
{
    AI=
    {    HP=1944, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA"},
        Walk={"WalkA"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={24,29}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1440]=        --[C]기본좀비B    빨간색
{
    AI=
    {    HP=1944, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunB"},
        Walk={"WalkB"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={24,29}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1441]=        --[C]기본좀비C    빨간색
{
    AI=
    {    HP=1944, RotateSpeed=5, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunC"},
        Walk={"WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={24,29}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1442]=        --[C]방어좀비A    파란색
{
    AI=
    {    HP=7200, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={25,30}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={20,24}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1443]=        --[C]방어좀비A    녹색
{
    AI=
    {    HP=10800, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={28,34}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={22,26}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1444]=        --[C]방어좀비A    노란색
{
    AI=
    {    HP=13680, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={31,37}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={24,29}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1445]=        --[C]방어좀비A    오렌지색
{
    AI=
    {    HP=16560, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={33,40}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={27,32}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1446]=        --[C]방어좀비A    빨간색
{
    AI=
    {    HP=19440, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={36,43}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={29,35}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1447]=        --[C]방어좀비B    파란색
{
    AI=
    {    HP=7200, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={25,30}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={20,24}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1448]=        --[C]방어좀비B    녹색
{
    AI=
    {    HP=10800, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={28,34}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={22,26}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1449]=        --[C]방어좀비B    노란색
{
    AI=
    {    HP=13680, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={31,37}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={24,29}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1450]=        --[C]방어좀비B    오렌지색
{
    AI=
    {    HP=16560, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={33,40}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={27,32}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	 
 
AIData[1451]=        --[C]방어좀비B    빨간색
{
    AI=
    {    HP=19440, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={36,43}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={29,35}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1452]=        --[C]방어좀비C    파란색
{
    AI=
    {    HP=7200, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={25,30}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={20,24}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1453]=        --[C]방어좀비C    녹색
{
    AI=
    {    HP=10800, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={28,34}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={22,26}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1454]=        --[C]방어좀비C    노란색
{
    AI=
    {    HP=13680, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={31,37}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={24,29}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1455]=        --[C]방어좀비C    오렌지색
{
    AI=
    {    HP=16560, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={33,40}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={27,32}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1456]=        --[C]방어좀비C    빨간색
{
    AI=
    {    HP=19440, RotateSpeed=7, WalkSpeed=100, RunSpeed=190, ViewDist=3000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={2}, AggroTime=15, DistToOpponent=90, Sense=1600, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={36,43}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_AttackEjector", Type="Impact", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Socket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={29,35}},
            Ani1={"SAttack"},
            Ani2={"RclBBD"},

               WorkEx={AmmoID=153, EjectTime=0.3},
               FX1={Socket="Fire", Name="Zom_Vomit_Spurt"},
        },
    },
}--------------------------------------------------	   
AIData[1457]=        --[C]곰돌이좀비    파란색
{
    AI=
    {    HP=720, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={17,20}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1458]=        --[C]곰돌이좀비    녹색
{
    AI=
    {    HP=1080, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={19,23}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1459]=        --[C]곰돌이좀비    노란색
{
    AI=
    {    HP=1368, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={20,24}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1460]=        --[C]곰돌이좀비    오렌지색
{
    AI=
    {    HP=1656, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={22,26}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1461]=        --[C]곰돌이좀비    빨간색
{
    AI=
    {    HP=1944, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=1500, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={24,29}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1462]=        --[C]포이즌좀비    파란색
{
    AI=
    {    HP=1440, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={22,32}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1463]=        --[C]포이즌좀비    노란색
{
    AI=
    {    HP=2736, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={27,39}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1464]=        --[C]포이즌좀비    빨간색
{
    AI=
    {    HP=3888, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={31,45}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1465]=        --[C]포이즌좀비    검정색
{
    AI=
    {    HP=4464, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
        [2]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"RunA", "RunB", "RunC"},
        Walk={"WalkA", "WalkB", "WalkC"},
        FDeath={"Death5"},
        BDeath={"Death1", "Death2", "Death3", "Death4"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,132}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=165, AngleRange=360, Damage={34,49}},
            Ani1={"Attack0"},
        },
    },
}--------------------------------------------------	   
AIData[1466]=        --[C]넉백좀비    파란색
{
    AI=
    {    HP=5040, RotateSpeed=7, WalkSpeed=160, RunSpeed=240, ViewDist=2000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=15, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.1},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={30,36}},
            Ani1={"Attack1","Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Direct", Range={110,1200}, ActTime={1.0,1.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=133, AngleRange=360, Damage={36,43}},
            Ani1={"S_ATK1 Ready1"},
            Ani2={"S_ATK1"},
            Ani3={"Tired"},
                DamagePenalty ={0.6,1},

               WorkEx={Move=1400, MoveTime=1},
        },
    },
}--------------------------------------------------	   
AIData[1467]=        --[C]넉백좀비    노란색
{
    AI=
    {    HP=9576, RotateSpeed=7, WalkSpeed=160, RunSpeed=240, ViewDist=2000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=15, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={37,44}},
            Ani1={"Attack1","Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Direct", Range={110,1200}, ActTime={1.0,1.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=133, AngleRange=360, Damage={44,53}},
            Ani1={"S_ATK1 Ready1"},
            Ani2={"S_ATK1"},
            Ani3={"Tired"},
                DamagePenalty ={0.6,1},

               WorkEx={Move=1400, MoveTime=1},
        },
    },
}--------------------------------------------------	   
AIData[1468]=        --[C]넉백좀비    빨간색
{
    AI=
    {    HP=13608, RotateSpeed=7, WalkSpeed=160, RunSpeed=240, ViewDist=2000, ViewAngle=90, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=15, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={43,52}},
            Ani1={"Attack1","Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Direct", Range={110,1200}, ActTime={1.0,1.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=133, AngleRange=360, Damage={52,62}},
            Ani1={"S_ATK1 Ready1"},
            Ani2={"S_ATK1"},
            Ani3={"Tired"},
                DamagePenalty ={0.6,1},

               WorkEx={Move=1400, MoveTime=1},
        },
    },
}--------------------------------------------------	   
AIData[1469]=        --[C]도살자    파란색
{
    AI=
    {    HP=14400, RotateSpeed=10, WalkSpeed=150, RunSpeed=450, ViewDist=2000, ViewAngle=90, AvoidRate=20, Factor1=7200,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1,2}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={3}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Transformer",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Ani1={"ArmorBreak"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_TwoStepAttack", Type="Key", Range={0,200}, ActTime={0.0,0.0}, CoolTime={2.0,2.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=300, AngleRange=360, Damage={101,145}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},
        },
        [2]={
            ActFunc="ActFunc_Pull", Type="Key", Range={150,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_L_D1"}, DamageNum=1, DistRange=250, AngleRange=360, Damage={17,24}},
            Ani1={"SAttack"},
            Ani2={"SAttack_Throw"},
            Ani3={"SAttack_RThrow"},
            Ani4={"SAttack_PO"},
                DamagePenalty ={0.8,2},
        },
        [3]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,180}, ActTime={0.2,0.2}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=200, AngleRange=360, Damage={34,49}},
            Ani1={"Attack_Run"},
        },
    },
}--------------------------------------------------	   
AIData[1470]=        --[C]도살자    녹색
{
    AI=
    {    HP=21600, RotateSpeed=10, WalkSpeed=150, RunSpeed=450, ViewDist=2000, ViewAngle=90, AvoidRate=20, Factor1=10800,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1,2}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={3}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Transformer",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Ani1={"ArmorBreak"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_TwoStepAttack", Type="Key", Range={0,200}, ActTime={0.0,0.0}, CoolTime={2.0,2.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=300, AngleRange=360, Damage={112,161}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},
        },
        [2]={
            ActFunc="ActFunc_Pull", Type="Key", Range={150,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_L_D1"}, DamageNum=1, DistRange=250, AngleRange=360, Damage={19,27}},
            Ani1={"SAttack"},
            Ani2={"SAttack_Throw"},
            Ani3={"SAttack_RThrow"},
            Ani4={"SAttack_PO"},
                DamagePenalty ={0.8,2},
        },
        [3]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,180}, ActTime={0.2,0.2}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=200, AngleRange=360, Damage={37,53}},
            Ani1={"Attack_Run"},
        },
    },
}--------------------------------------------------	   
AIData[1471]=        --[C]도살자    노란색
{
    AI=
    {    HP=27360, RotateSpeed=10, WalkSpeed=150, RunSpeed=450, ViewDist=2000, ViewAngle=90, AvoidRate=20, Factor1=13680,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1,2}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={3}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Transformer",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Ani1={"ArmorBreak"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_TwoStepAttack", Type="Key", Range={0,200}, ActTime={0.0,0.0}, CoolTime={2.0,2.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=300, AngleRange=360, Damage={122,176}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},
        },
        [2]={
            ActFunc="ActFunc_Pull", Type="Key", Range={150,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_L_D1"}, DamageNum=1, DistRange=250, AngleRange=360, Damage={20,29}},
            Ani1={"SAttack"},
            Ani2={"SAttack_Throw"},
            Ani3={"SAttack_RThrow"},
            Ani4={"SAttack_PO"},
                DamagePenalty ={0.8,2},
        },
        [3]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,180}, ActTime={0.2,0.2}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=200, AngleRange=360, Damage={41,59}},
            Ani1={"Attack_Run"},
        },
    },
}--------------------------------------------------	   
AIData[1472]=        --[C]도살자    오렌지색
{
    AI=
    {    HP=33120, RotateSpeed=10, WalkSpeed=150, RunSpeed=450, ViewDist=2000, ViewAngle=90, AvoidRate=20, Factor1=16560,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1,2}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={3}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Transformer",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Ani1={"ArmorBreak"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_TwoStepAttack", Type="Key", Range={0,200}, ActTime={0.0,0.0}, CoolTime={2.0,2.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=300, AngleRange=360, Damage={133,192}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},
        },
        [2]={
            ActFunc="ActFunc_Pull", Type="Key", Range={150,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_L_D1"}, DamageNum=1, DistRange=250, AngleRange=360, Damage={22,32}},
            Ani1={"SAttack"},
            Ani2={"SAttack_Throw"},
            Ani3={"SAttack_RThrow"},
            Ani4={"SAttack_PO"},
                DamagePenalty ={0.8,2},
        },
        [3]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,180}, ActTime={0.2,0.2}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=200, AngleRange=360, Damage={44,63}},
            Ani1={"Attack_Run"},
        },
    },
}--------------------------------------------------	   
AIData[1473]=        --[C]도살자    빨간색
{
    AI=
    {    HP=38880, RotateSpeed=10, WalkSpeed=150, RunSpeed=450, ViewDist=2000, ViewAngle=90, AvoidRate=20, Factor1=19440,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1,2}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={13}, AggroTime=15, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Transformer",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Ani1={"ArmorBreak"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_TwoStepAttack", Type="Key", Range={0,200}, ActTime={0.0,0.0}, CoolTime={2.0,2.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=300, AngleRange=360, Damage={144,207}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},
        },
        [2]={
            ActFunc="ActFunc_Pull", Type="Key", Range={150,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_L_D1"}, DamageNum=1, DistRange=250, AngleRange=360, Damage={24,35}},
            Ani1={"SAttack"},
            Ani2={"SAttack_Throw"},
            Ani3={"SAttack_RThrow"},
            Ani4={"SAttack_PO"},
                DamagePenalty ={0.8,2},
        },
        [3]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,180}, ActTime={0.2,0.2}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Weapon_R_D1"}, DamageNum=1, DistRange=200, AngleRange=360, Damage={48,69}},
            Ani1={"Attack_Run"},
        },
    },
}--------------------------------------------------	   
AIData[1474]=        --[C]자객    파란색
{
    AI=
    {    HP=1890, RotateSpeed=7, WalkSpeed=150, RunSpeed=210, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Stealth={"Idle_Ai","Walk","Run"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,140}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={25,36}},
            Ani1={"Attack0","Attack1"},
        },
    },
}--------------------------------------------------	   
AIData[1475]=        --[C]자객    녹색
{
    AI=
    {    HP=2835, RotateSpeed=7, WalkSpeed=150, RunSpeed=210, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Stealth={"Idle_Ai","Walk","Run"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,140}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={28,40}},
            Ani1={"Attack0","Attack1"},
        },
    },
}--------------------------------------------------	   
AIData[1476]=        --[C]자객    노란색
{
    AI=
    {    HP=3591, RotateSpeed=7, WalkSpeed=150, RunSpeed=210, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Stealth={"Idle_Ai","Walk","Run"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,140}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={31,45}},
            Ani1={"Attack0","Attack1"},
        },
    },
}--------------------------------------------------	   
AIData[1477]=        --[C]자객    오렌지색
{
    AI=
    {    HP=4347, RotateSpeed=7, WalkSpeed=150, RunSpeed=210, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Stealth={"Idle_Ai","Walk","Run"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,140}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={33,48}},
            Ani1={"Attack0","Attack1"},
        },
    },
}--------------------------------------------------	 
 
AIData[1478]=        --[C]자객    빨간색
{
    AI=
    {    HP=5103, RotateSpeed=7, WalkSpeed=150, RunSpeed=210, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
        Stealth={"Idle_Ai","Walk","Run"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,140}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={36,52}},
            Ani1={"Attack0","Attack1"},
        },
    },
}--------------------------------------------------	   
AIData[1479]=        --[C]연금술사    파란색
{
    AI=
    {    HP=3150, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2,3,4}, AggroTime=6, DistToOpponent=800, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death3", "Death4", "Death5"},
        BDeath={"Death0", "Death1", "Death2"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,150}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={25,30}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={150,600}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=28, Damage={30,36}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=551, Ani="right_left"},
        },
        [3]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={600,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=32, Damage={30,36}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=555, Ani="right_left"},
        },
        [4]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={900,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "R"}, DamageNum=1, DistRange=180, AngleRange=35, Damage={20,24}},
            Ani1={"Attack2_Ready"},
            Ani2={"Attack2"},

               WorkEx={AmmoID=558, Ani="right_left"},
        },
    },
}--------------------------------------------------	   
AIData[1480]=        --[C]연금술사    녹색
{
    AI=
    {    HP=4725, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2,3,4}, AggroTime=6, DistToOpponent=800, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death3", "Death4", "Death5"},
        BDeath={"Death0", "Death1", "Death2"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,150}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={28,34}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={150,600}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=28, Damage={33,40}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=551, Ani="right_left"},
        },
        [3]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={600,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=32, Damage={33,40}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=555, Ani="right_left"},
        },
        [4]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={900,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "R"}, DamageNum=1, DistRange=180, AngleRange=35, Damage={22,26}},
            Ani1={"Attack2_Ready"},
            Ani2={"Attack2"},

               WorkEx={AmmoID=558, Ani="right_left"},
        },
    },
}--------------------------------------------------	   
AIData[1481]=        --[C]연금술사    노란색
{
    AI=
    {    HP=5985, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2,3,4}, AggroTime=6, DistToOpponent=800, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death3", "Death4", "Death5"},
        BDeath={"Death0", "Death1", "Death2"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,150}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={31,37}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={150,600}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=28, Damage={37,44}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=551, Ani="right_left"},
        },
        [3]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={600,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=32, Damage={37,44}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=555, Ani="right_left"},
        },
        [4]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={900,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "R"}, DamageNum=1, DistRange=180, AngleRange=35, Damage={24,29}},
            Ani1={"Attack2_Ready"},
            Ani2={"Attack2"},

               WorkEx={AmmoID=558, Ani="right_left"},
        },
    },
}--------------------------------------------------	   
AIData[1482]=        --[C]연금술사    오렌지색
{
    AI=
    {    HP=7245, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2,3,4}, AggroTime=6, DistToOpponent=800, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death3", "Death4", "Death5"},
        BDeath={"Death0", "Death1", "Death2"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,150}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={33,40}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={150,600}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=28, Damage={40,48}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=551, Ani="right_left"},
        },
        [3]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={600,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=32, Damage={40,48}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=555, Ani="right_left"},
        },
        [4]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={900,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "R"}, DamageNum=1, DistRange=180, AngleRange=35, Damage={27,32}},
            Ani1={"Attack2_Ready"},
            Ani2={"Attack2"},

               WorkEx={AmmoID=558, Ani="right_left"},
        },
    },
}--------------------------------------------------	   
AIData[1483]=        --[C]연금술사    빨간색
{
    AI=
    {    HP=8505, RotateSpeed=7, WalkSpeed=100, RunSpeed=180, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2,3,4}, AggroTime=6, DistToOpponent=800, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death3", "Death4", "Death5"},
        BDeath={"Death0", "Death1", "Death2"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,150}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={36,43}},
            Ani1={"Attack0"},
        },
        [2]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={150,600}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=28, Damage={43,52}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=551, Ani="right_left"},
        },
        [3]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={600,900}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "L"}, DamageNum=1, DistRange=180, AngleRange=32, Damage={43,52}},
            Ani1={"Attack1_Ready"},
            Ani2={"Attack1"},

               WorkEx={AmmoID=555, Ani="right_left"},
        },
        [4]={
            ActFunc="ActFunc_TwoStepAttack", Type="Impact", Range={900,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "R"}, DamageNum=1, DistRange=180, AngleRange=35, Damage={29,35}},
            Ani1={"Attack2_Ready"},
            Ani2={"Attack2"},

               WorkEx={AmmoID=558, Ani="right_left"},
        },
    },
}--------------------------------------------------	   
AIData[1484]=        --[C]코믹 뱀파이어(RED)    AIBot
{
    AI=
    {    HP=972, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=120, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,150}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=162, AngleRange=15, Damage={13,16}},
            AIWeapon={WeaponID=328, InterruptedFireTime=0.4, ContinuousFireTime={0.4,0.4}},
        },
    },
}--------------------------------------------------	   
AIData[1485]=        --[C]코믹 뱀파이어(BLUE)    AIBot
{
    AI=
    {    HP=810, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,100}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=110, AngleRange=15, Damage={10,12}},
            AIWeapon={WeaponID=156, InterruptedFireTime=0.4, ContinuousFireTime={0.4,0.4}},
        },
    },
}--------------------------------------------------	   
AIData[1486]=        --[C]라이칸    AIBot
{
    AI=
    {    HP=5346, RotateSpeed=10, WalkSpeed=150, RunSpeed=310, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,140}, ActTime={0.0,0.2}, CoolTime={0.1,0.2},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=160, AngleRange=15, Damage={40,58}},
            AIWeapon={WeaponID=1549, InterruptedFireTime=0.8, ContinuousFireTime={0.8,0.8}},
        },
    },
}--------------------------------------------------	   
AIData[1487]=        --[C]황금잔호크    AIBot
{
    AI=
    {    HP=6480, RotateSpeed=10, WalkSpeed=150, RunSpeed=310, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=90, Sense=1200, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,140}, ActTime={0.0,0.2}, CoolTime={0.1,0.2},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=160, AngleRange=15, Damage={44,63}},
            AIWeapon={WeaponID=1610, InterruptedFireTime=0.8, ContinuousFireTime={0.8,0.8}},
        },
    },
}--------------------------------------------------	   
AIData[1488]=        --[C]처녀귀신    AIBot
{
    AI=
    {    HP=972, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,120}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=150, AngleRange=15, Damage={13,16}},
            AIWeapon={WeaponID=1277, InterruptedFireTime=0.4, ContinuousFireTime={0.4,0.4}},
        },
    },
}--------------------------------------------------	   
AIData[1489]=        --[C]저승사자    AIBot
{
    AI=
    {    HP=1296, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,120}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=150, AngleRange=15, Damage={13,16}},
            AIWeapon={WeaponID=1117, InterruptedFireTime=0.4, ContinuousFireTime={0.4,0.4}},
        },
    },
}--------------------------------------------------	   
AIData[1490]=        --[C]프랑켄슈타인(Red)    AIBot
{
    AI=
    {    HP=5400, RotateSpeed=10, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=600, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={3.0,3.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={7,10}},
            AIWeapon={WeaponID=753, InterruptedFireTime=0.1, ContinuousFireTime={1,2}},
        },
    },
}--------------------------------------------------	   
AIData[1491]=        --[C]프랑켄슈타인(Blue)    AIBot
{
    AI=
    {    HP=4860, RotateSpeed=10, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=600, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={3.0,3.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={5,7}},
            AIWeapon={WeaponID=23, InterruptedFireTime=0.13, ContinuousFireTime={1.3,2.6}},
        },
    },
}--------------------------------------------------	   
AIData[1492]=        --[C]미라(Red)    AIBot
{
    AI=
    {    HP=3888, RotateSpeed=10, WalkSpeed=150, RunSpeed=220, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=1000, Sense=2000, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_RunAndWalk", UseAct={1}, AggroTime=6, DistToOpponent=1000, Sense=2000, ReactionTime={0.1,0.6}, WalkDist=800,},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1500}, ActTime={0.0,0.2}, CoolTime={1.0,1.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=5000, AngleRange=10, Damage={28,50}},
            AIWeapon={WeaponID=2680, InterruptedFireTime=2, ContinuousFireTime={2,4}},
        },
    },
}--------------------------------------------------	   
AIData[1493]=        --[C]미라(Blue)    AIBot
{
    AI=
    {    HP=3456, RotateSpeed=10, WalkSpeed=150, RunSpeed=220, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=1000, Sense=2000, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_RunAndWalk", UseAct={1}, AggroTime=6, DistToOpponent=1000, Sense=2000, ReactionTime={0.1,0.6}, WalkDist=800,},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1500}, ActTime={0.0,0.2}, CoolTime={1.0,1.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=5000, AngleRange=10, Damage={25,45}},
            AIWeapon={WeaponID=391, InterruptedFireTime=2, ContinuousFireTime={2,4}},
        },
    },
}--------------------------------------------------	   
AIData[1494]=        --[C]백사(RED)    AIBot
{
    AI=
    {    HP=1728, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=400, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,700}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={9,11}},
            AIWeapon={WeaponID=508, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	   
AIData[1495]=        --[C]생존(BLUE)    AIBot
{
    AI=
    {    HP=432, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=400, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,700}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={5,6}},
            AIWeapon={WeaponID=19, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	   
AIData[1496]=        --[C]백사(BLUE)    AIBot
{
    AI=
    {    HP=1296, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=400, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,700}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={11,13}},
            AIWeapon={WeaponID=430, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	   
AIData[1497]=        --[C]생존(RED)    AIBot
{
    AI=
    {    HP=864, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=400, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,700}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={8,10}},
            AIWeapon={WeaponID=1586, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	   
AIData[1498]=        --[C]여도둑(RED)    AIBot
{
    AI=
    {    HP=864, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=500, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,800}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={8,10}},
            AIWeapon={WeaponID=2681, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	   
AIData[1499]=        --[C]여도둑(BLUE)    AIBot
{
    AI=
    {    HP=432, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=500, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,800}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={5,6}},
            AIWeapon={WeaponID=2210, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	   
AIData[1500]=        --[C]청마(BLUE)    AIBot
{
    AI=
    {    HP=1080, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=500, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={9,11}},
            AIWeapon={WeaponID=1353, InterruptedFireTime=0.8, ContinuousFireTime={1.6,2.4}},
        },
    },
}--------------------------------------------------	 
 
AIData[1501]=        --[C]인디언(RED)    AIBot
{
    AI=
    {    HP=972, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,120}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=150, AngleRange=15, Damage={10,12}},
            AIWeapon={WeaponID=1658, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1}},
        },
    },
}--------------------------------------------------	   
AIData[1502]=        --[C]인디안(BLUE)    AIBot
{
    AI=
    {    HP=972, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=90, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,130}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=160, AngleRange=15, Damage={13,16}},
            AIWeapon={WeaponID=1435, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1}},
        },
    },
}--------------------------------------------------	   
AIData[1503]=        --[C]스켈레톤    AIBot
{
    AI=
    {    HP=1890, RotateSpeed=10, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=700, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={7,8}},
            AIWeapon={WeaponID=947, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1.5}},
        },
    },
}--------------------------------------------------	   
AIData[1504]=        --[C]호박마녀    AIBot
{
    AI=
    {    HP=1080, RotateSpeed=10, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=700, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={5,6}},
            AIWeapon={WeaponID=11, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1.5}},
        },
    },
}--------------------------------------------------	   
AIData[1505]=        --[C]뱀파이어(RED)    AIBot
{
    AI=
    {    HP=2160, RotateSpeed=10, WalkSpeed=150, RunSpeed=220, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=700, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={8,12}},
            AIWeapon={WeaponID=2469, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1.5}},
        },
    },
}--------------------------------------------------	   
AIData[1506]=        --[C]뱀파이어(BLUE)    AIBot
{
    AI=
    {    HP=1350, RotateSpeed=10, WalkSpeed=150, RunSpeed=220, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=700, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={6,9}},
            AIWeapon={WeaponID=1054, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1.5}},
        },
    },
}--------------------------------------------------	   
AIData[1507]=        --[C]악마(RED)    AIBot
{
    AI=
    {    HP=2646, RotateSpeed=10, WalkSpeed=150, RunSpeed=220, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=700, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={7,8}},
            AIWeapon={WeaponID=766, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1.5}},
        },
    },
}--------------------------------------------------	   
AIData[1508]=        --[C]악마(BLUE)    AIBot
{
    AI=
    {    HP=1512, RotateSpeed=10, WalkSpeed=150, RunSpeed=220, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=700, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,1000}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=2000, AngleRange=15, Damage={5,6}},
            AIWeapon={WeaponID=478, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1.5}},
        },
    },
}--------------------------------------------------	   
AIData[1509]=        --[C]슬레이어(RED)    AIBot
{
    AI=
    {    HP=4860, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=90, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,180}, ActTime={0.2,0.5}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=220, AngleRange=15, Damage={23,41}},
            AIWeapon={WeaponID=1553, InterruptedFireTime=1, ContinuousFireTime={1,1}},
        },
    },
}--------------------------------------------------	   
AIData[1510]=        --[C]슬레이어(BLUE)    AIBot
{
    AI=
    {    HP=3240, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=90, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,180}, ActTime={0.2,0.5}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=220, AngleRange=15, Damage={18,32}},
            AIWeapon={WeaponID=1550, InterruptedFireTime=1, ContinuousFireTime={1,1}},
        },
    },
}--------------------------------------------------	   
AIData[1511]=        --[C]닌자(RED)    AIBot
{
    AI=
    {    HP=3888, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=90, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,130}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=160, AngleRange=15, Damage={21,25}},
            AIWeapon={WeaponID=281, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1}},
        },
        [2]={
            ActFunc="ActFunc_AttackPrjectileWeapon", Type="Weapon", Range={300,600}, ActTime={0.0,0.5}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "RightHand"}, DamageNum=1, DistRange=300, AngleRange=25, Damage={5,6}},
            AIWeapon={WeaponID=26, InterruptedFireTime=0.3, ContinuousFireTime={0.5,1}},

               WorkEx={AmmoID=553, Ani=""},
        },
    },
}--------------------------------------------------	   
AIData[1512]=        --[C]닌자(BLUE)    AIBot
{
    AI=
    {    HP=1944, RotateSpeed=10, WalkSpeed=150, RunSpeed=280, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=90, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,130}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=160, AngleRange=15, Damage={17,20}},
            AIWeapon={WeaponID=281, InterruptedFireTime=0.5, ContinuousFireTime={0.5,1}},
        },
        [2]={
            ActFunc="ActFunc_AttackPrjectileWeapon", Type="Weapon", Range={300,600}, ActTime={0.0,0.5}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "RightHand"}, DamageNum=1, DistRange=300, AngleRange=25, Damage={4,5}},
            AIWeapon={WeaponID=26, InterruptedFireTime=0.3, ContinuousFireTime={0.5,1}},

               WorkEx={AmmoID=553, Ani=""},
        },
    },
}--------------------------------------------------	   
AIData[1513]=        --[C]임프좀비    파란색
{
    AI=
    {    HP=2880, RotateSpeed=20, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=90, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,110}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={25,36}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Key", Range={200,1000}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={25,36}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"S_Atk1"},
            Ani3={"Attack1", "Attack2"},

               WorkEx={Move=1400, MoveTime=2},
        },
    },
}--------------------------------------------------	   
AIData[1514]=        --[C]임프좀비    오렌지색
{
    AI=
    {    HP=6624, RotateSpeed=20, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=90, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,130}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={33,48}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Key", Range={200,1000}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={33,48}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"S_Atk1"},
            Ani3={"Attack1", "Attack2"},

               WorkEx={Move=1400, MoveTime=2},
        },
    },
}--------------------------------------------------	   
AIData[1515]=        --[C]임프좀비    빨간색
{
    AI=
    {    HP=7776, RotateSpeed=20, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=90, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,130}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={36,52}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Key", Range={200,1000}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={36,52}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"S_Atk1"},
            Ani3={"Attack1", "Attack2"},

               WorkEx={Move=1400, MoveTime=2},
        },
    },
}--------------------------------------------------	   
AIData[1516]=        --[C]임프좀비    검정색
{
    AI=
    {    HP=8928, RotateSpeed=20, WalkSpeed=150, RunSpeed=200, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=90, Sense=1000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Default",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,130}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={39,56}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackKnockback", Type="Key", Range={200,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 Head"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={39,56}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"S_Atk1"},
            Ani3={"Attack1", "Attack2"},

               WorkEx={Move=1400, MoveTime=2},
        },
    },
}--------------------------------------------------	   
AIData[1517]=        --[C]마피아 잔호크(RED)    AIBot
{
    AI=
    {    HP=1944, RotateSpeed=10, WalkSpeed=120, RunSpeed=220, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=700, Sense=1200, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,400}, ActTime={0.1,0.3}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=150, AngleRange=10, Damage={13,19}},
            AIWeapon={WeaponID=52, InterruptedFireTime=0.3, ContinuousFireTime={0.6,0.6}},
        },
        [2]={
            ActFunc="ActFunc_AttackPrjectileWeapon", Type="Weapon", Range={300,800}, ActTime={0.5,1.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "RightHand"}, DamageNum=1, DistRange=200, AngleRange=27, Damage={13,19}},
            AIWeapon={WeaponID=2207, InterruptedFireTime=0.3, ContinuousFireTime={0.5,1}},

               WorkEx={AmmoID=554, Ani=""},
        },
    },
}--------------------------------------------------	   
AIData[1518]=        --[C]마피아 잔호크(BLUE)    AIBot
{
    AI=
    {    HP=972, RotateSpeed=10, WalkSpeed=120, RunSpeed=220, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1,2}, AggroTime=6, DistToOpponent=800, Sense=1200, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,400}, ActTime={0.1,0.3}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=150, AngleRange=10, Damage={11,16}},
            AIWeapon={WeaponID=52, InterruptedFireTime=0.4, ContinuousFireTime={0.4,0.4}},
        },
        [2]={
            ActFunc="ActFunc_AttackPrjectileWeapon", Type="Weapon", Range={300,1000}, ActTime={0.5,1.0}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "RightHand"}, DamageNum=1, DistRange=200, AngleRange=27, Damage={11,16}},
            AIWeapon={WeaponID=470, InterruptedFireTime=0.3, ContinuousFireTime={0.5,1}},

               WorkEx={AmmoID=552, Ani=""},
        },
    },
}--------------------------------------------------	   
AIData[1519]=        --[C]브라더(RED)    AIBot
{
    AI=
    {    HP=1512, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=100, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,200}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=250, AngleRange=15, Damage={13,23}},
            AIWeapon={WeaponID=1630, InterruptedFireTime=0.7, ContinuousFireTime={0.7,0.7}},
        },
    },
}--------------------------------------------------	 
 
AIData[1520]=        --[C]브라더(BLUE)    AIBot
{
    AI=
    {    HP=756, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=2000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=100, Sense=800, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,200}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=250, AngleRange=15, Damage={11,20}},
            AIWeapon={WeaponID=1629, InterruptedFireTime=0.9, ContinuousFireTime={0.9,0.9}},
        },
    },
}--------------------------------------------------	   
AIData[1521]=        --[C]블랙쉐도우(RED)    AIBot
{
    AI=
    {    HP=1620, RotateSpeed=10, WalkSpeed=120, RunSpeed=220, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=1200, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
        Stealth={"UR2Am"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,2000}, ActTime={0.0,0.2}, CoolTime={0.2,0.5},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=5000, AngleRange=15, Damage={18,32}},
            AIWeapon={WeaponID=2474, InterruptedFireTime=2, ContinuousFireTime={2,6}},
        },
    },
}--------------------------------------------------	   
AIData[1522]=        --[C]블랙쉐도우(BLUE)    AIBot
{
    AI=
    {    HP=810, RotateSpeed=10, WalkSpeed=120, RunSpeed=220, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=1200, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
        Stealth={"UR2Am"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,2000}, ActTime={0.0,0.2}, CoolTime={0.2,0.5},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=5000, AngleRange=15, Damage={16,29}},
            AIWeapon={WeaponID=391, InterruptedFireTime=2, ContinuousFireTime={2,4}},
        },
    },
}--------------------------------------------------	   
AIData[1523]=        --[C]잔호크    AIBot
{
    AI=
    {    HP=3402, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=200, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,200}, ActTime={0.0,0.2}, CoolTime={0.2,0.2},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=250, AngleRange=15, Damage={16,29}},
            AIWeapon={WeaponID=1630, InterruptedFireTime=0.7, ContinuousFireTime={0.7,0.7}},
        },
    },
}--------------------------------------------------	   
AIData[1524]=        --[C]카를로스    AIBot
{
    AI=
    {    HP=2430, RotateSpeed=10, WalkSpeed=150, RunSpeed=250, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=15, DistToOpponent=200, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,200}, ActTime={0.0,0.2}, CoolTime={0.2,0.2},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=250, AngleRange=15, Damage={16,29}},
            AIWeapon={WeaponID=1629, InterruptedFireTime=0.9, ContinuousFireTime={0.9,0.9}},
        },
    },
}--------------------------------------------------	   
AIData[1525]=        --[C]세르게이    AIBot
{
    AI=
    {    HP=1728, RotateSpeed=10, WalkSpeed=150, RunSpeed=270, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=400, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,800}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={4,5}},
            AIWeapon={WeaponID=2628, InterruptedFireTime=0.09, ContinuousFireTime={0.9,1.8}},
        },
    },
}--------------------------------------------------	   
AIData[1526]=        --[C]쉴트    AIBot
{
    AI=
    {    HP=1512, RotateSpeed=10, WalkSpeed=150, RunSpeed=270, ViewDist=3000, ViewAngle=60, AvoidRate=20,
        [1]={    AIFunc="AIFunc_Run", UseAct={1}, AggroTime=6, DistToOpponent=400, Sense=2000, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_AIBot",
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefaultWeapon", Type="Weapon", Range={0,800}, ActTime={0.0,0.2}, CoolTime={0.0,0.0},
            Work={Point={"WeaponSocket", "Flash"}, DamageNum=0, DistRange=1500, AngleRange=15, Damage={3,4}},
            AIWeapon={WeaponID=1176, InterruptedFireTime=0.08, ContinuousFireTime={0.8,1.6}},
        },
    },
}--------------------------------------------------	   
AIData[1527]=        --[C]자폭좀비    흰색
{
    AI=
    {    HP=3150, RotateSpeed=10, WalkSpeed=100, RunSpeed=150, ViewDist=2000, ViewAngle=60, AvoidRate=20, Factor1=0,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=100, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={2,3}, AggroTime=6, DistToOpponent=100, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Suicider",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=160, AngleRange=360, Damage={25,36}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackSuicideBombing", Type="Direct", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={25,36}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"Run"},
            Ani3={"S_Atk1"},

               WorkEx={Move=0, MoveTime=0, AmmoID=557, Ani="", refAct=4},
        },
        [3]={
            ActFunc="ActFunc_AttackSuicideBombing", Type="Direct", Range={200,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={25,36}},
            Ani1={"S_ATk2 Ready1"},
            Ani2={"Run"},
            Ani3={"S_Atk2"},

               WorkEx={Move=2000, MoveTime=2, AmmoID=557, Ani="", refAct=4},
        },
        [4]={
            ActFunc="", Type="", Range={0,0}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={13,19}},


               WorkEx={AmmoID=556, Ani="", },
        },
    },
}--------------------------------------------------	   
AIData[1528]=        --[C]자폭좀비    빨간색
{
    AI=
    {    HP=8505, RotateSpeed=10, WalkSpeed=100, RunSpeed=150, ViewDist=2000, ViewAngle=60, AvoidRate=20, Factor1=0,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=100, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={2,3}, AggroTime=6, DistToOpponent=100, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Suicider",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=160, AngleRange=360, Damage={36,52}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackSuicideBombing", Type="Direct", Range={0,400}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={36,52}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"Run"},
            Ani3={"S_Atk1"},

               WorkEx={Move=0, MoveTime=0, AmmoID=557, Ani="", refAct=4},
        },
        [3]={
            ActFunc="ActFunc_AttackSuicideBombing", Type="Direct", Range={400,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={36,52}},
            Ani1={"S_ATk2 Ready1"},
            Ani2={"Run"},
            Ani3={"S_Atk2"},

               WorkEx={Move=2000, MoveTime=2, AmmoID=557, Ani="", refAct=4},
        },
        [4]={
            ActFunc="", Type="", Range={0,0}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={18,26}},


               WorkEx={AmmoID=556, Ani="", },
        },
    },
}--------------------------------------------------	   
AIData[1529]=        --[C]자폭좀비    검정색
{
    AI=
    {    HP=9765, RotateSpeed=10, WalkSpeed=100, RunSpeed=150, ViewDist=2000, ViewAngle=60, AvoidRate=20, Factor1=0,
        [1]={    AIFunc="AIFunc_Walk", UseAct={1}, AggroTime=6, DistToOpponent=100, Sense=1500, ReactionTime={0.1,0.6},},
        [2]={    AIFunc="AIFunc_Run", UseAct={2,3}, AggroTime=6, DistToOpponent=100, Sense=1500, ReactionTime={0.1,0.6},},
    },
    Ani=
    {
        AniFunc="AniFunc_Suicider",
        Idle={"Idle_Ai"},
        Run={"Run"},
        Walk={"Walk"},
        FDeath={"Death0"},
        BDeath={"Death0"},
    },
    Act=
    {
        [1]={
            ActFunc="ActFunc_AttackDefault", Type="Key", Range={0,120}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Bone", "Bip01 R Finger0"}, DamageNum=1, DistRange=160, AngleRange=360, Damage={39,56}},
            Ani1={"Attack1", "Attack2"},
        },
        [2]={
            ActFunc="ActFunc_AttackSuicideBombing", Type="Direct", Range={0,400}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={39,56}},
            Ani1={"S_ATk1 Ready1"},
            Ani2={"Run"},
            Ani3={"S_Atk1"},

               WorkEx={Move=0, MoveTime=0, AmmoID=557, Ani="", refAct=4},
        },
        [3]={
            ActFunc="ActFunc_AttackSuicideBombing", Type="Direct", Range={400,1200}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={39,56}},
            Ani1={"S_ATk2 Ready1"},
            Ani2={"Run"},
            Ani3={"S_Atk2"},

               WorkEx={Move=2000, MoveTime=2, AmmoID=557, Ani="", refAct=4},
        },
        [4]={
            ActFunc="", Type="", Range={0,0}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
            Work={Point={"Soket", "Fire"}, DamageNum=1, DistRange=150, AngleRange=360, Damage={19,27}},


               WorkEx={AmmoID=556, Ani="", },
        },
    },
}--------------------------------------------------	 


















---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

AIData[1351]=	-- 상/하 기둥
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,-300,0}, },  -- 상하 움직임 (동일 시간)
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2,102}, CheckPos={0,-300,0}, }, --상하 움직임 (범위 체크1)
		[12]={	AIFunc="AIFunc_MoveTrap", UseAct={2,112}, CheckPos={0,-300,0}, }, --상하 움직임 (범위 체크2)
		[22]={	AIFunc="AIFunc_MoveTrap", UseAct={2,122}, CheckPos={0,-300,0}, }, --상하 움직임 (범위 체크3)
		[3]={	AIFunc="AIFunc_MoveTrap", UseAct={3}, CheckPos={0,-150,0}, }, -- 상하 가운데로 닫히기
		[4]={	AIFunc="AIFunc_MoveTrap", UseAct={4}, CheckPos={0,-300,0}, },  -- 상하 움직임 (동일 시간), 1번 역순 돌림
		[11]={	AIFunc="AIFunc_MoveTrap", UseAct={301}, CheckPos={0,-300,0}, },  -- 복제 블럭
		[13]={	AIFunc="AIFunc_MoveTrap", UseAct={303}, CheckPos={0,-150,0}, }, -- 복제 블럭
		[23]={	AIFunc="AIFunc_MoveTrap", UseAct={13}, CheckPos={0,-150,0}, }, -- 상하 가운데 닫히기, 아래 고정용
		
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},--move time 개념
			Work={Damage={3,3}, GO={0,50,0}, RotSpeed={0,0}, Next={101}}, --rotspeed의 경우 회전에서만 쓰임
		},
		[2]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={401,10000}, ActTime={0.0,0.0}, CoolTime={2.0,2.0},
			Work={Damage={3,3}, GO={0,300,0}, RotSpeed={0,0}, Next={nil}},
		},
		[3]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},
			Work={Damage={3,3}, GO={0,150,0}, RotSpeed={0,0}, Next={103}},
		},
		[13]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},
			Work={Damage={3,3}, GO={0,-120,0}, RotSpeed={0,0}, Next={nil}},
		},
		[4]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},
			Work={Damage={3,3}, GO={0,300,0}, RotSpeed={0,0}, Next={104}},
		},
		[101]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},
			Work={Damage={3,3}, GO={0,300,0}, RotSpeed={0,0}, Next={nil}},
		},
		[102]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,400}, ActTime={1.5,1.5}, CoolTime={0.6,0.6},
			Work={Damage={3,3}, GO={0,50,0}, RotSpeed={0,0}, Next={202}},
		},
		[112]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,400}, ActTime={1.0,1.0}, CoolTime={0.4,0.4},
			Work={Damage={3,3}, GO={0,50,0}, RotSpeed={0,0}, Next={202}},
		},
		[122]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,400}, ActTime={0.5,0.5}, CoolTime={0.4,0.4},
			Work={Damage={3,3}, GO={0,50,0}, RotSpeed={0,0}, Next={202}},
		},
		[103]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},
			Work={Damage={3,3}, GO={0,300,0}, RotSpeed={0,0}, Next={nil}},
		},
		[104]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},
			Work={Damage={3,3}, GO={0,50,0}, RotSpeed={0,0}, Next={nil}},
		},
		[202]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,400}, ActTime={3.0,3.0}, CoolTime={1.0,1.0},
			Work={Damage={3,3}, GO={0,300,0}, RotSpeed={0,0}, Next={nil}},
		},
		[301]={
			ActFunc="ActFunc_CopyTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},
			Work={Damage={3,3}, GO={1,1,1}, RotSpeed={-1,-1}, Next={nil}},	
		},
		[303]={
			ActFunc="ActFunc_CopyTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},
			Work={Damage={5,5}, GO={-1,-1,-1}, RotSpeed={-1,-1}, Next={nil}},	
		},
	},
}--------------------------------------------------------------------------------------------------------------------

AIData[1352]=	-- 회전트랩
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={101}, CheckPos={0,0,0}, },
		[3]={	AIFunc="AIFunc_MoveTrap", UseAct={201}, CheckPos={0,0,0}},
		[4]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={0,0,0},},
		[5]={	AIFunc="AIFunc_MoveTrap", UseAct={102}, CheckPos={0,0,0},},
		[6]={	AIFunc="AIFunc_MoveTrap", UseAct={202}, CheckPos={0,0,0},},
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={3,3}, GO={0,0,0}, RotSpeed={100,100}, Next={nil}},
		},
		[101]={
			ActFunc="ActFunc_CopyTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={3,3}, GO={1,1,1}, RotSpeed={-1,-1}, Next={nil}},
		},
		[201]={
			ActFunc="ActFunc_CopyTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={3,3}, GO={1,1,1}, RotSpeed={1,1}, Next={nil}},
		},
		[2]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={3,3}, GO={0,0,0}, RotSpeed={-100,-100}, Next={nil}},
		},
		[102]={
			ActFunc="ActFunc_CopyTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={3,3}, GO={1,1,1}, RotSpeed={-1,-1}, Next={nil}},
		},
		[202]={
			ActFunc="ActFunc_CopyTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={3,3}, GO={1,1,1}, RotSpeed={1,1}, Next={nil}},
		},
	},
}--------------------------------------------------------------------------------------------------------------------

AIData[1353]=	-- 상하 꼬챙이
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={150,0,0}, },
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={150,0,0}, },
		[11]={	AIFunc="AIFunc_MoveTrap", UseAct={301}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},
			Work={Damage={3,3}, GO={0,-200,0}, RotSpeed={0,0}, Next={101}},
		},
		[101]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},
			Work={Damage={3,3}, GO={0,-50,0}, RotSpeed={0,0}, Next={nil}},
		},
		[2]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},
			Work={Damage={3,3}, GO={0,-50,0}, RotSpeed={0,0}, Next={101}},
		},
		[102]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},
			Work={Damage={3,3}, GO={0,-200,0}, RotSpeed={0,0}, Next={nil}},
		},
		[301]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={1.0,1.0}, CoolTime={0.2,0.2},
			Work={Damage={3,3}, GO={-1,-1,-1}, RotSpeed={-1,-1}, Next={nil}},
		},
	},
}--------------------------------------------------------------------------------------------------------------------

AIData[1354]=	-- 좌우뺑소니차
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={150,0,0}, },
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2,3}, CheckPos={150,0,0}, },
		[3]={	AIFunc="AIFunc_MoveTrap", UseAct={11}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.0,1.0},
			Work={Damage={0,0}, GO={0,0,0}, RotSpeed={0,0}, Next={3}},
		},
		[2]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={200,10000}, ActTime={0.0,0.0}, CoolTime={0.2,0.2},
			Work={Damage={0,0}, GO={0,0,0}, RotSpeed={0,0}, Next={nil}},
		},
		[3]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,200}, ActTime={0.0,0.0}, CoolTime={0.2,0.2},
			Work={Damage={3,4}, GO={100,0,0}, RotSpeed={0,0}, Next={nil}},
		},
		[11]={
			ActFunc="ActFunc_CopyTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={2.0,2.0},
			Work={Damage={1,1}, GO={-1,-1,-1}, RotSpeed={-1,-1}, Next={nil}},
		},
	},
}--------------------------------------------------------------------------------------------------------------------


AIData[1355]=	-- 클리어트랩
{
	Interaction=5,
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_None",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Clear", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={2.0,2.0},
			Work={Damage={0,0}, GO={0,0,0}, RotSpeed={0,0}, Next={nil}},
		},
	},
}--------------------------------------------------------------------------------------------------------------------

AIData[1356]=	-- 회전트랩
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0},},
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={101}, CheckPos={0,0,0},},
		[3]={	AIFunc="AIFunc_MoveTrap", UseAct={201}, CheckPos={0,0,0},},
		[4]={	AIFunc="AIFunc_MoveTrap", UseAct={11}, CheckPos={0,0,0},},
		[5]={	AIFunc="AIFunc_MoveTrap", UseAct={111}, CheckPos={0,0,0},},
		[6]={	AIFunc="AIFunc_MoveTrap", UseAct={211}, CheckPos={0,0,0},},
		[11]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={0,0,0},},
		[12]={	AIFunc="AIFunc_MoveTrap", UseAct={102}, CheckPos={0,0,0},},
		[13]={	AIFunc="AIFunc_MoveTrap", UseAct={202}, CheckPos={0,0,0},},
		[14]={	AIFunc="AIFunc_MoveTrap", UseAct={12}, CheckPos={0,0,0},},
		[15]={	AIFunc="AIFunc_MoveTrap", UseAct={112}, CheckPos={0,0,0},},
		[16]={	AIFunc="AIFunc_MoveTrap", UseAct={212}, CheckPos={0,0,0},},
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={1,1}, GO={0,0,0}, RotSpeed={100,100}, Next={nil}},
		},
		[101]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={1,1}, GO={0,0,0}, RotSpeed={-100,-100}, Next={nil}},
		},
		[201]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={1,1}, GO={0,0,0}, RotSpeed={100,100}, Next={nil}},
		},
		[11]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={1,1}, GO={0,0,0}, RotSpeed={-100,-100}, Next={nil}},
		},
		[111]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={1,1}, GO={0,0,0}, RotSpeed={100,100}, Next={nil}},
		},
		[211]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={1,1}, GO={0,0,0}, RotSpeed={-100,-100}, Next={nil}},
		},
		[2]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={1,1}, GO={0,0,0}, RotSpeed={80,150}, Next={nil}},
		},
		[102]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={1,1}, GO={0,0,0}, RotSpeed={-150,-80}, Next={nil}},
		},
		[202]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={1,1}, GO={0,0,0}, RotSpeed={80,150}, Next={nil}},
		},
		[12]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={1,1}, GO={0,0,0}, RotSpeed={-150,-80}, Next={nil}},
		},
		[112]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={1,1}, GO={0,0,0}, RotSpeed={80,150}, Next={nil}},
		},
		[212]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={1,1}, GO={0,0,0}, RotSpeed={-150,-80}, Next={nil}},
		},
	},
}--------------------------------------------------------------------------------------------------------------------

AIData[1357]=	--사각기둥
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },  -- 앞뒤 움직임
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={0,0,0}, },  -- [1]번의 리버스 움직임

	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={ -- 위 아래 기본적인 왕복운동
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.3,0.3}, CoolTime={0.8,1.1},--move time 개념
			Work={Damage={5,10}, GO={0,400,0}, RotSpeed={0,0}, TrapSound=101, Next={101}}, --rotspeed의 경우 회전에서만 쓰임
		},
        [101]={ -- 위 아래 기본적인 왕복운동
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.4,0.4}, CoolTime={0.7,1.1},--move time 개념
			Work={Damage={5,10}, GO={0,30,0}, RotSpeed={0,0}, TrapSound=1, Next={1}}, --rotspeed의 경우 회전에서만 쓰임
		},
		[2]={ -- 위 아래 기본적인 왕복운동
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.3,0.3}, CoolTime={0.8,1.1},--move time 개념
			Work={Damage={5,10}, GO={0,30,0}, RotSpeed={0,0}, TrapSound=1, Next={201}}, --rotspeed의 경우 회전에서만 쓰임
		},
        [201]={ -- 위 아래 기본적인 왕복운동
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.4,0.4}, CoolTime={0.7,1.1},--move time 개념
			Work={Damage={5,10}, GO={0,400,0}, RotSpeed={0,0}, TrapSound=101, Next={2}}, --rotspeed의 경우 회전에서만 쓰임
		},
	},
}------------


AIData[1358]=	--다중막대
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },  -- 앞뒤 움직임
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={0,0,0}, },  -- 왼쪽 오른쪽 움직임
		[3]={	AIFunc="AIFunc_MoveTrap", UseAct={3}, CheckPos={0,0,0}, },  -- 왼쪽 오른쪽 랜덤시간
		
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={ -- 앞뒤로 기본적인 왕복운동을 하는 방식 
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.5,1.5},--move time 개념
			Work={Damage={5,10}, GO={0,0,240}, RotSpeed={0,0}, TrapSound=2, Next={101}}, --rotspeed의 경우 회전에서만 쓰임
		},
		[101]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.7,1.7},--move time 개념
			Work={Damage={5,10}, GO={0,0,-240}, RotSpeed={0,0}, TrapSound=2, Next={1}}, --rotspeed의 경우 회전에서만 쓰임
		},
		[2]={ -- 왼쪽과 오른쪽으로 왕복운동을 하는 방식
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.6,1.6},--move time 개념
			Work={Damage={5,10}, GO={180,0,0}, RotSpeed={0,0}, TrapSound=2, Next={201}}, --rotspeed의 경우 회전에서만 쓰임
		},
		[201]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.7,1.7},--move time 개념
			Work={Damage={5,10}, GO={-180,0,0}, RotSpeed={0,0}, TrapSound=2, Next={2}}, --rotspeed의 경우 회전에서만 쓰임
		},		
        [3]={ -- 매우 길게 앞뒤로 기본적인 왕복운동을 하는 방식 
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={0.7,1.3},--move time 개념
			Work={Damage={5,10}, GO={180,0,0}, RotSpeed={0,0}, TrapSound=2, Next={301}}, --rotspeed의 경우 회전에서만 쓰임
		},
		[301]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={0.7,1.3},--move time 개념
			Work={Damage={5,10}, GO={-180,0,0}, RotSpeed={0,0}, TrapSound=2, Next={3}}, --rotspeed의 경우 회전에서만 쓰임
		},
	},
}------

AIData[1359]=	--회전 다중막대 기둥
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={0,0,0}, },

	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1,1},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={80,80}, TrapSound=3, Next={nil}},
		},
		[2]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1,1},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={-80,-80}, TrapSound=3, Next={nil}},
		},
	},
}--------

AIData[1360]=	--회전 다중막대 날개
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },

	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={9999,9999},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={100,100}, Next={nil}},
		},
	},
}----------

	
AIData[1361]=	--회전 눈사람
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={0,0,0}, },

	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1,1},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={130,130}, TrapSound=4, Next={nil}},
		},
		[2]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1,1},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={-140,-140}, TrapSound=4, Next={nil}},
		},
	},
}------------
AIData[1362]=	--시간차1 대피프랍
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.0,1.0},
			Work={Damage={0,0}, GO={0,0,0}, RotSpeed={0,0}, Next={nil}},
		},
		[2]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={2.0,2.2},
			Work={Damage={0,0}, GO={0,0,-200}, RotSpeed={0,0}, TrapSound=5, Next={201}},
		},
		[201]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={2.0,2.2},
			Work={Damage={0,0}, GO={0,0,200}, RotSpeed={0,0}, TrapSound=5, Next={2}},
		},
	},
}--------
AIData[1363]=	--시간차1 함정프랍
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.5,1.5},
			Work={Damage={5,10}, GO={0,0,400}, RotSpeed={0,0}, TrapSound=5, Next={101}},
		},
		[101]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.5,1.5},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={0,0}, TrapSound=5, Next={1}},
		},
		[2]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.5,1.5},
			Work={Damage={5,10}, GO={0,0,-400}, RotSpeed={0,0}, TrapSound=5, Next={201}},
		},
		[201]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.5,1.5},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={0,0}, TrapSound=5, Next={2}},
		},
	},
}--------
AIData[1364]=	--시간차2 대피프랍
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.0,1.0},
			Work={Damage={0,0}, GO={0,0,0}, RotSpeed={0,0}, Next={nil}},
		},
		[2]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={2.0,2.2},
			Work={Damage={0,0}, GO={0,0,-200}, RotSpeed={0,0}, Next={201}},
		},
		[201]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={2.0,2.2},
			Work={Damage={0,0}, GO={0,0,200}, RotSpeed={0,0}, Next={2}},
		},
	},
}--------
AIData[1365]=	--시간차2 함정프랍
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.2,0.2}, CoolTime={0.4,0.4},
			Work={Damage={5,10}, GO={150,0,0}, RotSpeed={0,0}, Next={101}},
		},
		[101]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={0.4,0.4},
			Work={Damage={5,10}, GO={150,400,0}, RotSpeed={0,0}, TrapSound=6, Next={102}},
		},
		[102]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={0.4,0.4},
			Work={Damage={5,10}, GO={150,0,0}, RotSpeed={0,0}, Next={103}},
		},
		[103]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={0.4,0.4},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={0,0}, Next={104}},
		},
		[104]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.2,0.2}, CoolTime={0.3,0.3},
			Work={Damage={5,10}, GO={0,400,0}, RotSpeed={0,0}, TrapSound=6, Next={105}},
		},
		[105]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.2}, CoolTime={0.3,0.3},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={0,0}, TrapSound=601, Next={1}},
		},

	},
}--------
AIData[1366]=	--지그재그
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.3,0.3}, CoolTime={0.9,0.9},
			Work={Damage={5,10}, GO={-150,0,0}, RotSpeed={0,0}, TrapSound=7, Next={101}},
		},
		[101]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.4,0.4}, CoolTime={0.9,0.9},
			Work={Damage={5,10}, GO={150,0,0}, RotSpeed={0,0}, Next={1}},
		},
		[2]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.3,0.3}, CoolTime={0.9,0.9},
			Work={Damage={5,10}, GO={150,0,0}, RotSpeed={0,0}, Next={201}},
		},
		[201]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.4,0.4}, CoolTime={0.9,0.9},
			Work={Damage={5,10}, GO={-150,0,0}, RotSpeed={0,0}, TrapSound=7, Next={2}},
		},

	},
}--------

AIData[1367]=	--회전문
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={0,0,0}, },

	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1,1},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={100,100}, TrapSound=8, Next={nil}},
		},
		[2]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1,1},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={-100,-100}, TrapSound=8, Next={nil}},
		},
	},
}----------

AIData[1368]=	--2중 회전기둥 기둥
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },

	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={3.4,3.4},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={110,110}, TrapSound=9, Next={101}},
		},
		[101]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={3.4,3.4},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={-110,-110}, TrapSound=9, Next={1}},
		},
	},
}----------

AIData[1369]=	--칼날함정 바닥
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={ ---함정 바닥용
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={0.0,0.0},
			Work={Damage={5,10}, GO={0,0,0}, RotSpeed={0,0}, Next={nil}},
		},
	},
}----------

AIData[1370]=	--칼날함정 위에서 아래
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,450}, ActTime={0.0,0.0}, CoolTime={0.3,0.3},
			Work={Damage={10,20}, GO={0,-400,0}, RotSpeed={0,0},TrapSound=10, Next={101}},
		},
		[101]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={2.0,2.0}, CoolTime={1.0,1.0},
			Work={Damage={10,20}, GO={0,0,0}, RotSpeed={0,0}, Next={102}},
		},
		[102]={
			ActFunc="ActFunc_MoveTrap", Type="Restart", Range={0,10000}, ActTime={2.0,2.0}, CoolTime={0.3,0.3},
			Work={Damage={10,20}, GO={0,0,0}, RotSpeed={0,0}, Next={1}},
		},
		[2]={
			ActFunc="ActFunc_CopyTrap", Type="Restart", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={0.3,0.3},
			Work={Damage={10,20}, GO={1,1,1}, RotSpeed={0,0}, Next={nil}},
		},
	},
}--------

AIData[1371]=	--가로회전 기둥
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.0,1.0},
			Work={Damage={0,0}, GO={0,0,0}, RotSpeed={0,0}, TrapSound=11, Next={nil}},
		},
	},
}--------

AIData[1372]=	--푸시 오브젝트
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
		[2]={	AIFunc="AIFunc_MoveTrap", UseAct={2}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.3,0.3}, CoolTime={0.8,0.8},
			Work={Damage={1,1}, GO={145,0,0}, RotSpeed={0,0},TrapSound=7, Next={101}},
		},
		[101]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.3,0.3}, CoolTime={0.8,0.8},
			Work={Damage={1,1}, GO={-145,0,0}, RotSpeed={0,0}, Next={1}},
		},
		[2]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.3,0.3}, CoolTime={0.8,0.8},
			Work={Damage={1,1}, GO={-145,0,0}, RotSpeed={0,0}, Next={201}},
		},
		[201]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.3,0.3}, CoolTime={0.8,0.8},
			Work={Damage={1,1}, GO={145,0,0}, RotSpeed={0,0},TrapSound=7, Next={2}},
		},
	},
}--------

AIData[1373]=	--굴곡 파이프
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.0,1.0},
			Work={Damage={0,0}, GO={0,0,0}, RotSpeed={0,0},TrapSound=12, Next={nil}},
		},
	},
}--------

AIData[1374]=	--쥐덫
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={0.35,0.35},
			Work={Damage={0,0}, GO={0,0,0}, RotSpeed={0,0},TrapSound=13, Next={nil}},
		},
	},
}--------

AIData[1375]=	--일자파이프
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.0,1.0},
			Work={Damage={0,0}, GO={0,0,0}, RotSpeed={0,0},TrapSound=12, Next={nil}},
		},
	},
}--------

AIData[1376]=	--다중 일자파이프
{
	AI=
	{	HP=100, TouchCoolTime = 0.5,
		[1]={	AIFunc="AIFunc_MoveTrap", UseAct={1}, CheckPos={0,0,0}, },
	},
	Ani={AniFunc="AniFunc_MoveTrap",},
	Act=
	{
		[1]={
			ActFunc="ActFunc_MoveTrap", Type="Direct", Range={0,10000}, ActTime={0.0,0.0}, CoolTime={1.0,1.0},
			Work={Damage={0,0}, GO={0,0,0}, RotSpeed={0,0},TrapSound=12, Next={nil}},
		},
	},
}--------



--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

