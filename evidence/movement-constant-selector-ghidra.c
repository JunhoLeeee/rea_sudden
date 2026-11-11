
float FUN_180f031e0(undefined4 param_1)

{
  float fVar1;
  undefined1 local_58 [4];
  undefined1 local_54 [4];
  undefined1 local_50 [4];
  undefined1 local_4c [4];
  undefined1 local_48 [4];
  undefined4 local_44;
  float fStack_40;
  float fStack_3c;
  float fStack_38;
  float fStack_34;
  float fStack_30;
  float fStack_2c;
  float fStack_28;
  float fStack_24;
  float fStack_20;
  float fStack_1c;
  float fStack_18;
  float fStack_14;
  float fStack_10;
  float local_c;
  
  FUN_180f038e0(local_4c,0x42b40000);
  FUN_180f038e0(local_48,0x41200000);
  FUN_180f038e0(local_50,0x42480000);
  FUN_180f038f0(local_54);
  FUN_180f038f0(local_58);
  local_44 = param_1;
  switch(param_1) {
  case 0:
    func_0x000180f03ab0(local_54,local_50);
    fStack_40 = (float)func_0x000180f03ad0(local_54);
    fVar1 = (float)func_0x000180f03ad0(local_4c);
    FUN_180f03ac0(local_54,fStack_40 + fVar1);
    fVar1 = (float)func_0x000180f03ad0(local_48);
    FUN_180f03ac0(local_58,fVar1 * 4.0);
    fStack_3c = (float)func_0x000180f03ad0(local_54);
    fStack_38 = (float)func_0x000180f03ad0(local_58);
    fStack_38 = fStack_3c + fStack_38;
    FUN_180f039f0(local_58);
    FUN_180f039f0(local_54);
    FUN_180f039f0(local_50);
    FUN_180f039f0(local_48);
    FUN_180f039f0(local_4c);
    local_c = fStack_38;
    break;
  case 1:
    fVar1 = (float)func_0x000180f03ad0(local_4c);
    FUN_180f03ac0(local_58,fVar1 * 3.0);
    fStack_34 = (float)func_0x000180f03ad0(local_58);
    fVar1 = (float)func_0x000180f03ad0(local_50);
    FUN_180f03ac0(local_58,fStack_34 + fVar1);
    fStack_30 = (float)func_0x000180f03ad0(local_58);
    fStack_30 = fStack_30 + 10.0;
    FUN_180f039f0(local_58);
    FUN_180f039f0(local_54);
    FUN_180f039f0(local_50);
    FUN_180f039f0(local_48);
    FUN_180f039f0(local_4c);
    local_c = fStack_30;
    break;
  case 2:
    FUN_180f03ac0(local_58,0x40a00000);
    fStack_2c = (float)func_0x000180f03ad0(local_58);
    fVar1 = (float)func_0x000180f03ad0(local_50);
    FUN_180f03ac0(local_58,fStack_2c * fVar1);
    fStack_28 = (float)func_0x000180f03ad0(local_58);
    FUN_180f039f0(local_58);
    FUN_180f039f0(local_54);
    FUN_180f039f0(local_50);
    FUN_180f039f0(local_48);
    FUN_180f039f0(local_4c);
    local_c = fStack_28;
    break;
  case 3:
  case 4:
    func_0x000180f03ab0(local_54,local_4c);
    fVar1 = (float)func_0x000180f03ad0(local_54);
    FUN_180f03ac0(local_54,fVar1 * 4.0);
    fStack_24 = (float)func_0x000180f03ad0(local_54);
    fVar1 = (float)func_0x000180f03ad0(local_50);
    FUN_180f03ac0(local_54,fStack_24 + fVar1);
    fStack_20 = (float)func_0x000180f03ad0(local_54);
    fVar1 = (float)func_0x000180f03ad0(local_50);
    FUN_180f03ac0(local_54,fStack_20 + fVar1);
    fVar1 = (float)func_0x000180f03ad0(local_50);
    FUN_180f03ac0(local_58,fVar1 * 2.0);
    fStack_1c = (float)func_0x000180f03ad0(local_54);
    fVar1 = (float)func_0x000180f03ad0(local_58);
    fStack_18 = fStack_1c + fVar1 + 7.0;
    FUN_180f039f0(local_58);
    FUN_180f039f0(local_54);
    FUN_180f039f0(local_50);
    FUN_180f039f0(local_48);
    FUN_180f039f0(local_4c);
    local_c = fStack_18;
    break;
  default:
    local_c = 0.0;
    FUN_180f039f0(local_58);
    FUN_180f039f0(local_54);
    FUN_180f039f0(local_50);
    FUN_180f039f0(local_48);
    FUN_180f039f0(local_4c);
    break;
  case 6:
    fStack_14 = (float)func_0x000180f03ad0(local_50);
    fVar1 = (float)func_0x000180f03ad0(local_50);
    FUN_180f03ac0(local_58,fStack_14 + fVar1);
    fVar1 = (float)func_0x000180f03ad0(local_58);
    FUN_180f03ac0(local_58,fVar1 * 3.0);
    fStack_10 = (float)func_0x000180f03ad0(local_58);
    FUN_180f039f0(local_58);
    FUN_180f039f0(local_54);
    FUN_180f039f0(local_50);
    FUN_180f039f0(local_48);
    FUN_180f039f0(local_4c);
    local_c = fStack_10;
  }
  return local_c;
}

