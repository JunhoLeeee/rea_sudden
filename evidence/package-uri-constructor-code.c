
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined8 * FUN_1402a8e70(undefined8 *param_1,longlong param_2,longlong param_3)

{
  code *pcVar1;
  undefined4 uVar2;
  undefined4 uVar3;
  undefined4 uVar4;
  undefined4 uVar5;
  longlong lVar6;
  undefined4 *puVar7;
  undefined8 uVar8;
  undefined8 uVar9;
  undefined8 *puVar10;
  undefined8 *puVar11;
  void *pvVar12;
  longlong lVar13;
  ulonglong uVar14;
  uint uVar15;
  undefined1 auStack_f8 [32];
  uint local_d8;
  undefined8 *local_d0;
  undefined8 *local_c8;
  undefined8 *local_c0;
  undefined2 local_b8;
  undefined6 uStack_b6;
  undefined8 local_a8;
  ulonglong local_a0;
  undefined2 local_98;
  undefined6 uStack_96;
  undefined8 local_88;
  ulonglong local_80;
  undefined2 local_78;
  undefined6 uStack_76;
  undefined8 local_68;
  ulonglong local_60;
  undefined2 local_58;
  undefined6 uStack_56;
  undefined8 local_48;
  ulonglong local_40;
  ulonglong local_38;
  
  local_38 = DAT_1403eef38 ^ (ulonglong)auStack_f8;
  puVar10 = (undefined8 *)0x0;
  local_d8 = 0;
  local_c0 = param_1;
  if (*(longlong *)(param_2 + 0x10) == 0) {
    puVar7 = (undefined4 *)FUN_1402a0140(param_3,&local_58);
    uVar15 = 1;
  }
  else {
    uVar8 = FUN_1402a0140(param_3,&local_78);
    local_d8 = 2;
    uVar9 = FUN_14029e620(&local_98,param_2,0x2f);
    local_d8 = 6;
    puVar7 = (undefined4 *)FUN_1402a8790(&local_b8,uVar9,uVar8);
    uVar15 = 0xe;
  }
  *param_1 = 0;
  param_1[2] = 0;
  param_1[3] = 0;
  uVar2 = *puVar7;
  uVar3 = puVar7[1];
  uVar4 = puVar7[2];
  uVar5 = puVar7[3];
  *(undefined4 *)param_1 = uVar2;
  *(undefined4 *)((longlong)param_1 + 4) = uVar3;
  *(undefined4 *)(param_1 + 1) = uVar4;
  *(undefined4 *)((longlong)param_1 + 0xc) = uVar5;
  uVar3 = puVar7[5];
  uVar4 = puVar7[6];
  uVar5 = puVar7[7];
  *(undefined4 *)(param_1 + 2) = puVar7[4];
  *(undefined4 *)((longlong)param_1 + 0x14) = uVar3;
  *(undefined4 *)(param_1 + 3) = uVar4;
  *(undefined4 *)((longlong)param_1 + 0x1c) = uVar5;
  *(undefined8 *)(puVar7 + 4) = 0;
  *(undefined8 *)(puVar7 + 6) = 7;
  *(undefined2 *)puVar7 = 0;
  local_d8 = uVar15;
  if ((uVar15 & 8) != 0) {
    uVar15 = uVar15 & 0xfffffff7;
    local_d8 = uVar15;
    if (7 < local_a0) {
      uVar14 = local_a0 * 2 + 2;
      if ((0xfff < uVar14) &&
         (uVar14 = local_a0 * 2 + 0x29,
         0x1f < (CONCAT62(uStack_b6,local_b8) - *(longlong *)(CONCAT62(uStack_b6,local_b8) + -8)) -
                8U)) {
        (*(code *)0x3d7636)();
        pcVar1 = (code *)swi(3);
        puVar10 = (undefined8 *)(*pcVar1)();
        return puVar10;
      }
      thunk_FUN_1402b909d(uVar2,uVar14);
    }
    local_a8 = 0;
    local_a0 = 7;
    local_b8 = 0;
  }
  if ((uVar15 & 4) != 0) {
    uVar15 = uVar15 & 0xfffffffb;
    local_d8 = uVar15;
    if (7 < local_80) {
      uVar14 = local_80 * 2 + 2;
      lVar6 = CONCAT62(uStack_96,local_98);
      lVar13 = lVar6;
      if (0xfff < uVar14) {
        uVar14 = local_80 * 2 + 0x29;
        lVar13 = *(longlong *)(lVar6 + -8);
        if (0x1f < (lVar6 - lVar13) - 8U) {
          (*(code *)0x3d7636)();
          pcVar1 = (code *)swi(3);
          puVar10 = (undefined8 *)(*pcVar1)();
          return puVar10;
        }
      }
      thunk_FUN_1402b909d(lVar13,uVar14);
    }
    local_88 = 0;
    local_80 = 7;
    local_98 = 0;
  }
  if ((uVar15 & 2) != 0) {
    uVar15 = uVar15 & 0xfffffffd;
    local_d8 = uVar15;
    if (7 < local_60) {
      uVar14 = local_60 * 2 + 2;
      lVar6 = CONCAT62(uStack_76,local_78);
      lVar13 = lVar6;
      if (0xfff < uVar14) {
        uVar14 = local_60 * 2 + 0x29;
        lVar13 = *(longlong *)(lVar6 + -8);
        if (0x1f < (lVar6 - lVar13) - 8U) {
          (*(code *)0x3d7636)();
          pcVar1 = (code *)swi(3);
          puVar10 = (undefined8 *)(*pcVar1)();
          return puVar10;
        }
      }
      thunk_FUN_1402b909d(lVar13,uVar14);
    }
    local_68 = 0;
    local_60 = 7;
    local_78 = 0;
  }
  if ((uVar15 & 1) != 0) {
    local_d8 = uVar15 & 0xfffffffe;
    if (7 < local_40) {
      uVar14 = local_40 * 2 + 2;
      lVar6 = CONCAT62(uStack_56,local_58);
      lVar13 = lVar6;
      if (0xfff < uVar14) {
        uVar14 = local_40 * 2 + 0x29;
        lVar13 = *(longlong *)(lVar6 + -8);
        if (0x1f < (lVar6 - lVar13) - 8U) {
          (*(code *)0x3d7636)();
          pcVar1 = (code *)swi(3);
          puVar10 = (undefined8 *)(*pcVar1)();
          return puVar10;
        }
      }
      thunk_FUN_1402b909d(lVar13,uVar14);
    }
    local_48 = 0;
    local_40 = 7;
    local_58 = 0;
  }
  local_d0 = param_1 + 4;
  FUN_1400612f0(local_d0,param_3);
  FUN_1400612f0(param_1 + 8,param_3 + 0x20);
  FUN_1400612f0(param_1 + 0xc,param_3 + 0x40);
  FUN_1400612f0(param_1 + 0x10,param_3 + 0x60);
  FUN_1400612f0(param_1 + 0x14,param_3 + 0x80);
  FUN_1400612f0(param_1 + 0x18,param_3 + 0xa0);
  param_1[0x1c] = 0xffffffffffffffff;
  param_1[0x1d] = 0;
  param_1[0x1e] = 0;
  *(undefined4 *)(param_1 + 0x1f) = 0;
  puVar11 = operator_new(0x30);
  if (puVar11 != (undefined8 *)0x0) {
    *puVar11 = 0;
    puVar11[1] = 0;
    puVar11[2] = 0;
    puVar11[3] = 0;
    puVar11[4] = 0;
    puVar11[5] = 0;
    *puVar11 = 0;
    puVar11[1] = 0;
    puVar11[2] = 0;
    puVar11[3] = 0;
    puVar10 = puVar11 + 4;
    *puVar10 = 0;
    puVar11[5] = 0;
    local_d0 = puVar10;
    local_c8 = puVar11;
    pvVar12 = operator_new(0xa0);
    *(void **)pvVar12 = pvVar12;
    *(void **)((longlong)pvVar12 + 8) = pvVar12;
    *(void **)((longlong)pvVar12 + 0x10) = pvVar12;
    *(undefined2 *)((longlong)pvVar12 + 0x18) = 0x101;
    *puVar10 = pvVar12;
    puVar10 = puVar11;
  }
  param_1[0x20] = puVar10;
  return param_1;
}

