
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined8 FUN_140267cd0(int *param_1)

{
  int iVar1;
  code *pcVar2;
  undefined8 *****pppppuVar3;
  undefined8 *****pppppuVar4;
  undefined8 uVar5;
  void *pvVar6;
  undefined8 uVar7;
  ulonglong uVar8;
  longlong lVar9;
  ulonglong uVar10;
  longlong lVar11;
  undefined8 ******ppppppuVar12;
  undefined4 uVar13;
  undefined1 auStack_5b8 [32];
  undefined1 local_598;
  undefined1 local_597;
  undefined1 local_596;
  undefined1 local_595;
  undefined1 local_594;
  undefined1 local_593;
  int local_590;
  int local_58c;
  int local_588;
  undefined8 *local_580;
  undefined8 *****local_578 [2];
  ulonglong local_568;
  ulonglong local_560;
  undefined8 *****local_558 [2];
  ulonglong local_548;
  ulonglong local_540;
  longlong local_c8;
  longlong lStack_c0;
  longlong local_b8;
  undefined4 local_a8 [2];
  longlong *local_a0;
  undefined8 ****local_98;
  undefined8 ****ppppuStack_90;
  ulonglong local_88;
  ulonglong uStack_80;
  undefined8 ****local_78;
  undefined4 uStack_70;
  undefined4 uStack_6c;
  ulonglong local_68;
  ulonglong uStack_60;
  undefined1 local_58;
  undefined1 local_57;
  undefined1 local_56;
  undefined1 local_55;
  undefined1 local_54;
  undefined8 local_50;
  int local_48;
  undefined1 local_44;
  undefined1 local_43;
  int local_40;
  int local_3c;
  undefined8 local_38;
  ulonglong local_30;
  
  local_30 = DAT_1403eef38 ^ (ulonglong)auStack_5b8;
  local_c8 = 0;
  lStack_c0 = 0;
  uVar5 = 0;
  local_b8 = 0;
  uVar13 = 2;
  iVar1 = *param_1;
  if (iVar1 == 0) {
    uVar13 = 0;
  }
  else if ((iVar1 != 2) && (iVar1 == 4)) {
    uVar13 = 4;
  }
  local_568 = 0;
  local_560 = 7;
  local_578[0] = (undefined8 ******)0x0;
  lVar9 = -1;
  lVar11 = -1;
  do {
    lVar11 = lVar11 + 1;
  } while (*(short *)(*(longlong *)(param_1 + 4) + lVar11 * 2) != 0);
  FUN_14002f970(local_578);
  local_548 = 0;
  local_540 = 7;
  local_558[0] = (undefined8 ******)0x0;
  do {
    lVar9 = lVar9 + 1;
  } while (*(short *)(*(longlong *)(param_1 + 2) + lVar9 * 2) != 0);
  FUN_14002f970(local_558,*(longlong *)(param_1 + 2),lVar9);
  uVar8 = local_548;
  pppppuVar4 = local_558[0];
  local_588 = param_1[0xf];
  local_58c = param_1[0xe];
  local_593 = *(undefined1 *)((longlong)param_1 + 0x35);
  local_594 = (undefined1)param_1[0xd];
  local_590 = param_1[0xc];
  local_580 = *(undefined8 **)(param_1 + 8);
  local_595 = (undefined1)param_1[7];
  local_596 = *(undefined1 *)((longlong)param_1 + 0x1b);
  local_597 = *(undefined1 *)((longlong)param_1 + 0x19);
  local_598 = (undefined1)param_1[6];
  local_a8[0] = uVar13;
  local_a0 = &local_c8;
  local_98 = (undefined8 ****)0x0;
  local_88 = 0;
  uStack_80 = 0;
  ppppppuVar12 = local_558;
  if (7 < local_540) {
    ppppppuVar12 = (undefined8 ******)local_558[0];
  }
  if (local_548 < 8) {
    local_98 = *ppppppuVar12;
    ppppuStack_90 = ppppppuVar12[1];
    uStack_80 = 7;
  }
  else {
    uVar10 = local_548 | 7;
    if (0x7ffffffffffffffe < uVar10) {
      uVar10 = 0x7ffffffffffffffe;
    }
    local_98 = (undefined8 ****)FUN_140030400(&local_98,uVar10 + 1);
    FUN_1402b8fa7(local_98,ppppppuVar12,uVar8 * 2 + 2);
    uStack_80 = uVar10;
  }
  uVar10 = local_560;
  pppppuVar3 = local_578[0];
  local_88 = uVar8;
  local_78 = (undefined8 ****)0x0;
  local_68 = 0;
  uStack_60 = 0;
  ppppppuVar12 = local_578;
  if (7 < local_560) {
    ppppppuVar12 = (undefined8 ******)local_578[0];
  }
  if (local_568 < 8) {
    local_78 = *ppppppuVar12;
    uStack_70 = *(undefined4 *)(ppppppuVar12 + 1);
    uStack_6c = *(undefined4 *)((longlong)ppppppuVar12 + 0xc);
    uStack_60 = 7;
  }
  else {
    uVar8 = local_568 | 7;
    if (0x7ffffffffffffffe < uVar8) {
      uVar8 = 0x7ffffffffffffffe;
    }
    local_78 = (undefined8 ****)FUN_140030400(&local_78,uVar8 + 1);
    FUN_1402b8fa7(local_78,ppppppuVar12,local_568 * 2 + 2);
    uStack_60 = uVar8;
  }
  local_68 = local_568;
  local_58 = local_598;
  local_57 = local_597;
  local_56 = local_596;
  local_55 = local_595;
  local_54 = 0;
  local_50 = local_580;
  local_48 = local_590;
  local_44 = local_594;
  local_43 = local_593;
  local_40 = local_58c << 10;
  local_3c = local_588 << 10;
  if (7 < local_540) {
    uVar8 = local_540 * 2 + 2;
    ppppppuVar12 = (undefined8 ******)pppppuVar4;
    if (0xfff < uVar8) {
      uVar8 = local_540 * 2 + 0x29;
      ppppppuVar12 = (undefined8 ******)pppppuVar4[-1];
      if (0x1f < (ulonglong)((longlong)pppppuVar4 + (-8 - (longlong)ppppppuVar12))) {
        (*(code *)0x3d7636)();
        pcVar2 = (code *)swi(3);
        uVar5 = (*pcVar2)();
        return uVar5;
      }
    }
    thunk_FUN_1402b909d(ppppppuVar12,uVar8);
  }
  if (7 < uVar10) {
    lVar9 = uVar10 * 2;
    uVar8 = lVar9 + 2;
    ppppppuVar12 = (undefined8 ******)pppppuVar3;
    if (0xfff < uVar8) {
      uVar8 = lVar9 + 0x29;
      ppppppuVar12 = (undefined8 ******)pppppuVar3[-1];
      if (0x1f < (ulonglong)((longlong)pppppuVar3 + (-8 - (longlong)ppppppuVar12))) {
        (*(code *)0x3d7636)();
        pcVar2 = (code *)swi(3);
        uVar5 = (*pcVar2)();
        return uVar5;
      }
    }
    thunk_FUN_1402b909d(ppppppuVar12,uVar8);
  }
  DAT_14045fd40 = *(undefined1 *)((longlong)param_1 + 0x1a);
  DAT_14045fdf8 = (undefined1)param_1[10];
  if ((char)param_1[10] != '\0') {
    DAT_1403eeff0 = param_1[0xb] << 10;
  }
  pvVar6 = operator_new(0x1c8);
  uVar7 = uVar5;
  local_580 = pvVar6;
  if (pvVar6 != (void *)0x0) {
    FUN_1402b8fb3(pvVar6,0,0x1c8);
    uVar7 = FUN_140275900(pvVar6,local_a8);
  }
  local_38 = 0;
  DAT_14045fde0 = uVar7;
  local_580 = operator_new(0x70);
  if (local_580 != (undefined8 *)0x0) {
    *local_580 = 0;
    local_580[1] = 0;
    local_580[2] = 0;
    local_580[3] = 0;
    local_580[4] = 0;
    local_580[5] = 0;
    local_580[6] = 0;
    local_580[7] = 0;
    local_580[8] = 0;
    local_580[9] = 0;
    local_580[10] = 0;
    local_580[0xb] = 0;
    local_580[0xc] = 0;
    local_580[0xd] = 0;
    uVar5 = FUN_14028ab60(local_580,&local_38);
  }
  DAT_14045fe00 = uVar5;
  FUN_140289110(&DAT_14045fd80);
  FUN_14002f8c0(&local_78);
  FUN_14002f8c0(&local_98);
  lVar11 = lStack_c0;
  lVar9 = local_c8;
  if (local_c8 != 0) {
    for (; lVar9 != lVar11; lVar9 = lVar9 + 0x20) {
      FUN_14002f8c0(lVar9);
    }
    uVar8 = local_b8 - local_c8 & 0xffffffffffffffe0;
    lVar9 = local_c8;
    if (0xfff < uVar8) {
      uVar8 = uVar8 + 0x27;
      lVar9 = *(longlong *)(local_c8 + -8);
      if (0x1f < (local_c8 - lVar9) - 8U) {
        (*(code *)0x3d7636)();
        pcVar2 = (code *)swi(3);
        uVar5 = (*pcVar2)();
        return uVar5;
      }
    }
    thunk_FUN_1402b909d(lVar9,uVar8);
  }
  return 1;
}

