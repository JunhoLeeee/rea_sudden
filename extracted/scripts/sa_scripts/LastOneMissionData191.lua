----------------------------------------------------------------------------------------------------------------
-----  머지 과정에서 변경된 내용                                                                           -----
-----  수정 적용:  생존 키트, 헬멧 추가, 무기 드랍 변경,                                                   -----
-----              무기 사거리 정의, function GetSurvivalCashSetItem( nItemID ) 의 AP가 nAP로 변경된 부분. -----
-----  미적용(누락): 빈사, 짚라인, 개별 무기 드랍                                                          -----            
----------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
--         빈사 상태 설정
----------------------------------------------------------------------------------------------------
DyingDamage = 999                                                            -- 이 대미지 이하의 대미지를 받고 죽음에 이를 경우에만 빈사가 발동됨.
DyingFlag_HeadShot = 1                                  -- 1이면 헤드샷으로 빈사, 0이면 헤드샷으로 바로 죽음
DyingFlag_AmSal = 0                                                           -- 1이면 암살로 빈사, 0이면 암살로 바로 죽음.
DyingFlag_MyBomb = 1                                   -- 1이면 내가 던진 폭탄에 빈사, 0이면 내 폭탄 대미지에 바로 죽음
DyingFlag_Crush = 0                                                            -- 1이면 낙사에 빈사, 0이면 낙사에 바로 죽음
DyingFlag_Freeze = 0                                                           -- 1이면 물의 차가움에 빈사, 0이면 물의 차가움에 바로 죽음
DyingFlag_Bleeding = 1                                              -- 1이면 출혈에 빈사, 0이면 출혈에 바로 죽음.

Dying_CamRotSpeed = 18                       -- 카메라 돌리기 느려지는 수준. 3의 배수를 추천함. 숫자가 클수록 느려짐.
Dying_MoveSpeed = 0.1                                  -- 빈사시 속도 느려지는 비율
Dying_WeaponWeight = 0                                -- 빈사시 적용해야 할 무기의 무게. 웨폰스크립트의 weight에 해당함.

Dying_ReviveRange = 500                               -- E키로 빈사인 캐릭터 살릴때 나와 캐릭터의 범위.
Dying_ReviveTick = 3                                               -- E키로 빈사인 캐릭터 살릴때 걸리는 시간
Dying_ReviveHealth = 10                                  -- E키로 빈사인 캐릭터 살리면 그 캐릭터의 HP
Dying_RemainTime = 30                                   -- 빈사에서 죽기까지 걸리는 시간.
Dying_VolumeFadeTick1 = 1                                                                        -- 빈사 이후 이 시간까지 볼륨이 Dying_VolumeValue 로 줄어들음. 매우 작으면 이상 동작함.
Dying_VolumeFadeTick2 = 19                                                            -- 빈사 이후 이 시간부터 볼륨이 정상으로 되돌아감. Dying_RemainTime - Dying_VolumeFadeTick2 값이 매우 작으면 이상동작함.
Dying_VolumeValue = 0.1                                                                                      -- 빈사때 줄어들은 사운드 볼륨


function DoDamageDying(fDyingRemainTime, fDamage)
           fDyingRemainTime = fDyingRemainTime  - fDamage*0.1
           return fDyingRemainTime
end


-- 가방에 따른 근접무기 세팅하는 함수
function GetRewardItem(nPartsWingIndex)
	nRet = -1
	nWeaponID = -1
	if nPartsWingIndex == 3697 then	-- 가방의 아이템 인덱스_브론즈 가방
		nRet = 0										-- 리턴 값을 1로 세팅
		nWeaponID = 2026			-- 무기 아이디 세팅_낡은 장도리
	elseif nPartsWingIndex == 3698 then	-- 실버 가방
		nRet = 0										-- 
		nWeaponID = 2058			-- A급 장도리
	elseif nPartsWingIndex == 3699 then	-- 골드 가방
		nRet = 0										-- 
		nWeaponID = 2592			-- 금도금 장도리		
	elseif nPartsWingIndex == 3700 then	-- 다이아 가방
		nRet = 0										-- 
		nWeaponID = 2593			-- 다이아 장도리
	elseif nPartsWingIndex == 3701 then	-- 마그마 가방
		nRet = 0										-- 
		nWeaponID = 2594			-- 마그마 장도리
			end
	return nRet, nWeaponID
end

-- 가방에 따른 애니메이션 세팅하는 함수
function GetRewardItemAnim(nPartsWingIndex) -- 날개로 써 있지만 실제로는 가방임
		KillMotion = ""				-- 암살 모션
		KillMotion2 = ""			-- 암살2 모션
		KillMotion3 = ""			-- 빈사 처형 모션
		ProvokeMotion = ""		-- 도발 모션
		nMotion = 0				-- 어느것들이 바뀌는지 정보
		
		if nPartsWingIndex == 3699 then			-- 내가 가방을 3699을 메고 있었다면
			ProvokeMotion = "social_idle6"		-- 이거 애니메이션 신규로 나오면,  FX_SV_Social_C 와 같이 앞에 FX를 붙여서 
																						-- FX_social_idle1                                              = "Survival_state_giveup_adv"
																						-- 이런식으로 FX를 연결해주면 됨.
			nMotion = nMotion + 1		-- 도발 애니메이션이 들어갔으면 1을 추가한다.
		
		elseif nPartsWingIndex == 3700 then			 --다이아 가방
			ProvokeMotion = "social_idle5"		
			nMotion = nMotion + 1		-- 도발 애니메이션이 들어갔으면 1을 추가한다.
			
			KillMotion = "highkick_attack1"		-- 암살 모션. 예제 모션은 빈사처형 애니메이션임.
			KillMotion2 = "highkick_attack1"		-- 암살2모션
			nMotion = nMotion + 2		-- 암살 애니메이션(두가지 모두)을 추가했으면 2를 추가한다.
			

		elseif nPartsWingIndex == 3701 then  --마스터즈 가방
				ProvokeMotion = "social_idle4"		
				nMotion = nMotion + 1
				
				KillMotion = "highkick_attack1"		-- 암살 모션. 예제 모션은 빈사처형 애니메이션임.
				KillMotion2 = "highkick_attack1"		-- 암살2모션
				nMotion = nMotion + 2		-- 암살 애니메이션(두가지 모두)을 추가했으면 2를 추가한다.
				
				KillMotion3 = "scoccerkick_attack_1"			-- 빈사처형 모션
				nMotion = nMotion + 4		-- 빈사처형 애니메이션이 들어갔으면 4를 추가한다.
		
		end
		
		return KillMotion, KillMotion2, KillMotion3, ProvokeMotion, nMotion
end


function IsAmsalAnim(AnimName) -- 아래 애니메이션 2개는 딜레이값을 애니메이션 속도에 맞춘다.
		if AnimName == "highkick_attack1" then
			return 1
		end
		if AnimName == "scoccerkick_attack_1" then
			return 1
		end
		return 0
end


-- 도발 애니메이션이 세팅되었을때 그에따른 FX 세팅
FX_social_idle1  = "Survival_state_provoke"
FX_social_idle4  = "Survival_state_provoke"
FX_social_idle5  = "Survival_state_provoke"
FX_social_idle6  = "Survival_state_provoke"

function GetRewardItemDeathAnim(nPartsWingIndex, eDamageType)
		DeathMotion = ""
		nMotion = 0							-- 바꾸면 1 아니면 0
		
		if nPartsWingIndex == 3701 then			--  3701을 메고 있는 유저가 나를 죽였을 때
			if eDamageType == 43 then					-- 암살로 죽었다면
				DeathMotion = "highkick_death1"		-- 애니메이션 변경
				nMotion = 1
				
			elseif eDamageType == 45 then		-- 암살2로 죽었다면
				DeathMotion = "highkick_death1"
				nMotion = 1

			elseif eDamageType == 50 then		-- 빈사처형으로 죽었다면
				DeathMotion = "scoccerkick_death1_1"
				nMotion = 1
			end

		elseif nPartsWingIndex == 3700 then			--  3701을 메고 있는 유저가 나를 죽였을 때
			if eDamageType == 43 then					-- 암살로 죽었다면
				DeathMotion = "highkick_death1"		-- 애니메이션 변경
				nMotion = 1
				
			elseif eDamageType == 45 then		-- 암살2로 죽었다면
				DeathMotion = "highkick_death1"
				nMotion = 1
			end
		end
		
		return DeathMotion, nMotion
end

----------------------------------------------------------------------------------------------------
--	게임 시작 시 가지고 있는 기본 무기들(0은 설정하지 말것)
----------------------------------------------------------------------------------------------------
PrimaryWeaponID		= -2				--	빈슬롯
SecondaryWeaponID	= -2				--	빈슬롯
MeleeWeaponID1		= 2066				--	망원경(2066)
MeleeWeaponID2		= 2026				--	낡은 장도리
ThrowWeaponID		= 2116				--	없음,	G400(1720)
ToolWeaponID1		= 3447				--	회복키트
ToolWeaponID2		= -2				--	빈슬롯
CustomAmmoCount1	= "3447,391,1"		--	회복키트(무기ID,ammoID,총알수)
CustomAmmoCount2	= "1720,405,1"		--	G400 	(무기ID,ammoID,총알수)


----------------------------------------------------------------------------------------------------
--	빈사 상태 설정
----------------------------------------------------------------------------------------------------
DyingDamage = 999                                                            -- 이 대미지 이하의 대미지를 받고 죽음에 이를 경우에만 빈사가 발동됨.
DyingFlag_HeadShot = 1                                  -- 1이면 헤드샷으로 빈사, 0이면 헤드샷으로 바로 죽음
DyingFlag_AmSal = 0                                                           -- 1이면 암살로 빈사, 0이면 암살로 바로 죽음.
DyingFlag_MyBomb = 1                                   -- 1이면 내가 던진 폭탄에 빈사, 0이면 내 폭탄 대미지에 바로 죽음
DyingFlag_Crush = 0                                                            -- 1이면 낙사에 빈사, 0이면 낙사에 바로 죽음
DyingFlag_Freeze = 0                                                           -- 1이면 물의 차가움에 빈사, 0이면 물의 차가움에 바로 죽음
DyingFlag_Bleeding = 1                                              -- 1이면 출혈에 빈사, 0이면 출혈에 바로 죽음.

Dying_CamRotSpeed = 18                       -- 카메라 돌리기 느려지는 수준. 3의 배수를 추천함. 숫자가 클수록 느려짐.
Dying_MoveSpeed = 0.1                                  -- 빈사시 속도 느려지는 비율
Dying_WeaponWeight = 0                                -- 빈사시 적용해야 할 무기의 무게. 웨폰스크립트의 weight에 해당함.

Dying_ReviveRange = 500                               -- E키로 빈사인 캐릭터 살릴때 나와 캐릭터의 범위.
Dying_ReviveTick = 3                                               -- E키로 빈사인 캐릭터 살릴때 걸리는 시간
Dying_ReviveHealth = 10                                  -- E키로 빈사인 캐릭터 살리면 그 캐릭터의 HP
Dying_RemainTime = 30                                   -- 빈사에서 죽기까지 걸리는 시간.
Dying_VolumeFadeTick1 = 1							-- 빈사 이후 이 시간까지 볼륨이 Dying_VolumeValue 로 줄어들음. 매우 작으면 이상 동작함.
Dying_VolumeFadeTick2 = 19						-- 빈사 이후 이 시간부터 볼륨이 정상으로 되돌아감. Dying_RemainTime - Dying_VolumeFadeTick2 값이 매우 작으면 이상동작함.
Dying_VolumeValue = 0.1									-- 빈사때 줄어들은 사운드 볼륨


function DoDamageDying(fDyingRemainTime, fDamage)
	fDyingRemainTime = fDyingRemainTime  - fDamage*0.1
	return fDyingRemainTime
end



----------------------------------------------------------------------------------------------------
--	트랩 웨폰 ID
----------------------------------------------------------------------------------------------------
TrapWeaponID 		= 2173				--	트랩
TrapDistance		= 10				--	첫번째 설치물과 두번째 설치물 사이의 거리
TrapGuideDistance	= 210				--	트랩설치시 가이드 모델과 카메라의 거리
TrapTouchDelayTime	= 1.0				--	트랩을 터치했을때 폭파되기 까지의 시간
MaxWoodPiece = 4  -- 최대 나뭇가지 보유 수량


----------------------------------------------------------------------------------------------------
--	무기 종류별 사정거리 정의.
----------------------------------------------------------------------------------------------------

SniperRange = 30000


----------------------------------------------------------------------------------------------------
--	무기에 따라 정해져 있는 에니타입 정의.
--	클라이언트의 에니타입과 같아야 한다.
----------------------------------------------------------------------------------------------------
ANITYPE_RIFLE						= 0
ANITYPE_PISTOL						= 1
ANITYPE_SNIPER						= 4
ANITYPE_SHOTGUN						= 5
ANITYPE_AUTO_SNIPER					= 7
ANITYPE_RIFLE_KNIFE					= 10
ANITYPE_SNIPER_KNIFE					= 11

----------------------------------------------------------------------------------------------------
--	GetWeaponDistance(nWeaponAniType)
--	무기의 에니타입에 따른 무기 발사 거리를 반환한다.
----------------------------------------------------------------------------------------------------
function GetWeaponRange(nWeaponAniType)
	
	nRange = -1
		
	if	nWeaponAniType == ANITYPE_SNIPER	then	nRange = SniperRange
	elseif 	nWeaponAniType == ANITYPE_AUTO_SNIPER	then	nRange = SniperRange
	elseif 	nWeaponAniType == ANITYPE_SNIPER_KNIFE	then	nRange = SniperRange
	
	end

	return nRange
	
end

----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------
--	총알 궤적 빛 색상
----------------------------------------------------------------------------------------------------
TracerLightRadius = 300
TracerLightColorR = 0.25
TracerLightColorG = 0.125
TracerLightColorB = 0
TracerLightTexture = "fx/2011all/uniquecharacter/unique_light_a.dtx"
TracerLightTexSize = 40

----------------------------------------------------------------------------------------------------
--	무기 타입
----------------------------------------------------------------------------------------------------
WT_PRI_COMMON		= 1
WT_PRI_SNIPER		= 2
WT_PRI_SHOTGUN		= 3
WT_SECONDARY		= 4
WT_MELEE			= 5
WT_THROWING			= 6
WT_PACKAGE			= 7
WT_HELMET			= 8
WT_SHIELD			= 9

----------------------------------------------------------------------------------------------------
--	무기별 타입 정의
----------------------------------------------------------------------------------------------------
WeaponType = {}
--	주무기-일반
WeaponType[9]	= WT_PRI_COMMON		--	AK-47
WeaponType[4]	= WT_PRI_COMMON		--	M4A1
WeaponType[23]	= WT_PRI_COMMON	    --	MG-43
WeaponType[478]	= WT_PRI_COMMON		--	CM901
WeaponType[35]	= WT_PRI_COMMON		--	UAR
WeaponType[397]	= WT_PRI_COMMON		--	AK-47 데빌
WeaponType[623] = WT_PRI_COMMON		--	MP5EX 청룡
WeaponType[1483]= WT_PRI_COMMON  	--	M4A1 Aim
WeaponType[1484]= WT_PRI_COMMON 	--	MP5 Aim
WeaponType[390]= WT_PRI_COMMON 	    --	AK-103
WeaponType[2626]= WT_PRI_COMMON 	--	Mak-11
WeaponType[2848]= WT_PRI_COMMON 	--	NA-94

--	주무기-저격
WeaponType[1702]= WT_PRI_SNIPER		--	TRG-21
WeaponType[1706]= WT_PRI_SNIPER		--	SV-98
WeaponType[1704]= WT_PRI_SNIPER		--	AWP
WeaponType[2064]= WT_PRI_SNIPER		--	TRG-21 데빌
WeaponType[2065]= WT_PRI_SNIPER		--	SOCOM-K
WeaponType[391]	= WT_PRI_SNIPER	    --	Winchester m73
WeaponType[1215]= WT_PRI_SNIPER	    --	TRG-21 청마
WeaponType[2959]= WT_PRI_SNIPER 	--	GSR-6
WeaponType[3446]= WT_PRI_SNIPER 	--	AWP_v2

--	주무기-샷건
WeaponType[12]	= WT_PRI_SHOTGUN	--	SG-870_v2
WeaponType[13]	= WT_PRI_SHOTGUN	--	ASG-12_v2
WeaponType[1485]= WT_PRI_SHOTGUN    --	SG-870_v3
WeaponType[3104]	= WT_PRI_SHOTGUN	--	SG-12

--	보조무기
WeaponType[1]	= WT_SECONDARY		--	D.Eagle
WeaponType[10]	= WT_SECONDARY		--	B.92Fs
WeaponType[1958]= WT_SECONDARY		--	G18(s)
WeaponType[135]	= WT_SECONDARY		--	BH.Magnum
WeaponType[1831]= WT_SECONDARY		--	PNR-10

-- 근접무기
WeaponType[2058]= WT_MELEE			--	A급 장도리

--	투척무기
WeaponType[1720]= WT_THROWING		--	G400
WeaponType[2116]= WT_THROWING		--	고성능 연막탄

--	특수무기
WeaponType[3447]= WT_PACKAGE		--	회복키트
WeaponType[3448]= WT_PACKAGE		--	고성능 회복키트

-- 	헬멧
WeaponType[1898]= WT_HELMET			--	방독면
WeaponType[1963]= WT_HELMET			--	해골마스크(레드)
WeaponType[1964]= WT_HELMET			--	해골마스크(블루)
WeaponType[2428]= WT_HELMET			--	전투헬멧(디폴트)
WeaponType[2429]= WT_HELMET			--	전투헬멧(카모)
WeaponType[2430]= WT_HELMET			--	전투헬멧(레오파드)
WeaponType[2431]= WT_HELMET			--	잠수경
WeaponType[2794]= WT_HELMET			--	설원 위장 모자

--방패
WeaponType[1790]= WT_SHIELD			--	방패

--WeaponType[35]	= WT_PRI_COMMON	--	UAR
--WeaponType[99]	= WT_PRI_COMMON	--	SIG556
--WeaponType[14]	= WT_PRI_COMMON	--	FAMAS F1
--WeaponType[24]	= WT_PRI_COMMON	--	SCAR
--WeaponType[1176]	= WT_PRI_COMMON	--	KRISS
--WeaponType[29]	= WT_PRI_COMMON	--	K1
--WeaponType[16]	= WT_PRI_COMMON	--	P90
--WeaponType[7]		= WT_PRI_SNIPER	--	MSG90
--WeaponType[197]	= WT_PRI_SNIPER	--	DSR-1
--WeaponType[2]		= WT_SECONDARY	--	C.Anaconda
--WeaponType[27]	= WT_SECONDARY	--	B.93R

function GetWeaponType( weaponID )
	
	weapontype = 0
	
	if WeaponType[weaponID] ~= nil then
		weapontype = WeaponType[weaponID]
	end
	
	return weapontype

end


function SetupRecoveryKit()
	for k, v in pairs(WeaponType) do
		if v == WT_PACKAGE then
		AddRecoveryKit(k)
		end
	end
end

----------------------------------------------------------------------------------------------------
--	리스폰 아이템 타입 : *변경시 프로그래머와 협의
----------------------------------------------------------------------------------------------------
RIT_NOTHING			= 0		-- 없음(획득실패)
RIT_PRI_WEAPON		= 1		-- 주무기
RIT_SEC_WEAPON		= 2		-- 보조무기
RIT_PRI_AMMO_COMMON	= 3		-- 일반 탄약
RIT_PRI_AMMO_SNIPER	= 4		-- 저격 탄약
RIT_PRI_AMMO_SHOTGUN= 5		-- 샷건 탄약
RIT_SEC_AMMO_ALL	= 6		-- 권총 탄약
RIT_PAC_WEAPON		= 7		-- 5번 슬롯 무기
RIT_THROWING_WEAPON	= 8		-- 투척 무기
RIT_ARMOR			= 9		-- 방탄복
RIT_HELMET			= 10	-- 헬멧
RIT_DOGTAG			= 11	-- 인식표
RIT_EVENT_ITEM		= 12	-- 이벤트 아이템
RIT_ARMOR2			= 13	-- 고성능 방탄복
RIT_WOODPIECE		= 14	-- 나뭇가지

g_Point01Count = 0
g_Point02Count = 0
g_Point03Count = 0
g_Point04Count = 0


----------------------------------------------------------------------------------------------------
--	AddMapItemPointObject( "오브젝트 이름" )
--	맵 아이템 위치 참조에 사용할 point 오브젝트를 등록 한다
--	OnInitLastOneMission() : 모드 시작시 최초 한번 실행 한다
----------------------------------------------------------------------------------------------------
function OnInitLastOneMission()
		
	AddMapItemPointObject( "SaPoint01" )		-- 파이널존 초입부분
	AddMapItemPointObject( "SaPoint02" )		-- 초입을 제외한 모든 건물들
	AddMapItemPointObject( "SaPoint03" )		-- 대기실 동상
	AddMapItemPointObject( "SaPoint04" )		-- 차이나타운 전용 포인트 (부스팅 점프 아이템용)
	SetWeaponClassLimit( 3, 1, 3, 2, 2 )		-- 무기 클래스별 제한 개수 설정 (주무기, 보조무기, 근접무기, 투척무기, 특수무기))

	InitSurvivalKitI()
	
	g_Point01Count = 0
	g_Point02Count = 0
	g_Point03Count = 0
	g_Point04Count = 0
	g_Point05Count = 0
	
	SetupRecoveryKit()
	
end

----------------------------------------------------------------------------------------------------
--	방패
----------------------------------------------------------------------------------------------------
ShieldBlockDamage 		= 0.1f		-- 방패로 막았을때 대미지 0이면 완전 막힘. (100%는 1.of 면 대미지를 100% 받음)
OnlyShieldDamage 		= 0.0f		-- 캐릭터에는 맞지 않고 방매만 맞았을때 대미지 비율. 0이면 완전 막힘.
ShieldSpeed 			= 0.5f		-- 방패를 펼쳤을 경우의 캐릭터 속도 (1.0f 면 동일한 속도)
OtherBombShieldDamage 	= 0.1f		-- 방패병이 있을때 폭탄의 대미지 비율
BombShieldDamage 		= 0.1f		-- 방패병에 가는 폭탄의 대미지 비율
StoppingPowerBase 		= -1.00f	-- 방패병이 맞았을때 StoppingPower 기본
StoppingPowerAlpha 		= 0.27f		-- 방패병이 맞았을때 StoppingPower가 대미지에 비례하는 부분

----------------------------------------------------------------------------------------------------
--	lua 내부에서 사용 하는 함수 및 변수
--	RespawnItemTypeA[리스폰아이템타입] = 확률
----------------------------------------------------------------------------------------------------
--   리스폰 아이템 A타입 : 파이널존 초입	
MapItemTypeA = {}		
MapItemTypeA[RIT_PRI_WEAPON]     	=	8
MapItemTypeA[RIT_SEC_WEAPON]     	=	13
MapItemTypeA[RIT_PRI_AMMO_COMMON]	=	19
MapItemTypeA[RIT_PRI_AMMO_SNIPER]	=	19
MapItemTypeA[RIT_PRI_AMMO_SHOTGUN]	=	25
MapItemTypeA[RIT_SEC_AMMO_ALL]     	=	31
MapItemTypeA[RIT_PAC_WEAPON]     	=	36
MapItemTypeA[RIT_THROWING_WEAPON]	=	39
MapItemTypeA[RIT_ARMOR]          	=	44
MapItemTypeA[RIT_HELMET]          	=	50
MapItemTypeA[RIT_EVENT_ITEM]       	=	50
MapItemTypeA[RIT_ARMOR2]          	=	50
--없음                            	=	50%  -- 테스트용 밸런스 수정
		
--   리스폰 아이템 B타입 : 건물안, 송전탑, 다리 위		
MapItemTypeB = {}		
MapItemTypeB[RIT_PRI_WEAPON]     	=	6
MapItemTypeB[RIT_SEC_WEAPON]     	=	9
MapItemTypeB[RIT_PRI_AMMO_COMMON]	=	13
MapItemTypeB[RIT_PRI_AMMO_SNIPER]	=	15
MapItemTypeB[RIT_PRI_AMMO_SHOTGUN]	=	18
MapItemTypeB[RIT_SEC_AMMO_ALL]     	=	20
MapItemTypeB[RIT_PAC_WEAPON]     	=	22
MapItemTypeB[RIT_THROWING_WEAPON]	=	25
MapItemTypeB[RIT_ARMOR]          	=	29
MapItemTypeB[RIT_HELMET]          	=	33
MapItemTypeB[RIT_EVENT_ITEM]       	=	33
MapItemTypeB[RIT_ARMOR2]       		=	35
--없음                            	=	65%  -- 테스트용 밸런스 수정
		
--   리스폰 아이템 C타입 : 대기실 동상	
MapItemTypeC = {}		
MapItemTypeC[RIT_PRI_WEAPON]     	=	0
MapItemTypeC[RIT_SEC_WEAPON]     	=	0
MapItemTypeC[RIT_PRI_AMMO_COMMON]	=	0
MapItemTypeC[RIT_PRI_AMMO_SNIPER]	=	0
MapItemTypeC[RIT_PRI_AMMO_SHOTGUN]	=	0
MapItemTypeC[RIT_SEC_AMMO_ALL]     	=	0
MapItemTypeC[RIT_PAC_WEAPON]     	=	18
MapItemTypeC[RIT_THROWING_WEAPON]	=	18
MapItemTypeC[RIT_ARMOR]          	=	24
MapItemTypeC[RIT_HELMET]          	=   30
MapItemTypeC[RIT_EVENT_ITEM]       	=	30
MapItemTypeC[RIT_ARMOR2]       		=	30
--없음                            	=	70%  -- 테스트용 밸런스 수정
		
--   리스폰 아이템 D타입 : 부스팅 점프 지역	
MapItemTypeD = {}		
MapItemTypeD[RIT_PRI_WEAPON]     	=	20
MapItemTypeD[RIT_SEC_WEAPON]     	=	20
MapItemTypeD[RIT_PRI_AMMO_COMMON]	=	30
MapItemTypeD[RIT_PRI_AMMO_SNIPER]	=	40
MapItemTypeD[RIT_PRI_AMMO_SHOTGUN]	=	40
MapItemTypeD[RIT_SEC_AMMO_ALL]     	=	40
MapItemTypeD[RIT_PAC_WEAPON]     	=	70
MapItemTypeD[RIT_THROWING_WEAPON]	=	70
MapItemTypeD[RIT_ARMOR]          	=	70
MapItemTypeD[RIT_HELMET]          	=	70
MapItemTypeD[RIT_EVENT_ITEM]       	=	70
MapItemTypeD[RIT_ARMOR2]       		=	70
--없음                            	=	30%

function GetMapItemTypeByProb( rand, respawnItemTypeTable )	

	for k, v in pairs(respawnItemTypeTable) do
		
		if rand <= v then 
			return k 
		end
		
	end
	
	return RIT_NOTHING

end

----------------------------------------------------------------------------------------------------
--	클라이언트에서 호출 할 함수
--	GetRandomMapItemType( 포인트 오브젝트 이름 )
--	해당 오브젝트 위치에 생성해야할 아이템 타입을 랜덤하게 넘겨 준다
----------------------------------------------------------------------------------------------------
function GetRandomMapItemType( strPointName )	

	rand = math.random( 1, 100 )	-- 1~100까지의 숫자 중의 랜덤
	
	nRIT = RIT_NOTHING
	
	if 		( strPointName=="SaPoint01" )	then 
		nRIT = GetMapItemTypeByProb( rand, MapItemTypeA )		
	elseif	( strPointName=="SaPoint02" )	then	
		nRIT = GetMapItemTypeByProb( rand, MapItemTypeB )
	elseif	( strPointName=="SaPoint03" )	then	
		nRIT = GetMapItemTypeByProb( rand, MapItemTypeC )
	elseif	( strPointName=="SaPoint04" ) 	then	
		nRIT = GetMapItemTypeByProb( rand, MapItemTypeD )
	end
	
	if ( nRIT ~= RIT_NOTHING ) then
		if 		( strPointName=="SaPoint01" ) then g_Point01Count = g_Point01Count + 1
			if g_Point01Count > 184		then nRIT = RIT_NOTHING end
		elseif	( strPointName=="SaPoint02" ) then g_Point02Count = g_Point02Count + 1
			if g_Point02Count > 1361	then nRIT = RIT_NOTHING end
		elseif	( strPointName=="SaPoint03" ) then g_Point03Count = g_Point03Count + 1
			if g_Point03Count > 1		then nRIT = RIT_NOTHING	end
		elseif	( strPointName=="SaPoint04" ) then g_Point04Count = g_Point04Count + 1
			if g_Point04Count > 247		then nRIT = RIT_NOTHING	end
		end
	end
	
	return nRIT
	
end

----------------------------------------------------------------------------------------------------
--	리스폰 개수 참고 데이터
----------------------------------------------------------------------------------------------------
--	no		구분	총리스폰개수	확률	예상리스폰개수	최대제한 개수: 150%
--	1		해안가	406		0.3	122				183
--	2		건물안	2925		0.31	907				1360
--	3		대피소	100		0.06	6				9
--	4		야외	781		0.21	164				246
--			TOTAL	4212			1199				1798

----------------------------------------------------------------------------------------------------
--	주무기 확률 설정(루아에서의 배열은 1부터 시작한다.)
----------------------------------------------------------------------------------------------------
--MapPrimaryWeapon[1] = {}
--MapPrimaryWeapon[1].ID	= 무기 ID
--MapPrimaryWeapon[1].Prob	= 확률
----------------------------------------------------------------------------------------------------
MapPrimaryWeapon =  {}		
MapPrimaryWeapon[1] =  {}		--	AK-47
MapPrimaryWeapon[1].ID = 9		--	무기ID
MapPrimaryWeapon[1].Prob = 15	--	확률
MapPrimaryWeapon[2] =  {}		--	M4A1 Aim
MapPrimaryWeapon[2].ID = 1483	--	무기ID
MapPrimaryWeapon[2].Prob = 25	--	확률
MapPrimaryWeapon[3] =  {}		--	CM901
MapPrimaryWeapon[3].ID = 478	--	무기ID
MapPrimaryWeapon[3].Prob = 35	--	확률
MapPrimaryWeapon[4] =  {}		--	UAR
MapPrimaryWeapon[4].ID = 35		--	무기ID
MapPrimaryWeapon[4].Prob = 45	--	확률
MapPrimaryWeapon[5] =  {}		--	Mak-11
MapPrimaryWeapon[5].ID = 2626	--	무기ID
MapPrimaryWeapon[5].Prob = 57	--	확률
MapPrimaryWeapon[6] =  {}		--	NA-94
MapPrimaryWeapon[6].ID = 2848	--	무기ID
MapPrimaryWeapon[6].Prob = 69	--	확률
MapPrimaryWeapon[7] =  {}		--	TRG-21
MapPrimaryWeapon[7].ID = 1702	--	무기ID
MapPrimaryWeapon[7].Prob = 74	--	확률
MapPrimaryWeapon[8] =  {}		--	AWP_v2
MapPrimaryWeapon[8].ID = 3446	--	무기ID
MapPrimaryWeapon[8].Prob = 79	--	확률
MapPrimaryWeapon[9] =  {}		--	Winchester m73
MapPrimaryWeapon[9].ID = 391	--	무기ID
MapPrimaryWeapon[9].Prob = 84	--	확률
MapPrimaryWeapon[10] =  {}		--	SG-870_v3
MapPrimaryWeapon[10].ID = 1485	--	무기ID
MapPrimaryWeapon[10].Prob = 87	--	확률
MapPrimaryWeapon[11] =  {}		--	ASG-12_v2
MapPrimaryWeapon[11].ID = 13	--	무기ID
MapPrimaryWeapon[11].Prob = 90	--	확률
MapPrimaryWeapon[12] =  {}		--	SG-12
MapPrimaryWeapon[12].ID = 3104	--	무기ID
MapPrimaryWeapon[12].Prob = 93	--	확률
MapPrimaryWeapon[13] =  {}		--	방패
MapPrimaryWeapon[13].ID = 1790	--	무기ID
MapPrimaryWeapon[13].Prob = 100	--	확률

----------------------------------------------------------------------------------------------------
--	GetRandomPrimaryWeaponID()
--	주무기 중에 랜덤하게 넘겨 준다
----------------------------------------------------------------------------------------------------
function GetRandomPrimaryWeaponID()

	rand = math.random( 1, 100 )	-- 1~100까지의 숫자 중의 랜덤
	
	for k, v in pairs(MapPrimaryWeapon) do
		
		if rand <= v.Prob then 
			return v.ID 
		end
		
	end
	
	return -1
	
end

----------------------------------------------------------------------------------------------------
--	보조무기 확률 설정
--	루아에서의 배열은 1부터 시작한다.
----------------------------------------------------------------------------------------------------
MapSecondaryWeapon =  {}		
MapSecondaryWeapon[1] =  {}		--	D.Eagle
MapSecondaryWeapon[1].ID = 1		--	무기ID
MapSecondaryWeapon[1].Prob = 30		--	확률
MapSecondaryWeapon[2] =  {}		--	Magnum
MapSecondaryWeapon[2].ID = 135		--	무기ID
MapSecondaryWeapon[2].Prob = 50		--	확률
MapSecondaryWeapon[3] =  {}		--	G18(s)
MapSecondaryWeapon[3].ID = 1958		--	무기ID
MapSecondaryWeapon[3].Prob = 90		--	확률
MapSecondaryWeapon[4] =  {}		--	PNR-10
MapSecondaryWeapon[4].ID = 1831		--	무기ID
MapSecondaryWeapon[4].Prob = 100	--	확률

----------------------------------------------------------------------------------------------------
--	GetRandomSecondaryWeaponID()
--	보조무기 중에 랜덤하게 넘겨 준다
----------------------------------------------------------------------------------------------------
function GetRandomSecondaryWeaponID()

	rand = math.random( 1, 100 )	-- 1~100까지의 숫자 중의 랜덤
	
	for k, v in pairs(MapSecondaryWeapon) do

		if rand <= v.Prob then 
			return v.ID 
		end
		
	end
	
	return -1
	
end

----------------------------------------------------------------------------------------------------
-- 5번무기 확률 설정
-- 루아에서의 배열은 1부터 시작한다.
----------------------------------------------------------------------------------------------------
MapPackageWeapon = {}
MapPackageWeapon[1] 		= {}
MapPackageWeapon[1].ID		= 3447	-- 회복키트
MapPackageWeapon[1].Prob	= 75	-- 나올 확률
MapPackageWeapon[2] 		= {}
MapPackageWeapon[2].ID		= 3448	-- 고성능 회복키트
MapPackageWeapon[2].Prob	= 100	-- 나올 확률

----------------------------------------------------------------------------------------------------
--	GetRandomPackageWeaponID()
--	5번 무기 중에 랜덤하게 넘겨 준다, 또한 발수도 넘겨준다.
----------------------------------------------------------------------------------------------------
function GetRandomPackageWeaponID()

	rand = math.random( 1, 100 )	-- 1~100까지의 숫자 중의 랜덤
	
	for k, v in pairs(MapPackageWeapon) do

		if rand <= v.Prob then 
			--ammo = math.random( 1, 3 )	-- 총알 : 1개에서 3개
			ammo = 1						-- 그냥 1개
			return v.ID, ammo
		end
		
	end	
	
	return -1, 0
	
end

----------------------------------------------------------------------------------------------------
-- 투척무기 확률 설정
-- 루아에서의 배열은 1부터 시작한다.
----------------------------------------------------------------------------------------------------
MapThrowingWeapon = {}
MapThrowingWeapon[1] 		= {}
MapThrowingWeapon[1].ID		= 1720	-- G400
MapThrowingWeapon[1].Prob	= 100	-- 나올 확률

----------------------------------------------------------------------------------------------------
--	GetRandomThrowingWeaponID()
--	투척 무기 중에 랜덤하게 넘겨 준다, 또한 발수도 넘겨준다.
----------------------------------------------------------------------------------------------------
function GetRandomThrowingWeaponID()

	rand = math.random( 1, 100 )	-- 1~100까지의 숫자 중의 랜덤
	
	for k, v in pairs(MapThrowingWeapon) do
		
		if rand <= v.Prob then 
			ammo = 1			-- 1개
			return v.ID, ammo
		end
		
	end	
	
	return -1, 0
	
end

----------------------------------------------------------------------------------------------------
-- 헬멧무기 확률 설정
-- 루아에서의 배열은 1부터 시작한다.
----------------------------------------------------------------------------------------------------
MapHelmetWeapon = {}
MapHelmetWeapon[1] = {}
MapHelmetWeapon[1].ID	= 1898	-- 방독면
MapHelmetWeapon[1].Prob	= 40	-- 나올 확률
MapHelmetWeapon[2] = {}
MapHelmetWeapon[2].ID	= 1963	-- 해골마스크(레드)
MapHelmetWeapon[2].Prob	= 70	-- 나올 확률
MapHelmetWeapon[3] = {}
MapHelmetWeapon[3].ID	= 1964	-- 해골마스크(블루)
MapHelmetWeapon[3].Prob	= 100	-- 나올 확률
MapHelmetWeapon[4] = {}
MapHelmetWeapon[4].ID	= 2428	-- 전투헬멧
MapHelmetWeapon[4].Prob	= 100	-- 나올 확률
MapHelmetWeapon[5] = {}
MapHelmetWeapon[5].ID	= 2429	-- 전투헬멧_카모
MapHelmetWeapon[5].Prob	= 100	-- 나올 확률
MapHelmetWeapon[6] = {}
MapHelmetWeapon[6].ID	= 2430	-- 전투헬멧_레오파드
MapHelmetWeapon[6].Prob	= 100	-- 나올 확률
MapHelmetWeapon[7] = {}
MapHelmetWeapon[7].ID	= 2431	-- 잠수경
MapHelmetWeapon[7].Prob	= 100	-- 나올 확률
----------------------------------------------------------------------------------------------------
--	GetRandomHelmetWeaponID()
--	헬멧 무기 중에 랜덤하게 넘겨 준다
----------------------------------------------------------------------------------------------------
function GetRandomHelmetWeaponID()

	rand = math.random( 1, 100 )	-- 1~100까지의 숫자 중의 랜덤
	
	for k, v in pairs(MapHelmetWeapon) do
		
		if rand <= v.Prob then 			
			return v.ID
		end
		
	end	
	
	return -1
	
end

----------------------------------------------------------------------------------------------------
--	GetRandomHelmetWeaponID()
--	헬멧의 이름을 리턴한다(헬멧은 무기 이기 때문에 weapon.txt에 있는 이름을 그대로 사용 할 수 없다)
----------------------------------------------------------------------------------------------------
function GetHelmetName( nWpnID )

	strHelmet = "Helmet"
	
	if 		nWpnID == 1898 then strHelmet = "방독면"
	elseif 	nWpnID == 1963 then strHelmet = "용병 해골마스크"
	elseif 	nWpnID == 1964 then strHelmet = "특수부대 해골마스크"
    elseif 	nWpnID == 2428 then strHelmet = "전투헬멧"
 	elseif 	nWpnID == 2429 then strHelmet = "전투헬멧(카모)"
	elseif 	nWpnID == 2430 then strHelmet = "전투헬멧(레오파드)"
	elseif 	nWpnID == 2431 then strHelmet = "잠수경"
	elseif 	nWpnID == 2794 then strHelmet = "설원 위장 모자"
	end
	
	return strHelmet
	
end

--	HelmetFunc_DamageRate = {} 
--	헬멧의 대미지 경감 및 벗겨짐, 수영속도 영향 등을 설정한다
----------------------------------------------------------------------------------------------------

HelmetFunc_DamageRate = {}          -- 헬멧 피격 시 대미지 (원레 입을 피해 대비)비율 설정 1.0 = 100%, 0.0 = 0%
HelmetFunc_DamageRate[1898] = 0.0 
HelmetFunc_DamageRate[1963] = 0.0 
HelmetFunc_DamageRate[1964] = 0.0 
HelmetFunc_DamageRate[2428] = 0.4 
HelmetFunc_DamageRate[2429] = 0.4
HelmetFunc_DamageRate[2430] = 0.4
HelmetFunc_DamageRate[2431] = 0.0
HelmetFunc_DamageRate[2794] = 0.0


HelmetFunc_NoThrow = {}          -- 헬멧 피격 시, 벗겨짐 설정. 0 = 벗겨짐    1 = 안벗겨짐
HelmetFunc_NoThrow[1898] = 0
HelmetFunc_NoThrow[1963] = 0
HelmetFunc_NoThrow[1964] = 0 
HelmetFunc_NoThrow[2428] = 1
HelmetFunc_NoThrow[2429] = 1
HelmetFunc_NoThrow[2430] = 1
HelmetFunc_NoThrow[2431] = 0
HelmetFunc_NoThrow[2794] = 0


HelmetFunc_SpeedRate = {}          -- 헬멧 착용 시 수영속도 설정 1.0 = 100%,   2.0 = 200%
HelmetFunc_SpeedRate[1898] = 1.0
HelmetFunc_SpeedRate[1963] = 1.0
HelmetFunc_SpeedRate[1964] = 1.0
HelmetFunc_SpeedRate[2428] = 1.0
HelmetFunc_SpeedRate[2429] = 1.0
HelmetFunc_SpeedRate[2430] = 1.0
HelmetFunc_SpeedRate[2431] = 1.5
HelmetFunc_SpeedRate[2794] = 1.0


----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------
--	나올 총알 갯수 설정
--	GetRandomAmmoCount()
--	총알 갯수 넘겨줌
----------------------------------------------------------------------------------------------------
function GetRandomAmmoCount( rtti )

	ammo = 0
	
	if 		rtti == RIT_PRI_AMMO_COMMON		then	ammo = math.random( 15, 20 )	
	elseif 	rtti == RIT_PRI_AMMO_SNIPER		then	ammo = math.random( 3, 3 )
	elseif 	rtti == RIT_PRI_AMMO_SHOTGUN	then	ammo = math.random( 5, 5 )
	elseif 	rtti == RIT_SEC_AMMO_ALL		then	ammo = math.random( 6, 6 )
	end

	return ammo

end

----------------------------------------------------------------------------------------------------
--	총알 아이템 모델 설정
--	모델, 스킨, 아이콘을 리턴한다
----------------------------------------------------------------------------------------------------
function GetAmmoModelInfo( rtti )
	
	strModel 	= ""
	strSkin		= ""	

	if rtti 	== RIT_PRI_AMMO_COMMON 	then			
		strModel 	= "sa_weapons\\models\\20_tv\\sv_rifle_magazine_3p.ltb"
		strSkin		= "sa_weapons\\SKINS\\tv\\sv_rifle_magazine_3p.dtx"		
	elseif rtti == RIT_PRI_AMMO_SNIPER 	then
		strModel 	= "sa_weapons\\models\\20_tv\\sv_LM_magazine_3p.ltb"
		strSkin		= "sa_weapons\\SKINS\\tv\\sv_LM_magazine_3p.dtx"		
	elseif rtti == RIT_PRI_AMMO_SHOTGUN then
		strModel 	= "sa_weapons\\models\\20_tv\\sv_shotgunbelt_3p.ltb"
		strSkin		= "sa_weapons\\SKINS\\tv\\sv_shotgunbelt_3p.dtx"		
	elseif rtti == RIT_SEC_AMMO_ALL 	then
		strModel 	= "sa_weapons\\models\\20_tv\\sv_Pistol_Magazine_3p.ltb"
		strSkin		= "sa_weapons\\SKINS\\tv\\sv_Pistol_magazine_3p.dtx"
	elseif rtti == RIT_ARMOR 			then
		strModel 	= "sa_weapons\\models\\20_tv\\sv_bulletproof_vest.ltb"
		strSkin		= "sa_weapons\\SKINS\\tv\\sv_bulletproof_vest.dtx"
	elseif rtti == RIT_ARMOR2 			then
		strModel 	= "sa_weapons\\models\\20_tv\\sv_bulletproof_vest.ltb"
		strSkin		= "sa_weapons\\SKINS\\tv\\sv_bulletproof_vest2.dtx"
	end
	return strModel, strSkin

end

----------------------------------------------------------------------------------------------------
-- 이벤트 아이템 확률 설정
-- 루아에서의 배열은 1부터 시작한다.
----------------------------------------------------------------------------------------------------
MapEventItem = {}
MapEventItem[1] = {}
MapEventItem[1].ID		= 1		-- 조각 ID
MapEventItem[1].Prob	= 100	-- 조각 확률
MapEventItem[2] = {}
MapEventItem[2].ID		= 2		-- 조각 ID
MapEventItem[2].Prob	= 100	-- 조각 확률
MapEventItem[3] = {}
MapEventItem[3].ID		= 3		-- 조각 ID
MapEventItem[3].Prob	= 100	-- 조각 확률
MapEventItem[4] = {}
MapEventItem[4].ID		= 4		-- 조각 ID
MapEventItem[4].Prob	= 100	-- 조각 확률
MapEventItem[5] = {}
MapEventItem[5].ID		= 5		-- 조각 ID
MapEventItem[5].Prob	= 100	-- 조각 확률
MapEventItem[6] = {}
MapEventItem[6].ID		= 6		-- 조각 ID
MapEventItem[6].Prob	= 100	-- 조각 확률
MapEventItem[7] = {}
MapEventItem[7].ID		= 7		-- 조각 ID
MapEventItem[7].Prob	= 100	-- 조각 확률
MapEventItem[8] = {}
MapEventItem[8].ID		= 8		-- 조각 ID
MapEventItem[8].Prob	= 100	-- 조각 확률
MapEventItem[9] = {}
MapEventItem[9].ID		= 9		-- 조각 ID
MapEventItem[9].Prob	= 100	-- 조각 확률
MapEventItem[10] = {}
MapEventItem[10].ID		= 10	-- 조각 ID
MapEventItem[10].Prob	= 100   -- 조각 확률

----------------------------------------------------------------------------------------------------
--	GetRandomEventItemID()
--	이벤트 아이템 아이디를 랜덤하게 넘겨 준다
----------------------------------------------------------------------------------------------------
function GetRandomEventItemID()

	rand = math.random( 1, 100 )	-- 1~100까지의 숫자 중의 랜덤
	
	for k, v in pairs(MapEventItem) do
		
		if rand <= v.Prob then 			
			return v.ID
		end
		
	end	
	
	return -1
	
end

----------------------------------------------------------------------------------------------------
--	GetEventItemModelInfo()
--	이벤트아이템 모델을 리턴한다.
----------------------------------------------------------------------------------------------------
function GetEventItemModelInfo( nEventItemID )

	strModel = ""
	strSkin	= ""
	if 		nEventItemID == 1 then	strModel	= "sa_characters\\models\\Survival\\puzzle_hwang_ha.ltb"
									strSkin		= "sa_characters\\skins\\Survival\\puzzle_hwang_ha.dtx"
	elseif	nEventItemID == 2 then	strModel	= "sa_characters\\models\\Survival\\Finalpuzzle_xp.ltb"
									strSkin		= "sa_characters\\skins\\Survival\\Finalpuzzle_xp.dtx"
	elseif	nEventItemID == 3 then	strModel	= "sa_characters\\models\\Survival\\Finalpuzzle_10.ltb"
									strSkin		= "sa_characters\\skins\\Survival\\Finalpuzzle_10.dtx"
	elseif	nEventItemID == 4 then	strModel	= "sa_characters\\models\\Survival\\Finalpuzzle_20.ltb"
									strSkin		= "sa_characters\\skins\\Survival\\Finalpuzzle_20.dtx"
	elseif	nEventItemID == 5 then	strModel	= "sa_characters\\models\\Survival\\Finalpuzzle_30.ltb"
									strSkin		= "sa_characters\\skins\\Survival\\Finalpuzzle_30.dtx"	
	elseif	nEventItemID == 6 then	strModel	= "sa_characters\\models\\Survival\\Finalpuzzle_40.ltb"
									strSkin		= "sa_characters\\skins\\Survival\\Finalpuzzle_40.dtx"
	elseif	nEventItemID == 7 then	strModel	= "sa_characters\\models\\Survival\\Finalpuzzle_50.ltb"
									strSkin		= "sa_characters\\skins\\Survival\\Finalpuzzle_50.dtx"
	elseif	nEventItemID == 8 then	strModel	= "sa_characters\\models\\Survival\\Finalpuzzle_100.ltb"
									strSkin		= "sa_characters\\skins\\Survival\\Finalpuzzle_100.dtx"
	elseif	nEventItemID == 9 then	strModel	= "sa_characters\\models\\Survival\\Finalpuzzle_00.ltb"
									strSkin		= "sa_characters\\skins\\Survival\\Finalpuzzle_00.dtx"		
	elseif	nEventItemID == 10 then	strModel	= "sa_characters\\models\\Survival\\Finalpuzzle_000.ltb"
									strSkin		= "sa_characters\\skins\\Survival\\Finalpuzzle_000.dtx"										
	end
	
	return strModel, strSkin
	
end

----------------------------------------------------------------------------------------------------
--	이벤트 아이템 습득 시 표시 할 아이템 이름
----------------------------------------------------------------------------------------------------
function GetEventItemName( nEventItemID )
           
	strName = ""
           
	if 		nEventItemID == 1 then	strName	= "이벤트 판넬"										
	elseif	nEventItemID == 2 then	strName	= "이벤트 조각 2번슬롯"										
	elseif	nEventItemID == 3 then	strName	= "이벤트 조각 3번슬롯"										
	elseif	nEventItemID == 4 then	strName	= "이벤트 조각 3번슬롯"										
	elseif	nEventItemID == 5 then	strName	= "이벤트 조각 3번슬롯"	
	elseif	nEventItemID == 6 then	strName	= "이벤트 조각 3번슬롯"	
	elseif	nEventItemID == 7 then	strName	= "이벤트 조각 3번슬롯"	
	elseif	nEventItemID == 8 then	strName	= "이벤트 조각 3번슬롯"	
	elseif	nEventItemID == 9 then	strName	= "이벤트 조각 4번슬롯"	
	elseif	nEventItemID == 10 then	strName	= "이벤트 조각 4번슬롯"	
	end

	return strName

end

----------------------------------------------------------------------------------------------------
--	맵에 배치될 무기 모델 설정
--	모델, 스킨을 리턴한다
-- 기본 무기 스크립트에 따르려면 ""을 리턴한다.
----------------------------------------------------------------------------------------------------
function GetWeaponMapModelInfo( weaponID )
	
	strModel 	= ""
	strSkin		= ""	

	if weaponID 	== 3447 then			
		strModel 	= "sa_weapons\\models\\20_tv\\sv_first_aid_b_3p.ltb"
		strSkin		= "sa_weapons\\SKINS\\tv\\sv_first_aid_orange.dtx"	
	elseif weaponID == 3448 then			
		strModel 	= "sa_weapons\\models\\20_tv\\sv_first_aid_b_3p.ltb"
		strSkin		= "sa_weapons\\SKINS\\tv\\sv_first_aid_green.dtx"	
	end
	
	return strModel, strSkin

end

----------------------------------------------------------------------------------------------------
--	HP, AP 설정
----------------------------------------------------------------------------------------------------
HP 		= 500	-- 시작 HP
AP 		= 100	-- 시작 AP
MaxHP 	= 500	-- 최대 HP
MaxAP 	= 500	-- 최대 AP

----------------------------------------------------------------------------------------------------
--	인벤토리에 표시할 아이콘
----------------------------------------------------------------------------------------------------
strInvenIcon = {}
strInvenIcon[RIT_PRI_AMMO_COMMON]	= "sa_interface2\\hud\\survival\\inventory\\AR_ammo.dtx"
strInvenIcon[RIT_PRI_AMMO_SNIPER] 	= "sa_interface2\\hud\\survival\\inventory\\SR_ammo.dtx"
strInvenIcon[RIT_PRI_AMMO_SHOTGUN] 	= "sa_interface2\\hud\\survival\\inventory\\ETC_ammo.dtx"
strInvenIcon[RIT_SEC_AMMO_ALL]		= "sa_interface2\\hud\\survival\\inventory\\SW_ammo.dtx"
strInvenIcon[RIT_HELMET]			= "sa_interface2\\hud\\survival\\inventory\\helmet.dtx"
strInvenIcon[RIT_DOGTAG]			= "sa_interface2\\hud\\survival\\inventory\\dogtag.dtx"
strInvenIcon[RIT_WOODPIECE]			= "sa_interface2\\hud\\survival\\inventory\\WOODPIECE.dtx"
strInvenIcon[RIT_ARMOR]			    = "sa_interface2\\hud\\survival\\inventory\\sv_icon_bulletproof_vest.dtx"
strInvenIcon[RIT_ARMOR2]			= "sa_interface2\\hud\\survival\\inventory\\sv_icon_bulletproof_premiumvest.dtx"

function GetInventoryIcon( rtti )
	
	strIcon = ""
	
	if strInvenIcon[rtti] ~= nil then
		strIcon = strInvenIcon[rtti]	
	end
	
	return strIcon

end

----------------------------------------------------------------------------------------------------
--	인벤토리에 표시할 무기 아이콘
----------------------------------------------------------------------------------------------------
--주무기(일반)
strWeaponIcon = {}
strWeaponIcon[9] 	= "sa_interface2\\hud\\survival\\inventory\\AK-47.dtx"
strWeaponIcon[4] 	= "sa_interface2\\hud\\survival\\inventory\\M4A1.dtx"
strWeaponIcon[23]	= "sa_interface2\\hud\\survival\\inventory\\MG-43_v2.dtx"
strWeaponIcon[478] 	= "sa_interface2\\hud\\survival\\inventory\\CM901.dtx"
strWeaponIcon[35]	= "sa_interface2\\hud\\survival\\inventory\\UAR.dtx"
strWeaponIcon[397]	= "sa_interface2\\hud\\survival\\inventory\\AK-47_D.dtx"
strWeaponIcon[623]	= "sa_interface2\\hud\\survival\\inventory\\MP5EX_R.dtx"
strWeaponIcon[1483]	= "sa_interface2\\hud\\survival\\inventory\\M4a1_aim.dtx"
strWeaponIcon[1484]	= "sa_interface2\\hud\\survival\\inventory\\Mp5_aim.dtx"
strWeaponIcon[390]	= "sa_interface2\\hud\\survival\\inventory\\AK-103.dtx"
strWeaponIcon[2626]	= "sa_interface2\\hud\\survival\\inventory\\mak11.dtx"
strWeaponIcon[2848]	= "sa_interface2\\hud\\survival\\inventory\\NA-94.dtx"
--주무기(저격)
strWeaponIcon[1702]	= "sa_interface2\\hud\\survival\\inventory\\TRG-21.dtx"
strWeaponIcon[1706]	= "sa_interface2\\hud\\survival\\inventory\\SV-98.dtx"
strWeaponIcon[1704]	= "sa_interface2\\hud\\survival\\inventory\\awp.dtx"
strWeaponIcon[2064]	= "sa_interface2\\hud\\survival\\inventory\\TRG-21_D.dtx"
strWeaponIcon[2065]	= "sa_interface2\\hud\\survival\\inventory\\SOCOM_F.dtx"
strWeaponIcon[391]	= "sa_interface2\\hud\\survival\\inventory\\Winchester.dtx"
strWeaponIcon[1215]	= "sa_interface2\\hud\\survival\\inventory\\TRG-21_B.dtx"
strWeaponIcon[2959]	= "sa_interface2\\hud\\survival\\inventory\\gsr6.dtx"
strWeaponIcon[3446]	= "sa_interface2\\hud\\survival\\inventory\\AWP_v2.dtx"
--주무기(샷건)
strWeaponIcon[12]	= "sa_interface2\\hud\\survival\\inventory\\SG-870_v2.dtx"
strWeaponIcon[13]	= "sa_interface2\\hud\\survival\\inventory\\ASG-12_v2.dtx"
strWeaponIcon[1485]	= "sa_interface2\\hud\\survival\\inventory\\Sg870_v3.dtx"
strWeaponIcon[3104]	= "sa_interface2\\hud\\survival\\inventory\\SG-12.dtx"
--주무기(방패)
strWeaponIcon[1790]	= "sa_interface2\\hud\\survival\\inventory\\Shield.dtx"
--보조무기
strWeaponIcon[1]	= "sa_interface2\\hud\\survival\\inventory\\DEagle.dtx"
strWeaponIcon[10]	= "sa_interface2\\hud\\survival\\inventory\\B92Fs.dtx"
--strWeaponIcon[27]	= "sa_interface2\\hud\\survival\\inventory\\B93R.dtx"
strWeaponIcon[135]	= "sa_interface2\\hud\\survival\\inventory\\Magnum.dtx"
strWeaponIcon[1958]	= "sa_interface2\\hud\\survival\\inventory\\G18.dtx"
strWeaponIcon[1831]	= "sa_interface2\\hud\\survival\\inventory\\sv_icon_pnr_10.dtx" 
--투척무기
strWeaponIcon[1720]	= "sa_interface2\\hud\\survival\\inventory\\G400.dtx"
strWeaponIcon[2116]	= "sa_interface2\\hud\\survival\\inventory\\sv_inven_item_Smoke.dtx"
--회복키트, 지혈제
strWeaponIcon[3447]	= "sa_interface2\\hud\\survival\\inventory\\HPKIT.dtx"	--일반
strWeaponIcon[3448]	= "sa_interface2\\hud\\survival\\inventory\\HPKIT2.dtx"	--고성능
--탄약
--strWeaponIcon[0]	= "sa_interface2\hud\survival\inventory\\tag.dtx"
--헬멧
strWeaponIcon[1898]	= "sa_interface2\\hud\\survival\\inventory\\sv_icon_gasmask.dtx"		--방독면
strWeaponIcon[1963]	= "sa_interface2\\hud\\survival\\inventory\\sv_icon_skullmask_red.dtx"	--해골마스크_레드
strWeaponIcon[1964]	= "sa_interface2\\hud\\survival\\inventory\\sv_icon_skullmask_blue.dtx"	--해골마스크_블루
strWeaponIcon[2428]	= "sa_interface2\\hud\\survival\\inventory\\sv_icon_BattleHelmet_default.dtx"		--전투헬멧(디폴트)
strWeaponIcon[2429]	= "sa_interface2\\hud\\survival\\inventory\\sv_icon_BattleHelmet_camo.dtx"		--전투헬멧(카모)
strWeaponIcon[2430]	= "sa_interface2\\hud\\survival\\inventory\\sv_icon_BattleHelmet_leopard.dtx"	--전투헬멧(레오파드)
strWeaponIcon[2431]	= "sa_interface2\\hud\\survival\\inventory\\sv_icon_goggle_helmet_default.dtx"	--잠수경
strWeaponIcon[2794]	= "sa_interface2\\hud\\survival\\inventory\\sv_icon_snowcap.dtx"	--설원 위장 헬멧

--인식표
--strWeaponIcon[0]	= "sa_interface2\hud\survival\item\\tag.dtx"
--나뭇가지
strWeaponIcon[2173]	= "sa_interface2\\hud\\survival\\inventory\\WOODPIECE.dtx"	--나뭇가지


function GetWeaponIcon( weaponID )

	strIcon = "sa_interface\\weapon\\survival_kit_is.dtx"
	
	if strWeaponIcon[weaponID] ~= nil then
		strIcon = strWeaponIcon[weaponID]
	end
	
	return strIcon		

end

----------------------------------------------------------------------------------------------------
--	아이템 습득시 보여줄 텍스트 색
--	R, G, B를 리턴
----------------------------------------------------------------------------------------------------
--	주무기_일반 : 흰색
itemTextColor = {}
itemTextColor[RIT_PRI_AMMO_COMMON] 		= {}
itemTextColor[RIT_PRI_AMMO_COMMON].r 	= 255
itemTextColor[RIT_PRI_AMMO_COMMON].g 	= 255
itemTextColor[RIT_PRI_AMMO_COMMON].b 	= 255
--	주무기_저격 : 흰색
itemTextColor[RIT_PRI_AMMO_SNIPER] 		= {}
itemTextColor[RIT_PRI_AMMO_SNIPER].r 	= 255
itemTextColor[RIT_PRI_AMMO_SNIPER].g 	= 255
itemTextColor[RIT_PRI_AMMO_SNIPER].b 	= 255
--	주무기_샷건 : 흰색
itemTextColor[RIT_PRI_AMMO_SHOTGUN] 	= {}
itemTextColor[RIT_PRI_AMMO_SHOTGUN].r 	= 255
itemTextColor[RIT_PRI_AMMO_SHOTGUN].g 	= 255
itemTextColor[RIT_PRI_AMMO_SHOTGUN].b 	= 255
--	권총 : 흰색
itemTextColor[RIT_SEC_AMMO_ALL] 		= {}
itemTextColor[RIT_SEC_AMMO_ALL].r 		= 255
itemTextColor[RIT_SEC_AMMO_ALL].g 		= 255
itemTextColor[RIT_SEC_AMMO_ALL].b 		= 255
--	방탄복 : 흰색
itemTextColor[RIT_ARMOR] 				= {}
itemTextColor[RIT_ARMOR].r 				= 255
itemTextColor[RIT_ARMOR].g 				= 255
itemTextColor[RIT_ARMOR].b 				= 255
--	헬멧 : 흰색
itemTextColor[RIT_HELMET] 				= {}
itemTextColor[RIT_HELMET].r 			= 255
itemTextColor[RIT_HELMET].g 			= 255
itemTextColor[RIT_HELMET].b 			= 255

--	이벤트아이템 : 흰색
itemTextColor[RIT_EVENT_ITEM] 			= {}
itemTextColor[RIT_EVENT_ITEM].r 		= 255
itemTextColor[RIT_EVENT_ITEM].g 		= 255
itemTextColor[RIT_EVENT_ITEM].b 		= 255

--	방탄복 : 흰색
itemTextColor[RIT_ARMOR2] 				= {}
itemTextColor[RIT_ARMOR2].r				= 255
itemTextColor[RIT_ARMOR2].g				= 255
itemTextColor[RIT_ARMOR2].b				= 255

function GetItemTextColor( rtti )	
	
	rgb = {}
	rgb.r = 255
	rgb.g = 255
	rgb.b = 255
	
	if itemTextColor[rtti] ~= nil then
		rgb = itemTextColor[rtti]
	end	
	
	return rgb.r, rgb.g, rgb.b
end
----------------------------------------------------------------------------------------------------
-- 생존모드 전용 캐릭터
----------------------------------------------------------------------------------------------------
-- 특수 이모션
function IsSurvivalSocialChar( nModelID )
           
	if nModelID == 1261 or nModelID == 1262 or nModelID == 1263 or nModelID == 1264 then -- 적용 캐릭터 인덱스[모험가]
		 return 1
	end
	if nModelID == 2188 or nModelID == 2189 or nModelID == 2190 or nModelID == 2191 or nModelID == 2192 or nModelID == 2193 or nModelID == 2194 or nModelID == 2195 then -- 적용 캐릭터 인덱스[쵸단]
		return 1
	end
	return 0
end

SocialMotion = {}

ModelBaseID = 1261 -- 모험가

SocialMotion[ModelBaseID] = {}
SocialMotion[ModelBaseID].Provoke = "Survival_state_provoke_adv"
SocialMotion[ModelBaseID].accept = "Survival_state_accept_adv"
SocialMotion[ModelBaseID].giveup = "Survival_state_giveup_adv"

ModelBaseID = 2188 -- 쵸단

SocialMotion[ModelBaseID] = {}
SocialMotion[ModelBaseID].Provoke = "Survival_state_provoke_chodan"
SocialMotion[ModelBaseID].accept = "Survival_state_accept_chodan"
SocialMotion[ModelBaseID].giveup = "Survival_state_giveup_chodan"
function GetSpecialSocialFX( nModelID , strAniName )
    
	FXName = ""
	if nModelID == 1261 or nModelID == 1262 or nModelID == 1263 or nModelID == 1264 then -- 적용 캐릭터 인덱스[모험가]
		if strAniName == "FX_SV_Social_Z" then
			FXName = SocialMotion[1261].Provoke
		 elseif strAniName == "FX_SV_Social_X" then
			FXName = SocialMotion[1261].accept
		 elseif strAniName == "FX_SV_Social_C" then
			FXName = SocialMotion[1261].giveup
		end
	 elseif nModelID == 2188 or nModelID == 2189 or nModelID == 2190 or nModelID == 2191 or nModelID == 2192 or nModelID == 2193 or nModelID == 2194 or nModelID == 2195 then -- 적용 캐릭터 인덱스[쵸단]
		if strAniName == "FX_SV_Social_Z" then
			FXName = SocialMotion[2188].Provoke
		 elseif strAniName == "FX_SV_Social_X" then
			FXName = SocialMotion[2188].accept
		 elseif strAniName == "FX_SV_Social_C" then
			FXName = SocialMotion[2188].giveup
		end
	end
	return FXName
end

FX_SV_Social_Z                                              = "Survival_state_provoke_adv"    --놀리기(메롱)
FX_SV_Social_X                                              = "Survival_state_accept_adv"    --수락
FX_SV_Social_C                                              = "Survival_state_giveup_adv"    --항복
----------------------------------------------------------------------------------------------------
--	UI
----------------------------------------------------------------------------------------------------
--	아이템 아웃라인 색상
MapItemOutlineVisibleDistance   = 180	-- 아웃라인이 보이는 거리
MapItemOutlineColorR            = 1.0	-- 아웃라인 R(0~1.0)
MapItemOutlineColorG            = 1.0	-- 아웃라인 G(0~1.0)
MapItemOutlineColorB            = 1.0	-- 아웃라인 B(0~1.0)
MapItemOutlineScale             = 0.004	-- 아웃라인 굵기 0.0025

--	 힐, 대미지 UI 색상
HealColorR 						= 0
HealColorG 						= 255
HealColorB 						= 0
DamageColorR 					= 255
DamageColorG 					= 0
DamageColorB 					= 0

--	아이템 인터렉선
ItemInteractionRange     		= 210
ItemInteractionTime				= 0.15

--	이모션 FX (순서대로 ZXC)
FX_social_idle3					= "Survival_state_provoke"	--놀리기(메롱)
FX_social_idle2					= "Survival_state_accept"	--수락
FX_social_idle0					= "Survival_state_giveup"	--항복

--	집라인 FX
FX_zipline_idle_3                               = "Survival_Line_Spark_HH"
FX_zipline_idle_3_1                             = "Survival_Line_Spark_HH"
FX_zipline_idle_3_2                             = "Survival_Line_Spark_HH"

----------------------------------------------------------------------------------------------------
--	루팅 가방 (죽은 위치에 출력)
----------------------------------------------------------------------------------------------------
LootBoxModel			= "sa_weapons\\models\\20_tv\\sv_armybackpack_3p.ltb"
LootBoxSkin				= "sa_weapons\\SKINS\\tv\\sv_armybackpack_3p.dtx"
LootBoxInteractionMsg	= "가방열기"
LootBoxInteractionTime	= 2.0

----------------------------------------------------------------------------------------------------
--	보급 상자
----------------------------------------------------------------------------------------------------
SupplyBoxModel			= "sa_props\\models\\survival\\survival_supplyBox_01.ltb"
SupplyBoxSkin			= "sa_props\\skins\\survival\\survival_supplyBox_01.dtx"

----------------------------------------------------------------------------------------------------
--	게임 이벤트 관련
--	게임 이벤트 타입(Game Event Type)
----------------------------------------------------------------------------------------------------
GET_TAKE_ITEM		= 1		-- 아이템 획득
GET_OPEN_LOOT_BOX	= 2		-- 루팅박스를 열었을때
GET_CLOSE_LOOT_BOX	= 3		-- 루팅 박스를 닫을때

----------------------------------------------------------------------------------------------------
--	게임 내에서 이벤트가 발생했을때 호출 된다
--	glue 함수 설명
--	Play3DSound( "파일명", 위치X, 위치Y, 위치Z, 볼륨(0~100), 가까운범위, 먼범위 )
--	3D 사운드를 재생한다
----------------------------------------------------------------------------------------------------
function OnGameEvent( gameEventType, respawnItemType, eventPosX, eventPosY, eventPosZ )

	if gameEventType == GET_TAKE_ITEM then
		if 		respawnItemType==RIT_PRI_WEAPON 		then	Play3DSound( "sa_interface2\\snd\\survival\\get_weapon.wav", 		eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 주무기
		elseif	respawnItemType==RIT_SEC_WEAPON 		then	Play3DSound( "sa_interface2\\snd\\survival\\get_weapon_pistol.wav",	eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 보조무기
		elseif	respawnItemType==RIT_THROWING_WEAPON	then	Play3DSound( "sa_interface2\\snd\\survival\\get_aidkit.wav",		eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 투척무기
		elseif	respawnItemType==RIT_PAC_WEAPON 		then	Play3DSound( "sa_interface2\\snd\\survival\\get_aidkit.wav", 		eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 회복키트
		elseif	respawnItemType==RIT_PRI_AMMO_COMMON 	then	Play3DSound( "sa_interface2\\snd\\survival\\get_ammo_common.wav", 	eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 일반탄약
		elseif	respawnItemType==RIT_PRI_AMMO_SNIPER 	then	Play3DSound( "sa_interface2\\snd\\survival\\get_ammo_common.wav", 	eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 저격탄약(일반탄약과 동일)
		elseif	respawnItemType==RIT_PRI_AMMO_SHOTGUN 	then	Play3DSound( "sa_interface2\\snd\\survival\\get_ammo_shotgun.wav", 	eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 샷건탄약
		elseif	respawnItemType==RIT_SEC_AMMO_ALL 		then	Play3DSound( "sa_interface2\\snd\\survival\\get_ammo_common.wav", 	eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 보조무기탄약(일반탄약과 동일)
		elseif	respawnItemType==RIT_ARMOR 				then	Play3DSound( "sa_interface2\\snd\\survival\\get_bodyarmour.wav", 	eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 방탄복
		elseif	respawnItemType==RIT_HELMET 			then	Play3DSound( "sa_interface2\\snd\\survival\\get_helmet.wav", 		eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 헬멧
		elseif	respawnItemType==RIT_DOGTAG 			then	Play3DSound( "sa_interface2\\snd\\survival\\get_dogtag.wav", 		eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 인식표
		elseif	respawnItemType==RIT_EVENT_ITEM 		then	Play3DSound( "sa_interface2\\snd\\survival\\get_aidkit.wav", 		eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 이벤트 아이템
		elseif	respawnItemType==RIT_ARMOR2				then	Play3DSound( "sa_interface2\\snd\\survival\\get_bodyarmour.wav", 	eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 고성능 방탄복
		end

	elseif gameEventType == GET_OPEN_LOOT_BOX then Play3DSound( "sa_interface2\\snd\\survival\\get_duffel_bag.wav",	eventPosX, eventPosY, eventPosZ, 100, 300, 500 )	-- 가방열기

	end
	
end

----------------------------------------------------------------------------------------------------
--	총알 아이템 습득 시 표시 할 아이템 이름
----------------------------------------------------------------------------------------------------
function GetAmmoItemName( rit )
           
	strName = ""
           
	if 		rit==RIT_PRI_AMMO_COMMON 	then	strName = "일반 탄약"
	elseif 	rit==RIT_PRI_AMMO_SNIPER 	then	strName = "저격 탄약"
	elseif 	rit==RIT_PRI_AMMO_SHOTGUN 	then	strName = "샷건 탄약"
	elseif 	rit==RIT_SEC_AMMO_ALL 		then	strName = "권총 탄약"
	elseif 	rit==RIT_DOGTAG 			then	strName = "인식표"
	elseif 	rit==RIT_ARMOR 		        then  	strName = "방탄복"
	elseif 	rit==RIT_ARMOR2 	        then	strName = "고성능 방탄복"	
	end
	return strName

end

----------------------------------------------------------------------------------------------------
--	방어구 아이템 습득 시 표시 할 아이템 이름 및 +AP
----------------------------------------------------------------------------------------------------
function GetArmorItemName( rit )
           
	strName = ""
           
	if 		rit==RIT_ARMOR 		then	strName = "방탄복"
	elseif 	rit==RIT_ARMOR2 	then	strName = "고성능 방탄복"	
	end

	return strName

end

function GetArmorAP( rit )
           
	nAP = 100
           
	if 		rit==RIT_ARMOR 		then	nAP = 100
	elseif 	rit==RIT_ARMOR2 	then	nAP = 500
	end

	return nAP

end

----------------------------------------------------------------------------------------------------
--	무기 사운드 출력 범위 설정 
----------------------------------------------------------------------------------------------------
--	같은 크기로 출력되는 범위 설정 (값으로 설정한다)
function GetWeaponFireSoundInnerRadius( weaponID )

	innerRadius = -1.0	-- 값이 마이너스 이면 기존 계산방법으로 계산(outerRadius * 0.25)
	
	weaponType = GetWeaponType( weaponID )
		
	if 		weaponType == WT_PRI_COMMON 	then	innerRadius = 100	
	elseif 	weaponType == WT_PRI_SNIPER 	then	innerRadius = 300
	elseif 	weaponType == WT_PRI_SHOTGUN 	then	innerRadius = 200
	elseif 	weaponType == WT_SECONDARY 		then	innerRadius = 100
	elseif 	weaponType == WT_THROWING 		then	innerRadius = 300
	
	end

	return innerRadius
	
end

--	출력되는 모든 범위 설정 (비율로 설정한다)
function GetWeaponFireSoundRadiusIncreaseRate( weaponID )

	rate = 1.0
	
	weaponType = GetWeaponType( weaponID )
	
	if 		weaponType == WT_PRI_COMMON 	then	rate = 3.0
	elseif 	weaponType == WT_PRI_SNIPER 	then	rate = 5.0
	elseif 	weaponType == WT_PRI_SHOTGUN 	then	rate = 3.0
	elseif 	weaponType == WT_SECONDARY 		then	rate = 2.0
	elseif 	weaponType == WT_THROWING 		then	rate = 4.0
	end

	return rate

end

----------------------------------------------------------------------------------------------------
--	주무기, 보조무기 배치에 따른 주변 총알 아이템 배치
----------------------------------------------------------------------------------------------------
-- 총알 놓을 위치 사용할 각도 배열(순서대로 체크해서 이중에 2곳에 설치 )
WeaponAmmoAngleArray	= "0,45,90,135,180,225,270,315"	-- 설정하고 싶은 각도의 갯수대로 써 넣는다. **공백사용금지
WeaponAmmoDistance		= 40	-- 무기로 부터 이 거리 만큼 떨어뜨려 체크한다

----------------------------------------------------------------------------------------------------
--  차이나타운 일반/클랜전 인원 별 스폰 Index 연결 및 물설정 연동.
----------------------------------------------------------------------------------------------------
BaseMappingIndex = 0   -- 차이나타운 일반전은 Team0으로 설정된 포인트에 스폰됨.  물 속도도 기본 셋팅을 따름.
Clan1MappingIndex = 1  -- 차이나타운 첫 클랜전(5:5)은 Team1으로 설정된 포인트에 스폰. 물 속도는 1로 설정된 내용으로 적용.
Clan2MappingIndex = 1  -- 차이나타운 두번째 클랜전(3:3)은 위와 같음.


----------------------------------------------------------------------------------------------------
--	물 설정
----------------------------------------------------------------------------------------------------
--	물 기본속성
WaterTexturePath		= "sa_tex2\\cliffhanger\\water_blue.dtx"
WaterObjectPath			= "sa_props\\models\\sea.ltb"

WaterColorR 			= 50
WaterColorG 			= 205
WaterColorB 			= 255
WaterSize 				= 70000
WaterUV 				= 100
WaterHeightStart		= -4100

--물 출렁임
WaterWaveValue			= 50		-- -50 ~ +50
WaterWaveSpeed			= 1
WaterDwellTime			= 46

--물 빠짐 설정
WaterOmenValue			= -300
WaterOmenTime			= 3

--물 차오름 설정
WaterTsunamiValue		= 788
WaterTsunamiTime		= 8
WaterTsunamiRandomValue	= 0

-----------------------------클랜3vs3용 시작
--물 출렁임
WaterWaveValue1			= 50
WaterWaveSpeed1			= 1
WaterDwellTime1			= 46 --> 기존 설정 대비 30초 씩 빠르게 물이 차오름

--물 빠짐 설정
WaterOmenValue1			= -300
WaterOmenTime1			= 3

--물 차오름 설정
WaterTsunamiValue1		= 788
WaterTsunamiTime1		= 8
WaterTsunamiRandomValue1	= 0
-----------------------------클랜3vs3용 끝

--물 사운드 (눈보라일 경우엔 눈보라 사운드)
DisasterSoundOuterDist  = 2500
DisasterSoundInnerDist  = 1000
-- DisasterSound          	= "sa_interface2\\snd/survival\\sea_wave.wav"		-- 파도
DisasterAlarmSound  	= "sa_interface2\\snd\\survival\\sv_01.wav"			-- 싸이렌
DisasterMovementSound   = "sa_interface2\\snd/survival\\tsunami_wave.wav"	-- 수위 상승
DisasterUnderSound      = "sa_worlds\\snd\\under water_1.wav"				-- 물속, 눈보라 속

----------------------------------------------------------------------------------------------------
--	대미지설정
----------------------------------------------------------------------------------------------------
--	출혈
BloodDamageRate				= 0.1	-- 입은 대미지에서 출혈로 입힐 대미지 비율 예) 1이면 100%
BloodDamageTick				= 2		-- 2초마다 출혈 피해
BloodDamageDuration			= 30	-- 30초 동안 대미지를 입는다
BloodDamageAccumulateTime  	= 0.9	-- 출혈을 일으킬 대미지 누적 시간
BloodDamageAccumulateDamage = 100	-- 출혈을 일으킬 누적 대미지
-- 물
WaterDamage 				= 100	-- O2를 모두 소비 하였을 때 틱 당 대미지
WaterContactDamage			= 15	-- 물에 닿았을 때 대미지

----------------------------------------------------------------------------------------------------
--	BGM설정
----------------------------------------------------------------------------------------------------

EventBGM1	= "sa_interface2\\snd/survival\\LastOneSTART_BGM.ogg"
EventBGM2	= "sa_interface2\\snd/survival\\LastOne10_BGM.ogg"
EventBGM3	= "sa_interface2\\snd/survival\\LastOne2_BGM.ogg"
EventBGM4	= "sa_interface2\\snd/survival\\LastOne5_BGM.ogg"

WaitingBGM	= "sa_interface2\\snd/survival\\LastOne_Waiting_BGM.ogg"

-- 큐사운드: 앞에 다른 큐사운드가 출력되고 있으면, 해당 사운드가 종료될 때 까지 기다렸다가 출력.
-- 꼬리사운드: 앞에 설정된 큐사운드가 종료되고 나서, 바로 이어서 출력되는 사운드. (대기중인 다른 큐사운드와 중복 출력 가능)

EventPlayer2Queue                           = "sa_interface2/snd/survival/LastOne2_Voice.wav"                 -- 2명생존 큐사운드
EventPlayer2Tail                                = "sa_interface2/snd/survival/LastOne2_BGM.ogg"               -- 2명생존 꼬리사운드
EventPlayer5Queue                           = "sa_interface2/snd/survival/LastOne5_Voice.wav"                 -- 5명생존 큐사운드
EventPlayer5Tail                                = "sa_interface2/snd/survival/LastOne5_BGM.ogg"               -- 5명생존 꼬리사운드
EventPlayer10Queue                                       = "sa_interface2/snd/survival/LastOne10_Voice.wav"   -- 10명생존 큐사운드
EventPlayer10Tail                              = "sa_interface2/snd/survival/LastOne10_BGM.ogg"               -- 10명생존 꼬리사운드

EventTopPlayerDeathQueue   = "sa_interface2/snd/survival/sv_No1Die.wav"                                       -- 생존률 1위 유저 사망 큐사운드
EventDroneStartQueue                       = "sa_interface2/snd/survival/sv_SupplyStart.wav"                  -- 드론생성 큐사운드
EventPeerDeathQueue          = "sa_interface2/snd/survival/sv_crawl_death.wav"                                -- 동료사망 큐사운드
EventPeerCrawlQueue                                     = "sa_interface2/snd/survival/sv_crawl_ally.wav"      -- 동료빈사 큐사운드
EventPeerCrawlExecuteQueue              = "sa_interface2/snd/survival/sv_crawl_execute.wav"                   -- 동료빈사처형 큐사운드

----------------------------------------------------------------------------------------------------
--         서바이벌 캐시 아이템 세트 설정 
----------------------------------------------------------------------------------------------------
-- -1 이면 안줌 --(투척무기는 지급 개수의 -1개로 설정한다)
--	TRG-21 생존팩
CashSetItem = {}
CashSetItem[3051] = {}
CashSetItem[3051].PrimaryID				=  2064	-- 주무기
CashSetItem[3051].SecondaryID			= -1	-- 보조무기
CashSetItem[3051].KnifeID			= -1	-- 근접무기
CashSetItem[3051].ThrowID				= -1	-- 투척무기
CashSetItem[3051].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3051].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3051].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3051].HelmetID				= -1	-- 헬멧
CashSetItem[3051].AP					=  0	-- 방탄복
CashSetItem[3051].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3051].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3051].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3051].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수

--	AK-47 생존팩
CashSetItem[3052] = {}
CashSetItem[3052].PrimaryID				=  397	-- 주무기
CashSetItem[3052].SecondaryID			= -1	-- 보조무기
CashSetItem[3052].KnifeID			= -1	-- 근접무기
CashSetItem[3052].ThrowID				= -1	-- 투척무기
CashSetItem[3052].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3052].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3052].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3052].HelmetID				= -1	-- 헬멧
CashSetItem[3052].AP					=  0	-- 방탄복
CashSetItem[3052].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3052].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3052].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3052].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수

--	탄약 생존팩
CashSetItem[3053] = {}
CashSetItem[3053].PrimaryID				= -1	-- 주무기
CashSetItem[3053].SecondaryID			= -1	-- 보조무기
CashSetItem[3053].KnifeID			= -1	-- 근접무기
CashSetItem[3053].ThrowID				= -1	-- 투척무기
CashSetItem[3053].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3053].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3053].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3053].HelmetID				= -1	-- 헬멧
CashSetItem[3053].AP					=  0	-- 방탄복
CashSetItem[3053].CommonAmmoCount		=  10	-- 일반 총알 갯수
CashSetItem[3053].SniperAmmoCount		=  3	-- 스나이퍼 총알 갯수
CashSetItem[3053].ShotgunAmmoCount		=  5	-- 샷건 총알 갯수
CashSetItem[3053].SecondaryAmmoCount	=  10	-- 보조무기 총알 갯수

--	방어 생존팩
CashSetItem[3054] = {}
CashSetItem[3054].PrimaryID				= -1	-- 주무기
CashSetItem[3054].SecondaryID			= -1	-- 보조무기
CashSetItem[3054].KnifeID			= -1	-- 근접무기
CashSetItem[3054].ThrowID				= -1	-- 투척무기
CashSetItem[3054].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3054].PackageID				=  3447	-- 5번무기(없으면 새로 가짐)
CashSetItem[3054].PackageCount			=  2	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3054].HelmetID				=  1964	-- 헬멧
CashSetItem[3054].AP					=  100	-- 방탄복
CashSetItem[3054].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3054].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3054].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3054].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수

--	SOCOM 생존팩
CashSetItem[3055] = {}
CashSetItem[3055].PrimaryID				=  2065	-- 주무기
CashSetItem[3055].SecondaryID			= -1	-- 보조무기
CashSetItem[3055].KnifeID			= -1	-- 근접무기
CashSetItem[3055].ThrowID				=  1720	-- 투척무기
CashSetItem[3055].ThrowCount			=  0	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3055].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3055].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3055].HelmetID				= -1	-- 헬멧
CashSetItem[3055].AP					=  0	-- 방탄복
CashSetItem[3055].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3055].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3055].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3055].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수

--	방패 생존팩
CashSetItem[3073] = {}
CashSetItem[3073].PrimaryID				=  1790	-- 주무기
CashSetItem[3073].SecondaryID			= -1	-- 보조무기
CashSetItem[3073].KnifeID			= -1	-- 근접무기
CashSetItem[3073].ThrowID				= -1	-- 투척무기
CashSetItem[3073].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3073].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3073].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3073].HelmetID				= -1	-- 헬멧
CashSetItem[3073].AP					=  0	-- 방탄복
CashSetItem[3073].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3073].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3073].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3073].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수




-----------------------------------------------------------------
-- 생존팩 pc방 지급용
-----------------------------------------------------------------
--	TRG-21 생존팩
CashSetItem[3456] = {}
CashSetItem[3456].PrimaryID				=  2064	-- 주무기
CashSetItem[3456].SecondaryID			= -1	-- 보조무기
CashSetItem[3456].KnifeID			= -1	-- 근접무기
CashSetItem[3456].ThrowID				= -1	-- 투척무기
CashSetItem[3456].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3456].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3456].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3456].HelmetID				= -1	-- 헬멧
CashSetItem[3456].AP					=  0	-- 방탄복
CashSetItem[3456].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3456].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3456].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3456].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수

--	AK-47 생존팩
CashSetItem[3455] = {}
CashSetItem[3455].PrimaryID				=  397	-- 주무기
CashSetItem[3455].SecondaryID			= -1	-- 보조무기
CashSetItem[3455].KnifeID			= -1	-- 근접무기
CashSetItem[3455].ThrowID				= -1	-- 투척무기
CashSetItem[3455].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3455].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3455].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3455].HelmetID				= -1	-- 헬멧
CashSetItem[3455].AP					=  0	-- 방탄복
CashSetItem[3455].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3455].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3455].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3455].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수

--	탄약 생존팩
CashSetItem[3457] = {}
CashSetItem[3457].PrimaryID				= -1	-- 주무기
CashSetItem[3457].SecondaryID			= -1	-- 보조무기
CashSetItem[3457].KnifeID			= -1	-- 근접무기
CashSetItem[3457].ThrowID				= -1	-- 투척무기
CashSetItem[3457].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3457].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3457].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3457].HelmetID				= -1	-- 헬멧
CashSetItem[3457].AP					=  0	-- 방탄복
CashSetItem[3457].CommonAmmoCount		=  10	-- 일반 총알 갯수
CashSetItem[3457].SniperAmmoCount		=  3	-- 스나이퍼 총알 갯수
CashSetItem[3457].ShotgunAmmoCount		=  5	-- 샷건 총알 갯수
CashSetItem[3457].SecondaryAmmoCount	=  10	-- 보조무기 총알 갯수

--	방어 생존팩
CashSetItem[3458] = {}
CashSetItem[3458].PrimaryID				= -1	-- 주무기
CashSetItem[3458].SecondaryID			= -1	-- 보조무기
CashSetItem[3458].KnifeID			= -1	-- 근접무기
CashSetItem[3458].ThrowID				= -1	-- 투척무기
CashSetItem[3458].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3458].PackageID				=  3447	-- 5번무기(없으면 새로 가짐)
CashSetItem[3458].PackageCount			=  2	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3458].HelmetID				=  1964	-- 헬멧
CashSetItem[3458].AP					=  100	-- 방탄복
CashSetItem[3458].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3458].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3458].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3458].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수

--	SOCOM 생존팩
CashSetItem[3459] = {}
CashSetItem[3459].PrimaryID				=  2065	-- 주무기
CashSetItem[3459].SecondaryID			= -1	-- 보조무기
CashSetItem[3459].KnifeID			= -1	-- 근접무기
CashSetItem[3459].ThrowID				=  1720	-- 투척무기
CashSetItem[3459].ThrowCount			=  0	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3459].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3459].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3459].HelmetID				= -1	-- 헬멧
CashSetItem[3459].AP					=  0	-- 방탄복
CashSetItem[3459].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3459].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3459].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3459].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수


-----------------------------------------------------------------
-- 생존팩 연예인 캐릭터 세트효과
-----------------------------------------------------------------
--	TRG-21 생존팩
CashSetItem[3470] = {}
CashSetItem[3470].PrimaryID				=  2064	-- 주무기
CashSetItem[3470].SecondaryID			= -1	-- 보조무기
CashSetItem[3470].KnifeID			= -1	-- 근접무기
CashSetItem[3470].ThrowID				= -1	-- 투척무기
CashSetItem[3470].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3470].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3470].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3470].HelmetID				= -1	-- 헬멧
CashSetItem[3470].AP					=  0	-- 방탄복
CashSetItem[3470].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3470].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3470].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3470].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수

--	AK-47 생존팩
CashSetItem[3469] = {}
CashSetItem[3469].PrimaryID				=  397	-- 주무기
CashSetItem[3469].SecondaryID			= -1	-- 보조무기
CashSetItem[3469].KnifeID			= -1	-- 근접무기
CashSetItem[3469].ThrowID				= -1	-- 투척무기
CashSetItem[3469].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3469].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3469].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3469].HelmetID				= -1	-- 헬멧
CashSetItem[3469].AP					=  0	-- 방탄복
CashSetItem[3469].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3469].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3469].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3469].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수

--	탄약 생존팩
CashSetItem[3471] = {}
CashSetItem[3471].PrimaryID				= -1	-- 주무기
CashSetItem[3471].SecondaryID			= -1	-- 보조무기
CashSetItem[3471].KnifeID			= -1	-- 근접무기
CashSetItem[3471].ThrowID				= -1	-- 투척무기
CashSetItem[3471].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3471].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3471].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3471].HelmetID				= -1	-- 헬멧
CashSetItem[3471].AP					=  0	-- 방탄복
CashSetItem[3471].CommonAmmoCount		=  10	-- 일반 총알 갯수
CashSetItem[3471].SniperAmmoCount		=  3	-- 스나이퍼 총알 갯수
CashSetItem[3471].ShotgunAmmoCount		=  5	-- 샷건 총알 갯수
CashSetItem[3471].SecondaryAmmoCount	=  10	-- 보조무기 총알 갯수

--	방어 생존팩
CashSetItem[3472] = {}
CashSetItem[3472].PrimaryID				= -1	-- 주무기
CashSetItem[3472].SecondaryID			= -1	-- 보조무기
CashSetItem[3472].KnifeID			= -1	-- 근접무기
CashSetItem[3472].ThrowID				= -1	-- 투척무기
CashSetItem[3472].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3472].PackageID				=  3447	-- 5번무기(없으면 새로 가짐)
CashSetItem[3472].PackageCount			=  2	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3472].HelmetID				=  1964	-- 헬멧
CashSetItem[3472].AP					=  100	-- 방탄복
CashSetItem[3472].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3472].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3472].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3472].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수

--	SOCOM 생존팩
CashSetItem[3474] = {}
CashSetItem[3474].PrimaryID				=  2065	-- 주무기
CashSetItem[3474].SecondaryID			= -1	-- 보조무기
CashSetItem[3474].KnifeID			= -1	-- 근접무기
CashSetItem[3474].ThrowID				=  1720	-- 투척무기
CashSetItem[3474].ThrowCount			=  0	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3474].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3474].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3474].HelmetID				= -1	-- 헬멧
CashSetItem[3474].AP					=  0	-- 방탄복
CashSetItem[3474].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3474].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3474].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3474].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수

--	방패 생존팩
CashSetItem[3473] = {}
CashSetItem[3473].PrimaryID				=  1790	-- 주무기
CashSetItem[3473].SecondaryID			= -1	-- 보조무기
CashSetItem[3473].KnifeID			= -1	-- 근접무기
CashSetItem[3473].ThrowID				= -1	-- 투척무기
CashSetItem[3473].ThrowCount			= -1	-- 투척무기 갯수(투척무기가 있어야 가짐)
CashSetItem[3473].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
CashSetItem[3473].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
CashSetItem[3473].HelmetID				= -1	-- 헬멧
CashSetItem[3473].AP					=  0	-- 방탄복
CashSetItem[3473].CommonAmmoCount		=  0	-- 일반 총알 갯수
CashSetItem[3473].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
CashSetItem[3473].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
CashSetItem[3473].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수



function GetSurvivalCashSetItem( nItemID )
	bFound = 0
	nPrimaryID				= -1
	nSecondaryID			= -1
	nKnifeID				= -1
	nThrowID				= -1
	nThrowCount				=  0
	nPackageID				= -1
	nPackageCount			=  0
	nHelmetID				= -1
	nAP						=  0
	nCommonAmmoCount		=  0
	nSniperAmmoCount		=  0
	nShotgunAmmoCount		=  0
	nSecondaryAmmoCount		=  0
           
	if 	CashSetItem[nItemID] ~= nil then
		 nPrimaryID				= CashSetItem[nItemID].PrimaryID
		 nSecondaryID			= CashSetItem[nItemID].SecondaryID
		 nKnifeID				= CashSetItem[nItemID].KnifeID
		 nThrowID				= CashSetItem[nItemID].ThrowID
		 nThrowCount			= CashSetItem[nItemID].ThrowCount
		 nPackageID				= CashSetItem[nItemID].PackageID
		 nPackageCount			= CashSetItem[nItemID].PackageCount
		 nHelmetID				= CashSetItem[nItemID].HelmetID
		 nAP						= CashSetItem[nItemID].AP
		 nCommonAmmoCount		= CashSetItem[nItemID].CommonAmmoCount
		 nSniperAmmoCount		= CashSetItem[nItemID].SniperAmmoCount
		 nShotgunAmmoCount		= CashSetItem[nItemID].ShotgunAmmoCount
		 nSecondaryAmmoCount	= CashSetItem[nItemID].SecondaryAmmoCount     
		 bFound = 1
	end
	   
	return 	nPrimaryID, nSecondaryID, nKnifeID, nThrowID, nThrowCount, nPackageID, nPackageCount, 
			nHelmetID, nAP, nCommonAmmoCount, nSniperAmmoCount, nShotgunAmmoCount, nSecondaryAmmoCount, bFound
end
----------------------------------------------------------------------------------------------------
-- 서바이벌  생존키트 아이템
--

--	방패 생존키트
KitID = 3427

KitSetItem = {}


KitSetItem[KitID] = {}
KitSetItem[KitID].PrimaryID				=  1790	-- 주무기
KitSetItem[KitID].SecondaryID			=  -1	-- 보조무기
KitSetItem[KitID].KnifeID				=  -1	-- 근접무기
KitSetItem[KitID].ThrowID				=  2116	-- 투척무기
KitSetItem[KitID].ThrowCount			=  2	-- 투척무기 갯수(투척무기가 있어야 가짐)
KitSetItem[KitID].PackageID				=  -1	-- 5번무기(없으면 새로 가짐)
KitSetItem[KitID].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
KitSetItem[KitID].HelmetID				= -1	-- 헬멧
KitSetItem[KitID].AP					=  0	-- 방탄복
KitSetItem[KitID].CommonAmmoCount		        =  0	-- 일반 총알 갯수
KitSetItem[KitID].SniperAmmoCount		        =  0	-- 스나이퍼 총알 갯수
KitSetItem[KitID].ShotgunAmmoCount		        =  0	-- 샷건 총알 갯수
KitSetItem[KitID].SecondaryAmmoCount	                =  0	-- 보조무기 총알 갯수
KitSetItem[KitID].nIndex				=  1			--N키 무기교체에서 몇번째 칸에 보일지
KitSetItem[KitID].Texture                               =  "sa_interface2\\menu\\Survival\\Icon_shield.dtx"	        -- 결과 화면 창에 보이는 아이템 텍스처
KitSetItem[KitID].Texture2                              =  "sa_interface2\\menu\\Survival\\Icon_shield_d.dtx"	        -- 결과 화면 창에 보이는 아이템 텍스처, disable 이미지
KitSetItem[KitID].Desc = 18918							-- 메세지 박스에 있으며 키트에 대한 설명

--	돌격 생존키트
KitID = 3426

KitSetItem[KitID] = {}
KitSetItem[KitID].PrimaryID				=  390	-- 주무기
KitSetItem[KitID].SecondaryID			= -1	-- 보조무기
KitSetItem[KitID].KnifeID				= -1	-- 근접무기
KitSetItem[KitID].ThrowID				= -1	-- 투척무기
KitSetItem[KitID].ThrowCount			=  0	-- 투척무기 갯수(투척무기가 있어야 가짐)
KitSetItem[KitID].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
KitSetItem[KitID].PackageCount			        =  0	-- 5번무기 갯수(5번무기가있어야 가짐)
KitSetItem[KitID].HelmetID				= -1	-- 헬멧
KitSetItem[KitID].AP					= 100	-- 방탄복
KitSetItem[KitID].CommonAmmoCount		        =  0	-- 일반 총알 갯수
KitSetItem[KitID].SniperAmmoCount		        =  0	-- 스나이퍼 총알 갯수
KitSetItem[KitID].ShotgunAmmoCount		        =  0	-- 샷건 총알 갯수
KitSetItem[KitID].SecondaryAmmoCount	                =  0	-- 보조무기 총알 갯수
KitSetItem[KitID].nIndex				=  2			--N키 무기교체에서 몇번째 칸에 보일지
KitSetItem[KitID].Texture                               =  "sa_interface2\\menu\\Survival\\Icon_AK103.dtx"	-- 결과 화면 창에 보이는 아이템 텍스처
KitSetItem[KitID].Texture2                              =  "sa_interface2\\menu\\Survival\\Icon_AK103_d.dtx"	-- 결과 화면 창에 보이는 아이템 텍스처, disable 이미지
KitSetItem[KitID].Desc = 18917							-- 메세지 박스에 있으며 키트에 대한 설명


--	방어 생존키트
KitID = 3425

KitSetItem[KitID] = {}
KitSetItem[KitID].PrimaryID				= -1	-- 주무기
KitSetItem[KitID].SecondaryID			= -1	-- 보조무기
KitSetItem[KitID].KnifeID				= -1	-- 근접무기
KitSetItem[KitID].ThrowID				= -1	-- 투척무기
KitSetItem[KitID].ThrowCount			        =  0	-- 투척무기 갯수(투척무기가 있어야 가짐)
KitSetItem[KitID].PackageID				= -1	-- 5번무기(없으면 새로 가짐)
KitSetItem[KitID].PackageCount			        =  1	-- 5번무기 갯수(5번무기가있어야 가짐)
KitSetItem[KitID].HelmetID				= 2429	-- 헬멧
KitSetItem[KitID].AP					=  500	-- 방탄복
KitSetItem[KitID].CommonAmmoCount		        =  0	-- 일반 총알 갯수
KitSetItem[KitID].SniperAmmoCount		        =  0	-- 스나이퍼 총알 갯수
KitSetItem[KitID].ShotgunAmmoCount		        =  0	-- 샷건 총알 갯수
KitSetItem[KitID].SecondaryAmmoCount	                =  0	-- 보조무기 총알 갯수
KitSetItem[KitID].nIndex				=  3			--N키 무기교체에서 몇번째 칸에 보일지
KitSetItem[KitID].Texture                               =  "sa_interface2\\menu\\Survival\\icon_defense.dtx"	-- 결과 화면 창에 보이는 아이템 텍스처
KitSetItem[KitID].Texture2                              =  "sa_interface2\\menu\\Survival\\icon_defense_d.dtx"	-- 결과 화면 창에 보이는 아이템 텍스처, disable 이미지
KitSetItem[KitID].Desc = 18916						-- 메세지 박스에 있으며 키트에 대한 설명


--     회복 생존키트
KitID = 3424

KitSetItem[KitID] = {}
KitSetItem[KitID].PrimaryID				= -1	-- 주무기
KitSetItem[KitID].SecondaryID			= -1	-- 보조무기
KitSetItem[KitID].KnifeID				= -1	-- 근접무기
KitSetItem[KitID].ThrowID				= -1    -- 투척무기
KitSetItem[KitID].ThrowCount			        =  0	-- 투척무기 갯수(투척무기가 있어야 가짐)
KitSetItem[KitID].PackageID				= 3447	-- 5번무기(없으면 새로 가짐)
KitSetItem[KitID].PackageCount			        =  2	-- 5번무기 갯수(5번무기가있어야 가짐)
KitSetItem[KitID].HelmetID				= -1	-- 헬멧
KitSetItem[KitID].AP					= 0	-- 방탄복
KitSetItem[KitID].CommonAmmoCount		        =  0	-- 일반 총알 갯수
KitSetItem[KitID].SniperAmmoCount		        =  0	-- 스나이퍼 총알 갯수
KitSetItem[KitID].ShotgunAmmoCount		        =  0	-- 샷건 총알 갯수
KitSetItem[KitID].SecondaryAmmoCount	                =  0	-- 보조무기 총알 갯수
KitSetItem[KitID].nIndex				=  4			--N키 무기교체에서 몇번째 칸에 보일지
KitSetItem[KitID].Texture                               =  "sa_interface2\\menu\\Survival\\icon_survivalkit.dtx"	-- 결과 화면 창에 보이는 아이템 텍스처
KitSetItem[KitID].Texture2                              =  "sa_interface2\\menu\\Survival\\icon_survivalkit_d.dtx"	-- 결과 화면 창에 보이는 아이템 텍스처, disable 이미지
KitSetItem[KitID].Desc = 18915							-- 메세지 박스에 있으며 키트에 대한 설명


--    탄약 생존키트
KitID = 3423

KitSetItem[KitID] = {}
KitSetItem[KitID].PrimaryID				= -1    -- 주무기
KitSetItem[KitID].SecondaryID			        = -1	-- 보조무기
KitSetItem[KitID].KnifeID				= -1	-- 근접무기
KitSetItem[KitID].ThrowID				=  -1	-- 투척무기
KitSetItem[KitID].ThrowCount			        =  0	-- 투척무기 갯수(투척무기가 있어야 가짐)
KitSetItem[KitID].PackageID				=  -1	-- 5번무기(없으면 새로 가짐)
KitSetItem[KitID].PackageCount			        =  0	-- 5번무기 갯수(5번무기가있어야 가짐)
KitSetItem[KitID].HelmetID				= -1	-- 헬멧
KitSetItem[KitID].AP					=  0	-- 방탄복
KitSetItem[KitID].CommonAmmoCount		        =  10	-- 일반 총알 갯수
KitSetItem[KitID].SniperAmmoCount		        =  3	-- 스나이퍼 총알 갯수
KitSetItem[KitID].ShotgunAmmoCount		        =  3	-- 샷건 총알 갯수
KitSetItem[KitID].SecondaryAmmoCount	                =  10	-- 보조무기 총알 갯수
KitSetItem[KitID].nIndex				=  5			--N키 무기교체에서 몇번째 칸에 보일지
KitSetItem[KitID].Texture                               =  "sa_interface2\\menu\\Survival\\icon_ammunition.dtx"	        -- 결과 화면 창에 보이는 아이템 텍스처
KitSetItem[KitID].Texture2                              =  "sa_interface2\\menu\\Survival\\icon_ammunition_d.dtx"	-- 결과 화면 창에 보이는 아이템 텍스처, disable 이미지
KitSetItem[KitID].Desc = 18914							-- 메세지 박스에 있으며 키트에 대한 설명

--    스페셜 생존키트
KitID = 3702

KitSetItem[KitID] = {}
KitSetItem[KitID].PrimaryID				=  1215 -- 주무기
KitSetItem[KitID].SecondaryID			=  -1	-- 보조무기
KitSetItem[KitID].KnifeID				=  -1	-- 근접무기
KitSetItem[KitID].ThrowID				=  -1	-- 투척무기
KitSetItem[KitID].ThrowCount			=  0	-- 투척무기 갯수(투척무기가 있어야 가짐)
KitSetItem[KitID].PackageID				=  3448	-- 5번무기(없으면 새로 가짐)
KitSetItem[KitID].PackageCount			=  0	-- 5번무기 갯수(5번무기가있어야 가짐)
KitSetItem[KitID].HelmetID				= -1	-- 헬멧
KitSetItem[KitID].AP					=  100	-- 방탄복
KitSetItem[KitID].CommonAmmoCount		=  5	-- 일반 총알 갯수
KitSetItem[KitID].SniperAmmoCount		=  0	-- 스나이퍼 총알 갯수
KitSetItem[KitID].ShotgunAmmoCount		=  0	-- 샷건 총알 갯수
KitSetItem[KitID].SecondaryAmmoCount	=  0	-- 보조무기 총알 갯수
KitSetItem[KitID].nIndex				=  6	--N키 무기교체에서 몇번째 칸에 보일지
KitSetItem[KitID].Texture                       =  "sa_interface2\\menu\\Survival\\icon_special.dtx"	        -- 결과 화면 창에 보이는 아이템 텍스처
KitSetItem[KitID].Texture2                      =  "sa_interface2\\menu\\Survival\\icon_special_d.dtx"	-- 결과 화면 창에 보이는 아이템 텍스처, disable 이미지
KitSetItem[KitID].Desc = 19865					-- 메세지 박스에 있으며 키트에 대한 설명
function GetSurvivalKitSetItem( nItemID )
	nPrimaryID				= -1
	nSecondaryID		         	= -1
	nKnifeID				= -1
	nThrowID				= -1
	nThrowCount				=  0
	nPackageID				= -1
	nPackageCount			        =  0
	nHelmetID				= -1
	nAP					=  0
	nCommonAmmoCount		=  0
	nSniperAmmoCount		=  0
	nShotgunAmmoCount		=  0
	nSecondaryAmmoCount		=  0
 
 	nFound = 0
	nIndex = 0
	Tex = ""
	Tex2 = ""
	nDesc = 0
	
	if 	KitSetItem[nItemID] ~= nil then
		 nPrimaryID				= KitSetItem[nItemID].PrimaryID
		 nSecondaryID			= KitSetItem[nItemID].SecondaryID
		 nKnifeID				= KitSetItem[nItemID].KnifeID
		 nThrowID				= KitSetItem[nItemID].ThrowID
		 nThrowCount			= KitSetItem[nItemID].ThrowCount
		 nPackageID				= KitSetItem[nItemID].PackageID
		 nPackageCount			= KitSetItem[nItemID].PackageCount
		 nHelmetID				= KitSetItem[nItemID].HelmetID
		 nAP						= KitSetItem[nItemID].AP
		 nCommonAmmoCount		= KitSetItem[nItemID].CommonAmmoCount
		 nSniperAmmoCount		= KitSetItem[nItemID].SniperAmmoCount
		 nShotgunAmmoCount		= KitSetItem[nItemID].ShotgunAmmoCount
		 nSecondaryAmmoCount	= KitSetItem[nItemID].SecondaryAmmoCount   
		Tex = KitSetItem[nItemID].Texture
		Tex2 = KitSetItem[nItemID].Texture2
		nDesc = KitSetItem[nItemID].Desc
		
		 nFound			= 1
		 nIndex				= KitSetItem[nItemID].nIndex     

	 end
	   
	return 	nPrimaryID, nSecondaryID, nKnifeID, nThrowID, nThrowCount, nPackageID, nPackageCount, 
			nHelmetID, nAP, nCommonAmmoCount, nSniperAmmoCount, nShotgunAmmoCount, nSecondaryAmmoCount,
			nIndex, nFound, Tex, Tex2, nDesc
end

function InitSurvivalKitI()
	for key,value in pairs(KitSetItem) do
		AddSurvivalKit(key)
	end
end

----------------------------------------------------------------------------------------------------
--	말풍선이 보이는 보이스톡 볼륨.
----------------------------------------------------------------------------------------------------
VoiceTalkSpeechBubbleVolume = 0.5		

----------------------------------------------------------------------------------------------------
--	채팅, 라디오, 보이스 사용시 말풍선 타입.
--	클라이언트와 동일한 값으로 사용되어야함.
----------------------------------------------------------------------------------------------------
SPEECH_BUBBLE_CHAT	= 1		-- 채팅 메세지 사용시.
SPEECH_BUBBLE_RADIO	= 2		-- 라디오 메세지 사용시.
SPEECH_BUBBLE_VOICE	= 3		-- 보이스 사용시.


----------------------------------------------------------------------------------------------------
--	채팅, 라디오, 보이스 사용시 말풍선 FX의 이름을 설정하고 반환해준다.
----------------------------------------------------------------------------------------------------
strSpeechBubbleFXName = {}
strSpeechBubbleFXName[SPEECH_BUBBLE_CHAT]	= "Survival_voice_dot3"
strSpeechBubbleFXName[SPEECH_BUBBLE_RADIO] 	= "Survival_voice_wave"
strSpeechBubbleFXName[SPEECH_BUBBLE_VOICE] 	= "Survival_voice_mike"

function GetSpeechBubbleFXName( nType )
	
	strFXName = ""
	
	if strSpeechBubbleFXName[nType] ~= nil then
		strFXName = strSpeechBubbleFXName[nType]
	end
	
	return strFXName
	
end

----------------------------------------------------------------------------------------------------
--	집라인 경로
----------------------------------------------------------------------------------------------------
ZipLineKitModel = "sa_characters/models/Survival/zipline_3p.ltb"
ZipLineKitSkin = "sa_characters/skins/survival/zipline_d.dtx"
ZipLineKitSocket = "RightHand"

----------------------------------------------------------------------------------------------------
--	집라인 사운드
----------------------------------------------------------------------------------------------------
Flood_zipline_idle_3    = 1
Flood_zipline_idle_3_1  = 1
Flood_zipline_idle_3_2  = 1
FloodSound ="sa_interface2/snd/survival/Zipline_Idle.wav"


----------------------------------------------------------------------------------------------------
--	생존모드 BEST10 GAME 반복 우승자 혜택
--  에니메이션 이름으로 'Z'키 소셜모션인지 아닌지를 판별한다. (모든 도발 애니메이션을 등록해야한다.)
----------------------------------------------------------------------------------------------------
function IsZSocialMotionByAniName( strAniName )
			
        if strAniName == "FX_social_idle1" then
		   return 1
		elseif strAniName == "FX_social_idle3" then
		   return 1
		elseif strAniName == "FX_social_idle4" then
		   return 1
		elseif strAniName == "FX_social_idle5" then
		   return 1
		elseif strAniName == "FX_social_idle6" then
		   return 1
		elseif strAniName == "FX_SV_Social_Z" then
		   return 1
        end
        return 0
	
end

----------------------------------------------------------------------------------------------------
--	생존모드 베스트10게임에서 1등 횟수에 따라 z키 소셜 에니메이션 FX를 다르게 보여주는데...
--	1등 횟수에 따라 FX 이름을 출력해준다.
----------------------------------------------------------------------------------------------------
function GetBestGameFXNameByWinCount( nWinCount )

	strFXName = "";	
	
	if 	( 10 <= nWinCount and nWinCount <= 19 )		then
		strFXName = "Survival_state_winIcon_0"
	elseif	( 20 <= nWinCount and nWinCount <= 39 )		then
		strFXName = "Survival_state_winIcon_1"
	elseif	( 40 <= nWinCount and nWinCount <= 79 )		then
		strFXName = "Survival_state_winIcon_2"
	elseif	( 80 <= nWinCount and nWinCount <= 159 ) 	then
		strFXName = "Survival_state_winIcon_3"
	elseif	( 160 <= nWinCount and nWinCount <= 299 ) 	then
		strFXName = "Survival_state_winIcon_4"
	elseif	( 300 <= nWinCount ) 				then
		strFXName = "Survival_state_winIcon_5"

	end
	return strFXName
end

----------------------------------------------------------------------------------------------------
--	개별 무기 드랍이 가능한 무기의 ID
----------------------------------------------------------------------------------------------------
EachThrowWeaponCount = 2

EachThrowWeaponID = {}
EachThrowWeaponID[1] = 3447
EachThrowWeaponID[2] = 3448

function GetEachThrowWeaponID( nIndex )

	WeaponID = -1

	if EachThrowWeaponID[nIndex] ~= nil then
		WeaponID= EachThrowWeaponID[nIndex]
	end
	
	return WeaponID

end

----------------------------------------------------------------------------------------------------
--	무기 드랍했을때 크기 조정.
----------------------------------------------------------------------------------------------------
DropWeaponScale =  {}
		
DropWeaponScale[1] =  {}
DropWeaponScale[1].ID = 3447	--	무기ID
DropWeaponScale[1].Scale = 2	--	스케일
DropWeaponScale[2] =  {}
DropWeaponScale[2].ID = 3448	--	무기ID
DropWeaponScale[2].Scale = 2	--	스케일


function GetDropWeaponScale( nWeaponID )

	for k, v in pairs(DropWeaponScale) do
		
		if nWeaponID == v.ID then
			return v.Scale
		end
		
	end	
	
	return 1

end

----------------------------------------------------------------------------------------------------
--	Tab 미니맵에 적용될 minimapdata 스크립트의 인덱스
----------------------------------------------------------------------------------------------------
TabMiniMapDataIndex = 14

----------------------------------------------------------------------------------------------------
--	라이플, 스나이퍼, 샷건, 권총 탄창에 대한 Weapon ID
----------------------------------------------------------------------------------------------------
RifleMagazineID = 2492
SniperMagazineID = 2493
ShotgunMagazineID = 2494
PistolMagazineID = 2495

----------------------------------------------------------------------------------------------------
--	대기섬에서 같은 팀원을 나타내는 FX
----------------------------------------------------------------------------------------------------
TeamFX = "Survival_state_accept"

----------------------------------------------------------------------------------------------------
--           드론 보급상자 아이템
----------------------------------------------------------------------------------------------------
DroneItemWeaponList = {}
DroneItemEtcList = {}


function GetTableRand(tablernd)
             totalweight = 0
             for k, v in pairs(tablernd) do
                           totalweight = totalweight+v
             end        
             randweight = math.random(1,totalweight)
             for k, v in pairs(tablernd) do
                           randweight = randweight-v
                           if randweight < 1 then
                                        return k
                           end
             end        
             return nil
end

function IsTableKey(t, findkey)
             for k, v in pairs(t) do
                           if k == findkey then
                                        return true
                           end
             end        
             return false
end

function SetDroneWeaponItem(WeaponCountTable, WeaponTable)
             mainweaponcount = GetTableRand(WeaponCountTable)
             for v = 1, mainweaponcount do
                           WPT = {}
                           for k,v in pairs(WeaponTable) do
                                        if IsTableKey(DroneItemWeaponList, k) == false then
                                                     WPT[k] = v
                                        end
                           end
                           wp = GetTableRand(WPT)
                           if wp ~= nil then
                                        DroneItemWeaponList[wp] = 0
                           end
             end
end

function RouletteDroneItem()

             DroneItemWeaponList = {}
             DroneItemEtcList = {}

             
             -- 주무기 갯수 가중치
             WCountRnd = {}
             WCountRnd[0] = 0
             WCountRnd[1] = 30
             -- 주무기 가중치
             WRnd = {}
             WRnd[23] = 30                                     -- MG43_v2
             WRnd[1702] = 20                                   -- TRG-21
             WRnd[2959] = 30                                   -- GSR-6
			 WRnd[3446] = 20                                   -- AWP_v2
						 
             SetDroneWeaponItem(WCountRnd, WRnd)

             
             if math.random( 0, 99 ) < 80 then                                 -- 회복키트 제공확률
                           DroneItemWeaponList[3447] = math.random(3,5)        -- 회복키트 갯수
             end
             if math.random( 0, 99 ) < 30 then                                 -- 고성능회복키트 제공확률
                           DroneItemWeaponList[3448] = math.random(2,4)        -- 고성능회복키트 갯수
             end
             if math.random( 0, 99 ) < 30 then                                 -- G400 제공확률
                           DroneItemWeaponList[1720] = math.random(2,4)        -- G400 갯수
             end
             if math.random( 0, 99 ) < 80 then                                 -- 방독면 제공확률
                           DroneItemWeaponList[1898] = math.random(1,1)        -- 방독명 갯수 (1로 고정해야함.)
             end
             
             
             DroneItemEtcList[RIT_PRI_AMMO_COMMON] = math.random( 30, 60 )         -- 주무기-일반탄약
             DroneItemEtcList[RIT_PRI_AMMO_SNIPER] = math.random( 4, 8 )           -- 주무기-저격탄약
             DroneItemEtcList[RIT_PRI_AMMO_SHOTGUN] = math.random( 8, 12 )         -- 주무기-샷건탄약
             if math.random( 0, 99 ) < 100 then                                     -- 방탄복 제공확률
                           DroneItemEtcList[RIT_ARMOR] = 100
             end
             if math.random( 0, 99 ) < 100 then                                     -- 방탄복2 제공확률
                           DroneItemEtcList[RIT_ARMOR2] = 500
             end
             
end











-------------------------
