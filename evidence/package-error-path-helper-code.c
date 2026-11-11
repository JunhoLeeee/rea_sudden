
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

void FUN_1400b1740(undefined8 param_1,longlong param_2)

{
  code *pcVar1;
  undefined4 uVar2;
  int iVar3;
  undefined8 uVar4;
  undefined8 ****ppppuVar5;
  int extraout_var;
  ulonglong uVar6;
  ulonglong uVar7;
  undefined1 auStack_b8 [32];
  int local_98;
  undefined4 local_88;
  undefined8 ***local_80;
  undefined8 ***local_78 [2];
  ulonglong local_68;
  ulonglong local_60;
  undefined1 local_58 [8];
  undefined8 local_50;
  ulonglong local_38;
  
  local_38 = DAT_1403eef38 ^ (ulonglong)auStack_b8;
  local_88 = 0;
  local_80 = local_78;
  uVar7 = 0xffffffffffffffff;
  do {
    uVar7 = uVar7 + 1;
  } while (*(char *)(param_2 + uVar7) != '\0');
  uVar2 = FUN_140262030();
  local_78[0] = (undefined8 ****)0x0;
  local_68 = 0;
  local_60 = 7;
  local_88 = 4;
  if (uVar7 != 0) {
    if (0x7fffffff < uVar7) {
                    /* WARNING: Subroutine does not return */
      FUN_1400637f0(0x16);
    }
    local_98 = 0;
    uVar4 = __std_fs_convert_narrow_to_wide(uVar2,param_2,uVar7 & 0xffffffff,0);
    iVar3 = (int)((ulonglong)uVar4 >> 0x20);
    if (iVar3 != 0) {
                    /* WARNING: Subroutine does not return */
      FUN_140063830(iVar3);
    }
    uVar6 = (ulonglong)(int)uVar4;
    if (local_68 < uVar6) {
      FUN_140063a80(local_78,uVar6 - local_68,0);
    }
    else {
      ppppuVar5 = local_78;
      if (7 < local_60) {
        ppppuVar5 = (undefined8 ****)local_78[0];
      }
      local_68 = uVar6;
      *(undefined2 *)((longlong)ppppuVar5 + uVar6 * 2) = 0;
    }
    ppppuVar5 = local_78;
    if (7 < local_60) {
      ppppuVar5 = (undefined8 ****)local_78[0];
    }
    local_98 = (int)uVar4;
    __std_fs_convert_narrow_to_wide(uVar2,param_2,uVar7 & 0xffffffff,ppppuVar5);
    if (extraout_var != 0) {
                    /* WARNING: Subroutine does not return */
      FUN_140063830(extraout_var);
    }
  }
  ppppuVar5 = local_78;
  if (7 < local_60) {
    ppppuVar5 = (undefined8 ****)local_78[0];
  }
  iVar3 = __std_fs_get_stats(ppppuVar5,local_58,9,0xffffffff);
  uVar4 = 0xffffffffffffffff;
  if (iVar3 == 0) {
    uVar4 = local_50;
  }
  if (7 < local_60) {
    uVar7 = local_60 * 2 + 2;
    ppppuVar5 = (undefined8 ****)local_78[0];
    if (0xfff < uVar7) {
      uVar7 = local_60 * 2 + 0x29;
      ppppuVar5 = (undefined8 ****)local_78[0][-1];
      if (0x1f < (ulonglong)((longlong)local_78[0] + (-8 - (longlong)ppppuVar5))) {
        (*(code *)0x3d7636)();
        pcVar1 = (code *)swi(3);
        (*pcVar1)();
        return;
      }
    }
    thunk_FUN_1402b909d(ppppuVar5,uVar7);
  }
  if (iVar3 == 0) {
    FUN_1400bfea0("PKG File Info ( %s : %d )",param_2,uVar4);
  }
  else {
    (**(code **)(DAT_1403d9010 + 0x10))(&DAT_1403d9010,local_78,iVar3);
    ppppuVar5 = local_78;
    if (0xf < local_60) {
      ppppuVar5 = (undefined8 ****)local_78[0];
    }
    FUN_1400bfea0("PKG File Error Message ( %s : %s )",param_2,ppppuVar5);
    if (0xf < local_60) {
      uVar7 = local_60 + 1;
      ppppuVar5 = (undefined8 ****)local_78[0];
      if (0xfff < uVar7) {
        uVar7 = local_60 + 0x28;
        ppppuVar5 = (undefined8 ****)local_78[0][-1];
        if (0x1f < (ulonglong)((longlong)local_78[0] + (-8 - (longlong)ppppuVar5))) {
          (*(code *)0x3d7636)();
          pcVar1 = (code *)swi(3);
          (*pcVar1)();
          return;
        }
      }
      thunk_FUN_1402b909d(ppppuVar5,uVar7);
    }
  }
  return;
}

