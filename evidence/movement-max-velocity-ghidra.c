
float FUN_180ef1ff0(longlong param_1)

{
  bool bVar1;
  bool bVar2;
  bool bVar3;
  undefined4 uVar4;
  int iVar5;
  uint uVar6;
  float fVar7;
  float fVar8;
  float fVar9;
  float fVar10;
  
  uVar6 = *(uint *)(param_1 + 0x8c) & 0x200;
  if (*(int *)(param_1 + 0x50) == 0) {
    if (*(int *)(param_1 + 0xe8) == 0) {
      if ((0 < *(int *)(DAT_181a19c68 + 0x3a0)) ||
         (bVar3 = false, *(int *)(DAT_181a19c68 + 0x5ec) != 0)) {
        bVar3 = true;
      }
      iVar5 = FUN_180d1ca50();
      if (iVar5 == 0) {
LAB_180ef20ca:
        if ((*(int *)(DAT_181a19c68 + 0x3a0) < 1) || (*(int *)(DAT_181a19c68 + 0x3a0) != 4))
        goto LAB_180ef20dd;
        bVar1 = true;
      }
      else {
        if ((0 < *(int *)(DAT_181a19c68 + 0x3a0)) || (*(int *)(DAT_181a19c68 + 0x5ec) != 0)) {
          bVar3 = false;
          goto LAB_180ef20ca;
        }
LAB_180ef20dd:
        bVar1 = false;
      }
      if ((uVar6 != 0) && ((*(byte *)(param_1 + 0x8c) & 0x20) == 0)) {
        bVar2 = false;
        if (!bVar1) {
          bVar2 = bVar3;
        }
        if ((!bVar2) && (**(int **)(DAT_181a19c68 + 0x458) == 0)) {
          fVar9 = *(float *)(param_1 + 0x100);
          goto LAB_180ef211c;
        }
      }
      fVar9 = *(float *)(param_1 + 0xf8);
    }
    else {
      fVar9 = *(float *)(param_1 + 0x104);
      if (uVar6 == 0) {
        fVar9 = fVar9 * 0.5;
      }
    }
  }
  else {
    fVar9 = *(float *)(param_1 + 0xf4);
    if (uVar6 == 0) {
      fVar9 = fVar9 * 0.5;
    }
    if ((*(uint *)(param_1 + 0x8c) & 0x20) != 0) {
      fVar9 = fVar9 / 3.0;
    }
  }
LAB_180ef211c:
  if (((*(char *)(DAT_181a19c68 + 0x540) == '\x01') || (*(char *)(DAT_181a19c68 + 0x540) == '\x04'))
     && (*(float *)(param_1 + 0xf8) < fVar9)) {
    fVar9 = fVar9 - (fVar9 - *(float *)(param_1 + 0xf8));
  }
  fVar10 = 0.0;
  fVar7 = (float)FUN_1802cb0c0(param_1 + 0x450);
  fVar8 = fVar10;
  if (fVar7 != 0.0) {
    fVar8 = (float)FUN_180d66ae0("DamageMovePenalty",0x3f000000);
    iVar5 = *(int *)(DAT_181a08d38 + 0xe9e0);
    if ((iVar5 == 0x13) && (0.0 < *(float *)(param_1 + 0xb28))) {
      fVar8 = *(float *)(param_1 + 0xb28);
    }
    if (((DAT_1819ecee0 != 0) && (*(int *)(DAT_1819ecee0 + 0xcf8) != 0)) &&
       (0.0 < *(float *)(param_1 + 0xb28))) {
      fVar8 = *(float *)(param_1 + 0xb28);
    }
    if (iVar5 != 0x16) {
      if (((iVar5 - 0x22U < 0x23) &&
          ((0x400002001U >> ((ulonglong)(iVar5 - 0x22U) & 0x3f) & 1) != 0)) &&
         (0.0 < *(float *)(param_1 + 0xb28))) {
        fVar8 = *(float *)(param_1 + 0xb28);
      }
      if (iVar5 == 0xd) {
        uVar4 = FUN_1807805e0(DAT_1819fcb40);
        iVar5 = FUN_180f8c510(uVar4);
        if (iVar5 != 0) {
          fVar10 = (float)FUN_1807807d0(DAT_1819fcb40);
          fVar10 = fVar10 * fVar8;
          *(undefined1 *)(DAT_1819fcb40 + 0x30) = 1;
        }
        if (fVar8 <= fVar10) {
          fVar8 = fVar10;
        }
        goto LAB_180ef2242;
      }
    }
    fVar8 = *(float *)(param_1 + 0xb28);
    if (fVar8 <= 0.0) {
      fVar8 = 0.0;
    }
  }
LAB_180ef2242:
  return (1.0 - fVar8) * fVar9;
}

