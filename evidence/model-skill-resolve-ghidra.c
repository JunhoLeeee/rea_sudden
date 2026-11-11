
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined8 *
FUN_1811d41a0(undefined8 param_1,undefined8 *param_2,undefined4 param_3,undefined4 param_4,
             undefined4 param_5)

{
  char cVar1;
  undefined1 auStack_178 [32];
  undefined4 local_158;
  undefined4 local_150;
  undefined8 local_148;
  char local_140;
  undefined1 local_138 [256];
  ulonglong local_38;
  
  local_38 = DAT_181905cc8 ^ (ulonglong)auStack_178;
  cVar1 = FUN_180d9f8f0(DAT_181a1d4f8,param_4);
  if (cVar1 == '\0') {
    FUN_180d9fd90(DAT_181a1d4f8,param_2,param_4);
  }
  else {
    FUN_1811d4290(param_1,&local_148,param_3,param_4);
    if (local_140 == '\0') {
      memset(local_138,0,0x100);
      local_150 = param_5;
      local_158 = param_4;
      FUN_18017f7e0(local_138,0xffffffffffffffff,
                    "[ReskillModel] Failed to CModelSkillMgr::getMatchedSkillset. serverIndex:%d, modelId:%d, skillIndex:%d"
                    ,param_3);
      (**(code **)(*DAT_181a08d10 + 0x30))(DAT_181a08d10,local_138);
    }
    *param_2 = local_148;
  }
  return param_2;
}

