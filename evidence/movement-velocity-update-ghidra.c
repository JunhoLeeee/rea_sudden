
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_180efb510(longlong param_1)

{
  int *piVar1;
  undefined8 *puVar2;
  float *pfVar3;
  undefined4 *puVar4;
  bool bVar5;
  char cVar6;
  byte bVar7;
  SHORT SVar8;
  int iVar9;
  undefined4 uVar10;
  uint uVar11;
  longlong lVar12;
  longlong *plVar13;
  longlong lVar14;
  undefined8 uVar15;
  float *pfVar16;
  uint uVar17;
  ulonglong uVar18;
  uint uVar19;
  uint uVar20;
  uint uVar21;
  bool bVar22;
  float fVar23;
  float fVar24;
  float fVar25;
  float fVar26;
  float fVar27;
  float fVar28;
  float fVar29;
  float fVar30;
  float fVar31;
  float fVar32;
  float fVar33;
  undefined1 auStack_548 [32];
  undefined8 *local_528;
  float local_518;
  float fStack_514;
  float local_510;
  undefined8 local_508;
  float local_500;
  float local_4f8;
  float fStack_4f4;
  float local_4f0;
  float local_4e8;
  float local_4e0;
  float local_4dc;
  float local_4d8;
  float local_4d0;
  float local_4cc;
  float local_4c8;
  float local_4c4;
  float local_4c0;
  float local_4bc;
  float local_4b8 [2];
  undefined **local_4b0;
  undefined8 local_4a8;
  char local_4a0;
  undefined8 local_498;
  float fStack_490;
  float fStack_48c;
  float local_488;
  float fStack_484;
  float fStack_480;
  float fStack_47c;
  undefined1 local_478 [60];
  float local_43c;
  float local_438;
  float local_400;
  ulonglong local_d8;
  
  local_d8 = DAT_181905cc8 ^ (ulonglong)auStack_548;
  local_4e8 = 0.7;
  local_4c4 = 0.65;
  if ((*(uint *)(DAT_181a08d38 + 0xe9e0) < 0x37) &&
     ((0x40000000402000U >> ((longlong)(int)*(uint *)(DAT_181a08d38 + 0xe9e0) & 0x3fU) & 1) != 0)) {
    local_4e8 = 1.0;
    local_4c4 = 1.0;
  }
  if (*(int *)(param_1 + 0xe8) != 0) {
    local_4e8 = 1.0;
    local_4c4 = 1.0;
  }
  (**(code **)(*DAT_181952a40 + 0x110))();
  local_518 = 0.0;
  fStack_514 = 0.0;
  local_510 = 0.0;
  (**(code **)(*DAT_181a08d00 + 0x88))(DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),&local_518);
  local_498 = *(undefined8 *)(param_1 + 0xa8);
  fStack_490 = *(float *)(param_1 + 0xb0);
  if ((((DAT_181a2b640 != (longlong *)0x0) && (DAT_181a2b638 != 0)) &&
      (fVar23 = (float)(**(code **)(*DAT_181a2b640 + 0xf8))(), fVar33 = fStack_490, 0.0 < fVar23))
     && ((fVar23 = (float)local_498, (float)local_498 != 0.0 || (fStack_490 != 0.0)))) {
    local_508._0_4_ = 0.0;
    local_508 = 0;
    local_500 = 0.0;
    fVar25 = 0.0;
    if ((DAT_181a08d00 != (longlong *)0x0) && (*(longlong *)(param_1 + 0x20) != 0)) {
      (**(code **)(*DAT_181a08d00 + 0x60))(DAT_181a08d00,*(longlong *)(param_1 + 0x20),&local_508);
      fVar25 = local_500;
    }
    fVar23 = (float)local_508 - fVar23;
    local_508 = CONCAT44(local_508._4_4_,fVar23);
    local_500 = fVar25 - fVar33;
    if ((DAT_181a08d00 != (longlong *)0x0) && (*(longlong *)(param_1 + 0x20) != 0)) {
      (**(code **)(*DAT_181a08d00 + 0x68))(fVar23,*(longlong *)(param_1 + 0x20),&local_508);
    }
  }
  FUN_180efea00(param_1);
  fVar33 = 3000.0;
  if (((DAT_181a2b640 == (longlong *)0x0) || (DAT_181a2b638 == 0)) ||
     (fVar23 = (float)(**(code **)(*DAT_181a2b640 + 0xf8))(), fVar23 <= 0.0)) {
    fVar23 = 0.0;
    fVar25 = 0.0;
  }
  else {
    fVar23 = (float)FUN_180bfe360(DAT_181a08d38);
    if (fVar23 <= 0.0) {
      fVar24 = 0.0;
    }
    else {
      fVar24 = expf(fVar23 * -100.0);
    }
    local_498 = *(undefined8 *)(param_1 + 0x98);
    fStack_490 = *(float *)(param_1 + 0xa0);
    fVar26 = *(float *)(param_1 + 0xa0);
    fVar27 = *(float *)(param_1 + 0x98);
    fVar28 = fVar27 * fVar27 + fVar26 * fVar26;
    if (fVar28 < 0.0) {
      fVar28 = sqrtf(fVar28);
    }
    else {
      fVar28 = SQRT(fVar28);
    }
    fVar23 = (float)local_498;
    fVar25 = fStack_490;
    if (0.0001 < fVar28) {
      fVar23 = (fVar28 / 0.0077) / 3000.0;
      fVar25 = 1.0;
      if (fVar23 <= 1.0) {
        fVar25 = fVar23;
      }
      fVar25 = *(float *)(param_1 + 0x100) * fVar25;
      fVar23 = (float)local_498 + (fVar27 / fVar28) * fVar25;
      fVar25 = fStack_490 + (fVar26 / fVar28) * fVar25;
    }
    fVar23 = (*(float *)(param_1 + 0xa8) - fVar23) * fVar24 + fVar23;
    fVar25 = (*(float *)(param_1 + 0xb0) - fVar25) * fVar24 + fVar25;
  }
  *(float *)(param_1 + 0xb0) = fVar25;
  *(undefined4 *)(param_1 + 0xac) = 0;
  *(float *)(param_1 + 0xa8) = fVar23;
  FUN_180ef4990(param_1);
  local_488 = 0.0;
  fStack_484 = 0.0;
  fStack_480 = 0.0;
  fStack_47c = 1.0;
  FUN_180d1d820(DAT_181a19c68,&local_488);
  (**(code **)(*DAT_181952a40 + 0x400))(DAT_181952a40,*(undefined8 *)(param_1 + 0x20),&local_488,0);
  local_4e0 = 0.0;
  local_4dc = 0.0;
  local_4d8 = 0.0;
  if ((DAT_181a08d00 != (longlong *)0x0) && (*(longlong *)(param_1 + 0x20) != 0)) {
    (**(code **)(*DAT_181a08d00 + 0x60))(DAT_181a08d00,*(longlong *)(param_1 + 0x20),&local_4e0);
  }
  fVar25 = local_4d8;
  fVar23 = local_4e0;
  fVar24 = 0.0;
  iVar9 = *(int *)(param_1 + 0xad0);
  bVar22 = false;
  uVar11 = 0;
  if (((iVar9 == 1) || (iVar9 == 2)) || ((iVar9 == 4 || (iVar9 == 0x2b)))) {
    uVar21 = 1;
LAB_180efb948:
    uVar20 = uVar21;
    uVar19 = 1;
  }
  else {
    uVar20 = uVar11;
    uVar19 = uVar11;
    uVar21 = 0;
    if (*(int *)(param_1 + 0x50) != 0) goto LAB_180efb948;
  }
  if ((((((((iVar9 == 1) || (iVar9 == 2)) || (iVar9 == 4)) || ((iVar9 == 0x2b || (iVar9 == 0xb))))
        || (iVar9 == 0x35)) || (*(int *)(param_1 + 0xe8) != 0)) ||
      ((piVar1 = *(int **)(param_1 + 0xac8), piVar1 != (int *)0x0 &&
       (iVar9 = FUN_180bfeb60(DAT_181a08d38), *piVar1 == iVar9)))) ||
     (cVar6 = FUN_180d19f30(DAT_181a19c68), bVar5 = bVar22, cVar6 == '\x03')) {
    bVar5 = true;
  }
  if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x16) &&
     (*(char *)(DAT_1819ecf18 + 0xb8) == *(char *)(DAT_1819ecf18 + 0xb9))) {
    bVar5 = true;
  }
  fVar26 = (float)FUN_180ef1ff0(param_1);
  if (((*(int *)(param_1 + 0x46c) != 0) && (*(int *)(param_1 + 0x468) != 0)) &&
     (fVar27 = (float)(**(code **)(*DAT_181952a40 + 0x110))(),
     0.1 < fVar27 - *(float *)(param_1 + 0x464))) {
    *(undefined4 *)(param_1 + 0x46c) = 0;
    *(undefined4 *)(param_1 + 0x464) = 0;
  }
  if (bVar5) {
    uVar21 = *(uint *)(param_1 + 0x8c) >> 4 & 1;
  }
  else if ((*(int *)(param_1 + 0x46c) == 0) || (uVar21 = 1, *(int *)(param_1 + 0xaf8) != 0)) {
    uVar21 = uVar11;
  }
  local_4cc = (float)(DAT_181a2b650 ^ 0x81a2b650);
  fVar27 = local_4cc * 330.0;
  if (fVar26 <= local_4cc * 330.0) {
    fVar27 = fVar26;
  }
  local_4b8[0] = 0.0;
  local_4bc = fVar27;
  (**(code **)(*DAT_181a08d00 + 0x30))(DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),local_4b8);
  if ((*(int *)(param_1 + 0xc4) == 0) || (uVar21 != 0)) {
    local_4c0 = 0.0;
  }
  else {
    local_4c0 = local_4b8[0];
  }
  FUN_180bfe360(DAT_181a08d38);
  if (*(int *)(param_1 + 0x50) == 0) {
    if (*(int *)(param_1 + 0xe8) != 0) {
LAB_180efbc16:
      bVar22 = true;
      fVar23 = local_4e0;
      fVar25 = local_4d8;
      fVar24 = local_4dc;
      goto LAB_180efbc2e;
    }
    if (((*(int *)(param_1 + 0xc4) == 0) ||
        ((piVar1 = *(int **)(param_1 + 0xac8), piVar1 != (int *)0x0 &&
         (iVar9 = FUN_180bfeb60(DAT_181a08d38), *piVar1 == iVar9)))) ||
       ((uVar21 != 0 ||
        (cVar6 = FUN_180d19f30(DAT_181a19c68), fVar26 = local_4d8, fVar24 = local_4e0,
        cVar6 == '\x03')))) {
      fVar24 = fVar23 * fVar23 + 0.0 + fVar25 * fVar25;
      if (fVar24 < 0.0) {
        fVar24 = sqrtf(fVar24);
      }
      else {
        fVar24 = SQRT(fVar24);
      }
      if (fVar24 <= fVar27) goto LAB_180efbcc8;
      if (fVar24 != 0.0) {
        fVar23 = fVar23 * (1.0 / fVar24);
        fVar25 = fVar25 * (1.0 / fVar24);
      }
      local_4e0 = fVar23 * fVar27;
      local_4d8 = fVar25 * fVar27;
      goto LAB_180efbcb2;
    }
    fVar23 = local_4d8 * local_4d8 + local_4e0 * local_4e0;
    if (fVar23 < 0.0) {
      fVar23 = sqrtf(fVar23);
    }
    else {
      fVar23 = SQRT(fVar23);
    }
    if (fVar27 < fVar23) {
      fVar27 = fVar27 / fVar23;
      local_4e0 = fVar24 * fVar27;
      local_4d8 = fVar26 * fVar27;
      local_4dc = local_4dc * fVar27;
      goto LAB_180efbcb2;
    }
  }
  else {
    if (((*(int *)(param_1 + 0xe8) != 0) || (uVar20 != 0)) || (*(int *)(param_1 + 0x54) != 0))
    goto LAB_180efbc16;
LAB_180efbc2e:
    fVar26 = fVar24 * fVar24 + fVar23 * fVar23 + fVar25 * fVar25;
    if (fVar26 < 0.0) {
      fVar26 = sqrtf(fVar26);
    }
    else {
      fVar26 = SQRT(fVar26);
    }
    if (fVar27 < fVar26) {
      if (fVar26 != 0.0) {
        fVar26 = 1.0 / fVar26;
        fVar23 = fVar23 * fVar26;
        fVar24 = fVar24 * fVar26;
        fVar25 = fVar25 * fVar26;
      }
      local_4e0 = fVar23 * fVar27;
      local_4d8 = fVar25 * fVar27;
      if (bVar22) {
        local_4dc = fVar24 * fVar27;
      }
LAB_180efbcb2:
      (**(code **)(*DAT_181a08d00 + 0x68))(DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),&local_4e0)
      ;
    }
  }
LAB_180efbcc8:
  iVar9 = *(int *)(param_1 + 0x108);
  if (((iVar9 == 1) || (iVar9 == 2)) || ((iVar9 == 4 || (iVar9 == 0x2b)))) {
    if (uVar20 != 0) goto LAB_180efbcec;
    if ((*(int *)(param_1 + 0xc4) != 0) || (*(int *)(param_1 + 0xe8) != 0)) goto LAB_180efbe16;
    *(undefined4 *)(param_1 + 0x54) = 1;
LAB_180efbd5c:
    if (*(int *)(param_1 + 0x50) == 0) {
      *(undefined4 *)(param_1 + 0xb0c) = 0;
    }
  }
  else if (uVar20 == 0) {
LAB_180efbe16:
    if (*(int *)(param_1 + 0x50) == 0) {
      *(undefined8 *)(param_1 + 0x54) = 0;
      goto LAB_180efbd5c;
    }
  }
  else {
LAB_180efbcec:
    *(undefined4 *)(param_1 + 0x54) = 0;
    *(undefined4 *)(param_1 + 0x58) = 1;
    if (uVar20 == 0) goto LAB_180efbd5c;
    fVar23 = *(float *)(**(longlong **)(param_1 + 0x110) + 4);
    if ((*(int *)(param_1 + 0xb0c) == 0) ||
       (*(float *)(param_1 + 0xb08) <= fVar23 && fVar23 != *(float *)(param_1 + 0xb08))) {
      *(float *)(param_1 + 0xb08) = fVar23;
    }
    *(undefined4 *)(param_1 + 0xb0c) = 1;
  }
  if (*(int *)(param_1 + 0x11c) != 0) {
    if ((*(int *)(param_1 + 0x50) == 0) || (uVar11 = 1, uVar21 == 0)) {
      uVar11 = 0;
    }
    *(uint *)(param_1 + 0x11c) = uVar11;
  }
  bVar22 = false;
  if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x16) &&
     (bVar22 = false, *(char *)(DAT_1819ecf18 + 0xb8) == *(char *)(DAT_1819ecf18 + 0xb9))) {
    bVar22 = true;
  }
  piVar1 = *(int **)(param_1 + 0xac8);
  if (((((piVar1 != (int *)0x0) && (iVar9 = FUN_180bfeb60(), *piVar1 == iVar9)) ||
       (*(int *)(param_1 + 0x54) != 0)) || ((bVar22 || (*(int *)(param_1 + 0xe8) != 0)))) ||
     ((iVar9 = FUN_180f04560(param_1), iVar9 != 0 ||
      (cVar6 = FUN_180d19f30(DAT_181a19c68), cVar6 == '\x03')))) {
    FUN_180d1d7b0(DAT_181a19c68,&local_488);
  }
  else {
    (**(code **)(*DAT_181952a40 + 0x170))(DAT_181952a40,*(undefined8 *)(param_1 + 0x20),&local_488);
  }
  fVar27 = fStack_480 * local_488 - fStack_47c * fStack_484;
  fVar27 = fVar27 + fVar27;
  fVar23 = fStack_480 * fStack_480 + fStack_484 * fStack_484;
  fVar26 = 1.0 - (fVar23 + fVar23);
  fVar23 = local_488 * local_488 + fStack_484 * fStack_484;
  fVar24 = 1.0 - (fVar23 + fVar23);
  fVar25 = fStack_480 * fStack_484 - fStack_47c * local_488;
  fVar25 = fVar25 + fVar25;
  fVar23 = fStack_47c * fStack_484 + fStack_480 * local_488;
  fVar23 = fVar23 + fVar23;
  local_500 = fVar24;
  local_4d0 = fVar26;
  local_508._0_4_ = fVar23;
  local_508._4_4_ = fVar25;
  if (*(int *)(param_1 + 0xe8) == 0) {
    uVar15 = *(undefined8 *)(DAT_181a19c68 + 0x430);
    uVar10 = FUN_180d454b0(uVar15);
    lVar12 = FUN_180c64490(DAT_181a0e3a0,uVar10);
    if (lVar12 == 0) {
      if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x16) {
        uVar10 = (**(code **)(*DAT_181a1a340 + 0x158))();
        lVar12 = FUN_180c64490(DAT_181a0e3a0,uVar10);
        if (lVar12 != 0) goto LAB_180efbf6c;
      }
      if ((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x41) && (*(int *)(DAT_181a08d38 + 0xe9e0) != 0x2f))
      {
        return;
      }
    }
LAB_180efbf6c:
    fVar28 = 0.0;
    FUN_180c501b0(local_478);
    if (lVar12 != 0) {
      plVar13 = (longlong *)FUN_180d45400(uVar15);
      cVar6 = FUN_180c65d90(DAT_181a0e3a0,*(undefined4 *)(lVar12 + 4));
      if ((cVar6 == '\x01') &&
         (lVar14 = FUN_180ec3680(DAT_181a08d38 + 0xef88,*(undefined4 *)(lVar12 + 4)), lVar14 != 0))
      {
        FUN_180315db0(local_478,lVar14 + 0x18);
      }
      if (plVar13 != (longlong *)0x0) {
        if ((DAT_181a19c68 == 0) ||
           ((*(int *)(DAT_181a19c68 + 0x3a0) < 1 && (*(int *)(DAT_181a19c68 + 0x5ec) == 0)))) {
          if (*(char *)(param_1 + 0xb92) == '\x01') {
            fVar28 = local_43c + *(float *)(lVar12 + 0xfdc);
          }
          else {
            fVar28 = local_43c + *(float *)(lVar12 + 0xfd8);
          }
        }
        else {
          fVar28 = local_438 + *(float *)(lVar12 + 0x38a8);
        }
        if (((((*(int *)(lVar12 + 0xc) == 0x22) &&
              (iVar9 = (**(code **)(*plVar13 + 0x2d0))(plVar13), iVar9 != 0)) ||
             ((*(int *)(lVar12 + 0xc) == 0x26 &&
              (iVar9 = (**(code **)(*plVar13 + 0x2d0))(plVar13), iVar9 != 0)))) ||
            ((cVar6 = FUN_180c58940(lVar12,2), cVar6 != '\0' &&
             (iVar9 = (**(code **)(*plVar13 + 0x2d0))(plVar13), iVar9 != 0)))) ||
           ((cVar6 = FUN_180c58940(lVar12,8), cVar6 != '\0' &&
            ((0 < *(int *)(DAT_181a19c68 + 0x3a0) || (*(int *)(DAT_181a19c68 + 0x5ec) != 0)))))) {
          fVar28 = local_400 + *(float *)(lVar12 + 0x3684);
        }
      }
    }
    if (*(int *)(DAT_181a19238 + 0x864c) != -1) {
      fVar28 = 0.0;
    }
    if ((((DAT_181a19c68 != 0) && (lVar12 != 0)) && (iVar9 = FUN_180d1ca50(), iVar9 != 0)) &&
       ((0 < *(int *)(DAT_181a19c68 + 0x3a0) || (*(int *)(DAT_181a19c68 + 0x5ec) != 0)))) {
      fVar28 = local_438 + *(float *)(lVar12 + 0xfe0);
    }
    local_4c8 = 0.0;
    if (((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x31) && (DAT_181a0e320 != 0)) &&
       ((*(longlong *)(DAT_181a0e320 + 0x890) != 0 &&
        (cVar6 = FUN_1810658f0(*(longlong *)(DAT_181a0e320 + 0x890),&local_4c8), cVar6 != '\0')))) {
      fVar28 = local_4c8;
    }
    if (*(int *)(DAT_181a0e320 + 0x160) == 0x120) {
      fVar28 = 100.0;
    }
    else if (150.0 < fVar28) {
      local_4e8 = 0.82;
    }
    if (lVar12 != 0) {
      if (*(char *)(param_1 + 0xb92) == '\0') {
        fVar32 = *(float *)(lVar12 + 0xfd8);
      }
      else {
        fVar32 = *(float *)(lVar12 + 0xfdc);
      }
      if ((0.0 < fVar32) || ((*(int *)(lVar12 + 0xc) == 0x22 && (0.0 < fVar28)))) {
        fVar33 = 500.0;
        if (fVar28 <= 500.0) {
          fVar33 = fVar28;
        }
        fVar33 = (float)FUN_180d6fe30(fVar33);
        fVar33 = fVar33 * 3000.0;
      }
    }
    FUN_1802f7290(local_478);
  }
  piVar1 = *(int **)(param_1 + 0xac8);
  if (((piVar1 == (int *)0x0) || (iVar9 = FUN_180bfeb60(DAT_181a08d38), *piVar1 != iVar9)) &&
     (cVar6 = FUN_180d19f30(DAT_181a19c68), cVar6 != '\x03')) {
LAB_180efc31a:
    if ((uVar19 != 0) || (bVar5)) {
      if ((*(int *)(param_1 + 0x50) == 0) || ((uVar20 != 0 || (*(int *)(param_1 + 0xe8) != 0))))
      goto LAB_180efc379;
      if ((*(uint *)(param_1 + 0x8c) & 1) == 0) {
        if ((*(uint *)(param_1 + 0x8c) & 2) != 0) {
          bVar22 = 0.0 < fVar25;
          goto LAB_180efc351;
        }
      }
      else {
        bVar22 = fVar25 < 0.0;
LAB_180efc351:
        if (!bVar22 && fVar25 != 0.0) goto LAB_180efc353;
      }
    }
    else {
LAB_180efc353:
      local_508._4_4_ = 0.0;
    }
    FUN_1801e2e00(&local_508);
    fVar23 = (float)local_508;
    fVar25 = local_508._4_4_;
    fVar24 = local_500;
  }
  else {
    iVar9 = FUN_180d1d780(DAT_181a19c68);
    if (iVar9 == 1) {
      uVar15 = FUN_180c6f820();
      iVar9 = FUN_180c7ad00(uVar15);
      if (iVar9 == 0) goto LAB_180efc31a;
    }
    local_498 = 0;
    fStack_490 = 0.0;
    (**(code **)(*DAT_181a08d00 + 0x68))(DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),&local_498);
    if ((*(uint *)(param_1 + 0x8c) & 0x200) == 0) {
      fVar33 = 100000.0;
    }
    else {
      fVar33 = 200000.0;
    }
    cVar6 = FUN_180d19f30(DAT_181a19c68);
    if (cVar6 == '\x03') {
      fVar33 = (float)FUN_180bfe360(DAT_181a08d38);
      fVar33 = fVar33 * 10000.0 + *(float *)(param_1 + 0xaf4) + 200000.0;
      if ((*(uint *)(param_1 + 0x8c) & 0x200) == 0) {
        FUN_1801e2e00(&local_508);
        fVar33 = 50000.0;
        fVar23 = (float)local_508;
        fVar25 = local_508._4_4_;
        fVar24 = local_500;
      }
      else {
        SVar8 = GetAsyncKeyState(0x11);
        if (SVar8 != 0) {
          FUN_1801e2e00(&local_508);
          fVar33 = 25000.0;
          fVar23 = (float)local_508;
          fVar25 = local_508._4_4_;
          fVar24 = local_500;
        }
      }
    }
    fVar28 = (float)FUN_180bfe360(DAT_181a08d38);
    if (0.0001 < fVar28) {
      fVar33 = fVar33 / (fVar28 * 84.0);
    }
  }
LAB_180efc379:
  if ((((*(uint *)(param_1 + 0x8c) & 0x20) != 0) && (*(int *)(param_1 + 0xe8) == 0)) ||
     (**(int **)(DAT_181a19c68 + 0x458) != 0)) {
    fVar33 = fVar33 * 0.25;
  }
  if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x13) && ((*(uint *)(param_1 + 0x8c) & 2) != 0)) {
    uVar15 = FUN_1810feba0();
    fVar28 = (float)FUN_181100730(uVar15);
    fVar33 = fVar33 * fVar28;
  }
  if ((*(int *)(param_1 + 0xaf8) != 0) && (!bVar5)) {
    fVar33 = fVar33 * 0.1;
  }
  if ((DAT_1819ecf10 != 0) && (iVar9 = FUN_1807193a0(), iVar9 != 0)) {
    if ((DAT_181a2b610 == (longlong *)0x0) || (DAT_181a2b608 == 0)) {
      fVar28 = 0.0;
    }
    else {
      fVar28 = (float)(**(code **)(*DAT_181a2b610 + 0xf8))();
    }
    fVar32 = fVar28;
    if ((*(int *)(param_1 + 0xe8) != 0) && (fVar32 = 0.8, 0.8 <= fVar28)) {
      fVar32 = fVar28;
    }
    fVar33 = fVar33 * fVar32;
  }
  local_4a8 = 0;
  local_4b0 = &PTR_FUN_18163e080;
  local_4a0 = '\x01';
  FUN_180079060(&DAT_181a2b658,&local_4b0);
  if (((*(int *)(DAT_181a19c68 + 0x80) == 0) || (*(int *)(DAT_181a19c68 + 0x84) == 0)) &&
     (local_4a0 != '\0')) {
    if ((DAT_181a2b5f8 != 0) && ((*(uint *)(param_1 + 0x8c) & 0x800) != 0)) {
      fVar28 = (float)FUN_180bfe360(DAT_181a08d38);
      fVar33 = (float)FUN_180ef1ff0(param_1);
      uVar11 = (uint)DAT_181a2b5f4;
      fVar26 = 2.0;
      if (DAT_181a2b5f4 != 0) {
        uVar18 = (ulonglong)uVar11;
        do {
          fVar26 = fVar26 + fVar26;
          uVar18 = uVar18 - 1;
        } while (uVar18 != 0);
      }
      fVar32 = fVar33;
      if (fVar26 <= fVar33) {
        fVar32 = fVar26;
      }
      fVar30 = 0.0;
      fVar31 = fVar28;
      while (0.0 < fVar31) {
        fVar29 = fVar31;
        if (0.011904 - DAT_181a2b5fc <= fVar31) {
          fVar29 = 0.011904 - DAT_181a2b5fc;
        }
        fVar30 = fVar30 + fVar29 * fVar32;
        fVar31 = fVar31 - fVar29;
        DAT_181a2b5fc = DAT_181a2b5fc + fVar29;
        if (0.011904 <= DAT_181a2b5fc) {
          DAT_181a2b5fc = DAT_181a2b5fc + -0.011904;
          bVar7 = (char)uVar11 + 1;
          uVar11 = (uint)bVar7;
          if (8 < bVar7) {
            DAT_181a2b5f8 = 0;
            DAT_181a2b5f4 = 0;
            DAT_181a2b5fc = 0.0;
            break;
          }
          fVar26 = fVar26 + fVar26;
          fVar32 = fVar33;
          if (fVar26 <= fVar33) {
            fVar32 = fVar26;
          }
        }
        DAT_181a2b5f4 = (byte)uVar11;
      }
      fVar26 = local_4d0;
      if (fVar30 / fVar28 <= fVar33) {
        fVar33 = fVar30 / fVar28;
      }
    }
    if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0xd) {
      uVar11 = *(uint *)(param_1 + 0x8c);
      if (((byte)uVar11 & 0x81) == 0x81) {
LAB_180efc5c6:
        fVar24 = fVar24 * fVar33;
        fVar27 = fVar27 * fVar33;
        fVar23 = fVar23 * fVar33;
        fVar26 = fVar33 * fVar26;
        fStack_514 = (fStack_514 + fVar25 * fVar33) - fVar33 * 0.0;
LAB_180efc601:
        local_518 = (fVar23 + local_518) - fVar26;
        local_510 = (local_510 + fVar24) - fVar27;
      }
      else if ((uVar11 & 0x101) == 0x101) {
        local_518 = fVar23 * fVar33 + local_518 + fVar33 * fVar26;
        fStack_514 = fStack_514 + fVar25 * fVar33 + fVar33 * 0.0;
        local_510 = local_510 + fVar24 * fVar33 + fVar27 * fVar33;
      }
      else if (((byte)uVar11 & 0x82) == 0x82) {
        local_518 = (local_518 - fVar23 * fVar33) - fVar33 * fVar26;
        fStack_514 = (fStack_514 - fVar25 * fVar33) - fVar33 * 0.0;
        local_510 = (local_510 - fVar24 * fVar33) - fVar27 * fVar33;
      }
      else {
        if ((uVar11 & 0x102) != 0x102) goto LAB_180efcb19;
        local_518 = (local_518 - fVar23 * fVar33) + fVar33 * fVar26;
        fStack_514 = (fStack_514 - fVar25 * fVar33) + fVar33 * 0.0;
        local_510 = (local_510 - fVar24 * fVar33) + fVar27 * fVar33;
      }
    }
    else {
      uVar11 = *(uint *)(param_1 + 0x8c);
      bVar7 = (byte)uVar11;
      if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x16) {
        if ((bVar7 & 0x81) == 0x81) goto LAB_180efc5c6;
        if ((uVar11 & 0x101) == 0x101) {
          fVar24 = fVar24 * fVar33;
          fVar27 = fVar27 * fVar33;
          fVar23 = fVar23 * fVar33;
          fVar26 = fVar33 * fVar26;
          fStack_514 = fStack_514 + fVar25 * fVar33 + fVar33 * 0.0;
LAB_180efc7f9:
          local_518 = fVar23 + local_518 + fVar26;
          local_510 = local_510 + fVar24 + fVar27;
        }
        else if ((bVar7 & 0x82) == 0x82) {
          local_518 = (local_518 - fVar23 * fVar33) - fVar33 * fVar26;
          fStack_514 = (fStack_514 - fVar25 * fVar33) - fVar33 * 0.0;
          local_510 = (local_510 - fVar24 * fVar33) - fVar27 * fVar33;
        }
        else if ((uVar11 & 0x102) == 0x102) {
          local_518 = (local_518 - fVar23 * fVar33) + fVar33 * fVar26;
          fStack_514 = (fStack_514 - fVar25 * fVar33) + fVar33 * 0.0;
          local_510 = (local_510 - fVar24 * fVar33) + fVar27 * fVar33;
        }
        else {
LAB_180efcb19:
          local_498 = 0;
          fStack_490 = 0.0;
          fStack_48c = 1.0;
          bVar22 = false;
          local_508._4_4_ = 0.0;
          local_500 = fVar24;
          local_508._0_4_ = fVar23;
          FUN_1801e2e00(&local_508);
          (**(code **)(*DAT_181952a40 + 0x170))
                    (DAT_181952a40,*(undefined8 *)(param_1 + 0x510),&local_498);
          uVar11 = *(uint *)(param_1 + 0x8c);
          if ((uVar11 & 1) != 0) {
            fVar26 = local_498._4_4_ * local_498._4_4_ + (float)local_498 * (float)local_498;
            fVar32 = fStack_490 * local_498._4_4_ - fStack_48c * (float)local_498;
            fVar28 = fStack_48c * local_498._4_4_ + fStack_490 * (float)local_498;
            fVar26 = (fVar28 + fVar28) * (float)local_508 + (fVar32 + fVar32) * local_508._4_4_ +
                     local_500 * (1.0 - (fVar26 + fVar26));
            if (((*(int *)(param_1 + 0xe8) == 0) || (*(int *)(param_1 + 0xc4) != 0)) ||
               (ABS(fVar26) <= 0.9)) {
              local_518 = local_518 + fVar23 * fVar33;
              local_510 = local_510 + fVar24 * fVar33;
              fStack_514 = fStack_514 + fVar25 * fVar33;
            }
            else {
              if (0.0 < fVar26) {
                fVar33 = fVar33 * -1.0;
                fStack_514 = fVar33;
                if (0.0 <= fVar25) goto LAB_180efccac;
                fVar33 = fVar33 * -1.0;
              }
              fStack_514 = fVar33;
              if (fVar25 < 0.0) {
                fVar33 = fVar33 * -1.0;
                fStack_514 = fVar33;
              }
            }
          }
LAB_180efccac:
          if ((uVar11 & 2) != 0) {
            fVar26 = local_498._4_4_ * local_498._4_4_ + (float)local_498 * (float)local_498;
            fVar32 = fStack_490 * local_498._4_4_ - fStack_48c * (float)local_498;
            fVar28 = fStack_48c * local_498._4_4_ + fStack_490 * (float)local_498;
            fVar26 = (fVar28 + fVar28) * (float)local_508 + (fVar32 + fVar32) * local_508._4_4_ +
                     (1.0 - (fVar26 + fVar26)) * local_500;
            if (((*(int *)(param_1 + 0xe8) == 0) || (*(int *)(param_1 + 0xc4) != 0)) ||
               (ABS(fVar26) <= 0.9)) {
              local_518 = local_518 - fVar23 * fVar33 * local_4c4;
              fStack_514 = fStack_514 - fVar25 * fVar33 * local_4c4;
              local_510 = local_510 - fVar24 * fVar33 * local_4c4;
            }
            else {
              if (fVar26 <= 0.0) {
LAB_180efcd68:
                if (fVar25 < 0.0) {
                  fVar33 = fVar33 * -1.0;
                }
              }
              else {
                fVar33 = fVar33 * -1.0;
                if (fVar25 < 0.0) {
                  fVar33 = fVar33 * -1.0;
                  goto LAB_180efcd68;
                }
              }
              fStack_514 = -fVar33;
            }
          }
          if ((uVar19 != 0) || (bVar5)) {
            if (uVar21 != 0) {
              if ((uVar19 == 0) || (*(int *)(param_1 + 0xe8) != 0)) {
                fVar23 = fStack_514 + fVar33;
              }
              else {
                fVar23 = fVar33;
                if ((uVar20 == 0) && (*(int *)(param_1 + 0x54) == 0)) goto LAB_180efce10;
              }
              fStack_514 = fVar23;
            }
LAB_180efce10:
            if ((uVar11 & 0x20) != 0) {
              cVar6 = FUN_180d19f30(DAT_181a19c68);
              if ((cVar6 != '\x03') && (cVar6 = FUN_180d19f30(DAT_181a19c68), cVar6 != '\0')) {
                fStack_514 = -fVar33;
              }
            }
          }
          if ((char)*(uint *)(param_1 + 0x8c) < '\0') {
            fVar23 = local_498._4_4_ * local_498._4_4_ + (float)local_498 * (float)local_498;
            fVar24 = fStack_490 * local_498._4_4_ - fStack_48c * (float)local_498;
            fVar25 = fStack_48c * local_498._4_4_ + fStack_490 * (float)local_498;
            fVar23 = ((fVar24 + fVar24) * -0.0 - (fVar25 + fVar25) * local_4d0) +
                     (1.0 - (fVar23 + fVar23)) * -fVar27;
            if ((*(int *)(param_1 + 0xe8) == 0) || (ABS(fVar23) <= 0.7)) {
              local_518 = local_518 - fVar33 * local_4d0 * local_4e8;
              local_510 = local_510 - fVar27 * fVar33 * local_4e8;
              bVar22 = true;
              fStack_514 = fStack_514 - fVar33 * 0.0 * local_4e8;
            }
            else {
              fStack_514 = fVar33;
              if (0.0 < fVar23) {
                fStack_514 = fVar33 * -1.0;
                fVar33 = fStack_514;
              }
            }
            if ((*(int *)(param_1 + 0xc4) != 0) && (!bVar22)) {
              local_518 = local_518 + fVar33 * local_4d0 * local_4e8;
              fStack_514 = fStack_514 + fVar33 * 0.0 * local_4e8;
              local_510 = local_510 + fVar27 * fVar33 * local_4e8;
            }
          }
          if ((*(uint *)(param_1 + 0x8c) >> 8 & 1) != 0) {
            fVar23 = local_498._4_4_ * local_498._4_4_ + (float)local_498 * (float)local_498;
            fVar25 = fStack_490 * local_498._4_4_ - fStack_48c * (float)local_498;
            fVar24 = fStack_48c * local_498._4_4_ + fStack_490 * (float)local_498;
            fVar23 = (fVar24 + fVar24) * local_4d0 + (fVar25 + fVar25) * 0.0 +
                     (1.0 - (fVar23 + fVar23)) * fVar27;
            if ((*(int *)(param_1 + 0xe8) == 0) || (ABS(fVar23) <= 0.7)) {
              local_518 = local_518 + fVar33 * local_4d0 * local_4e8;
              local_510 = local_510 + fVar27 * fVar33 * local_4e8;
              bVar22 = true;
              fStack_514 = fStack_514 + fVar33 * 0.0 * local_4e8;
            }
            else {
              fStack_514 = fVar33;
              if (0.0 < fVar23) {
                fStack_514 = fVar33 * -1.0;
                fVar33 = fStack_514;
              }
            }
            if ((*(int *)(param_1 + 0xc4) != 0) && (!bVar22)) {
              local_518 = local_518 - fVar33 * local_4d0 * local_4e8;
              fStack_514 = fStack_514 - fVar33 * 0.0 * local_4e8;
              local_510 = local_510 - fVar27 * fVar33 * local_4e8;
            }
          }
        }
      }
      else {
        if ((bVar7 & 0x81) == 0x81) {
          fVar24 = fVar24 * fVar33 * 0.7;
          fVar27 = fVar27 * fVar33 * 0.7;
          fVar23 = fVar23 * fVar33 * 0.7;
          fVar26 = fVar33 * fVar26 * 0.7;
          fStack_514 = (fVar25 * fVar33 * 0.7 + fStack_514) - fVar33 * 0.0 * 0.7;
          goto LAB_180efc601;
        }
        if ((uVar11 & 0x101) == 0x101) {
          fVar24 = fVar24 * fVar33 * 0.7;
          fVar27 = fVar27 * fVar33 * 0.7;
          fVar23 = fVar23 * fVar33 * 0.7;
          fVar26 = fVar33 * fVar26 * 0.7;
          fStack_514 = fVar25 * fVar33 * 0.7 + fStack_514 + fVar33 * 0.0 * 0.7;
          goto LAB_180efc7f9;
        }
        if ((bVar7 & 0x82) == 0x82) {
          local_518 = (local_518 - fVar23 * fVar33 * 0.5) - fVar33 * fVar26 * 0.5;
          fStack_514 = (fStack_514 - fVar25 * fVar33 * 0.5) - fVar33 * 0.0 * 0.5;
          local_510 = (local_510 - fVar24 * fVar33 * 0.5) - fVar27 * fVar33 * 0.5;
        }
        else {
          if ((uVar11 & 0x102) != 0x102) goto LAB_180efcb19;
          local_518 = (local_518 - fVar23 * fVar33 * 0.5) + fVar33 * fVar26 * 0.5;
          fStack_514 = (fStack_514 - fVar25 * fVar33 * 0.5) + fVar33 * 0.0 * 0.5;
          local_510 = (local_510 - fVar24 * fVar33 * 0.5) + fVar27 * fVar33 * 0.5;
        }
      }
    }
  }
  iVar9 = FUN_180d1d780(DAT_181a19c68);
  fVar23 = local_4cc;
  if ((iVar9 < 2) && (iVar9 = FUN_180d1d780(DAT_181a19c68), fVar23 = local_4cc, 0 < iVar9)) {
    uVar15 = FUN_180c6f820();
    iVar9 = FUN_180c7ad00(uVar15);
    fVar23 = local_4cc;
    if ((iVar9 * 1000 == 0) &&
       ((local_4cc <= 1.0 &&
        (2e+07 < fStack_514 * fStack_514 + local_518 * local_518 + local_510 * local_510)))) {
      FUN_1801e2e00(&local_518);
      local_518 = local_518 * 369.0;
      fStack_514 = fStack_514 * 369.0;
      local_510 = local_510 * 369.0;
    }
  }
  fVar25 = local_518 * fVar23;
  fVar23 = local_510 * fVar23;
  plVar13 = DAT_181a08d00;
  local_510 = fVar23;
  local_4c8 = fVar23;
  local_518 = fVar25;
  if ((!bVar5) && (uVar19 == 0)) {
    fVar26 = (float)FUN_180bfe360(DAT_181a08d38);
    local_498 = 0;
    fStack_490 = 0.0;
    fVar24 = 0.0;
    if ((DAT_181a08d00 != (longlong *)0x0) && (*(longlong *)(param_1 + 0x20) != 0)) {
      (**(code **)(*DAT_181a08d00 + 0x60))(DAT_181a08d00,*(longlong *)(param_1 + 0x20),&local_498);
      fVar24 = (float)local_498;
    }
    fVar32 = fStack_490;
    fVar28 = local_510;
    fVar27 = local_518;
    plVar13 = DAT_181a08d00;
    if (((0.0 < local_4bc) && (0.0 < fVar26)) &&
       (fVar30 = local_510 * local_510 + local_518 * local_518, 1e-12 <= fVar30)) {
      if (local_4c0 <= 1e-06) {
        fVar26 = fStack_490 * fStack_490 + fVar24 * fVar24;
        if (fVar26 < 0.0) {
          fVar26 = sqrtf(fVar26);
        }
        else {
          fVar26 = SQRT(fVar26);
        }
        if (1e-06 <= fVar26) {
          fVar32 = fVar32 / fVar26;
          fVar30 = fVar28 * fVar32 + fVar27 * (fVar24 / fVar26);
          if ((local_4bc <= fVar26) && (0.0 < fVar30)) {
            local_510 = fVar28 - fVar30 * fVar32;
            local_518 = fVar27 - fVar30 * (fVar24 / fVar26);
          }
        }
      }
      else {
        if (fVar30 < 0.0) {
          fVar30 = sqrtf(fVar30);
        }
        else {
          fVar30 = SQRT(fVar30);
        }
        fVar31 = local_4c0;
        fVar26 = expf(-local_4c0 * fVar26);
        if (1e-09 <= 1.0 - fVar26) {
          fVar24 = ((local_4bc - fVar26 * (fVar32 * (fVar28 / fVar30) + fVar24 * (fVar27 / fVar30)))
                   * fVar31) / (1.0 - fVar26);
          if (0.0 < fVar24) {
            if (fVar24 < fVar30) {
              local_510 = fVar28 * (fVar24 / fVar30);
              local_518 = fVar27 * (fVar24 / fVar30);
            }
          }
          else {
            local_518 = 0.0;
            local_510 = 0.0;
          }
        }
      }
    }
  }
  iVar9 = *(int *)(DAT_181a08d38 + 0xe9e0);
  if (iVar9 == 0x2f) {
    if ((DAT_1819ecef0 == 0) || (*(int *)(DAT_1819ecef0 + 0x2694) != 1)) {
LAB_180efd5c6:
      pfVar16 = &local_518;
    }
    else {
      pfVar16 = (float *)(param_1 + 0xb2c);
    }
    (**(code **)(*plVar13 + 0x88))(plVar13,*(undefined8 *)(param_1 + 0x20),pfVar16);
  }
  else if (iVar9 == 0x39) {
    if ((DAT_18194ee00 == 0) || (*(char *)(DAT_18194ee00 + 0x30) == '\0')) goto LAB_180efd5c6;
    (**(code **)(*plVar13 + 0x88))(plVar13,*(undefined8 *)(param_1 + 0x20),param_1 + 0xb2c);
    puVar2 = *(undefined8 **)(param_1 + 0x110);
    pfVar16 = (float *)*puVar2;
    fVar24 = pfVar16[1];
    fVar26 = pfVar16[2];
    local_508._0_4_ = *(float *)(param_1 + 0xb2c);
    local_508._4_4_ = *(float *)(param_1 + 0xb30);
    local_500 = *(float *)(param_1 + 0xb34);
    FUN_1801e2e00(&local_508);
    fVar27 = (float)local_508 * 2.0 + *pfVar16;
    local_528 = puVar2;
LAB_180efd7a9:
    fStack_490 = local_500 * 2.0 + fVar26;
    local_498 = CONCAT44(local_508._4_4_ * 2.0 + fVar24,fVar27);
    (**(code **)(*DAT_181a08d00 + 0x90))(DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),&local_498,1)
    ;
  }
  else if ((iVar9 - 0x3aU < 0x17) && ((0x408001U >> (iVar9 - 0x3aU & 0x1f) & 1) != 0)) {
    if ((*(float *)(param_1 + 0xb68) <= 0.0) ||
       (fVar24 = (float)(**(code **)(*DAT_181952a40 + 0x110))(),
       *(float *)(param_1 + 0xb68) <= fVar24)) {
      *(undefined4 *)(param_1 + 0xb68) = 0;
      (**(code **)(*DAT_181a08d00 + 0x88))(DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),&local_518)
      ;
    }
    else {
      pfVar16 = (float *)(param_1 + 0xb50);
      local_518 = local_518 + *pfVar16;
      fStack_514 = fStack_514 + *(float *)(param_1 + 0xb54);
      local_510 = local_510 + *(float *)(param_1 + 0xb58);
      (**(code **)(*DAT_181a08d00 + 0x88))(DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),pfVar16);
      if (*(char *)(param_1 + 0xb7c) == '\x01') {
        puVar2 = *(undefined8 **)(param_1 + 0x110);
        pfVar3 = (float *)*puVar2;
        fVar24 = pfVar3[1];
        fVar26 = pfVar3[2];
        local_508._0_4_ = *pfVar16;
        local_508._4_4_ = *(float *)(param_1 + 0xb54);
        local_500 = *(float *)(param_1 + 0xb58);
        FUN_1801e2e00(&local_508);
        fVar27 = (float)local_508 * 2.0 + *pfVar3;
        local_528 = puVar2;
        goto LAB_180efd7a9;
      }
    }
  }
  else if (iVar9 == 0x40) {
    uVar15 = FUN_180c44210(DAT_181a0e320);
    local_528 = (undefined8 *)((ulonglong)local_528 & 0xffffffff00000000);
    lVar12 = __RTDynamicCast(uVar15,0,&PTR_PTR_181906040,&PTR_PTR_18190ac90);
    if (lVar12 != 0) {
      cVar6 = FUN_181099a50(lVar12);
      if (cVar6 == '\0') {
        cVar6 = FUN_181099aa0(lVar12);
        uVar15 = *(undefined8 *)(param_1 + 0x20);
        lVar12 = *DAT_181a08d00;
        if (cVar6 == '\0') goto LAB_180efdac3;
        (**(code **)(lVar12 + 0x88))(DAT_181a08d00,uVar15,param_1 + 0xb2c);
        puVar2 = *(undefined8 **)(param_1 + 0x110);
        pfVar16 = (float *)*puVar2;
        fVar24 = pfVar16[1];
        fVar26 = pfVar16[2];
        local_508._0_4_ = *(float *)(param_1 + 0xb2c);
        local_508._4_4_ = *(float *)(param_1 + 0xb30);
        local_500 = *(float *)(param_1 + 0xb34);
        FUN_1801e2e00(&local_508);
        local_498 = CONCAT44(local_508._4_4_ * 10.0 + fVar24,(float)local_508 * 10.0 + *pfVar16);
        fStack_490 = local_500 * 10.0 + fVar26;
        local_528 = puVar2;
        (**(code **)(*DAT_181a08d00 + 0x90))
                  (DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),&local_498,0);
      }
      else {
        (**(code **)(*DAT_181a08d00 + 0x88))
                  (DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),param_1 + 0xb2c);
      }
    }
  }
  else {
    if ((iVar9 != 0x3d) || (*(char *)(param_1 + 0xb7c) == '\0')) goto LAB_180efd5c6;
    pfVar16 = (float *)**(undefined8 **)(param_1 + 0x110);
    local_508._0_4_ = *pfVar16;
    local_508._4_4_ = pfVar16[1];
    local_500 = pfVar16[2];
    fVar24 = (float)local_508 - *(float *)(param_1 + 0xb80);
    fVar27 = local_508._4_4_ - *(float *)(param_1 + 0xb84);
    fVar26 = local_500 - *(float *)(param_1 + 0xb88);
    uVar15 = *(undefined8 *)(param_1 + 0x20);
    if (*(float *)(param_1 + 0xb8c) <= ABS(fVar27 * fVar27 + fVar24 * fVar24 + fVar26 * fVar26)) {
      *(undefined4 *)(param_1 + 0xb8c) = 0;
      *(undefined1 *)(param_1 + 0xb7c) = 0;
      lVar12 = *DAT_181a08d00;
LAB_180efdac3:
      (**(code **)(lVar12 + 0x88))(DAT_181a08d00,uVar15,&local_518);
    }
    else {
      (**(code **)(*plVar13 + 0x88))(plVar13,uVar15,param_1 + 0xb2c);
      local_498 = *(undefined8 *)(param_1 + 0xb2c);
      fStack_490 = *(float *)(param_1 + 0xb34);
      FUN_1801e2e00(&local_498);
      local_508._0_4_ = (float)local_508 + (float)local_498 * 5.0;
      local_508._4_4_ = local_508._4_4_ + local_498._4_4_ * 5.0;
      local_500 = local_500 + fStack_490 * 5.0;
      local_528 = *(undefined8 **)(param_1 + 0x110);
      (**(code **)(*DAT_181a08d00 + 0x90))
                (DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),&local_508,1);
    }
  }
  uVar11 = 0;
  *(float *)(param_1 + 0x518) = local_510 * local_510 + local_518 * local_518;
  local_4f8 = 0.0;
  fStack_4f4 = 0.0;
  local_4f0 = 0.0;
  if ((DAT_181a08d00 != (longlong *)0x0) && (*(longlong *)(param_1 + 0x20) != 0)) {
    (**(code **)(*DAT_181a08d00 + 0x60))(DAT_181a08d00,*(longlong *)(param_1 + 0x20),&local_4f8);
  }
  uVar17 = *(int *)(DAT_181a08d38 + 0xe9e0) - 0x2e;
  uVar19 = 1;
  if ((((uVar17 < 0x23) && ((0x400001041U >> ((ulonglong)uVar17 & 0x3f) & 1) != 0)) ||
      (iVar9 = FUN_180ef4440(param_1), iVar9 == 1)) &&
     ((*(int *)(param_1 + 0xaf8) != 0 && ((*(uint *)(param_1 + 0x8c) & 0x2000000) != 0)))) {
    uVar21 = uVar19;
  }
  if (((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x45) && (iVar9 = FUN_180f8ab40(), iVar9 != 0)) ||
     (uVar21 != 0)) {
    if ((uVar20 == 0) && (*(int *)(param_1 + 0x50) != 0)) {
      if (*(int *)(param_1 + 0x58) == 0) {
        if (*(int *)(param_1 + 0xc4) == 0) goto LAB_180efdae4;
      }
      else {
        *(undefined4 *)(param_1 + 0x58) = 0;
      }
      *(undefined4 *)(param_1 + 0x11c) = 1;
    }
LAB_180efdae4:
    if ((*(int *)(param_1 + 0x11c) != 0) ||
       (((*(int *)(param_1 + 0xc4) != 0 && (*(int *)(param_1 + 0x50) == 0)) ||
        (uVar21 = uVar11, *(int *)(param_1 + 0xe8) != 0)))) {
      uVar21 = uVar19;
    }
    if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x16) &&
       (iVar9 = FUN_18072e310(DAT_1819ecf18), iVar9 == 2)) {
      uVar21 = 0;
    }
    if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x2f) {
      if ((DAT_1819ecef0 != 0) && (*(int *)(DAT_1819ecef0 + 0x275c) != 0)) {
        uVar21 = uVar11;
      }
    }
    else if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x45) && (iVar9 = FUN_180f8ab40(), iVar9 == 2)) {
      uVar21 = 1;
    }
    if (((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x2e) || (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x34))
       || (iVar9 = FUN_180ef4440(param_1), iVar9 == 1)) {
      if (uVar21 == 1) {
        FUN_1802eb9f0(DAT_181a1b460);
      }
      if ((*(uint *)(param_1 + 0x8c) & 0x2000000) != 0) {
        uVar21 = uVar19;
      }
    }
    uVar11 = uVar21;
    if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x3a) {
      if ((uVar21 == 1) && (DAT_18194e810 != 0)) {
        FUN_1802b0c50();
      }
      if ((*(uint *)(param_1 + 0x8c) & 0x2000000) != 0) {
        uVar11 = uVar19;
      }
    }
    if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x50) {
      if ((uVar11 == 1) && (DAT_181949a60 != 0)) {
        FUN_18009a850();
      }
      if ((*(uint *)(param_1 + 0x8c) & 0x2000000) == 0) goto LAB_180efdc16;
    }
    else {
LAB_180efdc16:
      uVar19 = uVar11;
      if (uVar11 == 0) goto LAB_180efe0fe;
    }
    uVar11 = uVar19;
    if (*(int *)(param_1 + 0xe8) == 0) {
      if ((*(byte *)(param_1 + 0x8c) & 0x20) != 0) {
        puVar4 = (undefined4 *)**(undefined8 **)(param_1 + 0x110);
        fStack_490 = (float)puVar4[2];
        local_498 = CONCAT44((float)puVar4[1] + 10.0,*puVar4);
        cVar6 = FUN_180f852f0();
        if (cVar6 == '\x01') {
          local_508._0_4_ = 0.0;
          local_508._4_4_ = 0.0;
          local_500 = 0.0;
          (*(code *)DAT_181952a40[0x81])(*(undefined8 *)(param_1 + 0x20),&local_508);
          if (1.0 < local_508._4_4_) {
            local_498 = CONCAT44(local_498._4_4_ + (local_508._4_4_ - 1.0) * 10.0,(float)local_498);
          }
        }
        local_528 = *(undefined8 **)(param_1 + 0x110);
        (**(code **)(*DAT_181a08d00 + 0x90))
                  (DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),&local_498,0);
        local_528 = *(undefined8 **)(param_1 + 0x110);
        (**(code **)(*DAT_181952a40 + 0x230))
                  (DAT_181952a40,*(undefined8 *)(param_1 + 0x20),&local_498,1);
      }
      fVar24 = (float)FUN_180bfe360(DAT_181a08d38);
      fVar27 = fVar24 * 2000.0 * 0.5;
      fVar23 = *(float *)(param_1 + 0xb8);
      fVar26 = fVar27 * fVar27 + (fVar23 + 11.904762) * fVar23 * 4.0;
      if (0.0 < fVar26) {
        if (fVar26 < 0.0) {
          fVar26 = sqrtf(fVar26);
        }
        else {
          fVar26 = SQRT(fVar26);
        }
        fVar23 = (fVar26 - fVar27) * 0.5;
      }
      fStack_4f4 = fVar23;
      if (*(int *)(param_1 + 0x11c) != 0) {
        if (((*(int *)(param_1 + 0xb0c) == 0) || (fVar24 <= 0.0)) || (0.011785715 <= fVar24)) {
LAB_180efdf83:
          fStack_4f4 = (0.011904762 - fVar24) * 2503.0 + fVar23;
        }
        else {
          fVar26 = (*(float *)(param_1 + 0xb08) + 100.0) -
                   *(float *)(**(longlong **)(param_1 + 0x110) + 4);
          if (0.0 < fVar26) {
            fVar27 = fVar24 * 2100.0;
            fVar28 = fVar27 / 2000.0 + fVar24 + fVar24 * 0.25;
            fVar26 = fVar28 * fVar28 -
                     (((fVar27 * fVar27) / 4000.0 + fVar27 * fVar24 * 0.25) - fVar26) * 0.001;
            if (fVar26 <= 0.0) goto LAB_180efdf83;
            if (fVar26 < 0.0) {
              fVar26 = sqrtf(fVar26);
            }
            else {
              fVar26 = SQRT(fVar26);
            }
            fVar24 = (fVar26 - fVar28) / 0.0005 - fVar23;
            if (0.0 < fVar24) {
              if (80.0 <= fVar24) {
                fVar24 = 80.0;
              }
              fStack_4f4 = fVar24 + fVar23;
            }
          }
        }
      }
    }
    else {
      local_498 = 0;
      fStack_490 = 0.0;
      fStack_48c = 1.0;
      (**(code **)(*DAT_181952a40 + 0x170))
                (DAT_181952a40,*(undefined8 *)(param_1 + 0x510),&local_498);
      fVar23 = local_498._4_4_ * local_498._4_4_ + (float)local_498 * (float)local_498;
      fVar24 = fStack_48c * local_498._4_4_ + fStack_490 * (float)local_498;
      local_4f8 = local_4f8 + (fVar24 + fVar24) * 1400.0;
      local_4f0 = local_4f0 + (1.0 - (fVar23 + fVar23)) * 1400.0;
      fStack_4f4 = *(float *)(param_1 + 0xb8) * 0.5;
    }
    cVar6 = FUN_180f852f0();
    if (cVar6 == '\x01') {
      if (DAT_1819499a0 != 0) {
        local_498 = 0x3f8000003f800000;
        fStack_490 = 1.0;
        (*(code *)DAT_181952a40[0x81])(*(undefined8 *)(param_1 + 0x20),&local_498);
        fVar23 = (local_498._4_4_ - 1.0) + 1.0;
        if (1.0 <= fVar23) {
          fVar24 = 4.0;
          if (fVar23 <= 4.0) {
            fVar24 = fVar23;
          }
        }
        else {
          fVar24 = 1.0;
        }
        if (fVar24 < 0.0) {
          fVar24 = sqrtf(fVar24);
        }
        else {
          fVar24 = SQRT(fVar24);
        }
        fStack_4f4 = fStack_4f4 * fVar24;
      }
      iVar9 = FUN_180f8ab40();
      if (iVar9 == 1) {
        fStack_4f4 = fStack_4f4 * 2.8;
      }
      else {
        iVar9 = FUN_180f8ab40();
        if (iVar9 == 2) {
          fStack_4f4 = fStack_4f4 * 2.0;
        }
      }
    }
    *(undefined4 *)(param_1 + 0xaf8) = 1;
    *(undefined4 *)(param_1 + 0x54) = 0;
    *(undefined4 *)(param_1 + 0x46c) = 0;
    fVar23 = *(float *)(**(longlong **)(param_1 + 0x110) + 4);
    fVar24 = (float)FUN_180bfe360(DAT_181a08d38);
    *(float *)(param_1 + 0xafc) =
         (fStack_4f4 * fStack_4f4) / 4000.0 + fVar23 + fVar24 * fStack_4f4 * 0.25;
    *(uint *)(param_1 + 0xb00) = *(uint *)(param_1 + 0x8c) >> 5 & 1;
    *(uint *)(param_1 + 0xb04) = (uint)(*(int *)(param_1 + 0x11c) != 0);
    fVar23 = local_4c8;
  }
LAB_180efe0fe:
  piVar1 = *(int **)(param_1 + 0xac8);
  if (((piVar1 != (int *)0x0) && (iVar9 = FUN_180bfeb60(DAT_181a08d38), *piVar1 == iVar9)) ||
     (cVar6 = FUN_180d19f30(DAT_181a19c68), cVar6 == '\x03')) {
    pfVar16 = (float *)FUN_1801e2e00(&local_518);
    local_4f8 = *pfVar16;
    fStack_4f4 = pfVar16[1];
    local_4f0 = pfVar16[2];
    cVar6 = FUN_180d19f30(DAT_181a19c68);
    if (cVar6 != '\x03') {
      local_4f8 = local_4f8 * 300.0;
      fStack_4f4 = fStack_4f4 * 300.0;
      local_4f0 = local_4f0 * 300.0;
    }
  }
  lVar12 = DAT_1819ecf18;
  if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x16) &&
     (*(char *)(DAT_1819ecf18 + 0xb8) == *(char *)(DAT_1819ecf18 + 0xb9))) {
    fVar24 = fStack_484 * fStack_484 + local_488 * local_488;
    fVar26 = fStack_480 * fStack_484 - fStack_47c * local_488;
    fVar27 = fStack_47c * fStack_484 + fStack_480 * local_488;
    local_510 = fVar33 * (1.0 - (fVar24 + fVar24));
    fStack_514 = fVar33 * (fVar26 + fVar26);
    local_518 = (fVar27 + fVar27) * fVar33;
    pfVar16 = (float *)FUN_1801e2e00(&local_518);
    local_4f8 = *pfVar16;
    fStack_4f4 = pfVar16[1];
    if (((DAT_181a2b708 != 0.0) || (DAT_181a2b70c != 0.0)) ||
       (uVar15 = *(undefined8 *)pfVar16, fVar33 = pfVar16[2], DAT_181a2b710 != 0.0)) {
      local_4f8 = DAT_181a2b708;
      fStack_4f4 = DAT_181a2b70c;
      uVar15 = _DAT_181a2b708;
      fVar33 = DAT_181a2b710;
    }
    DAT_181a2b710 = fVar33;
    _DAT_181a2b708 = uVar15;
    local_4f0 = DAT_181a2b710;
    if (((DAT_181a95150 != 0) &&
        (lVar14 = FUN_180feb690(DAT_1819ed0b8,*(undefined4 *)(DAT_181a0e320 + 0x160)),
        lVar12 = DAT_1819ecf18, lVar14 != 0)) &&
       (lVar14 = FUN_181138550(DAT_181a95150,*(undefined4 *)(lVar14 + 0x28818)),
       lVar12 = DAT_1819ecf18, lVar14 != 0)) {
      fVar33 = *(float *)(lVar14 + 0xb0);
      local_4f8 = local_4f8 * fVar33;
      fStack_4f4 = fStack_4f4 * fVar33;
      local_4f0 = local_4f0 * fVar33;
    }
  }
  else {
    _DAT_181a2b708 = 0;
    DAT_181a2b710 = 0.0;
  }
  if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x16) &&
     (*(char *)(lVar12 + 200) == *(char *)(lVar12 + 0xc9))) {
    pfVar16 = (float *)FUN_18072e1d0(lVar12,&local_498);
    local_4f8 = *pfVar16;
    fStack_4f4 = pfVar16[1];
    local_4f0 = pfVar16[2];
  }
  if (((DAT_181a2b640 == (longlong *)0x0) || (DAT_181a2b638 == 0)) ||
     (fVar33 = (float)(**(code **)(*DAT_181a2b640 + 0xf8))(), fVar33 <= 0.0)) {
    local_4f8 = local_4f8 + *(float *)(param_1 + 0x98);
    local_4f0 = local_4f0 + *(float *)(param_1 + 0xa0);
  }
  else {
    local_4f8 = local_4f8 + *(float *)(param_1 + 0xa8);
    local_4f0 = local_4f0 + *(float *)(param_1 + 0xb0);
  }
  fStack_4f4 = fStack_4f4 + *(float *)(param_1 + 0x9c);
  if ((((*(int *)(param_1 + 0x50) != 0) && (*(int *)(param_1 + 0xe8) == 0)) &&
      ((piVar1 = *(int **)(param_1 + 0xac8), piVar1 == (int *)0x0 ||
       (iVar9 = FUN_180bfeb60(DAT_181a08d38), *piVar1 != iVar9)))) &&
     (cVar6 = FUN_180d19f30(DAT_181a19c68), cVar6 != '\x03')) {
    fVar33 = (float)FUN_180bfe360(DAT_181a08d38);
    fVar33 = (0.011904762 - fVar33) * 0.17;
    local_4f8 = local_4f8 + fVar25 * fVar33;
    local_4f0 = local_4f0 + fVar23 * fVar33;
  }
  lVar12 = DAT_181a08d38;
  iVar9 = *(int *)(DAT_181a08d38 + 0xe9e0);
  if ((iVar9 == 0x3a) || (iVar9 == 0x50)) {
    if ((local_4f8 != 0.0) || ((fStack_4f4 != 0.0 || (local_4f0 != 0.0)))) {
      *(float *)(param_1 + 0xb5c) = local_4f8;
      *(float *)(param_1 + 0xb60) = fStack_4f4;
      *(float *)(param_1 + 0xb64) = local_4f0;
      iVar9 = *(int *)(lVar12 + 0xe9e0);
    }
    if (iVar9 == 0x50) {
      if (((local_4f8 == 0.0) && (fStack_4f4 == 0.0)) && (local_4f0 == 0.0)) goto LAB_180efe5c0;
      *(float *)(param_1 + 0xb5c) = local_4f8;
      *(float *)(param_1 + 0xb60) = fStack_4f4;
      *(float *)(param_1 + 0xb64) = local_4f0;
      iVar9 = *(int *)(lVar12 + 0xe9e0);
    }
  }
  if (iVar9 == 0x45) {
    FUN_180f8aaa0(&local_4f8,param_1 + 0x118,0xc4fa0000,*(int *)(param_1 + 0xc4) == 1);
  }
LAB_180efe5c0:
  (**(code **)(*DAT_181a08d00 + 0x68))(DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),&local_4f8);
  if (*(int *)(DAT_181a19c68 + 0x528) == 0) {
    local_498 = 0;
    fStack_490 = 0.0;
    (**(code **)(*DAT_181a08d00 + 0x68))(DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),&local_498);
    (**(code **)(*DAT_181a08d00 + 0x88))(DAT_181a08d00,*(undefined8 *)(param_1 + 0x20),&local_498);
  }
  FUN_180ef61f0(param_1,uVar11);
  if ((*(int *)(param_1 + 0xb14) != 0) && (*(float *)(param_1 + 0x70) == 0.0)) {
    FUN_180c01630(DAT_181a08d38);
    *(undefined4 *)(param_1 + 0xb14) = 0;
  }
  return;
}

