
undefined8 FUN_1402ace30(undefined4 *param_1,int param_2)

{
  undefined4 uVar1;
  longlong lVar2;
  int iVar3;
  int iVar4;
  longlong lVar5;
  longlong lVar6;
  
  lVar2 = *(longlong *)(param_1 + 0x28);
  lVar6 = (longlong)param_2;
  iVar4 = (int)(*(longlong *)(param_1 + 0x2a) - lVar2 >> 0x3f);
  iVar3 = (int)((*(longlong *)(param_1 + 0x2a) - lVar2) / 0x94) + iVar4;
  if ((param_2 < iVar3 - iVar4) && (iVar3 != iVar4)) {
    lVar5 = lVar6 * 0x94;
    *param_1 = *(undefined4 *)(lVar5 + lVar2);
    param_1[1] = *(undefined4 *)(lVar5 + 4 + lVar2);
    param_1[2] = *(undefined4 *)(lVar5 + 8 + lVar2);
    param_1[3] = *(undefined4 *)(lVar5 + 0xc + lVar2);
    param_1[4] = *(undefined4 *)(lVar5 + 0x10 + lVar2);
    param_1[5] = *(undefined4 *)(lVar5 + 0x14 + lVar2);
    param_1[6] = *(undefined4 *)(lVar5 + 0x18 + lVar2);
    param_1[7] = *(undefined4 *)(lVar5 + 0x1c + lVar2);
    param_1[8] = *(undefined4 *)(lVar5 + 0x20 + lVar2);
    param_1[9] = *(undefined4 *)(lVar5 + 0x24 + lVar2);
    param_1[10] = *(undefined4 *)(lVar5 + 0x28 + lVar2);
    param_1[0xb] = *(undefined4 *)(lVar5 + 0x2c + lVar2);
    param_1[0xc] = *(undefined4 *)(lVar5 + 0x30 + lVar2);
    param_1[0xd] = *(undefined4 *)(lVar5 + 0x34 + lVar2);
    param_1[0xe] = *(undefined4 *)(lVar5 + 0x38 + lVar2);
    param_1[0xf] = *(undefined4 *)(lVar5 + 0x3c + lVar2);
    param_1[0x10] = *(undefined4 *)(lVar5 + 0x40 + lVar2);
    param_1[0x11] = *(undefined4 *)(lVar5 + 0x44 + lVar2);
    param_1[0x12] = *(undefined4 *)(lVar5 + 0x48 + lVar2);
    param_1[0x13] = *(undefined4 *)(lVar5 + 0x4c + lVar2);
    param_1[0x24] = *(undefined4 *)(lVar5 + 0x90 + lVar2);
    param_1[0x26] = param_2 * param_1[0x25];
    param_1[0x14] = *(undefined4 *)(lVar2 + 0x50 + lVar6 * 0x94);
    param_1[0x15] = *(undefined4 *)(lVar2 + 0x54 + lVar6 * 0x94);
    param_1[0x16] = *(undefined4 *)(lVar2 + 0x58 + lVar6 * 0x94);
    param_1[0x17] = *(undefined4 *)(lVar2 + 0x5c + lVar6 * 0x94);
    param_1[0x18] = *(undefined4 *)(lVar2 + 0x60 + lVar6 * 0x94);
    param_1[0x19] = *(undefined4 *)(lVar2 + 100 + lVar6 * 0x94);
    param_1[0x1a] = *(undefined4 *)(lVar2 + 0x68 + lVar6 * 0x94);
    param_1[0x1b] = *(undefined4 *)(lVar2 + 0x6c + lVar6 * 0x94);
    param_1[0x1c] = *(undefined4 *)(lVar2 + 0x70 + lVar6 * 0x94);
    param_1[0x1d] = *(undefined4 *)(lVar2 + 0x74 + lVar6 * 0x94);
    param_1[0x1e] = *(undefined4 *)(lVar2 + 0x78 + lVar6 * 0x94);
    param_1[0x1f] = *(undefined4 *)(lVar2 + 0x7c + lVar6 * 0x94);
    param_1[0x20] = *(undefined4 *)(lVar2 + 0x80 + lVar6 * 0x94);
    param_1[0x21] = *(undefined4 *)(lVar2 + 0x84 + lVar6 * 0x94);
    param_1[0x22] = *(undefined4 *)(lVar2 + 0x88 + lVar6 * 0x94);
    uVar1 = *(undefined4 *)(lVar2 + 0x8c + lVar6 * 0x94);
    param_1[0x23] = uVar1;
    return CONCAT71((uint7)(uint3)((uint)uVar1 >> 8),1);
  }
  return 0;
}

