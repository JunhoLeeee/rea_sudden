
void FUN_1806dea80(longlong param_1)

{
  uint uVar1;
  longlong lVar2;
  undefined4 uVar3;
  undefined4 uVar4;
  undefined4 uVar5;
  undefined4 *puVar6;
  longlong *plVar7;
  uint uVar8;
  undefined4 local_res10 [6];
  undefined1 local_58 [16];
  undefined4 local_48 [2];
  longlong local_40;
  undefined8 local_38;
  longlong local_30 [4];
  undefined8 local_10;
  
  puVar6 = (undefined4 *)FUN_1801df730();
  local_48[0] = *puVar6;
  local_40 = 0;
  local_38 = 0;
  local_40 = FUN_181387aac(0x38);
  *(longlong *)local_40 = local_40;
  *(longlong *)(local_40 + 8) = local_40;
  local_30[0] = 0;
  local_30[1] = 0;
  local_30[2] = 0;
  local_30[3] = *(longlong *)(puVar6 + 0xc);
  local_10 = *(undefined8 *)(puVar6 + 0xe);
  FUN_1801e00e0(local_30,*(longlong *)(puVar6 + 8) - *(longlong *)(puVar6 + 6) >> 3,local_40);
  FUN_1806da3d0(local_48,**(undefined8 **)(puVar6 + 2));
  local_res10[0] = 1;
  plVar7 = (longlong *)FUN_1806d9dc0(local_48,local_58,local_res10);
  lVar2 = *plVar7;
  uVar3 = *(undefined4 *)(lVar2 + 0x18);
  uVar4 = *(undefined4 *)(lVar2 + 0x1c);
  uVar5 = *(undefined4 *)(lVar2 + 0x20);
  *(undefined4 *)(param_1 + 0x1308) = *(undefined4 *)(lVar2 + 0x14);
  *(undefined4 *)(param_1 + 0x130c) = uVar3;
  *(undefined4 *)(param_1 + 0x1310) = uVar4;
  *(undefined4 *)(param_1 + 0x1314) = uVar5;
  uVar3 = *(undefined4 *)(lVar2 + 0x28);
  uVar4 = *(undefined4 *)(lVar2 + 0x2c);
  uVar5 = *(undefined4 *)(lVar2 + 0x30);
  *(undefined4 *)(param_1 + 0x1318) = *(undefined4 *)(lVar2 + 0x24);
  *(undefined4 *)(param_1 + 0x131c) = uVar3;
  *(undefined4 *)(param_1 + 0x1320) = uVar4;
  *(undefined4 *)(param_1 + 0x1324) = uVar5;
  *(undefined4 *)(param_1 + 0x1328) = *(undefined4 *)(lVar2 + 0x34);
  uVar8 = *(byte *)(param_1 + 0x4b4) + 1;
  plVar7 = (longlong *)
           ((local_30[3] &
            (((ulonglong)uVar8 & 0xff ^ 0xcbf29ce484222325) * 0x100000001b3 ^
            (ulonglong)(uVar8 >> 8)) * 0x8a97b0004e7feab) * 0x10 + local_30[0]);
  lVar2 = plVar7[1];
  if (lVar2 != local_40) {
    uVar1 = *(uint *)(lVar2 + 0x10);
    while (uVar8 != uVar1) {
      if (lVar2 == *plVar7) goto LAB_1806dec0d;
      lVar2 = *(longlong *)(lVar2 + 8);
      uVar1 = *(uint *)(lVar2 + 0x10);
    }
    if ((lVar2 != 0) && (lVar2 != local_40)) {
      uVar3 = *(undefined4 *)(lVar2 + 0x18);
      uVar4 = *(undefined4 *)(lVar2 + 0x1c);
      uVar5 = *(undefined4 *)(lVar2 + 0x20);
      *(undefined4 *)(param_1 + 0x1308) = *(undefined4 *)(lVar2 + 0x14);
      *(undefined4 *)(param_1 + 0x130c) = uVar3;
      *(undefined4 *)(param_1 + 0x1310) = uVar4;
      *(undefined4 *)(param_1 + 0x1314) = uVar5;
      uVar3 = *(undefined4 *)(lVar2 + 0x28);
      uVar4 = *(undefined4 *)(lVar2 + 0x2c);
      uVar5 = *(undefined4 *)(lVar2 + 0x30);
      *(undefined4 *)(param_1 + 0x1318) = *(undefined4 *)(lVar2 + 0x24);
      *(undefined4 *)(param_1 + 0x131c) = uVar3;
      *(undefined4 *)(param_1 + 0x1320) = uVar4;
      *(undefined4 *)(param_1 + 0x1324) = uVar5;
      *(undefined4 *)(param_1 + 0x1328) = *(undefined4 *)(lVar2 + 0x34);
    }
  }
LAB_1806dec0d:
  FUN_1801df3a0(local_48);
  return;
}

