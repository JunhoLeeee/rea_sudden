
void FUN_1402ad1f0(uint *param_1)

{
  uint uVar1;
  uint uVar2;
  uint uVar3;
  uint uVar4;
  uint uVar5;
  uint uVar6;
  uint uVar7;
  uint uVar8;
  uint uVar9;
  uint uVar10;
  uint uVar11;
  uint uVar12;
  uint uVar13;
  uint uVar14;
  uint uVar15;
  
  uVar10 = param_1[0xd];
  uVar11 = param_1[0xc];
  uVar6 = param_1[0x12];
  uVar12 = *(uint *)(&DAT_1403ef1a0 + (ulonglong)(param_1[0xf] >> 0x18) * 4) ^
           *(uint *)(&DAT_1403ef5a0 + (ulonglong)(param_1[4] & 0xff) * 4) ^ param_1[4] >> 8 ^
           param_1[0xf] << 8 ^ uVar10;
  uVar4 = param_1[10] + param_1[0x13];
  uVar7 = *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar6 & 0xff) * 4);
  param_1[0xf] = uVar12;
  uVar9 = param_1[0xe];
  uVar6 = uVar7 ^ *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar6 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar6 >> 0x10 & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar6 >> 8 & 0xff) * 4);
  uVar7 = *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar9 >> 0x18) * 4);
  param_1[0x14] = uVar4 + uVar12 ^ uVar9 ^ uVar6;
  uVar6 = uVar6 + param_1[9];
  uVar1 = uVar7 ^ *(uint *)(&DAT_1403ef5a0 + (ulonglong)(param_1[3] & 0xff) * 4) ^ param_1[3] >> 8 ^
          uVar9 << 8 ^ uVar11;
  param_1[0xe] = uVar1;
  uVar7 = *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar4 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar4 >> 0x10 & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar4 >> 8 & 0xff) * 4) ^
          *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar4 & 0xff) * 4);
  uVar9 = *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar10 >> 0x18) * 4);
  uVar4 = param_1[0xb];
  param_1[0x15] = uVar6 + uVar1 ^ uVar10 ^ uVar7;
  uVar14 = uVar9 ^ *(uint *)(&DAT_1403ef5a0 + (ulonglong)(param_1[2] & 0xff) * 4) ^ uVar10 << 8 ^
           param_1[2] >> 8 ^ uVar4;
  uVar7 = uVar7 + param_1[8];
  uVar10 = *(uint *)(&DAT_1403ef9a0 + ((ulonglong)uVar6 & 0xff) * 4);
  param_1[0xd] = uVar14;
  uVar9 = param_1[10];
  uVar6 = uVar10 ^ *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar6 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar6 >> 0x10 & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + ((ulonglong)(uVar6 >> 8) & 0xff) * 4);
  param_1[0x16] = uVar7 + uVar14 ^ uVar6 ^ uVar11;
  uVar13 = *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar11 >> 0x18) * 4) ^
           *(uint *)(&DAT_1403ef5a0 + (ulonglong)(param_1[1] & 0xff) * 4) ^ param_1[1] >> 8 ^
           uVar11 << 8 ^ uVar9;
  param_1[0xc] = uVar13;
  uVar10 = param_1[7];
  uVar6 = uVar6 + uVar10;
  uVar7 = *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar7 & 0xff) * 4) ^
          *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar7 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar7 >> 0x10 & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar7 >> 8 & 0xff) * 4);
  param_1[0x17] = uVar6 + uVar13 ^ uVar7 ^ uVar4;
  uVar2 = *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar4 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403ef5a0 + (ulonglong)(*param_1 & 0xff) * 4) ^ *param_1 >> 8 ^ uVar4 << 8
          ^ param_1[9];
  uVar11 = param_1[6];
  param_1[0xb] = uVar2;
  uVar7 = uVar7 + uVar11;
  uVar5 = *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar6 & 0xff) * 4) ^
          *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar6 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar6 >> 0x10 & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar6 >> 8 & 0xff) * 4);
  uVar6 = *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar9 >> 0x18) * 4);
  param_1[0x18] = uVar7 + uVar2 ^ uVar9 ^ uVar5;
  uVar3 = uVar6 ^ *(uint *)(&DAT_1403ef5a0 + (ulonglong)(uVar12 & 0xff) * 4) ^ uVar9 << 8 ^
          uVar12 >> 8 ^ param_1[8];
  uVar6 = param_1[5];
  uVar5 = uVar5 + uVar6;
  param_1[10] = uVar3;
  uVar9 = param_1[9];
  uVar8 = *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar7 & 0xff) * 4) ^
          *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar7 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + ((ulonglong)(uVar7 >> 0x10) & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar7 >> 8 & 0xff) * 4);
  param_1[0x19] = uVar5 + uVar3 ^ uVar8 ^ uVar9;
  uVar8 = param_1[4] + uVar8;
  uVar4 = *(uint *)(&DAT_1403ef5a0 + (ulonglong)(uVar1 & 0xff) * 4) ^
          *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar9 >> 0x18) * 4) ^ uVar1 >> 8 ^ uVar9 << 8 ^
          uVar10;
  param_1[9] = uVar4;
  uVar5 = *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar5 & 0xff) * 4) ^
          *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar5 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar5 >> 0x10 & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar5 >> 8 & 0xff) * 4);
  uVar7 = param_1[8];
  uVar9 = *(uint *)(&DAT_1403ef5a0 + (ulonglong)(uVar14 & 0xff) * 4);
  param_1[0x1a] = uVar4 + uVar8 ^ uVar5 ^ uVar7;
  uVar5 = param_1[3] + uVar5;
  uVar15 = uVar9 ^ *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar7 >> 0x18) * 4) ^ uVar14 >> 8 ^
           uVar7 << 8 ^ uVar11;
  uVar7 = *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar8 & 0xff) * 4);
  param_1[8] = uVar15;
  uVar9 = uVar7 ^ *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar8 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar8 >> 0x10 & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar8 >> 8 & 0xff) * 4);
  uVar7 = *(uint *)(&DAT_1403ef5a0 + (ulonglong)(uVar13 & 0xff) * 4);
  param_1[0x1b] = uVar15 + uVar5 ^ uVar9 ^ uVar10;
  uVar8 = uVar7 ^ *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar10 >> 0x18) * 4) ^ uVar13 >> 8 ^
          uVar10 << 8 ^ uVar6;
  param_1[7] = uVar8;
  uVar9 = param_1[2] + uVar9;
  uVar7 = *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar5 & 0xff) * 4) ^
          *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar5 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar5 >> 0x10 & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar5 >> 8 & 0xff) * 4);
  param_1[0x1c] = uVar8 + uVar9 ^ uVar7 ^ uVar11;
  uVar7 = param_1[1] + uVar7;
  uVar5 = *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar11 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403ef5a0 + (ulonglong)(uVar2 & 0xff) * 4) ^ uVar11 << 8 ^ uVar2 >> 8 ^
          param_1[4];
  param_1[6] = uVar5;
  uVar9 = *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar9 & 0xff) * 4) ^
          *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar9 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar9 >> 0x10 & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar9 >> 8 & 0xff) * 4);
  param_1[0x1d] = uVar7 + uVar5 ^ uVar9 ^ uVar6;
  uVar10 = param_1[3];
  uVar9 = *param_1 + uVar9;
  uVar3 = *(uint *)(&DAT_1403ef5a0 + (ulonglong)(uVar3 & 0xff) * 4) ^
          *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar6 >> 0x18) * 4) ^ uVar3 >> 8 ^ uVar6 << 8 ^
          uVar10;
  uVar6 = *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar7 & 0xff) * 4) ^
          *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar7 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar7 >> 0x10 & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar7 >> 8 & 0xff) * 4);
  uVar7 = param_1[4];
  param_1[0x1e] = uVar9 + uVar3 ^ uVar7 ^ uVar6;
  uVar11 = *(uint *)(&DAT_1403ef5a0 + (ulonglong)(uVar4 & 0xff) * 4);
  param_1[5] = uVar3;
  uVar4 = uVar11 ^ *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar7 >> 0x18) * 4) ^ uVar4 >> 8 ^
          uVar7 << 8 ^ param_1[2];
  param_1[4] = uVar4;
  uVar6 = uVar12 + uVar6;
  uVar7 = *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar9 & 0xff) * 4) ^
          *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar9 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar9 >> 0x10 & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar9 >> 8 & 0xff) * 4);
  uVar11 = param_1[1];
  uVar9 = *(uint *)(&DAT_1403ef5a0 + (ulonglong)(uVar15 & 0xff) * 4);
  param_1[0x1f] = uVar4 + uVar6 ^ uVar10 ^ uVar7;
  uVar10 = uVar9 ^ *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar10 >> 0x18) * 4) ^ uVar15 >> 8 ^
           uVar10 << 8 ^ uVar11;
  param_1[3] = uVar10;
  uVar7 = uVar7 + uVar1;
  uVar9 = *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar6 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar6 >> 0x10 & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar6 >> 8 & 0xff) * 4) ^
          *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar6 & 0xff) * 4);
  uVar6 = param_1[2];
  param_1[0x20] = uVar10 + uVar7 ^ uVar6 ^ uVar9;
  uVar10 = *param_1;
  uVar9 = uVar9 + uVar14;
  uVar6 = *(uint *)(&DAT_1403ef5a0 + (ulonglong)(uVar8 & 0xff) * 4) ^
          *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar6 >> 0x18) * 4) ^ uVar8 >> 8 ^ uVar6 << 8 ^
          uVar10;
  param_1[2] = uVar6;
  uVar7 = *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar7 & 0xff) * 4) ^
          *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar7 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + ((ulonglong)(uVar7 >> 0x10) & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar7 >> 8 & 0xff) * 4);
  param_1[0x21] = uVar6 + uVar9 ^ uVar11 ^ uVar7;
  uVar13 = uVar13 + uVar7;
  uVar6 = *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar9 & 0xff) * 4);
  uVar7 = *(uint *)(&DAT_1403ef5a0 + (ulonglong)(uVar5 & 0xff) * 4) ^
          *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar11 >> 0x18) * 4) ^ uVar5 >> 8 ^ uVar11 << 8 ^
          uVar12;
  param_1[1] = uVar7;
  uVar11 = uVar6 ^ *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar9 >> 0x18) * 4) ^
           *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar9 >> 0x10 & 0xff) * 4) ^
           *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar9 >> 8 & 0xff) * 4);
  param_1[0x22] = uVar7 + uVar13 ^ uVar11 ^ uVar10;
  uVar11 = uVar11 + uVar2;
  uVar6 = *(uint *)(&DAT_1403ef5a0 + (ulonglong)(uVar3 & 0xff) * 4);
  param_1[0x11] = uVar11;
  uVar7 = *(uint *)(&DAT_1403ef9a0 + (ulonglong)(uVar13 & 0xff) * 4);
  uVar1 = uVar6 ^ *(uint *)(&DAT_1403ef1a0 + (ulonglong)(uVar10 >> 0x18) * 4) ^ uVar3 >> 8 ^
          uVar10 << 8 ^ uVar1;
  *param_1 = uVar1;
  param_1[0x12] = uVar11;
  uVar6 = uVar7 ^ *(uint *)(&DAT_1403f05a0 + (ulonglong)(uVar13 >> 0x18) * 4) ^
          *(uint *)(&DAT_1403f01a0 + (ulonglong)(uVar13 >> 0x10 & 0xff) * 4) ^
          *(uint *)(&DAT_1403efda0 + (ulonglong)(uVar13 >> 8 & 0xff) * 4);
  param_1[0x13] = uVar6;
  param_1[0x23] = uVar1 + uVar11 ^ uVar6 ^ uVar12;
  return;
}

