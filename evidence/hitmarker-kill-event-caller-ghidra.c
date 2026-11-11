
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

void FUN_180cab530(longlong param_1,uint param_2,undefined4 param_3,int param_4,int param_5)

{
  char cVar1;
  undefined4 uVar2;
  int iVar3;
  undefined4 uVar4;
  undefined8 uVar5;
  longlong lVar6;
  longlong lVar7;
  undefined8 *****_Memory;
  undefined1 uVar8;
  undefined1 auStack_d8 [32];
  undefined4 local_b8;
  undefined8 ****local_b0;
  undefined8 local_a8;
  uint local_a0;
  undefined2 *local_98;
  undefined8 local_90;
  undefined4 local_88;
  undefined4 local_80;
  undefined4 local_78 [2];
  undefined8 ****local_70 [2];
  undefined8 local_60;
  ulonglong local_58;
  ulonglong local_50;
  
  local_50 = DAT_181905cc8 ^ (ulonglong)auStack_d8;
  local_78[0] = 0;
  uVar5 = FUN_180c6f820();
  uVar2 = FUN_180c736d0(uVar5);
  lVar6 = FUN_180c8a1e0(param_1 + 0x5e50,uVar2);
  if (lVar6 != 0) {
    if (DAT_1819ecdd0 != 0) {
      FUN_1806df350();
    }
    *(int *)(lVar6 + 0x6c) = *(int *)(lVar6 + 0x6c) + 1;
    FUN_180f37c80(DAT_181a1b3a8,*(undefined1 *)(lVar6 + 0x68));
    if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x20) {
      *(int *)(lVar6 + 0x184) = *(int *)(lVar6 + 0x184) + 1;
      *(undefined4 *)(param_1 + 0x876c) = 1;
    }
    FUN_180f36140(DAT_181a1b3a8,1);
    lVar7 = FUN_180c64490(DAT_181a0e3a0,param_3);
    FUN_180d1bde0(DAT_181a19c68);
    if (lVar7 != 0) {
      local_60 = 0;
      local_58 = 0xf;
      local_70[0] = (undefined8 *****)0x0;
      cVar1 = FUN_180c59f30(lVar7);
      uVar8 = 0;
      if (cVar1 != '\0') {
        cVar1 = FUN_180c58940(lVar7,0x800000);
        if (cVar1 != '\0') {
          iVar3 = FUN_180c58c50(lVar7);
          uVar8 = 0;
          if (iVar3 != param_4) {
            uVar8 = 1;
          }
        }
      }
      uVar2 = FUN_180c58d10(lVar7,param_4);
      local_b8._0_1_ = uVar8;
      uVar4 = FUN_180c64850(DAT_181a0e3a0,param_3,param_5 != 0,param_4);
      local_a8 = local_70;
      local_b0 = (undefined8 ****)local_78;
      local_b8 = CONCAT31(local_b8._1_3_,(char)param_2);
      FUN_180cab7b0(param_1,lVar7,uVar2,uVar4);
      local_b0 = local_70;
      if (0xf < local_58) {
        local_b0 = local_70[0];
      }
      local_88 = 0;
      local_90 = 0;
      local_98 = &DAT_1814675f4;
      local_a0 = local_a0 & 0xffffff00;
      local_a8 = (undefined8 *****)(CONCAT44(local_a8._4_4_,param_2) & 0xffffffff000000ff);
      local_b8 = 0;
      local_80 = param_3;
      FUN_180d7b8c0(DAT_181a1b400,lVar6 + 0x10,(int)*(char *)(lVar6 + 0x68));
      if (0xf < local_58) {
        _Memory = (undefined8 *****)local_70[0];
        if ((0xfff < local_58 + 1) &&
           (_Memory = (undefined8 *****)local_70[0][-1],
           0x1f < (ulonglong)((longlong)local_70[0] + (-8 - (longlong)_Memory)))) {
                    /* WARNING: Subroutine does not return */
          _invalid_parameter_noinfo_noreturn();
        }
        free(_Memory);
      }
    }
    local_98 = (undefined2 *)((ulonglong)local_98 & 0xffffffff00000000);
    local_a0 = 0;
    local_a8 = (undefined8 *****)CONCAT44(local_a8._4_4_,20000);
    local_b0 = (undefined8 ****)CONCAT44(local_b0._4_4_,0xffffffff);
    local_b8 = 0xffffffff;
    FUN_180cb93d0(param_1,param_2 & 0xff,lVar7,local_78[0]);
  }
  return;
}

