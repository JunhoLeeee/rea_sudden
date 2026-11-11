
void FUN_1810c62b0(longlong *param_1,float *param_2,uint param_3,int param_4)

{
  code *pcVar1;
  char cVar2;
  char cVar3;
  byte bVar4;
  undefined4 uVar5;
  undefined4 uVar6;
  int iVar7;
  longlong lVar8;
  longlong lVar9;
  undefined8 uVar10;
  undefined8 uVar11;
  longlong *plVar12;
  float fVar13;
  float fVar14;
  float fVar15;
  float fVar16;
  float fVar17;
  float fVar18;
  longlong *local_res8;
  longlong *local_res10;
  float local_148;
  float local_144;
  float local_140;
  float local_13c;
  float local_138;
  float local_134;
  undefined8 local_130;
  undefined4 local_128;
  undefined4 local_124;
  code *local_120;
  undefined8 local_118;
  undefined8 local_110;
  undefined8 local_108;
  undefined8 local_100;
  undefined8 local_f8;
  float local_f0;
  undefined8 local_e8;
  undefined8 uStack_e0;
  undefined8 local_d8;
  undefined4 local_d0;
  undefined8 local_c8;
  undefined8 local_c0;
  undefined4 local_b8;
  
  fVar17 = *(float *)(param_1 + 0x11) - param_2[2];
  fVar18 = *(float *)((longlong)param_1 + 0x84) - param_2[1];
  fVar15 = *(float *)(param_1 + 0x10) - *param_2;
  fVar14 = fVar18 * fVar18 + fVar15 * fVar15 + fVar17 * fVar17;
  if (fVar14 < 0.0) {
    fVar14 = sqrtf(fVar14);
  }
  else {
    fVar14 = SQRT(fVar14);
  }
  lVar8 = FUN_180c64490(DAT_181a0e3a0,param_3);
  if (lVar8 == 0) {
    return;
  }
  uVar5 = FUN_180c58c50(lVar8);
  lVar9 = FUN_180c64560(DAT_181a0e3a0,uVar5);
  if (0 < param_4) {
    lVar9 = FUN_180c64560(DAT_181a0e3a0,param_4);
  }
  if (lVar9 == 0) {
    return;
  }
  if ((float)*(int *)(lVar9 + 8) < fVar14) {
    return;
  }
  local_e8 = 0;
  uStack_e0 = 0;
  local_d8 = 0;
  local_d0 = 0;
  local_c8 = 0;
  local_c0 = 0xffffffffffffffff;
  local_b8 = 0;
  local_110 = 0;
  local_118 = 0;
  local_100 = 0;
  local_108 = 0;
  local_130 = 0;
  local_128 = 0;
  local_124 = 7;
  local_120 = FUN_1810c9b80;
  fVar16 = 1.0;
  fVar13 = 1.0 / fVar14;
  local_140 = fVar13 * fVar17 + *(float *)(param_1 + 0x11);
  local_144 = fVar13 * fVar18 + *(float *)((longlong)param_1 + 0x84);
  local_148 = fVar15 * fVar13 + *(float *)(param_1 + 0x10);
  local_13c = *param_2;
  local_138 = param_2[1];
  local_134 = param_2[2];
  if (DAT_181a2b600 == 0) {
    cVar2 = (**(code **)(*DAT_181952a40 + 0x218))(DAT_181952a40,&local_148,&local_e8,0);
  }
  else {
    pcVar1 = *(code **)(*DAT_181952a40 + 0x218);
    uVar10 = FUN_180ef9480();
    cVar2 = (*pcVar1)(DAT_181952a40,&local_148,&local_e8,uVar10);
  }
  local_148 = *param_2;
  local_144 = param_2[1];
  local_140 = param_2[2];
  local_134 = fVar13 * fVar17 + *(float *)(param_1 + 0x11);
  local_138 = fVar13 * fVar18 + *(float *)((longlong)param_1 + 0x84);
  local_13c = fVar15 * fVar13 + *(float *)(param_1 + 0x10);
  if (DAT_181a2b600 == 0) {
    cVar3 = (**(code **)(*DAT_181952a40 + 0x218))(DAT_181952a40,&local_148,&local_e8,0);
  }
  else {
    pcVar1 = *(code **)(*DAT_181952a40 + 0x218);
    uVar10 = FUN_180ef9480();
    cVar3 = (*pcVar1)(DAT_181952a40,&local_148,&local_e8,uVar10);
  }
  if (((cVar2 != '\0') || (cVar3 != '\0')) && (*(int *)(lVar9 + 0x14) != 0x3d)) {
    return;
  }
  if ((char)param_1[0x24a] != '\0') goto LAB_1810c69b0;
  fVar15 = (float)*(int *)(lVar9 + 8) * 0.25;
  if (fVar15 < fVar14) {
    fVar15 = (fVar14 - fVar15) / ((float)*(int *)(lVar9 + 8) - fVar15);
    fVar14 = 0.0;
    if (0.0 <= fVar15) {
      fVar14 = fVar15;
    }
    fVar16 = 1.0;
    if (fVar14 <= 1.0) {
      fVar16 = fVar14;
    }
    fVar16 = 1.0 - fVar16;
  }
  fVar16 = (float)*(int *)(lVar9 + 4) * fVar16;
  fVar15 = 0.0;
  fVar14 = *(float *)(param_1 + 0x2f);
  if (fVar14 != 0.0) {
    fVar14 = (float)FUN_180bf8910();
    fVar14 = (fVar14 + 0.6) * fVar16;
    fVar15 = 100.0;
    if (fVar14 <= 100.0) {
      fVar15 = fVar14;
    }
    fVar16 = fVar16 - fVar15;
    fVar14 = *(float *)(param_1 + 0x2f);
  }
  if (*(int *)(lVar9 + 0x14) == 0x3d) {
    fVar16 = (float)*(int *)(lVar9 + 4);
  }
  *(float *)((longlong)param_1 + 0x174) = *(float *)((longlong)param_1 + 0x174) - fVar16;
  *(float *)(param_1 + 0x2f) = fVar14 - fVar15;
  if ((0.0 < fVar16) && ((int)param_1[0x30] == 0)) {
    if (DAT_181a19c68 != 0) {
      FUN_180d41ed0(DAT_181a19c68,param_3,(longlong)fVar16,0);
    }
    cVar2 = FUN_180c5a240(lVar8);
    uVar10 = FUN_180c6f820();
    uVar11 = FUN_180c6f820();
    uVar5 = FUN_180c71410(uVar11);
    uVar5 = FUN_180c71f40(uVar10,uVar5);
    uVar10 = FUN_180c6f820();
    uVar6 = FUN_180c736d0(uVar10);
    cVar3 = FUN_180d9fbf0(DAT_181a1d4f8,uVar5,uVar6);
    if (cVar3 == '\0') {
      uVar10 = FUN_180c6f820();
      bVar4 = FUN_180c7eee0(uVar10);
      if ((bVar4 < 2) && (cVar2 == '\0')) goto LAB_1810c699d;
    }
    local_res8 = (longlong *)0x0;
    iVar7 = (**(code **)(*DAT_181a08d08 + 0x48))(DAT_181a08d08,&local_res8);
    if (iVar7 == 0) {
      (**(code **)(*local_res8 + 8))();
    }
    else {
      local_res8 = (longlong *)0x0;
    }
    (**(code **)(*local_res8 + 0x48))(local_res8,1,1);
    (**(code **)(*local_res8 + 0x48))(local_res8,0,1);
    (**(code **)(*local_res8 + 0x48))(local_res8,0xff,8);
    (**(code **)(*local_res8 + 0x48))(local_res8,(int)fVar16 & 0xffff,0x10);
    uVar10 = FUN_180c6f820();
    bVar4 = FUN_180c7eee0(uVar10);
    if (bVar4 < 2) {
      uVar10 = FUN_180c6f820();
      cVar3 = FUN_180c7eee0(uVar10);
      if ((cVar3 != '\0') && (cVar3 = FUN_180c170c0(DAT_181a08d38,2), cVar3 != '\0'))
      goto LAB_1810c685e;
      uVar10 = FUN_180c6f820();
      uVar5 = FUN_180c736d0(uVar10);
      uVar10 = FUN_180c6f820();
      uVar11 = FUN_180c6f820();
      uVar6 = FUN_180c71410(uVar11);
      uVar6 = FUN_180c71f40(uVar10,uVar6);
      cVar3 = FUN_180d9fcd0(DAT_181a1d4f8,uVar6,uVar5);
      if ((cVar3 != '\0') || (cVar2 != '\0')) goto LAB_1810c685e;
      (**(code **)(*local_res8 + 0x48))(local_res8,0,1);
    }
    else {
LAB_1810c685e:
      (**(code **)(*local_res8 + 0x48))(local_res8,1,1);
      fVar14 = *(float *)((longlong)param_1 + 0x174);
      if (fVar14 <= 0.0) {
        fVar14 = 0.0;
      }
      (**(code **)(*local_res8 + 0x48))(local_res8,(int)fVar14 & 0xffff,0x10);
    }
    uVar10 = FUN_180c6f820();
    uVar5 = FUN_180c736d0(uVar10);
    (**(code **)(*local_res8 + 0x48))(local_res8,uVar5,0x20);
    (**(code **)(*local_res8 + 0x48))(local_res8,0xffff,0x10);
    (**(code **)(*local_res8 + 0x48))(local_res8,0,1);
    (**(code **)(*local_res8 + 0x48))(local_res8,0,1);
    (**(code **)(*local_res8 + 0x48))(local_res8,cVar2 != '\0',1);
    if (cVar2 != '\0') {
      (**(code **)(*local_res8 + 0x48))(local_res8,param_3 & 0xffff,0x10);
    }
    pcVar1 = *(code **)(*DAT_181a19238 + 0x68);
    plVar12 = (longlong *)(**(code **)(*local_res8 + 0x38))();
    local_res10 = plVar12;
    if (plVar12 != (longlong *)0x0) {
      (**(code **)(*plVar12 + 8))(plVar12);
    }
    (*pcVar1)(DAT_181a19238,0x93,plVar12);
    if (plVar12 != (longlong *)0x0) {
      (**(code **)(*plVar12 + 0x10))(plVar12);
    }
    if (local_res8 != (longlong *)0x0) {
      (**(code **)(*local_res8 + 0x10))();
    }
  }
LAB_1810c699d:
  if (*(float *)(param_1 + 0x2f) <= 0.0 && *(float *)(param_1 + 0x2f) != 0.0) {
    *(undefined4 *)(param_1 + 0x2f) = 0;
  }
LAB_1810c69b0:
  if (*(float *)((longlong)param_1 + 0x174) <= 0.0) {
    if ((int)param_1[0x30] == 0) {
      local_f8 = *(undefined8 *)param_2;
      local_f0 = param_2[2];
      (**(code **)(*param_1 + 0x138))(param_1,7,4,&local_f8,0);
      (**(code **)(*param_1 + 0x150))(param_1,param_3,param_4,0);
    }
  }
  else {
    (**(code **)(*param_1 + 0x130))(param_1,4);
    if ((DAT_1819ecdd0 != 0) && (*(int *)(lVar9 + 0x14) != 0x3d)) {
      FUN_1806df270(DAT_1819ecdd0,0);
    }
  }
  FUN_180ebf0b0(DAT_181a08d38 + 0xef88,param_1[3],param_2,*(undefined4 *)(lVar9 + 0x20));
  return;
}

