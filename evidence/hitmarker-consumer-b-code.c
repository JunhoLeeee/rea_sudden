
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

void FUN_1806dee60(longlong param_1,int param_2,char param_3)

{
  uint uVar1;
  char cVar2;
  undefined4 uVar3;
  undefined4 uVar4;
  undefined4 uVar5;
  int iVar6;
  undefined8 uVar7;
  undefined4 *puVar8;
  longlong *plVar9;
  uint uVar10;
  char *pcVar11;
  longlong lVar12;
  int iVar13;
  ulonglong uVar14;
  undefined8 *puVar15;
  undefined1 auStack_218 [32];
  int local_1f8;
  undefined4 local_1f0;
  uint local_1e8;
  undefined1 local_1e4 [12];
  undefined4 local_1d8 [2];
  longlong local_1d0;
  undefined8 local_1c8;
  longlong local_1c0 [4];
  undefined8 local_1a0;
  undefined1 local_198 [16];
  char local_188 [7];
  char cStack_181;
  char local_180 [40];
  undefined1 local_158 [272];
  ulonglong local_48;
  
  local_48 = DAT_181905cc8 ^ (ulonglong)auStack_218;
  iVar13 = 0;
  puVar15 = &DAT_1819f7760;
  do {
    if (param_3 == '\0') {
      if ((*(int *)(param_1 + 0x4c4) == 0) || (pcVar11 = "Observer%d", param_2 != 8)) {
        pcVar11 = "Crosshair%d";
      }
      FUN_18006bc10(local_180,pcVar11,param_2);
      FUN_18006bc10(local_188,&DAT_18145ac10,iVar13);
      pcVar11 = &cStack_181;
      do {
        pcVar11 = pcVar11 + 1;
      } while (*pcVar11 != '\0');
      lVar12 = 0;
      do {
        cVar2 = local_188[lVar12];
        pcVar11[lVar12] = cVar2;
        lVar12 = lVar12 + 1;
      } while (cVar2 != '\0');
      iVar6 = FUN_18105a2d0(DAT_1819ed0b0,"HUDCrosshair",local_180);
      if (iVar6 == 0) break;
      local_1f8 = 0x104;
      FUN_18105a400(DAT_1819ed0b0,"HUDCrosshair",local_180,local_158);
    }
    else {
      local_1f8 = iVar13;
      snprintf(local_158,0x103,"sa_interface\\hud\\crosshair\\add_%d\\crosshair_%02d.dtx",param_2);
    }
    uVar7 = FUN_180d617b0(DAT_181a1b390,local_158,1);
    *puVar15 = uVar7;
    (**(code **)(*DAT_181952a58 + 0x30))(DAT_181952a58,uVar7,&local_1e8,local_1e4);
    *(float *)(param_1 + 0x4b0) = (float)local_1e8;
    local_1f0 = 0x3f800000;
    local_1f8 = 0x3f800000;
    FUN_1800abe00(param_1 + 0x78,*puVar15,0,0);
    iVar13 = iVar13 + 1;
    puVar15 = puVar15 + 1;
  } while (iVar13 < 10);
  *(char *)(param_1 + 0x4b4) = (char)param_2;
  puVar8 = (undefined4 *)FUN_1801df730();
  local_1d8[0] = *puVar8;
  local_1d0 = 0;
  local_1c8 = 0;
  local_1d0 = FUN_181387aac(0x38);
  *(longlong *)local_1d0 = local_1d0;
  *(longlong *)(local_1d0 + 8) = local_1d0;
  local_1c0[0] = 0;
  local_1c0[1] = 0;
  local_1c0[2] = 0;
  local_1c0[3] = *(longlong *)(puVar8 + 0xc);
  local_1a0 = *(undefined8 *)(puVar8 + 0xe);
  FUN_1801e00e0(local_1c0,*(longlong *)(puVar8 + 8) - *(longlong *)(puVar8 + 6) >> 3,local_1d0);
  FUN_1806da3d0(local_1d8,**(undefined8 **)(puVar8 + 2));
  local_1e8 = 1;
  plVar9 = (longlong *)FUN_1806d9dc0(local_1d8,local_198,&local_1e8);
  lVar12 = *plVar9;
  uVar3 = *(undefined4 *)(lVar12 + 0x18);
  uVar4 = *(undefined4 *)(lVar12 + 0x1c);
  uVar5 = *(undefined4 *)(lVar12 + 0x20);
  *(undefined4 *)(param_1 + 0x1308) = *(undefined4 *)(lVar12 + 0x14);
  *(undefined4 *)(param_1 + 0x130c) = uVar3;
  *(undefined4 *)(param_1 + 0x1310) = uVar4;
  *(undefined4 *)(param_1 + 0x1314) = uVar5;
  uVar3 = *(undefined4 *)(lVar12 + 0x28);
  uVar4 = *(undefined4 *)(lVar12 + 0x2c);
  uVar5 = *(undefined4 *)(lVar12 + 0x30);
  *(undefined4 *)(param_1 + 0x1318) = *(undefined4 *)(lVar12 + 0x24);
  *(undefined4 *)(param_1 + 0x131c) = uVar3;
  *(undefined4 *)(param_1 + 0x1320) = uVar4;
  *(undefined4 *)(param_1 + 0x1324) = uVar5;
  *(undefined4 *)(param_1 + 0x1328) = *(undefined4 *)(lVar12 + 0x34);
  uVar10 = *(byte *)(param_1 + 0x4b4) + 1;
  uVar14 = local_1c0[3] &
           (((ulonglong)uVar10 & 0xff ^ 0xcbf29ce484222325) * 0x100000001b3 ^
           (ulonglong)(uVar10 >> 8)) * 0x8a97b0004e7feab;
  lVar12 = *(longlong *)(local_1c0[0] + 8 + uVar14 * 0x10);
  if (lVar12 != local_1d0) {
    uVar1 = *(uint *)(lVar12 + 0x10);
    while (uVar10 != uVar1) {
      if (lVar12 == *(longlong *)(local_1c0[0] + uVar14 * 0x10)) goto LAB_1806df177;
      lVar12 = *(longlong *)(lVar12 + 8);
      uVar1 = *(uint *)(lVar12 + 0x10);
    }
    if ((lVar12 != 0) && (lVar12 != local_1d0)) {
      uVar3 = *(undefined4 *)(lVar12 + 0x18);
      uVar4 = *(undefined4 *)(lVar12 + 0x1c);
      uVar5 = *(undefined4 *)(lVar12 + 0x20);
      *(undefined4 *)(param_1 + 0x1308) = *(undefined4 *)(lVar12 + 0x14);
      *(undefined4 *)(param_1 + 0x130c) = uVar3;
      *(undefined4 *)(param_1 + 0x1310) = uVar4;
      *(undefined4 *)(param_1 + 0x1314) = uVar5;
      uVar3 = *(undefined4 *)(lVar12 + 0x28);
      uVar4 = *(undefined4 *)(lVar12 + 0x2c);
      uVar5 = *(undefined4 *)(lVar12 + 0x30);
      *(undefined4 *)(param_1 + 0x1318) = *(undefined4 *)(lVar12 + 0x24);
      *(undefined4 *)(param_1 + 0x131c) = uVar3;
      *(undefined4 *)(param_1 + 0x1320) = uVar4;
      *(undefined4 *)(param_1 + 0x1324) = uVar5;
      *(undefined4 *)(param_1 + 0x1328) = *(undefined4 *)(lVar12 + 0x34);
    }
  }
LAB_1806df177:
  FUN_1801df3a0(local_1d8);
  return;
}

