

----------------------------------------------------------------------------------------------------
-- 퍽 타입을 정의 한다. 클라이언트의 EPerkType 정의와 같아야 한다.
----------------------------------------------------------------------------------------------------
PERK_TYPE_NOTHING = 0
PERK_TYPE_ATTACK = 1
PERK_TYPE_SPECIAL = 2
PERK_TYPE_CHANCE = 3



----------------------------------------------------------------------------------------------------
-- 퍽 능력을 정의 한다. 클라이언트의 EPerkAbility 정의와 같아야 한다.
----------------------------------------------------------------------------------------------------
PERK_ABILITY_ATTACK_PRIMARY_TYPE1 = 1		-- 샷건, 특수무기 대미지 증가.
PERK_ABILITY_ATTACK_PRIMARY_TYPE2 = 2		-- 라이플, SMG 대미지 증가.
PERK_ABILITY_ATTACK_PRIMARY_TYPE3 = 3		-- 스나이퍼 대미지 증가.
PERK_ABILITY_ATTACK_SECONDARY = 4		-- 보조무기 대미지 증가.
PERK_ABILITY_ATTACK_MELEE = 5			-- 근접무기 대미지 증가.

PERK_ABILITY_ENCHANT_SUCCESS = 6		-- 강화 성공 확률 증가.
PERK_ABILITY_RARE_REWARD = 7			-- 희귀 보상 등장 확률 증가.
PERK_ABILITY_EVASION_RATE = 8			-- 회피률 증가.
PERK_ABILITY_CRITICAL_PROBABILITY = 9		-- 크리티컬 발생 확률 증가.

PERK_ABILITY_MAX_HP = 10			-- 최대 HP 증가.
PERK_ABILITY_AMMO_CLIP = 11			-- 삽탄 증가.
PERK_ABILITY_CRITICAL_DAMAGE = 12		-- 크리티컬 대미지 증가.
PERK_ABILITY_BUFF_TIME = 13			-- 스킬 시간 증가.

----------------------------------------------------------------------------------------------------
-- 퍽 정보가 저장되어 있는 배열.
----------------------------------------------------------------------------------------------------
Perk_Info = {}

----------------------------------------------------------------------------------------------------
-- 샷건, 특수무기 공격력 퍽 정보가 저장되어 있는 배열.
-- Description1 : 대기실 마우스 오버시 나오는 문구.
-- Description2 : 게임 보상 카드에 나오는 문구.
----------------------------------------------------------------------------------------------------
Perk_Info[1] = {}
Perk_Info[1].Name = "특수총(대미지)"
Perk_Info[1].Type = PERK_TYPE_ATTACK
Perk_Info[1].Ability = PERK_ABILITY_ATTACK_PRIMARY_TYPE1
Perk_Info[1].MaxLevel = 5

Perk_Info[1].UnlockCount1 = 1
Perk_Info[1].Value1 = 25

Perk_Info[1].UnlockCount2 = 4
Perk_Info[1].Value2 = 35

Perk_Info[1].UnlockCount3 = 12
Perk_Info[1].Value3 = 50

Perk_Info[1].UnlockCount4 = 27
Perk_Info[1].Value4 = 70

Perk_Info[1].UnlockCount5 = 57
Perk_Info[1].Value5 = 100

Perk_Info[1].Model = "sa_props/models/Elevator/PERK_BOX.ltb"
Perk_Info[1].Skin1 = "sa_props/skins/Elevator/FUCBOX_RED.dtx"
Perk_Info[1].Skin2 = "sa_props/skins/Elevator/FUKBOX_Panel_3.dtx"
Perk_Info[1].Scale = {0.5, 0.5, 0.5}
Perk_Info[1].Color = {80, 80, 80}
Perk_Info[1].Fx = "Elevator_Perk_Damage"
Perk_Info[1].Icon = "sa_interface2/hud/elevator/perkicon/RG_Icon_SgSpecialDamage.dtx"

Perk_Info[1].Description1 = "특수총 대미지가 %d%% 증가합니다."
Perk_Info[1].Description2 = "특수총 대미지 증가 퍽을 획득합니다."
Perk_Info[1].NameFontSize = 11

----------------------------------------------------------------------------------------------------
-- 돌격소총 공격력 퍽 정보가 저장되어 있는 배열.
----------------------------------------------------------------------------------------------------
Perk_Info[2] = {}
Perk_Info[2].Name = "돌격소총(대미지)"
Perk_Info[2].Type = PERK_TYPE_ATTACK
Perk_Info[2].Ability = PERK_ABILITY_ATTACK_PRIMARY_TYPE2

Perk_Info[2].MaxLevel = 5

Perk_Info[2].UnlockCount1 = 1
Perk_Info[2].Value1 = 25

Perk_Info[2].UnlockCount2 = 4
Perk_Info[2].Value2 = 35

Perk_Info[2].UnlockCount3 = 12
Perk_Info[2].Value3 = 50

Perk_Info[2].UnlockCount4 = 27
Perk_Info[2].Value4 = 70

Perk_Info[2].UnlockCount5 = 57
Perk_Info[2].Value5 = 100

Perk_Info[2].Model = "sa_props/models/Elevator/PERK_BOX.ltb"
Perk_Info[2].Skin1 = "sa_props/skins/Elevator/FUCBOX_RED.dtx"
Perk_Info[2].Skin2 = "sa_props/skins/Elevator/FUKBOX_Panel.dtx"
Perk_Info[2].Scale = {0.5, 0.5, 0.5}
Perk_Info[2].Color = {80, 80, 80}
Perk_Info[2].Fx = "Elevator_Perk_Damage"
Perk_Info[2].Icon = "sa_interface2/hud/elevator/perkicon/RG_Icon_RifleSMGDamage.dtx"
Perk_Info[2].Description1 = "돌격소총 대미지가 %d%% 증가합니다."
Perk_Info[2].Description2 = "돌격소총 대미지 증가 퍽을 획득합니다."
Perk_Info[2].NameFontSize = 11

----------------------------------------------------------------------------------------------------
-- 저격소총 공격력 퍽 정보가 저장되어 있는 배열.
----------------------------------------------------------------------------------------------------
Perk_Info[3] = {}
Perk_Info[3].Name = "저격소총(대미지)"
Perk_Info[3].Type = PERK_TYPE_ATTACK
Perk_Info[3].Ability = PERK_ABILITY_ATTACK_PRIMARY_TYPE3
Perk_Info[3].MaxLevel = 5

Perk_Info[3].UnlockCount1 = 1
Perk_Info[3].Value1 = 25

Perk_Info[3].UnlockCount2 = 4
Perk_Info[3].Value2 = 35

Perk_Info[3].UnlockCount3 = 12
Perk_Info[3].Value3 = 50

Perk_Info[3].UnlockCount4 = 27
Perk_Info[3].Value4 = 70

Perk_Info[3].UnlockCount5 = 57
Perk_Info[3].Value5 = 100

Perk_Info[3].Model = "sa_props/models/Elevator/PERK_BOX.ltb"
Perk_Info[3].Skin1 = "sa_props/skins/Elevator/FUCBOX_RED.dtx"
Perk_Info[3].Skin2 = "sa_props/skins/Elevator/FUKBOX_Panel_2.dtx"
Perk_Info[3].Scale = {0.5, 0.5, 0.5}
Perk_Info[3].Color = {80, 80, 80}
Perk_Info[3].Fx = "Elevator_Perk_Damage"
Perk_Info[3].Icon = "sa_interface2/hud/elevator/perkicon/RG_Icon_SRDamage.dtx"
Perk_Info[3].Description1 = "저격소총 대미지가 %d%% 증가합니다."
Perk_Info[3].Description2 = "저격소총 대미지 증가 퍽을 획득합니다."
Perk_Info[3].NameFontSize = 11

----------------------------------------------------------------------------------------------------
-- 보조무기 공격력 퍽 정보가 저장되어 있는 배열.
----------------------------------------------------------------------------------------------------
Perk_Info[4] = {}
Perk_Info[4].Name = "보조무기(대미지)"
Perk_Info[4].Type = PERK_TYPE_ATTACK
Perk_Info[4].Ability = PERK_ABILITY_ATTACK_SECONDARY
Perk_Info[4].MaxLevel = 5

Perk_Info[4].UnlockCount1 = 1
Perk_Info[4].Value1 = 10

Perk_Info[4].UnlockCount2 = 4
Perk_Info[4].Value2 = 15

Perk_Info[4].UnlockCount3 = 12
Perk_Info[4].Value3 = 25

Perk_Info[4].UnlockCount4 = 27
Perk_Info[4].Value4 = 35

Perk_Info[4].UnlockCount5 = 57
Perk_Info[4].Value5 = 50

Perk_Info[4].Model = "sa_props/models/Elevator/PERK_BOX.ltb"
Perk_Info[4].Skin1 = "sa_props/skins/Elevator/FUCBOX_RED.dtx"
Perk_Info[4].Skin2 = "sa_props/skins/Elevator/FUKBOX_Panel_4.dtx"
Perk_Info[4].Scale = {0.5, 0.5, 0.5}
Perk_Info[4].Color = {80, 80, 80}
Perk_Info[4].Fx = "Elevator_Perk_Damage"
Perk_Info[4].Icon = "sa_interface2/hud/elevator/perkicon/RG_Icon_SecondaryDamage.dtx"
Perk_Info[4].Description1 = "보조무기 대미지가 %d%% 증가합니다."
Perk_Info[4].Description2 = "보조무기 대미지 증가 퍽을 획득합니다."
Perk_Info[4].NameFontSize = 11

----------------------------------------------------------------------------------------------------
-- 근접무기 공격력 퍽 정보가 저장되어 있는 배열.
----------------------------------------------------------------------------------------------------
Perk_Info[5] = {}
Perk_Info[5].Name = "근접무기(대미지)"
Perk_Info[5].Type = PERK_TYPE_ATTACK
Perk_Info[5].Ability = PERK_ABILITY_ATTACK_MELEE
Perk_Info[5].MaxLevel = 5

Perk_Info[5].UnlockCount1 = 1
Perk_Info[5].Value1 = 10

Perk_Info[5].UnlockCount2 = 4
Perk_Info[5].Value2 = 15

Perk_Info[5].UnlockCount3 = 12
Perk_Info[5].Value3 = 25

Perk_Info[5].UnlockCount4 = 27
Perk_Info[5].Value4 = 35

Perk_Info[5].UnlockCount5 = 57
Perk_Info[5].Value5 = 50

Perk_Info[5].Model = "sa_props/models/Elevator/PERK_BOX.ltb"
Perk_Info[5].Skin1 = "sa_props/skins/Elevator/FUCBOX_RED.dtx"
Perk_Info[5].Skin2 = "sa_props/skins/Elevator/FUKBOX_Panel_5.dtx"
Perk_Info[5].Scale = {0.5, 0.5, 0.5}
Perk_Info[5].Color = {80, 80, 80}
Perk_Info[5].Fx = "Elevator_Perk_Damage"
Perk_Info[5].Icon = "sa_interface2/hud/elevator/perkicon/RG_Icon_KnifeDamage.dtx"
Perk_Info[5].Description1 = "근접무기 대미지가 %d%% 증가합니다."
Perk_Info[5].Description2 = "근접무기 대미지 증가 퍽을 획득합니다."
Perk_Info[5].NameFontSize = 11

----------------------------------------------------------------------------------------------------
-- 크리티컬 발생 확률 정보가 저장되어 있는 배열
----------------------------------------------------------------------------------------------------
Perk_Info[6] = {}
Perk_Info[6].Name = "크리티컬 확률"
Perk_Info[6].Type = PERK_TYPE_CHANCE
Perk_Info[6].Ability = PERK_ABILITY_CRITICAL_PROBABILITY
Perk_Info[6].MaxLevel = 5

Perk_Info[6].UnlockCount1 = 1
Perk_Info[6].Value1 = 3

Perk_Info[6].UnlockCount2 = 4
Perk_Info[6].Value2 = 5

Perk_Info[6].UnlockCount3 = 12
Perk_Info[6].Value3 = 10

Perk_Info[6].UnlockCount4 = 27
Perk_Info[6].Value4 = 15

Perk_Info[6].UnlockCount5 = 57
Perk_Info[6].Value5 = 20

Perk_Info[6].Model = "sa_props/models/Elevator/PERK_BOX.ltb"
Perk_Info[6].Skin1 = "sa_props/skins/Elevator/FUKBOX_Green.dtx"
Perk_Info[6].Skin2 = "sa_props/skins/Elevator/Chance_Panel4.dtx"
Perk_Info[6].Scale = {0.5, 0.5, 0.5}
Perk_Info[6].Color = {80, 80, 80}
Perk_Info[6].Fx = "Elevator_Perk_Chance"
Perk_Info[6].Icon = "sa_interface2/hud/elevator/perkicon/RG_Icon_CriticalRate_1.dtx"
Perk_Info[6].Description1 = "크리티컬 발생 확률이 %d%% 증가합니다."
Perk_Info[6].Description2 = "크리티컬 발생 확률 증가 퍽을 획득합니다."
Perk_Info[6].NameFontSize = 11

----------------------------------------------------------------------------------------------------
-- 강화성공률 퍽 정보가 저장되어 있는 배열.
----------------------------------------------------------------------------------------------------
Perk_Info[7] = {}
Perk_Info[7].Name = "강화성공률"
Perk_Info[7].Type = PERK_TYPE_CHANCE
Perk_Info[7].Ability = PERK_ABILITY_ENCHANT_SUCCESS
Perk_Info[7].MaxLevel = 5

Perk_Info[7].UnlockCount1 = 1
Perk_Info[7].Value1 = 3

Perk_Info[7].UnlockCount2 = 4
Perk_Info[7].Value2 = 5

Perk_Info[7].UnlockCount3 = 12
Perk_Info[7].Value3 = 10

Perk_Info[7].UnlockCount4 = 27
Perk_Info[7].Value4 = 15

Perk_Info[7].UnlockCount5 = 57
Perk_Info[7].Value5 = 20

Perk_Info[7].Model = "sa_props/models/Elevator/PERK_BOX.ltb"
Perk_Info[7].Skin1 = "sa_props/skins/Elevator/FUKBOX_Green.dtx"
Perk_Info[7].Skin2 = "sa_props/skins/Elevator/Chance_Panel.dtx"
Perk_Info[7].Scale = {0.5, 0.5, 0.5}
Perk_Info[7].Color = {80, 80, 80}
Perk_Info[7].Fx = "Elevator_Perk_Chance"
Perk_Info[7].Icon = "sa_interface2/hud/elevator/perkicon/RG_Icon_GambleRate.dtx"
Perk_Info[7].Description1 = "강화성공률이 %d%% 증가합니다."
Perk_Info[7].Description2 = "강화성공률 증가 퍽을 획득합니다."
Perk_Info[7].NameFontSize = 11

----------------------------------------------------------------------------------------------------
-- 레어 선택지 등장확률 퍽 정보가 저장되어 있는 배열.
----------------------------------------------------------------------------------------------------
Perk_Info[8] = {}
Perk_Info[8].Name = "레어선택지 등장"
Perk_Info[8].Type = PERK_TYPE_CHANCE
Perk_Info[8].Ability = PERK_ABILITY_RARE_REWARD
Perk_Info[8].MaxLevel = 5

Perk_Info[8].UnlockCount1 = 1
Perk_Info[8].Value1 = 5

Perk_Info[8].UnlockCount2 = 4
Perk_Info[8].Value2 = 10

Perk_Info[8].UnlockCount3 = 12
Perk_Info[8].Value3 = 15

Perk_Info[8].UnlockCount4 = 27
Perk_Info[8].Value4 = 20

Perk_Info[8].UnlockCount5 = 57
Perk_Info[8].Value5 = 25

Perk_Info[8].Model = "sa_props/models/Elevator/PERK_BOX.ltb"
Perk_Info[8].Skin1 = "sa_props/skins/Elevator/FUKBOX_Green.dtx"
Perk_Info[8].Skin2 = "sa_props/skins/Elevator/Chance_Panel2.dtx"
Perk_Info[8].Scale = {0.5, 0.5, 0.5}
Perk_Info[8].Color = {80, 80, 80}
Perk_Info[8].Fx = "Elevator_Perk_Chance"
Perk_Info[8].Icon = "sa_interface2/hud/elevator/perkicon/RG_Icon_RareRewardRate.dtx"
Perk_Info[8].Description1 = "레어선택지 등장확률이 %d%% 증가합니다."
Perk_Info[8].Description2 = "레어선택지 등장확률 증가 퍽을 획득합니다."
Perk_Info[8].NameFontSize = 11

----------------------------------------------------------------------------------------------------
-- 회피율 퍽 정보가 저장되어 있는 배열.
----------------------------------------------------------------------------------------------------
Perk_Info[9] = {}
Perk_Info[9].Name = "회피율"
Perk_Info[9].Type = PERK_TYPE_CHANCE
Perk_Info[9].Ability = PERK_ABILITY_EVASION_RATE
Perk_Info[9].MaxLevel = 5

Perk_Info[9].UnlockCount1 = 1
Perk_Info[9].Value1 = 3

Perk_Info[9].UnlockCount2 = 4
Perk_Info[9].Value2 = 5

Perk_Info[9].UnlockCount3 = 12
Perk_Info[9].Value3 = 10

Perk_Info[9].UnlockCount4 = 27
Perk_Info[9].Value4 = 15

Perk_Info[9].UnlockCount5 = 57
Perk_Info[9].Value5 = 20

Perk_Info[9].Model = "sa_props/models/Elevator/PERK_BOX.ltb"
Perk_Info[9].Skin1 = "sa_props/skins/Elevator/FUKBOX_Green.dtx"
Perk_Info[9].Skin2 = "sa_props/skins/Elevator/Chance_Panel3.dtx"
Perk_Info[9].Scale = {0.5, 0.5, 0.5}
Perk_Info[9].Color = {80, 80, 80}
Perk_Info[9].Fx = "Elevator_Perk_Chance"
Perk_Info[9].Icon = "sa_interface2/hud/elevator/perkicon/RG_Icon_DodgeRG_Icon_Dodge.dtx"
Perk_Info[9].Description1 = "회피율이 %d%% 증가합니다."
Perk_Info[9].Description2 = "회피율 증가 퍽을 획득합니다."
Perk_Info[9].NameFontSize = 11

----------------------------------------------------------------------------------------------------
-- 최대HP 증가 퍽 정보가 저장되어 있는 배열.
----------------------------------------------------------------------------------------------------
Perk_Info[10] = {}
Perk_Info[10].Name = "최대HP증가"
Perk_Info[10].Type = PERK_TYPE_SPECIAL
Perk_Info[10].Ability = PERK_ABILITY_MAX_HP
Perk_Info[10].Value = 300
Perk_Info[10].MaxLevel = 1

Perk_Info[10].UnlockCount1 = 30
Perk_Info[10].Value1 = 300

Perk_Info[10].Model = "sa_props/models/Elevator/PERK_BOX.ltb"
Perk_Info[10].Skin1 = "sa_props/skins/Elevator/FUKBOX_BLUE.dtx"
Perk_Info[10].Skin2 = "sa_props/skins/Elevator/Special_Panel2.dtx"
Perk_Info[10].Scale = {0.5, 0.5, 0.5}
Perk_Info[10].Color = {80, 80, 80}
Perk_Info[10].Fx = "Elevator_Perk_Special"
Perk_Info[10].Icon = "sa_interface2/hud/elevator/perkicon/RG_Icon_HPIncrese.dtx"
Perk_Info[10].Description1 = "최대HP가 %d 증가합니다."
Perk_Info[10].Description2 = "최대HP 증가 퍽을 획득합니다."
Perk_Info[10].NameFontSize = 11

----------------------------------------------------------------------------------------------------
-- 삽탄 증가 퍽 정보가 저장되어 있는 배열.
----------------------------------------------------------------------------------------------------
Perk_Info[11] = {}
Perk_Info[11].Name = "삽탄증가"
Perk_Info[11].Type = PERK_TYPE_SPECIAL
Perk_Info[11].Ability = PERK_ABILITY_AMMO_CLIP
Perk_Info[11].MaxLevel = 1

Perk_Info[11].UnlockCount1 = 30
Perk_Info[11].Value1 = 50

Perk_Info[11].Model = "sa_props/models/Elevator/PERK_BOX.ltb"
Perk_Info[11].Skin1 = "sa_props/skins/Elevator/FUKBOX_BLUE.dtx"
Perk_Info[11].Skin2 = "sa_props/skins/Elevator/Special_Panel3.dtx"
Perk_Info[11].Scale = {0.5, 0.5, 0.5}
Perk_Info[11].Color = {80, 80, 80}
Perk_Info[11].Fx = "Elevator_Perk_Special"
Perk_Info[11].Icon = "sa_interface2/hud/elevator/perkicon/RG_Icon_AmmoIncrese.dtx"
Perk_Info[11].Description1 = "삽탄이 %d%% 증가합니다."
Perk_Info[11].Description2 = "삽탄 증가 퍽을 획득합니다."
Perk_Info[11].NameFontSize = 11

----------------------------------------------------------------------------------------------------
-- 크리티컬 대미지 증가 퍽 정보가 저장되어 있는 배열.
----------------------------------------------------------------------------------------------------
Perk_Info[12] = {}
Perk_Info[12].Name = "크리티컬 배수"
Perk_Info[12].Type = PERK_TYPE_SPECIAL
Perk_Info[12].Ability = PERK_ABILITY_CRITICAL_DAMAGE
Perk_Info[12].MaxLevel = 1

Perk_Info[12].UnlockCount1 = 30
Perk_Info[12].Value1 = 100

Perk_Info[12].Model = "sa_props/models/Elevator/PERK_BOX.ltb"
Perk_Info[12].Skin1 = "sa_props/skins/Elevator/FUKBOX_BLUE.dtx"
Perk_Info[12].Skin2 = "sa_props/skins/Elevator/Special_Panel4.dtx"
Perk_Info[12].Scale = {0.5, 0.5, 0.5}
Perk_Info[12].Color = {80, 80, 80}
Perk_Info[12].Fx = "Elevator_Perk_Special"
Perk_Info[12].Icon = "sa_interface2/hud/elevator/perkicon/RG_Icon_CriticalDamage.dtx"
Perk_Info[12].Description1 = "크리티컬 배수가 %d%% 증가합니다."
Perk_Info[12].Description2 = "크리티컬 배수 증가 퍽을 획득합니다."
Perk_Info[12].NameFontSize = 11

----------------------------------------------------------------------------------------------------
-- 버프시간지속 퍽 정보가 저장되어 있는 배열.
----------------------------------------------------------------------------------------------------
Perk_Info[13] = {}
Perk_Info[13].Name = "버프지속 시간"
Perk_Info[13].Type = PERK_TYPE_SPECIAL
Perk_Info[13].Ability = PERK_ABILITY_BUFF_TIME
Perk_Info[13].MaxLevel = 1

Perk_Info[13].UnlockCount1 = 30
Perk_Info[13].Value1 = 10

Perk_Info[13].Model = "sa_props/models/Elevator/PERK_BOX.ltb"
Perk_Info[13].Skin1 = "sa_props/skins/Elevator/FUKBOX_BLUE.dtx"
Perk_Info[13].Skin2 = "sa_props/skins/Elevator/Special_Panel.dtx"
Perk_Info[13].Scale = {0.5, 0.5, 0.5}
Perk_Info[13].Color = {80, 80, 80}
Perk_Info[13].Fx = "Elevator_Perk_Special"
Perk_Info[13].Icon = "sa_interface2/hud/elevator/perkicon/RG_Icon_BuffTime.dtx"
Perk_Info[13].Description1 = "버프지속 시간이 %d초 증가합니다."
Perk_Info[13].Description2 = "버프지속 시간 증가 퍽을 획득합니다."
Perk_Info[13].NameFontSize = 11

----------------------------------------------------------------------------------------------------
-- 퍽 정보가 저장되어 있는 배열의 갯수를 반환한다. 배열변수 앞에 #을 붙이면 갯수가 반환된다.
----------------------------------------------------------------------------------------------------
function GetPerkInfoCount()

	nCount = #Perk_Info

	return nCount
end



----------------------------------------------------------------------------------------------------
-- 카드 정보가 저장되어 있는 배열.
----------------------------------------------------------------------------------------------------
Card_Info = {}

----------------------------------------------------------------------------------------------------
-- 명중률 카드가 저장되어 있는 배열
----------------------------------------------------------------------------------------------------
Card_Info[1] = {}
Card_Info[1].Name = "돌격소총(명중률)"
Card_Info[1].UnlockFloor = 0
Card_Info[1].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialAcc_1.dtx"
Card_Info[1].Description1 = "돌격소총 명중률이 5% 증가합니다."
Card_Info[1].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[2] = {}
Card_Info[2].Name = "돌격소총(명중률)"
Card_Info[2].UnlockFloor = 0
Card_Info[2].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialAcc_1.dtx"
Card_Info[2].Description1 = "돌격소총 명중률이 10% 증가합니다."
Card_Info[2].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[3] = {}
Card_Info[3].Name = "돌격소총(명중률)"
Card_Info[3].UnlockFloor = 10
Card_Info[3].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialAcc_1.dtx"
Card_Info[3].Description1 = "돌격소총 명중률이 15% 증가합니다."
Card_Info[3].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[4] = {}
Card_Info[4].Name = "돌격소총(명중률)"
Card_Info[4].UnlockFloor = 15
Card_Info[4].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialAcc_1.dtx"
Card_Info[4].Description1 = "돌격소총 명중률이 20% 증가합니다."
Card_Info[4].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[5] = {}
Card_Info[5].Name = "돌격소총(명중률)"
Card_Info[5].UnlockFloor = 20
Card_Info[5].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialAcc_1.dtx"
Card_Info[5].Description1 = "돌격소총 명중률이 25% 증가합니다."
Card_Info[5].Description2 = "41층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[6] = {}
Card_Info[6].Name = "돌격소총(명중률)"
Card_Info[6].UnlockFloor = 25
Card_Info[6].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SgSpecialAcc_1.dtx"
Card_Info[6].Description1 = "돌격소총 명중률이 30% 증가합니다."
Card_Info[6].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 저격소총 명중률 카드가 저장되어 있는 배열
----------------------------------------------------------------------------------------------------
Card_Info[7] = {}
Card_Info[7].Name = "저격소총(명중률)"
Card_Info[7].UnlockFloor = 0
Card_Info[7].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRAccIncrese_1.dtx"
Card_Info[7].Description1 = "저격소총 명중률이 5% 증가합니다."
Card_Info[7].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[8] = {}
Card_Info[8].Name = "저격소총(명중률)"
Card_Info[8].UnlockFloor = 0
Card_Info[8].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRAccIncrese_1.dtx"
Card_Info[8].Description1 = "저격소총 명중률이 10% 증가합니다."
Card_Info[8].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[9] = {}
Card_Info[9].Name = "저격소총(명중률)"
Card_Info[9].UnlockFloor = 10
Card_Info[9].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRAccIncrese_1.dtx"
Card_Info[9].Description1 = "저격소총 명중률이 15% 증가합니다."
Card_Info[9].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[10] = {}
Card_Info[10].Name = "저격소총(명중률)"
Card_Info[10].UnlockFloor = 15
Card_Info[10].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRAccIncrese_1.dtx"
Card_Info[10].Description1 = "저격소총 명중률이 20% 증가합니다."
Card_Info[10].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[11] = {}
Card_Info[11].Name = "저격소총(명중률)"
Card_Info[11].UnlockFloor = 20
Card_Info[11].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRAccIncrese_1.dtx"
Card_Info[11].Description1 = "저격소총 명중률이 25% 증가합니다."
Card_Info[11].Description2 = "41층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[12] = {}
Card_Info[12].Name = "저격소총(명중률)"
Card_Info[12].UnlockFloor = 25
Card_Info[12].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SRAccIncrese_1.dtx"
Card_Info[12].Description1 = "저격소총 명중률이 30% 증가합니다."
Card_Info[12].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 특수총 명중률 카드가 저장되어 있는 배열
----------------------------------------------------------------------------------------------------
Card_Info[13] = {}
Card_Info[13].Name = "특수총(명중률)"
Card_Info[13].UnlockFloor = 0
Card_Info[13].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Card_Info[13].Description1 = "특수총 명중률이 5% 증가합니다."
Card_Info[13].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[14] = {}
Card_Info[14].Name = "특수총(명중률)"
Card_Info[14].UnlockFloor = 0
Card_Info[14].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Card_Info[14].Description1 = "특수총 명중률이 10% 증가합니다."
Card_Info[14].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[15] = {}
Card_Info[15].Name = "특수총(명중률)"
Card_Info[15].UnlockFloor = 10
Card_Info[15].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Card_Info[15].Description1 = "특수총 명중률이 15% 증가합니다."
Card_Info[15].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[16] = {}
Card_Info[16].Name = "특수총(명중률)"
Card_Info[16].UnlockFloor = 15
Card_Info[16].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Card_Info[16].Description1 = "특수총 명중률이 20% 증가합니다."
Card_Info[16].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[17] = {}
Card_Info[17].Name = "특수총(명중률)"
Card_Info[17].UnlockFloor = 20
Card_Info[17].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Card_Info[17].Description1 = "특수총 명중률이 25% 증가합니다."
Card_Info[17].Description2 = "41층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[18] = {}
Card_Info[18].Name = "특수총(명중률)"
Card_Info[18].UnlockFloor = 25
Card_Info[18].Icon = "sa_interface2/hud/elevator/Icon/RG_SgSpecialAcc_1.dtx"
Card_Info[18].Description1 = "특수총 명중률이 30% 증가합니다."
Card_Info[18].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 보조무기 명중률 카드가 저장되어 있는 배열
----------------------------------------------------------------------------------------------------
Card_Info[19] = {}
Card_Info[19].Name = "보조무기(명중률)"
Card_Info[19].UnlockFloor = 0
Card_Info[19].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Card_Info[19].Description1 = "보조무기 명중률이 5% 증가합니다."
Card_Info[19].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[20] = {}
Card_Info[20].Name = "보조무기(명중률)"
Card_Info[20].UnlockFloor = 0
Card_Info[20].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Card_Info[20].Description1 = "보조무기 명중률이 10% 증가합니다."
Card_Info[20].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[21] = {}
Card_Info[21].Name = "보조무기(명중률)"
Card_Info[21].UnlockFloor = 10
Card_Info[21].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Card_Info[21].Description1 = "보조무기 명중률이 15% 증가합니다."
Card_Info[21].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[22] = {}
Card_Info[22].Name = "보조무기(명중률)"
Card_Info[22].UnlockFloor = 15
Card_Info[22].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Card_Info[22].Description1 = "보조무기 명중률이 20% 증가합니다."
Card_Info[22].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[23] = {}
Card_Info[23].Name = "보조무기(명중률)"
Card_Info[23].UnlockFloor = 20
Card_Info[23].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Card_Info[23].Description1 = "보조무기 명중률이 25% 증가합니다."
Card_Info[23].Description2 = "41층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[24] = {}
Card_Info[24].Name = "보조무기(명중률)"
Card_Info[24].UnlockFloor = 25
Card_Info[24].Icon = "sa_interface2/hud/elevator/Icon/RG_SecondaryAcc_1.dtx"
Card_Info[24].Description1 = "보조무기 명중률이 30% 증가합니다."
Card_Info[24].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 근접무기 명중률 카드가 저장되어 있는 배열
----------------------------------------------------------------------------------------------------
Card_Info[25] = {}
Card_Info[25].Name = "근접무기(명중률)"
Card_Info[25].UnlockFloor = 0
Card_Info[25].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Card_Info[25].Description1 = "근접무기 명중률이 5% 증가합니다."
Card_Info[25].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[26] = {}
Card_Info[26].Name = "근접무기(명중률)"
Card_Info[26].UnlockFloor = 0
Card_Info[26].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Card_Info[26].Description1 = "근접무기 명중률이 10% 증가합니다."
Card_Info[26].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[27] = {}
Card_Info[27].Name = "근접무기(명중률)"
Card_Info[27].UnlockFloor = 10
Card_Info[27].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Card_Info[27].Description1 = "근접무기 명중률이 15% 증가합니다."
Card_Info[27].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[28] = {}
Card_Info[28].Name = "근접무기(명중률)"
Card_Info[28].UnlockFloor = 15
Card_Info[28].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Card_Info[28].Description1 = "근접무기 명중률이 20% 증가합니다."
Card_Info[28].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[29] = {}
Card_Info[29].Name = "근접무기(명중률)"
Card_Info[29].UnlockFloor = 20
Card_Info[29].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Card_Info[29].Description1 = "근접무기 명중률이 25% 증가합니다."
Card_Info[29].Description2 = "41층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[30] = {}
Card_Info[30].Name = "근접무기(명중률)"
Card_Info[30].UnlockFloor = 25
Card_Info[30].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAcc_1.dtx"
Card_Info[30].Description1 = "근접무기 명중률이 30% 증가합니다."
Card_Info[30].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 전체 명중률 강화 카드가 저장되어 있는 배열
----------------------------------------------------------------------------------------------------
Card_Info[31] = {}
Card_Info[31].Name = "전체무기(명중률)"
Card_Info[31].UnlockFloor = 0
Card_Info[31].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAccIncrese_1.dtx"
Card_Info[31].Description1 = "전체무기 명중률이 5% 증가합니다."
Card_Info[31].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[32] = {}
Card_Info[32].Name = "전체무기(명중률)"
Card_Info[32].UnlockFloor = 0
Card_Info[32].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAccIncrese_1.dtx"
Card_Info[32].Description1 = "전체무기 명중률이 10% 증가합니다."
Card_Info[32].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[33] = {}
Card_Info[33].Name = "전체무기(명중률)"
Card_Info[33].UnlockFloor = 10
Card_Info[33].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAccIncrese_1.dtx"
Card_Info[33].Description1 = "전체무기 명중률이 15% 증가합니다."
Card_Info[33].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[34] = {}
Card_Info[34].Name = "전체무기(명중률)"
Card_Info[34].UnlockFloor = 15
Card_Info[34].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAccIncrese_1.dtx"
Card_Info[34].Description1 = "전체무기 명중률이 20% 증가합니다."
Card_Info[34].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[35] = {}
Card_Info[35].Name = "전체무기(명중률)"
Card_Info[35].UnlockFloor = 20
Card_Info[35].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAccIncrese_1.dtx"
Card_Info[35].Description1 = "전체무기 명중률이 25% 증가합니다."
Card_Info[35].Description2 = "41층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[36] = {}
Card_Info[36].Name = "전체무기(명중률)"
Card_Info[36].UnlockFloor = 25
Card_Info[36].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAccIncrese_1.dtx"
Card_Info[36].Description1 = "전체무기 명중률이 30% 증가합니다."
Card_Info[36].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 주무기(대미지, 명중률)
----------------------------------------------------------------------------------------------------
Card_Info[31] = {}
Card_Info[31].Name = "주무기(대미지, 명중률)"
Card_Info[31].UnlockFloor = 0
Card_Info[31].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAll_1.dtx"
Card_Info[31].Description1 = "주무기 대미지, 명중률이 5% 증가합니다."
Card_Info[31].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[32] = {}
Card_Info[32].Name = "주무기(대미지, 명중률)"
Card_Info[32].UnlockFloor = 0
Card_Info[32].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAll_1.dtx"
Card_Info[32].Description1 = "주무기 대미지, 명중률이 10% 증가합니다."
Card_Info[32].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[33] = {}
Card_Info[33].Name = "주무기(대미지, 명중률)"
Card_Info[33].UnlockFloor = 10
Card_Info[33].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAll_1.dtx"
Card_Info[33].Description1 = "주무기 대미지, 명중률이 15% 증가합니다."
Card_Info[33].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[34] = {}
Card_Info[34].Name = "주무기(대미지, 명중률)"
Card_Info[34].UnlockFloor = 15
Card_Info[34].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAll_1.dtx"
Card_Info[34].Description1 = "주무기 대미지, 명중률이 20% 증가합니다."
Card_Info[34].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[35] = {}
Card_Info[35].Name = "주무기(대미지, 명중률)"
Card_Info[35].UnlockFloor = 20
Card_Info[35].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAll_1.dtx"
Card_Info[35].Description1 = "주무기 대미지, 명중률이 25% 증가합니다."
Card_Info[35].Description2 = "41층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[36] = {}
Card_Info[36].Name = "주무기(대미지, 명중률)"
Card_Info[36].UnlockFloor = 25
Card_Info[36].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_PrimaryAll_1.dtx"
Card_Info[36].Description1 = "주무기 대미지, 명중률이 30% 증가합니다."
Card_Info[36].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."


----------------------------------------------------------------------------------------------------
-- 보조무기(대미지, 명중률)
----------------------------------------------------------------------------------------------------
Card_Info[37] = {}
Card_Info[37].Name = "보조무기(대미지, 명중률)"
Card_Info[37].UnlockFloor = 0
Card_Info[37].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryAll_1.dtx"
Card_Info[37].Description1 = "보조무기 대미지, 명중률이 5% 증가합니다."
Card_Info[37].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[38] = {}
Card_Info[38].Name = "보조무기(대미지, 명중률)"
Card_Info[38].UnlockFloor = 0
Card_Info[38].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryAll_1.dtx"
Card_Info[38].Description1 = "보조무기 대미지, 명중률이 10% 증가합니다."
Card_Info[38].Description2 = "게임 내에서 획득할 수 있는 카드입니다."
Card_Info[39] = {}
Card_Info[39].Name = "보조무기(대미지, 명중률)"
Card_Info[39].UnlockFloor = 10
Card_Info[39].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryAll_1.dtx"
Card_Info[39].Description1 = "보조무기 대미지, 명중률이 15% 증가합니다."
Card_Info[39].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[40] = {}
Card_Info[40].Name = "보조무기(대미지, 명중률)"
Card_Info[40].UnlockFloor = 15
Card_Info[40].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryAll_1.dtx"
Card_Info[40].Description1 = "보조무기 대미지, 명중률이 20% 증가합니다."
Card_Info[40].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[41] = {}
Card_Info[41].Name = "보조무기(대미지, 명중률)"
Card_Info[41].UnlockFloor = 20
Card_Info[41].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryAll_1.dtx"
Card_Info[41].Description1 = "보조무기 대미지, 명중률이 25% 증가합니다."
Card_Info[41].Description2 = "41층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[42] = {}
Card_Info[42].Name = "보조무기(대미지, 명중률)"
Card_Info[42].UnlockFloor = 25
Card_Info[42].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_SecondaryAll_1.dtx"
Card_Info[42].Description1 = "보조무기 대미지, 명중률이 30% 증가합니다."
Card_Info[42].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."


----------------------------------------------------------------------------------------------------
-- 근접무기(대미지, 명중률)
----------------------------------------------------------------------------------------------------
Card_Info[43] = {}
Card_Info[43].Name = "근접무기(대미지, 명중률)"
Card_Info[43].UnlockFloor = 0
Card_Info[43].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAll_1.dtx"
Card_Info[43].Description1 = "보조무기 대미지, 명중률이 5% 증가합니다."
Card_Info[43].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[44] = {}
Card_Info[44].Name = "근접무기(대미지, 명중률)"
Card_Info[44].UnlockFloor = 0
Card_Info[44].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAll_1.dtx"
Card_Info[44].Description1 = "보조무기 대미지, 명중률이 10% 증가합니다."
Card_Info[44].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[45] = {}
Card_Info[45].Name = "근접무기(대미지, 명중률)"
Card_Info[45].UnlockFloor = 10
Card_Info[45].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAll_1.dtx"
Card_Info[45].Description1 = "보조무기 대미지, 명중률이 15% 증가합니다."
Card_Info[45].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[46] = {}
Card_Info[46].Name = "근접무기(대미지, 명중률)"
Card_Info[46].UnlockFloor = 15
Card_Info[46].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAll_1.dtx"
Card_Info[46].Description1 = "보조무기 대미지, 명중률이 20% 증가합니다."
Card_Info[46].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[47] = {}
Card_Info[47].Name = "근접무기(대미지, 명중률)"
Card_Info[47].UnlockFloor = 20
Card_Info[47].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAll_1.dtx"
Card_Info[47].Description1 = "보조무기 대미지, 명중률이 25% 증가합니다."
Card_Info[47].Description2 = "41층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[48] = {}
Card_Info[48].Name = "근접무기(대미지, 명중률)"
Card_Info[48].UnlockFloor = 25
Card_Info[48].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_KnifeAll_1.dtx"
Card_Info[48].Description1 = "보조무기 대미지, 명중률이 30% 증가합니다."
Card_Info[48].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 예비장탄 증가	
----------------------------------------------------------------------------------------------------
Card_Info[49] = {}
Card_Info[49].Name = "예비장탄"
Card_Info[49].UnlockFloor = 0
Card_Info[49].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_MaxAmmo_1.dtx"
Card_Info[49].Description1 = "예비장탄이 100% 증가합니다."
Card_Info[49].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[50] = {}
Card_Info[50].Name = "예비장탄"
Card_Info[50].UnlockFloor = 25
Card_Info[50].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_MaxAmmo_1.dtx"
Card_Info[50].Description1 = "예비장탄이 200% 증가합니다."
Card_Info[50].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 강화 성공 값 증가
----------------------------------------------------------------------------------------------------
Card_Info[51] = {}
Card_Info[51].Name = "강화 성공 값"
Card_Info[51].UnlockFloor = 0
Card_Info[51].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleValue_1.dtx"
Card_Info[51].Description1 = "강화 성공 값이 5% 증가합니다."
Card_Info[51].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[52] = {}
Card_Info[52].Name = "강화 성공 값"
Card_Info[52].UnlockFloor = 0
Card_Info[52].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleValue_1.dtx"
Card_Info[52].Description1 = "강화 성공 값이 10% 증가합니다."
Card_Info[52].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[53] = {}
Card_Info[53].Name = "강화 성공 값"
Card_Info[53].UnlockFloor = 10
Card_Info[53].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleValue_1.dtx"
Card_Info[53].Description1 = "강화 성공 값이 15% 증가합니다."
Card_Info[53].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[54] = {}
Card_Info[54].Name = "강화 성공 값"
Card_Info[54].UnlockFloor = 15
Card_Info[54].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleValue_1.dtx"
Card_Info[54].Description1 = "강화 성공 값이 20% 증가합니다."
Card_Info[54].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[55] = {}
Card_Info[55].Name = "강화 성공 값"
Card_Info[55].UnlockFloor = 20
Card_Info[55].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleValue_1.dtx"
Card_Info[55].Description1 = "강화 성공 값이 25% 증가합니다."
Card_Info[55].Description2 = "41층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[56] = {}
Card_Info[56].Name = "강화 성공 값"
Card_Info[56].UnlockFloor = 25
Card_Info[56].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleValue_1.dtx"
Card_Info[56].Description1 = "강화 성공 값이 30% 증가합니다."
Card_Info[56].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 크리티컬 발생 확률
----------------------------------------------------------------------------------------------------
Card_Info[57] = {}
Card_Info[57].Name = "크리티컬 발생 확률"
Card_Info[57].UnlockFloor = 0
Card_Info[57].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalRate_1.dtx"
Card_Info[57].Description1 = "크리티컬 발생 확률이 3% 증가합니다."
Card_Info[57].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[58] = {}
Card_Info[58].Name = "크리티컬 발생 확률"
Card_Info[58].UnlockFloor = 0
Card_Info[58].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalRate_1.dtx"
Card_Info[58].Description1 = "크리티컬 발생 확률이 5% 증가합니다."
Card_Info[58].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[59] = {}
Card_Info[59].Name = "크리티컬 발생 확률"
Card_Info[59].UnlockFloor = 10
Card_Info[59].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalRate_1.dtx"
Card_Info[59].Description1 = "크리티컬 발생 확률이 10% 증가합니다."
Card_Info[59].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[60] = {}
Card_Info[60].Name = "크리티컬 발생 확률"
Card_Info[60].UnlockFloor = 15
Card_Info[60].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalRate_1.dtx"
Card_Info[60].Description1 = "크리티컬 발생 확률이 15% 증가합니다."
Card_Info[60].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[61] = {}
Card_Info[61].Name = "크리티컬 발생 확률"
Card_Info[61].UnlockFloor = 20
Card_Info[61].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalRate_1.dtx"
Card_Info[61].Description1 = "크리티컬 발생 확률이 20% 증가합니다."
Card_Info[61].Description2 = "41층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[62] = {}
Card_Info[62].Name = "크리티컬 발생 확률"
Card_Info[62].UnlockFloor = 25
Card_Info[62].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalRate_1.dtx"
Card_Info[62].Description1 = "크리티컬 발생 확률이 30% 증가합니다."
Card_Info[62].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 강화성공률
----------------------------------------------------------------------------------------------------

Card_Info[63] = {}
Card_Info[63].Name = "강화성공률"
Card_Info[63].UnlockFloor = 0
Card_Info[63].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleRate_1.dtx"
Card_Info[63].Description1 = "강화성공률이 3% 증가합니다."
Card_Info[63].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[64] = {}
Card_Info[64].Name = "강화성공률"
Card_Info[64].UnlockFloor = 0
Card_Info[64].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleRate_1.dtx"
Card_Info[64].Description1 = "강화성공률이 5% 증가합니다."
Card_Info[64].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[65] = {}
Card_Info[65].Name = "강화성공률"
Card_Info[65].UnlockFloor = 10
Card_Info[65].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleRate_1.dtx"
Card_Info[65].Description1 = "강화성공률이 10% 증가합니다."
Card_Info[65].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[66] = {}
Card_Info[66].Name = "강화성공률"
Card_Info[66].UnlockFloor = 15
Card_Info[66].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleRate_1.dtx"
Card_Info[66].Description1 = "강화성공률이 15% 증가합니다."
Card_Info[66].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[67] = {}
Card_Info[67].Name = "강화성공률"
Card_Info[67].UnlockFloor = 20
Card_Info[67].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleRate_1.dtx"
Card_Info[67].Description1 = "강화성공률이 20% 증가합니다."
Card_Info[67].Description2 = "41층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[68] = {}
Card_Info[68].Name = "강화성공률"
Card_Info[68].UnlockFloor = 25
Card_Info[68].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_GambleRate_1.dtx"
Card_Info[68].Description1 = "강화성공률이 30% 증가합니다."
Card_Info[68].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 회피율
----------------------------------------------------------------------------------------------------

Card_Info[69] = {}
Card_Info[69].Name = "회피율"
Card_Info[69].UnlockFloor = 0
Card_Info[69].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_Dodge_1.dtx"
Card_Info[69].Description1 = "회피율이 3% 증가합니다."
Card_Info[69].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[70] = {}
Card_Info[70].Name = "회피율"
Card_Info[70].UnlockFloor = 0
Card_Info[70].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_Dodge_1.dtx"
Card_Info[70].Description1 = "회피율이 5% 증가합니다."
Card_Info[70].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[71] = {}
Card_Info[71].Name = "회피율"
Card_Info[71].UnlockFloor = 10
Card_Info[71].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_Dodge_1.dtx"
Card_Info[71].Description1 = "회피율이 10% 증가합니다."
Card_Info[71].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[72] = {}
Card_Info[72].Name = "회피율"
Card_Info[72].UnlockFloor = 15
Card_Info[72].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_Dodge_1.dtx"
Card_Info[72].Description1 = "회피율이 15% 증가합니다."
Card_Info[72].Description2 = "31층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[73] = {}
Card_Info[73].Name = "회피율"
Card_Info[73].UnlockFloor = 20
Card_Info[73].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_Dodge_1.dtx"
Card_Info[73].Description1 = "회피율이 20% 증가합니다."
Card_Info[73].Description2 = "41층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[74] = {}
Card_Info[74].Name = "회피율"
Card_Info[74].UnlockFloor = 25
Card_Info[74].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_Dodge_1.dtx"
Card_Info[74].Description1 = "회피율이 30% 증가합니다."
Card_Info[74].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."


----------------------------------------------------------------------------------------------------
-- 최대HP증가
----------------------------------------------------------------------------------------------------

Card_Info[75] = {}
Card_Info[75].Name = "최대HP증가"
Card_Info[75].UnlockFloor = 0
Card_Info[75].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_HPIncrese_1.dtx"
Card_Info[75].Description1 = "최대HP가 100 증가합니다."
Card_Info[75].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[76] = {}
Card_Info[76].Name = "최대HP증가"
Card_Info[76].UnlockFloor = 15
Card_Info[76].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_HPIncrese_1.dtx"
Card_Info[76].Description1 = "최대HP가 200 증가합니다."
Card_Info[76].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[77] = {}
Card_Info[77].Name = "최대HP증가"
Card_Info[77].UnlockFloor = 25
Card_Info[77].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_HPIncrese_1.dtx"
Card_Info[77].Description1 = "최대HP가 300 증가합니다."
Card_Info[77].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 삽탄증가
----------------------------------------------------------------------------------------------------

Card_Info[78] = {}
Card_Info[78].Name = "삽탄증가"
Card_Info[78].UnlockFloor = 0
Card_Info[78].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_AmmoIncrese_1.dtx"
Card_Info[78].Description1 = "삽탄이 50% 증가합니다."
Card_Info[78].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[79] = {}
Card_Info[79].Name = "삽탄증가"
Card_Info[79].UnlockFloor = 15
Card_Info[79].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_AmmoIncrese_1.dtx"
Card_Info[79].Description1 = "삽탄이 100% 증가합니다."
Card_Info[79].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

Card_Info[80] = {}
Card_Info[80].Name = "삽탄증가"
Card_Info[80].UnlockFloor = 25
Card_Info[80].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_AmmoIncrese_1.dtx"
Card_Info[80].Description1 = "삽탄이 150% 증가합니다."
Card_Info[80].Description2 = "51층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 크리티컬 배수 증가
----------------------------------------------------------------------------------------------------

Card_Info[81] = {}
Card_Info[81].Name = "크리티컬 배수"
Card_Info[81].UnlockFloor = 15
Card_Info[81].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalDamage_1.dtx"
Card_Info[81].Description1 = "크리티컬 배수가 0.25배 증가합니다."
Card_Info[81].Description2 = "게임 내에서 획득할 수 있는 카드입니다."

Card_Info[82] = {}
Card_Info[82].Name = "크리티컬 배수"
Card_Info[82].UnlockFloor = 25
Card_Info[82].Icon = "sa_interface2/hud/elevator/Icon/RG_Icon_CriticalDamage_1.dtx"
Card_Info[82].Description1 = "크리티컬 배수가 0.50배 증가합니다."
Card_Info[82].Description2 = "21층에 도달하면 게임 내에서 해당 카드를 획득할수 있습니다."

----------------------------------------------------------------------------------------------------
-- 카드 정보가 저장되어 있는 배열의 갯수를 반환한다. 배열변수 앞에 #을 붙이면 갯수가 반환된다.
----------------------------------------------------------------------------------------------------
function GetCardInfoCount()

	nCount = #Card_Info

	return nCount
end

















-------------------------