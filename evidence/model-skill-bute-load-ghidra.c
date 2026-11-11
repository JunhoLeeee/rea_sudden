
void FUN_180d9fef0(longlong param_1,undefined8 param_2)

{
  char cVar1;
  int iVar2;
  undefined4 uVar3;
  
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"ShowKillerHP",0);
  FUN_180da03b0(param_1,param_2,iVar2 != 0);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"ShowDamageInfo",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 2);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"FourthRadio",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 3);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"ShowTarget",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 4);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"FootStepAmplify",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 5);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"ShowObserverList",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 6);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"ShowAttackEffect",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 7);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"ShowShoulderFX",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 8);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"Emotion",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 9);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"bGhostEffect",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0xb);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"TeamFootStepMute",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0xf);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"MuteSelfFootStep",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0x10);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"ShowHitMarker",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0x12);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"GrenadeWarning",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0x13);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"MinimapUpgrade",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0x14);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"ShowCustomTarget",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0x15);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"ShowTargetHP",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0x16);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"RandomCustomVoice",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0x1b);
  cVar1 = FUN_181327c30(param_1 + 0x10,&DAT_181a1d510,"EmotionSndCustum",0);
  FUN_180da03b0(param_1,param_2,-(cVar1 != '\0') & 0x1c);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"RenderClanMark",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0x1e);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"AdditionalWalkingAcceleration",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0x1f);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"ShowRemainInfo",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0x20);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"SkinChangeable",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0x17);
  iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"HitDirAlert",0);
  FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0x19);
  cVar1 = FUN_181327c30(param_1 + 0x10,&DAT_181a1d510,"JumpSound",1);
  uVar3 = 0;
  if (cVar1 == '\0') {
    uVar3 = 0xe;
  }
  FUN_180da03b0(param_1,param_2,uVar3);
  return;
}

