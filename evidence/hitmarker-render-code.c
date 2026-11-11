
void FUN_1806e0120(longlong param_1)

{
  ushort uVar1;
  ushort uVar2;
  char cVar3;
  int iVar4;
  uint uVar5;
  ushort uVar6;
  ushort uVar7;
  byte bVar8;
  longlong *plVar9;
  ulonglong uVar10;
  uint uVar11;
  short sVar12;
  uint uVar13;
  ushort uVar14;
  ushort uVar15;
  float fVar16;
  float fVar17;
  uint local_res20;
  uint local_res24;
  
  cVar3 = FUN_1806db1c0();
  if (cVar3 == '\0') {
    return;
  }
  iVar4 = (**(code **)(*(longlong *)(param_1 + 0x768) + 0x1d0))(param_1 + 0x768);
  if (iVar4 == 0) {
    return;
  }
  fVar16 = (float)(**(code **)(*DAT_181952a40 + 0x118))();
  fVar17 = *(float *)(param_1 + 0x1320);
  fVar16 = fVar16 + *(float *)(param_1 + 0x132c);
  uVar15 = *(ushort *)(param_1 + 0x130c);
  bVar8 = *(byte *)(param_1 + 0x1334);
  uVar14 = *(ushort *)(param_1 + 0x1310);
  uVar5 = (uint)bVar8;
  *(float *)(param_1 + 0x132c) = fVar16;
  if (fVar16 < fVar17) {
    if (fVar17 <= 0.0) {
      fVar17 = 1.0;
    }
    else {
      fVar16 = fVar16 / fVar17;
      fVar17 = 1.0;
      if ((fVar16 <= 1.0) && (fVar17 = fVar16, fVar16 < 0.0)) {
        fVar17 = 0.0;
      }
    }
    fVar17 = (float)roundf((float)uVar15 * fVar17);
    uVar15 = (ushort)(int)fVar17;
    goto LAB_1806e0222;
  }
  if (fVar16 <= *(float *)(param_1 + 0x1324) + fVar17) goto LAB_1806e0222;
  if (*(float *)(param_1 + 0x1328) <= 0.0) {
LAB_1806e0356:
    fVar17 = 0.0;
  }
  else {
    fVar16 = 1.0 - ((fVar16 - fVar17) - *(float *)(param_1 + 0x1324)) / *(float *)(param_1 + 0x1328)
    ;
    fVar17 = 1.0;
    if ((fVar16 <= 1.0) && (fVar17 = fVar16, fVar16 < 0.0)) goto LAB_1806e0356;
  }
  fVar16 = (float)roundf((float)uVar15 * fVar17);
  uVar14 = uVar14 + (uVar15 - (ushort)(int)fVar16);
  fVar17 = (float)roundf((float)bVar8 * fVar17);
  uVar5 = (uint)fVar17;
  uVar15 = (ushort)(int)fVar16;
LAB_1806e0222:
  plVar9 = (longlong *)(param_1 + 0x768);
  bVar8 = 0;
  uVar11 = (uint)(*(float *)(param_1 + 0x6e8) + 0.5);
  uVar13 = (uint)(*(float *)(param_1 + 0x6ec) + 0.5);
  do {
    uVar1 = *(ushort *)(param_1 + 0x130e);
    uVar10 = 0;
    uVar6 = uVar15;
    uVar2 = uVar1;
    if (1 < bVar8) {
      uVar6 = uVar1;
      uVar2 = uVar15;
    }
    sVar12 = (short)uVar13;
    uVar7 = sVar12 - (uVar1 >> 1);
    if (1 < bVar8) {
      uVar7 = 0;
    }
    if (1 < bVar8) {
      uVar10 = (ulonglong)(ushort)((short)uVar11 - (uVar1 >> 1));
    }
    if (bVar8 == 0) {
      uVar10 = (ulonglong)(ushort)(((short)uVar11 - uVar14) - uVar15);
    }
    else if (bVar8 == 1) {
      uVar10 = (ulonglong)(uVar14 + uVar11);
    }
    else if (bVar8 == 2) {
      uVar7 = (sVar12 - uVar14) - uVar15;
    }
    else if (bVar8 == 3) {
      uVar7 = uVar14 + sVar12;
    }
    (**(code **)(*plVar9 + 0xa8))(plVar9,(ulonglong)uVar7 << 0x20 | uVar10 & 0xffff);
    (**(code **)(*plVar9 + 0xa0))(plVar9,uVar6,uVar2);
    FUN_180b44880(plVar9,(float)(uVar5 & 0xff) / 255.0);
    if (*(short *)(param_1 + 0x130a) == 0) {
      local_res20 = uVar11 & 0xffff;
      local_res24 = uVar13 & 0xffff;
      FUN_180b44750(plVar9,&local_res20,0x42340000);
    }
    bVar8 = bVar8 + 1;
    plVar9 = plVar9 + 0x5d;
  } while (bVar8 < 4);
  plVar9 = (longlong *)(param_1 + 0x768);
  if (*(float *)(param_1 + 0x1324) + *(float *)(param_1 + 0x1320) + *(float *)(param_1 + 0x1328) <
      *(float *)(param_1 + 0x132c)) {
    for (; plVar9 != (longlong *)(param_1 + 0x1308); plVar9 = plVar9 + 0x5d) {
      (**(code **)(*plVar9 + 0x198))(plVar9,0);
    }
  }
  return;
}

