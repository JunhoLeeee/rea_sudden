
void FUN_1806dce40(longlong param_1)

{
  uint uVar1;
  char cVar2;
  undefined1 uVar3;
  int iVar4;
  uint uVar5;
  longlong lVar6;
  longlong lVar7;
  longlong *plVar8;
  undefined **local_38;
  undefined8 local_30;
  char local_28;
  
  if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x39) && (DAT_18194ee00 != 0)) {
    FUN_1803080a0();
  }
  if ((((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x13) && (lVar6 = FUN_1810feba0(), lVar6 != 0)) &&
      (iVar4 = FUN_181100980(lVar6), iVar4 != 0)) &&
     (((iVar4 = FUN_181100aa0(lVar6), iVar4 == 0 && (lVar6 = FUN_181101400(lVar6), lVar6 != 0)) &&
      (*(int *)(lVar6 + 4) - 3U < 2)))) {
    return;
  }
  cVar2 = FUN_1806db1c0(param_1);
  if (cVar2 != '\0') {
    for (plVar8 = (longlong *)(param_1 + 0x768); plVar8 != (longlong *)(param_1 + 0x1308);
        plVar8 = plVar8 + 0x5d) {
      (**(code **)(*plVar8 + 0x68))(plVar8);
    }
  }
  if (*(int *)(DAT_181a19238 + 0x9cc) == 0x12b1) {
    if (*(int *)(DAT_181a19c68 + 0x4e0) == 0) {
      FUN_1806ddad0(param_1);
    }
    if (*(int *)(DAT_181a08d38 + 0xe9e0) != 0xf) {
      return;
    }
    (**(code **)(**(longlong **)(param_1 + 0x4b8) + 8))();
    (**(code **)(*(longlong *)(param_1 + 800) + 0x10))();
    if (*(char *)(param_1 + 0x700) != '\x01') {
      (**(code **)(**(longlong **)(param_1 + 0x6f8) + 8))();
      return;
    }
    lVar7 = FUN_181019290(DAT_181a31610,
                          *(undefined4 *)(*(longlong *)(DAT_181a19c68 + 0x460) + 0x584));
    lVar6 = DAT_181a1b390;
    if (lVar7 == 0) {
      return;
    }
    uVar5 = *(uint *)(DAT_181a1b390 + 0x2c);
    if (uVar5 == 0) {
      FUN_180d61ac0(DAT_181a1b390);
      uVar5 = *(uint *)(lVar6 + 0x2c);
    }
    lVar6 = DAT_181a1b390;
    iVar4 = *(int *)(lVar7 + 0x14);
    uVar1 = *(uint *)(DAT_181a1b390 + 0x28);
    if (uVar1 == 0) {
      FUN_180d61ac0(DAT_181a1b390);
      uVar1 = *(uint *)(lVar6 + 0x28);
    }
    FUN_181018e60(DAT_181a31610,*(undefined4 *)(*(longlong *)(DAT_181a19c68 + 0x460) + 0x584),
                  param_1 + 0x704,(float)uVar1 * 0.5 - (float)*(int *)(lVar7 + 0x10) * 0.5,
                  (float)uVar5 * 0.58 - (float)iVar4);
    return;
  }
  if (*(char *)(param_1 + 0x49a) == '\0') {
    return;
  }
  if ((*(longlong *)(DAT_181a19c68 + 0x430) == 0) || (lVar6 = FUN_180d45400(), lVar6 == 0))
  goto LAB_1806dd320;
  plVar8 = (longlong *)FUN_180d45400(*(undefined8 *)(DAT_181a19c68 + 0x430));
  lVar6 = (**(code **)(*plVar8 + 0x120))(plVar8);
  if (lVar6 == 0) goto LAB_1806dd320;
  iVar4 = *(int *)(lVar6 + 4);
  if (((-1 < iVar4) && (iVar4 < *(int *)(DAT_181a0e3a0 + 0x26a8))) &&
     (*(int *)(*(longlong *)(*(longlong *)(DAT_181a0e3a0 + 0x26a0) + (longlong)iVar4 * 8) + 0xfec)
      != 0)) {
    if ((*(int *)(DAT_181a19c68 + 0x3a0) < 1) && (*(int *)(DAT_181a19c68 + 0x5ec) == 0)) {
      if (DAT_181a07150 == 0) goto LAB_1806dd11a;
      uVar3 = FUN_1808d1a10();
    }
    else {
      uVar3 = 3;
    }
    FUN_1806dee60(param_1,uVar3,0);
  }
LAB_1806dd11a:
  if (*(int *)(lVar6 + 0xc) == 0x18) {
    plVar8 = (longlong *)FUN_180d45400(*(undefined8 *)(DAT_181a19c68 + 0x430));
    iVar4 = (**(code **)(*plVar8 + 0x2d0))(plVar8);
    if (iVar4 == 0) {
      if (DAT_181a07150 == 0) goto LAB_1806dd169;
      uVar3 = FUN_1808d1a10();
    }
    else {
      uVar3 = 0x40;
    }
    FUN_1806dee60(param_1,uVar3,0);
  }
LAB_1806dd169:
  plVar8 = (longlong *)FUN_180d45400(*(undefined8 *)(DAT_181a19c68 + 0x430));
  iVar4 = (**(code **)(*plVar8 + 0x310))(plVar8);
  if (((iVar4 != 0) || (0x1a < *(uint *)(lVar6 + 0xc))) ||
     (((0x6000890U >> (*(uint *)(lVar6 + 0xc) & 0x1f) & 1) == 0 ||
      (uVar5 = FUN_180c58920(lVar6), (uVar5 >> 0x10 & 1) != 0)))) {
LAB_1806dd320:
    (**(code **)(**(longlong **)(param_1 + 0x4b8) + 8))();
    (**(code **)(*(longlong *)(param_1 + 800) + 0x10))();
    local_30 = 0;
    local_38 = &PTR_FUN_1815465b0;
    local_28 = '\x01';
    FUN_180079060(&DAT_1819f7700,&local_38);
    if (local_28 != '\0') {
      if ((*(char *)(param_1 + 0x700) == '\x01') && (DAT_181a19c68 != 0)) {
        lVar7 = FUN_181019290(DAT_181a31610,
                              *(undefined4 *)(*(longlong *)(DAT_181a19c68 + 0x460) + 0x584));
        lVar6 = DAT_181a1b390;
        if (lVar7 != 0) {
          uVar5 = *(uint *)(DAT_181a1b390 + 0x2c);
          if (uVar5 == 0) {
            FUN_180d61ac0(DAT_181a1b390);
            uVar5 = *(uint *)(lVar6 + 0x2c);
          }
          lVar6 = DAT_181a1b390;
          iVar4 = *(int *)(lVar7 + 0x14);
          uVar1 = *(uint *)(DAT_181a1b390 + 0x28);
          if (uVar1 == 0) {
            FUN_180d61ac0(DAT_181a1b390);
            uVar1 = *(uint *)(lVar6 + 0x28);
          }
          FUN_181018e60(DAT_181a31610,*(undefined4 *)(*(longlong *)(DAT_181a19c68 + 0x460) + 0x584),
                        param_1 + 0x704,(float)uVar1 * 0.5 - (float)*(int *)(lVar7 + 0x10) * 0.5,
                        (float)uVar5 * 0.58 - (float)iVar4);
        }
      }
      else {
        (**(code **)(**(longlong **)(param_1 + 0x6f8) + 8))();
      }
    }
    if (((DAT_181a19c68 == 0) || (*(longlong *)(DAT_181a19c68 + 0x430) == 0)) ||
       (iVar4 = FUN_180d48180(), iVar4 == 0)) {
      iVar4 = FUN_180f8c9d0();
      if (((iVar4 == 0x41) && (DAT_181949b00 != 0)) &&
         (cVar2 = FUN_1800b3900(DAT_181949b00,DAT_1819f77b0), cVar2 != '\0')) {
        return;
      }
      iVar4 = FUN_180f8c9d0();
      if (((iVar4 == 0x45) && (DAT_181949c40 != 0)) &&
         (cVar2 = FUN_1800e6d20(DAT_181949c40,DAT_1819f77b0), cVar2 != '\0')) {
        return;
      }
      iVar4 = FUN_180f8c9d0();
      if (((iVar4 == 0x4f) && (DAT_181949bf0 != 0)) &&
         (cVar2 = FUN_1800e1ce0(DAT_181949bf0,DAT_1819f77b0), cVar2 != '\0')) {
        return;
      }
      iVar4 = FUN_180d1d790(DAT_181a19c68);
      if ((iVar4 == 0) || (cVar2 = FUN_1802e33a0(DAT_1819ecfc8), cVar2 != '\0')) {
        (**(code **)(*DAT_181952a48 + 0x20))(DAT_181952a48,(&DAT_1819f7760)[DAT_1819f77b0]);
        (**(code **)(*DAT_181952a48 + 0xf8))(DAT_181952a48,param_1 + 0x78,1);
      }
      lVar6 = param_1 + 0x78;
      if (*(char *)(param_1 + 0x1338) == '\0') {
        return;
      }
      if (*(int *)(param_1 + 0x4c4) == 0) {
        return;
      }
      cVar2 = FUN_180d19f30(DAT_181a19c68);
      if (cVar2 != '\x01') {
        return;
      }
      (**(code **)(*DAT_181952a48 + 0x20))(DAT_181952a48,(&DAT_1819f7760)[DAT_1819f77b0]);
    }
    else {
      (**(code **)(*DAT_181952a48 + 0x20))(DAT_181952a48,*(undefined8 *)(param_1 + 0x630));
      lVar6 = param_1 + 0x638;
    }
    (**(code **)(*DAT_181952a48 + 0xf8))(DAT_181952a48,lVar6,1);
    return;
  }
  if (*(int *)(*(longlong *)(DAT_181a19c68 + 0x460) + 0x158) == 0) {
    iVar4 = FUN_180f8c9d0();
    if ((iVar4 != 0x30) && (iVar4 != 0x31)) goto LAB_1806dd2f2;
    plVar8 = *(longlong **)(param_1 + 0x4b8);
  }
  else {
    (**(code **)(**(longlong **)(param_1 + 0x4b8) + 8))();
    (**(code **)(*(longlong *)(param_1 + 800) + 0x10))();
    if (*(char *)(param_1 + 0x700) == '\x01') {
      lVar7 = FUN_181019290(DAT_181a31610,
                            *(undefined4 *)(*(longlong *)(DAT_181a19c68 + 0x460) + 0x584));
      lVar6 = DAT_181a1b390;
      if (lVar7 != 0) {
        uVar5 = *(uint *)(DAT_181a1b390 + 0x2c);
        if (uVar5 == 0) {
          FUN_180d61ac0(DAT_181a1b390);
          uVar5 = *(uint *)(lVar6 + 0x2c);
        }
        lVar6 = DAT_181a1b390;
        iVar4 = *(int *)(lVar7 + 0x14);
        uVar1 = *(uint *)(DAT_181a1b390 + 0x28);
        if (uVar1 == 0) {
          FUN_180d61ac0(DAT_181a1b390);
          uVar1 = *(uint *)(lVar6 + 0x28);
        }
        FUN_181018e60(DAT_181a31610,*(undefined4 *)(*(longlong *)(DAT_181a19c68 + 0x460) + 0x584),
                      param_1 + 0x704,(float)uVar1 * 0.5 - (float)*(int *)(lVar7 + 0x10) * 0.5,
                      (float)uVar5 * 0.58 - (float)iVar4);
      }
      goto LAB_1806dd2f2;
    }
    plVar8 = *(longlong **)(param_1 + 0x6f8);
  }
  (**(code **)(*plVar8 + 8))();
LAB_1806dd2f2:
  iVar4 = FUN_180f8c9d0();
  if (iVar4 != 0x45) {
    return;
  }
  if (DAT_181949c40 == 0) {
    return;
  }
  FUN_1800e6d20(DAT_181949c40,DAT_1819f77b0);
  return;
}

