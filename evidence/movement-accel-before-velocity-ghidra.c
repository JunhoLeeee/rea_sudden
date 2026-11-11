
void FUN_180efea00(longlong param_1)

{
  int *piVar1;
  code *pcVar2;
  bool bVar3;
  bool bVar4;
  char cVar5;
  int iVar6;
  uint uVar7;
  longlong lVar9;
  float *pfVar10;
  ulonglong uVar11;
  ulonglong uVar12;
  longlong lVar13;
  ulonglong uVar14;
  longlong *plVar15;
  float fVar16;
  float fVar17;
  float local_a8;
  float local_a4;
  float local_a0;
  undefined8 local_98;
  float local_90;
  ulonglong uVar8;
  
  uVar12 = 0;
  *(undefined8 *)(param_1 + 0x98) = 0;
  *(undefined8 *)(param_1 + 0xa0) = 0;
  if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x16) &&
     (*(char *)(DAT_1819ecf18 + 0xb8) == *(char *)(DAT_1819ecf18 + 0xb9))) {
LAB_180efea84:
    (**(code **)(*DAT_181a08d08 + 0x90))(DAT_181a08d08,*(undefined8 *)(param_1 + 0x20),0,0,0x20000);
  }
  else {
    piVar1 = *(int **)(param_1 + 0xac8);
    if ((piVar1 != (int *)0x0) && (iVar6 = FUN_180bfeb60(), *piVar1 == iVar6)) goto LAB_180efea84;
    pcVar2 = *(code **)(*DAT_181a08d08 + 0x90);
    cVar5 = FUN_180d19f30(DAT_181a19c68);
    uVar8 = 0x20000;
    if (cVar5 == '\x03') {
      uVar8 = uVar12;
    }
    (*pcVar2)(DAT_181a08d08,*(undefined8 *)(param_1 + 0x20),0,uVar8,0x20000);
  }
  plVar15 = (longlong *)(param_1 + 0x20);
  *(undefined4 *)(param_1 + 0x5c) = 0;
  *(undefined4 *)(param_1 + 0xec) = *(undefined4 *)(param_1 + 0xe8);
  *(undefined4 *)(param_1 + 0xe8) = 0;
  *(undefined4 *)(param_1 + 0x50) = 0;
  *(undefined8 *)(param_1 + 0x510) = 0;
  FUN_180ef6c30(param_1);
  bVar3 = false;
  uVar8 = uVar12;
  if (*(uint *)(param_1 + 0x440) != 0) {
    do {
      uVar11 = uVar12;
      uVar14 = uVar12;
      if ((*(int *)(param_1 + 0x158 + uVar8 * 0x30) == 0) &&
         ((((iVar6 = *(int *)(param_1 + 0x154 + uVar8 * 0x30), iVar6 == 1 || (iVar6 == 2)) ||
           (iVar6 == 4)) || (iVar6 == 0x2b)))) {
        bVar3 = true;
        break;
      }
      uVar7 = (int)uVar8 + 1;
      uVar8 = (ulonglong)uVar7;
    } while (uVar7 < *(uint *)(param_1 + 0x440));
    do {
      lVar9 = uVar11 * 0x30;
      if ((*(int *)(lVar9 + 0x158 + param_1) == 0) &&
         ((iVar6 = *(int *)(lVar9 + 0x154 + param_1), iVar6 == 0xb || (iVar6 == 0x35)))) {
        *(int *)(param_1 + 0x5c) = iVar6;
        iVar6 = *(int *)(lVar9 + 0x154 + param_1);
        if (((iVar6 == 0xb) || (iVar6 == 0x35)) && ((int)uVar14 == 0)) {
          *(undefined4 *)(param_1 + 0xe8) = 1;
          *(undefined8 *)(param_1 + 0x510) = *(undefined8 *)(lVar9 + 0x160 + param_1);
          (**(code **)(*DAT_181a08d08 + 0x90))(DAT_181a08d08,*plVar15,0,0,0x20000);
          lVar13 = param_1 + 0x140 + lVar9;
          if ((lVar13 != 0) && (*(int *)(lVar13 + 0x18) == 0)) {
            if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x31) &&
               (cVar5 = FUN_181066010(lVar13), cVar5 != '\0')) {
              fVar17 = *(float *)(lVar13 + 4) * 0.1;
            }
            else {
              fVar17 = *(float *)(lVar13 + 4);
            }
            FUN_180ef77b0(param_1,fVar17);
          }
          uVar14 = 1;
        }
        fVar17 = (float)FUN_180bfe360(DAT_181a08d38);
        if (((DAT_181a2b640 == (longlong *)0x0) || (DAT_181a2b638 == 0)) ||
           (fVar16 = (float)(**(code **)(*DAT_181a2b640 + 0xf8))(), fVar16 <= 0.0)) {
          fVar16 = fVar17;
          if (!bVar3) {
            fVar16 = 0.011904762;
          }
          *(float *)(param_1 + 0x98) =
               fVar16 * *(float *)(lVar9 + 0x148 + param_1) + *(float *)(param_1 + 0x98);
          fVar16 = fVar16 * *(float *)(lVar9 + 0x150 + param_1);
        }
        else {
          *(float *)(param_1 + 0x98) =
               *(float *)(lVar9 + 0x148 + param_1) * 0.0077 + *(float *)(param_1 + 0x98);
          fVar16 = *(float *)(lVar9 + 0x150 + param_1) * 0.0077;
        }
        *(float *)(param_1 + 0xa0) = fVar16 + *(float *)(param_1 + 0xa0);
        *(float *)(param_1 + 0x9c) =
             fVar17 * *(float *)(lVar9 + 0x14c + param_1) + *(float *)(param_1 + 0x9c);
      }
      uVar7 = (int)uVar11 + 1;
      uVar11 = (ulonglong)uVar7;
    } while (uVar7 < *(uint *)(param_1 + 0x440));
  }
  if (*(int *)(param_1 + 0xec) == 0) {
    if (*(int *)(param_1 + 0xe8) == 0) goto LAB_180efed67;
    *(undefined4 *)(param_1 + 0xec) = 0;
  }
  if (*(int *)(param_1 + 0xe8) != 0) {
    return;
  }
LAB_180efed67:
  uVar8 = uVar12;
  if (*(int *)(param_1 + 0x440) != 0) {
    do {
      lVar9 = uVar8 * 0x30;
      if (*(int *)(lVar9 + 0x158 + param_1) == 0) {
        *(undefined4 *)(param_1 + 0x5c) = *(undefined4 *)(lVar9 + 0x154 + param_1);
        iVar6 = *(int *)(lVar9 + 0x154 + param_1);
        if ((((iVar6 != 1) && (iVar6 != 2)) && ((iVar6 != 4 && (iVar6 != 0x2b)))) ||
           ((int)uVar12 == 0)) {
          pfVar10 = (float *)(param_1 + 0x140 + lVar9);
          if ((pfVar10 == (float *)0x0) || (pfVar10[6] != 0.0)) {
            if (pfVar10 == (float *)0x0) goto LAB_180efee5d;
          }
          else if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x31) &&
                  (cVar5 = FUN_181066010(pfVar10), cVar5 != '\0')) {
            FUN_180ef77b0(param_1,pfVar10[1] * 0.1);
          }
          else {
            FUN_180ef77b0(param_1,pfVar10[1]);
          }
          if ((pfVar10[6] == 0.0) && (pfVar10[5] == 2.66247e-44)) {
            *(uint *)(param_1 + 0x10c) = *(uint *)(param_1 + 0x13c) ^ 1;
            *(float *)(param_1 + 0xb4) = *pfVar10 + *(float *)(param_1 + 0xb4);
          }
        }
LAB_180efee5d:
        iVar6 = *(int *)(lVar9 + 0x154 + param_1);
        if (((((iVar6 == 1) || (iVar6 == 2)) || (iVar6 == 4)) || (iVar6 == 0x2b)) &&
           ((int)uVar12 == 0)) {
          pfVar10 = (float *)(param_1 + 0x140 + lVar9);
          if (pfVar10 != (float *)0x0) {
            iVar6 = *(int *)(param_1 + 0xad0);
            fVar17 = *pfVar10;
            *(undefined4 *)(param_1 + 0x50) = 1;
            if (((iVar6 == 1) || (iVar6 == 2)) || ((iVar6 == 4 || (bVar4 = false, iVar6 == 0x2b))))
            {
              bVar4 = true;
            }
            local_98 = 0;
            local_90 = 0.0;
            if ((DAT_181a08d00 != (longlong *)0x0) && (*plVar15 != 0)) {
              (**(code **)(*DAT_181a08d00 + 0x60))(DAT_181a08d00,*plVar15,&local_98);
            }
            (**(code **)(*DAT_181a08d00 + 0x80))(DAT_181a08d00,*plVar15,&local_a8);
            if (*(int *)(param_1 + 0x54) == 0) {
              if (bVar4) {
                (**(code **)(*DAT_181a08d08 + 0x90))(DAT_181a08d08,*plVar15,0,0,0x20000);
                goto LAB_180eff00a;
              }
            }
            else {
              fVar16 = local_a8 * local_a8 + local_a4 * local_a4 + local_a0 * local_a0;
              if (fVar16 < 0.0) {
                fVar16 = sqrtf(fVar16);
              }
              else {
                fVar16 = SQRT(fVar16);
              }
              if (0.01 < fVar16) {
LAB_180efef97:
                bVar4 = true;
              }
              else {
                fVar16 = local_98._4_4_ * local_98._4_4_ + (float)local_98 * (float)local_98 +
                         local_90 * local_90;
                if (fVar16 < 0.0) {
                  fVar16 = sqrtf(fVar16);
                }
                else {
                  fVar16 = SQRT(fVar16);
                }
                bVar4 = false;
                if (0.01 < fVar16) goto LAB_180efef97;
              }
              (**(code **)(*DAT_181a08d08 + 0x90))(DAT_181a08d08,*plVar15,0,0,0x20000);
              if (bVar4) {
                if ((0.0 < local_98._4_4_) || (0.0 < local_a4)) {
                  local_98 = local_98 & 0xffffffff;
                  local_a4 = 0.0;
                }
              }
              else {
LAB_180eff00a:
                local_a4 = local_a4 + fVar17;
              }
            }
            (**(code **)(*DAT_181a08d00 + 0x68))(DAT_181a08d00,*plVar15,&local_98);
            (**(code **)(*DAT_181a08d00 + 0x88))(DAT_181a08d00,*plVar15,&local_a8);
          }
          uVar12 = 1;
        }
        fVar17 = (float)FUN_180bfe360(DAT_181a08d38);
        if (((DAT_181a2b640 == (longlong *)0x0) || (DAT_181a2b638 == 0)) ||
           (fVar16 = (float)(**(code **)(*DAT_181a2b640 + 0xf8))(), fVar16 <= 0.0)) {
          fVar16 = fVar17;
          if (!bVar3) {
            fVar16 = 0.011904762;
          }
          *(float *)(param_1 + 0x98) =
               fVar16 * *(float *)(lVar9 + 0x148 + param_1) + *(float *)(param_1 + 0x98);
          fVar16 = fVar16 * *(float *)(lVar9 + 0x150 + param_1);
        }
        else {
          *(float *)(param_1 + 0x98) =
               *(float *)(lVar9 + 0x148 + param_1) * 0.0077 + *(float *)(param_1 + 0x98);
          fVar16 = *(float *)(lVar9 + 0x150 + param_1) * 0.0077;
        }
        *(float *)(param_1 + 0xa0) = fVar16 + *(float *)(param_1 + 0xa0);
        *(float *)(param_1 + 0x9c) =
             fVar17 * *(float *)(lVar9 + 0x14c + param_1) + *(float *)(param_1 + 0x9c);
      }
      uVar7 = (int)uVar8 + 1;
      uVar8 = (ulonglong)uVar7;
    } while (uVar7 < *(uint *)(param_1 + 0x440));
  }
  return;
}

