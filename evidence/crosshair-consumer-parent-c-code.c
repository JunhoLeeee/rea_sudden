
void FUN_1806dd700(longlong param_1)

{
  uint uVar1;
  undefined1 uVar2;
  char cVar3;
  int iVar4;
  uint uVar5;
  longlong lVar6;
  longlong lVar7;
  longlong *plVar8;
  
  if (*(int *)(DAT_181a19238 + 0x9cc) == 0x12b1) {
    if (*(int *)(DAT_181a19c68 + 0x4e0) == 0) {
      FUN_1806ddad0();
    }
    if (*(int *)(DAT_181a08d38 + 0xe9e0) != 0xf) {
      return;
    }
    (**(code **)(**(longlong **)(param_1 + 0x4b8) + 8))();
    (**(code **)(*(longlong *)(param_1 + 800) + 0x10))();
    if (*(char *)(param_1 + 0x700) != '\x01') {
                    /* WARNING: Could not recover jumptable at 0x0001806dd874. Too many branches */
                    /* WARNING: Treating indirect jump as call */
      (**(code **)(**(longlong **)(param_1 + 0x6f8) + 8))();
      return;
    }
    lVar6 = FUN_181019290(DAT_181a31610,
                          *(undefined4 *)(*(longlong *)(DAT_181a19c68 + 0x460) + 0x584));
    lVar7 = DAT_181a1b390;
    if (lVar6 == 0) {
      return;
    }
    uVar5 = *(uint *)(DAT_181a1b390 + 0x2c);
    if (uVar5 == 0) {
      FUN_180d61ac0(DAT_181a1b390);
      uVar5 = *(uint *)(lVar7 + 0x2c);
    }
    lVar7 = DAT_181a1b390;
    iVar4 = *(int *)(lVar6 + 0x14);
    uVar1 = *(uint *)(DAT_181a1b390 + 0x28);
    if (uVar1 == 0) {
      FUN_180d61ac0(DAT_181a1b390);
      uVar1 = *(uint *)(lVar7 + 0x28);
    }
    FUN_181018e60(DAT_181a31610,*(undefined4 *)(*(longlong *)(DAT_181a19c68 + 0x460) + 0x584),
                  param_1 + 0x704,(float)uVar1 * 0.5 - (float)*(int *)(lVar6 + 0x10) * 0.5,
                  (float)uVar5 * 0.58 - (float)iVar4);
    return;
  }
  if ((*(longlong *)(DAT_181a19c68 + 0x430) == 0) || (lVar7 = FUN_180d45400(), lVar7 == 0))
  goto LAB_1806dd99e;
  plVar8 = (longlong *)FUN_180d45400(*(undefined8 *)(DAT_181a19c68 + 0x430));
  lVar7 = (**(code **)(*plVar8 + 0x120))(plVar8);
  if (lVar7 == 0) goto LAB_1806dd99e;
  iVar4 = *(int *)(lVar7 + 4);
  if (((-1 < iVar4) && (iVar4 < *(int *)(DAT_181a0e3a0 + 0x26a8))) &&
     (*(int *)(*(longlong *)(*(longlong *)(DAT_181a0e3a0 + 0x26a0) + (longlong)iVar4 * 8) + 0xfec)
      != 0)) {
    if ((*(int *)(DAT_181a19c68 + 0x3a0) < 1) && (*(int *)(DAT_181a19c68 + 0x5ec) == 0)) {
      if (DAT_181a07150 == 0) goto LAB_1806dd92b;
      uVar2 = FUN_1808d1a10();
    }
    else {
      uVar2 = 3;
    }
    FUN_1806dee60(param_1,uVar2,0);
  }
LAB_1806dd92b:
  if (*(int *)(lVar7 + 0xc) == 0x18) {
    plVar8 = (longlong *)FUN_180d45400(*(undefined8 *)(DAT_181a19c68 + 0x430));
    iVar4 = (**(code **)(*plVar8 + 0x2d0))(plVar8);
    if (iVar4 == 0) {
      if (DAT_181a07150 == 0) goto LAB_1806dd97a;
      uVar2 = FUN_1808d1a10();
    }
    else {
      uVar2 = 0x40;
    }
    FUN_1806dee60(param_1,uVar2,0);
  }
LAB_1806dd97a:
  if (((*(uint *)(lVar7 + 0xc) < 0x1b) && ((0x6000890U >> (*(uint *)(lVar7 + 0xc) & 0x1f) & 1) != 0)
      ) && (uVar5 = FUN_180c58920(lVar7), (uVar5 >> 0x10 & 1) == 0)) {
    return;
  }
LAB_1806dd99e:
  iVar4 = FUN_180d1d790(DAT_181a19c68);
  if ((iVar4 != 0) &&
     ((*(int *)(param_1 + 0x4c4) == 0 || (cVar3 = FUN_180d19f30(DAT_181a19c68), cVar3 != '\x01'))))
  {
    return;
  }
  (**(code **)(*DAT_181952a48 + 0x20))(DAT_181952a48,(&DAT_1819f7760)[DAT_1819f77b0]);
                    /* WARNING: Could not recover jumptable at 0x0001806dda0c. Too many branches */
                    /* WARNING: Treating indirect jump as call */
  (**(code **)(*DAT_181952a48 + 0xf8))(DAT_181952a48,param_1 + 0x78,1);
  return;
}

