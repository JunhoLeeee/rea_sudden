
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined8 FUN_180ef0aa0(undefined8 *param_1)

{
  longlong lVar1;
  DWORD DVar2;
  undefined8 *puVar3;
  undefined8 uVar4;
  undefined4 uVar5;
  undefined1 auStack_258 [32];
  char *local_238;
  undefined8 *local_228;
  char local_218 [256];
  undefined1 local_118 [256];
  ulonglong local_18;
  
  local_18 = DAT_181905cc8 ^ (ulonglong)auStack_258;
  DAT_181a2b600 = param_1;
  *(int *)((longlong)param_1 + 0xac4) = (int)param_1;
  *param_1 = 0;
  param_1[1] = 0;
  puVar3 = (undefined8 *)FUN_181387aac(0x10);
  local_228 = puVar3;
  if (puVar3 != (undefined8 *)0x0) {
    *puVar3 = 0;
    *(undefined4 *)(puVar3 + 1) = 0;
    local_228 = (undefined8 *)FUN_181387aac(0xc);
    *puVar3 = local_228;
    *local_228 = 0;
    *(undefined4 *)(local_228 + 1) = 0;
    uVar4 = FUN_18206ccc4();
    return uVar4;
  }
  param_1[0x22] = 0;
  puVar3 = _DAT_00000000;
  DVar2 = GetCurrentThreadId();
  if (DVar2 == _DAT_00000008) {
    *_DAT_00000000 = 0;
    *(undefined4 *)(puVar3 + 1) = 0;
  }
  uVar5 = FUN_180f031e0(0);
  *(undefined4 *)(param_1 + 0x1f) = uVar5;
  uVar5 = FUN_180f031e0(1);
  *(undefined4 *)(param_1 + 0x20) = uVar5;
  uVar5 = FUN_180f031e0(2);
  *(undefined4 *)((longlong)param_1 + 0xf4) = uVar5;
  uVar5 = FUN_180f031e0(3);
  *(undefined4 *)(param_1 + 0x17) = uVar5;
  uVar5 = FUN_180f031e0(4);
  *(undefined4 *)((longlong)param_1 + 0xbc) = uVar5;
  uVar5 = FUN_180f031e0(5);
  *(undefined4 *)(param_1 + 0x18) = uVar5;
  uVar5 = FUN_180f031e0(6);
  *(undefined4 *)((longlong)param_1 + 0x104) = uVar5;
  FUN_180ef9550(param_1);
  *(undefined4 *)((longlong)param_1 + 0xdc) = 1;
  *(undefined8 *)((longlong)param_1 + 300) = 0;
  *(uint *)((longlong)param_1 + 0x8c) = *(uint *)((longlong)param_1 + 0x8c) & 0xfffff7ff;
  lVar1 = DAT_181952a40;
  _DAT_181a2b618 = "HeartBeatOnSpeed";
  DAT_181a2b608 = (**(code **)(DAT_181952a40 + 0x228))("HeartBeatOnSpeed");
  if (DAT_181a2b608 == 0) {
    local_238 = "0.305f";
    FUN_1802ccc20(local_218,0x100,"\"%s\" \"%s\"","HeartBeatOnSpeed");
    (**(code **)(lVar1 + 0x3d0))(local_218);
    DAT_181a2b608 = (**(code **)(lVar1 + 0x228))("HeartBeatOnSpeed");
    if (DAT_181a2b608 != 0) goto LAB_180ef0c61;
  }
  else {
LAB_180ef0c61:
    DAT_181a2b610 = lVar1;
  }
  *(undefined2 *)((longlong)param_1 + 0xad4) = 0;
  param_1[0x15b] = 0;
  param_1[0x15c] = 0;
  *(undefined4 *)(param_1 + 0x15d) = 0;
  param_1[2] = 0;
  param_1[3] = 0;
  lVar1 = DAT_181952a40;
  if (DAT_181a2b628 == 0) {
    DAT_181a2b630 = "walkaccmul";
    FUN_1802ccc20(local_218,0x80,&DAT_1814a5a28,0x3ff0000000000000);
    _DAT_181a2b620 = (**(code **)(lVar1 + 0x228))("walkaccmul");
    if (_DAT_181a2b620 == 0) {
      local_238 = local_218;
      FUN_1802ccc20(local_118,0x100,"\"%s\" \"%s\"","walkaccmul");
      (**(code **)(lVar1 + 0x3d0))(local_118);
      _DAT_181a2b620 = (**(code **)(lVar1 + 0x228))("walkaccmul");
      if (_DAT_181a2b620 == 0) goto LAB_180ef0d3e;
    }
    DAT_181a2b628 = lVar1;
  }
LAB_180ef0d3e:
  lVar1 = DAT_181952a40;
  if (DAT_181a2b640 == 0) {
    _DAT_181a2b648 = "WindRedesign";
    FUN_1802ccc20(local_218,0x80,&DAT_1814a5a28,0x3ff0000000000000);
    DAT_181a2b638 = (**(code **)(lVar1 + 0x228))("WindRedesign");
    if (DAT_181a2b638 == 0) {
      local_238 = local_218;
      FUN_1802ccc20(local_118,0x100,"\"%s\" \"%s\"","WindRedesign");
      (**(code **)(lVar1 + 0x3d0))(local_118);
      DAT_181a2b638 = (**(code **)(lVar1 + 0x228))("WindRedesign");
      if (DAT_181a2b638 == 0) {
        return 1;
      }
    }
    DAT_181a2b640 = lVar1;
  }
  return 1;
}

