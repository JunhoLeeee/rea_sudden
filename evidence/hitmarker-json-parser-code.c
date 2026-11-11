
void FUN_1801df810(float *param_1,undefined8 param_2)

{
  undefined8 uVar1;
  ulong uVar2;
  undefined8 *puVar3;
  longlong lVar4;
  longlong lVar5;
  char *pcVar6;
  int *piVar7;
  ulonglong uVar8;
  undefined8 *puVar9;
  float fVar10;
  float fVar11;
  char *local_res18;
  char *local_res20;
  undefined8 local_108;
  undefined4 local_100;
  ushort local_fc;
  undefined1 local_fa;
  undefined8 local_f8;
  undefined8 local_f0;
  undefined2 local_e0;
  undefined2 local_de;
  undefined2 local_dc;
  undefined2 local_da;
  undefined2 local_d8;
  ulong local_d4;
  ulong local_d0;
  ulong local_cc;
  undefined4 local_c8;
  undefined4 local_c4;
  undefined4 local_c0;
  undefined8 local_b8;
  undefined4 local_b0;
  undefined2 local_ac;
  undefined1 local_aa;
  undefined8 local_a8;
  undefined8 local_a0;
  undefined4 local_98 [2];
  undefined8 *local_90;
  ulonglong local_88;
  undefined8 *local_80;
  undefined8 *local_78;
  undefined8 *puStack_70;
  undefined8 local_68;
  undefined8 local_60;
  char *local_58 [4];
  
  local_98[0] = 0;
  local_90 = (undefined8 *)0x0;
  local_88 = 0;
  puVar3 = (undefined8 *)FUN_181387aac(0x28);
  *puVar3 = puVar3;
  puVar3[1] = puVar3;
  local_80 = (undefined8 *)0x0;
  local_78 = (undefined8 *)0x0;
  puStack_70 = (undefined8 *)0x0;
  local_68 = 7;
  local_60 = 8;
  local_98[0] = 0x3f800000;
  local_90 = puVar3;
  local_80 = (undefined8 *)FUN_181387aac(0x80);
  local_78 = local_80 + 0x10;
  for (puVar9 = local_80; puVar9 != local_78; puVar9 = puVar9 + 1) {
    *puVar9 = puVar3;
  }
  local_res18 = (char *)&local_b8;
  local_a0 = 0xf;
  local_a8 = 0xe;
  local_b8 = 0x69616873736f7263;
  local_b0 = 0x646e4972;
  local_ac = 0x7865;
  local_aa = 0;
  local_f0 = 0xf;
  local_f8 = 9;
  local_108 = 0x656b72614d746948;
  local_100 = CONCAT22(local_100._2_2_,0x72);
  puStack_70 = local_78;
  FUN_1800748c0(&local_108,param_2,local_98,&local_b8);
  FUN_1801e06b0(param_1);
  fVar10 = (float)local_88 / *param_1 + 0.5;
  lVar4 = 0;
  if ((9.223372e+18 <= fVar10) && (fVar10 = fVar10 - 9.223372e+18, fVar10 < 9.223372e+18)) {
    lVar4 = -0x8000000000000000;
  }
  fVar11 = ceilf((float)*(ulonglong *)(param_1 + 4) / *param_1);
  lVar5 = 0;
  if ((9.223372e+18 <= fVar11) && (fVar11 = fVar11 - 9.223372e+18, fVar11 < 9.223372e+18)) {
    lVar5 = -0x8000000000000000;
  }
  uVar8 = (longlong)fVar11 + lVar5;
  if ((ulonglong)((longlong)fVar11 + lVar5) < (ulonglong)((longlong)fVar10 + lVar4)) {
    uVar8 = (longlong)fVar10 + lVar4;
  }
  if (*(ulonglong *)(param_1 + 0xe) < uVar8) {
    FUN_1801e0260(param_1);
  }
  puVar3 = local_90;
  puVar9 = (undefined8 *)*local_90;
  do {
    if (puVar9 == puVar3) {
      FUN_1801df520(&local_80);
      *(undefined8 *)local_90[1] = 0;
      puVar9 = (undefined8 *)*local_90;
      while (puVar9 != (undefined8 *)0x0) {
        puVar3 = (undefined8 *)*puVar9;
        if (puVar9[4] != 0) {
          FUN_1801a9660();
        }
        free(puVar9);
        puVar9 = puVar3;
      }
      free(local_90);
      return;
    }
    local_f0 = 0xf;
    local_f8 = 0xe;
    local_108 = 0x69616873736f7263;
    local_100 = 0x646e4972;
    local_fc = 0x7865;
    local_fa = 0;
    lVar4 = FUN_180bfbdc0(puVar9[3],&local_108);
    if (lVar4 == 0) {
      local_e0 = 1;
    }
    else {
      local_e0 = FUN_180bfabd0(lVar4);
    }
    local_f0 = 0xf;
    local_f8 = 4;
    local_108 = 0x65707974;
    lVar4 = FUN_180bfbdc0(puVar9[3],&local_108);
    if (lVar4 == 0) {
      local_de = 0;
    }
    else {
      local_de = FUN_180bfabd0(lVar4);
    }
    local_f0 = 0xf;
    local_f8 = 9;
    local_108 = 0x74676e654c726162;
    local_100 = CONCAT22(local_100._2_2_,0x68);
    lVar4 = FUN_180bfbdc0(puVar9[3],&local_108);
    if (lVar4 == 0) {
      local_dc = 0xd;
    }
    else {
      local_dc = FUN_180bfabd0(lVar4);
    }
    local_f0 = 0xf;
    local_f8 = 0xc;
    local_108 = 0x6b63696854726162;
    local_100 = 0x7373656e;
    local_fc = local_fc & 0xff00;
    lVar4 = FUN_180bfbdc0(puVar9[3],&local_108);
    if (lVar4 == 0) {
      local_da = 2;
    }
    else {
      local_da = FUN_180bfabd0(lVar4);
    }
    local_f0 = 0xf;
    local_f8 = 0xb;
    local_108 = 0x6c427265746e6563;
    local_100 = 0x6b6e61;
    lVar4 = FUN_180bfbdc0(puVar9[3],&local_108);
    if (lVar4 == 0) {
      local_d8 = 8;
    }
    else {
      local_d8 = FUN_180bfabd0(lVar4);
    }
    uVar1 = puVar9[3];
    local_108 = 0;
    local_f8 = 0;
    local_f0 = 0xf;
    FUN_18004dca0(&local_108,"normalColor",0xb);
    lVar4 = FUN_180bfbdc0(uVar1,&local_108);
    if (lVar4 == 0) {
      uVar2 = 0x99ffffff;
    }
    else {
      pcVar6 = (char *)FUN_180bfab90(lVar4);
      piVar7 = _errno();
      if (0xf < *(ulonglong *)(pcVar6 + 0x18)) {
        pcVar6 = *(char **)pcVar6;
      }
      *piVar7 = 0;
      uVar2 = strtoul(pcVar6,&local_res18,0x10);
      if (pcVar6 == local_res18) {
                    /* WARNING: Subroutine does not return */
        std::_Xinvalid_argument("invalid stoul argument");
      }
      if (*piVar7 == 0x22) {
                    /* WARNING: Subroutine does not return */
        std::_Xout_of_range("stoul argument out of range");
      }
    }
    uVar1 = puVar9[3];
    local_108 = 0;
    local_f8 = 0;
    local_f0 = 0xf;
    local_d4 = uVar2;
    FUN_18004dca0(&local_108,"headshotColor",0xd);
    lVar4 = FUN_180bfbdc0(uVar1,&local_108);
    if (lVar4 == 0) {
      uVar2 = 0x9900ffff;
    }
    else {
      pcVar6 = (char *)FUN_180bfab90(lVar4);
      piVar7 = _errno();
      if (0xf < *(ulonglong *)(pcVar6 + 0x18)) {
        pcVar6 = *(char **)pcVar6;
      }
      *piVar7 = 0;
      uVar2 = strtoul(pcVar6,&local_res20,0x10);
      if (pcVar6 == local_res20) {
                    /* WARNING: Subroutine does not return */
        std::_Xinvalid_argument("invalid stoul argument");
      }
      if (*piVar7 == 0x22) {
                    /* WARNING: Subroutine does not return */
        std::_Xout_of_range("stoul argument out of range");
      }
    }
    uVar1 = puVar9[3];
    local_108 = 0;
    local_f8 = 0;
    local_f0 = 0xf;
    local_d0 = uVar2;
    FUN_18004dca0(&local_108,"killColor",9);
    lVar4 = FUN_180bfbdc0(uVar1,&local_108);
    if (lVar4 == 0) {
      uVar2 = 0xffff0000;
    }
    else {
      pcVar6 = (char *)FUN_180bfab90(lVar4);
      piVar7 = _errno();
      if (0xf < *(ulonglong *)(pcVar6 + 0x18)) {
        pcVar6 = *(char **)pcVar6;
      }
      *piVar7 = 0;
      uVar2 = strtoul(pcVar6,local_58,0x10);
      if (pcVar6 == local_58[0]) {
                    /* WARNING: Subroutine does not return */
        std::_Xinvalid_argument("invalid stoul argument");
      }
      if (*piVar7 == 0x22) {
                    /* WARNING: Subroutine does not return */
        std::_Xout_of_range("stoul argument out of range");
      }
    }
    uVar1 = puVar9[3];
    local_108 = 0;
    local_f8 = 0;
    local_f0 = 0xf;
    local_cc = uVar2;
    FUN_18004dca0(&local_108,"fadeInTime",10);
    lVar4 = FUN_180bfbdc0(uVar1,&local_108);
    if (lVar4 == 0) {
      local_c8 = 0x3dcccccd;
    }
    else {
      local_c8 = FUN_180bfabf0(lVar4);
    }
    uVar1 = puVar9[3];
    local_108 = 0;
    local_f8 = 0;
    local_f0 = 0xf;
    FUN_18004dca0(&local_108,"showTime",8);
    lVar4 = FUN_180bfbdc0(uVar1,&local_108);
    if (lVar4 == 0) {
      local_c4 = 0x3df5c28f;
    }
    else {
      local_c4 = FUN_180bfabf0(lVar4);
    }
    uVar1 = puVar9[3];
    local_108 = 0;
    local_f8 = 0;
    local_f0 = 0xf;
    FUN_18004dca0(&local_108,"fadeOutTime",0xb);
    lVar4 = FUN_180bfbdc0(uVar1,&local_108);
    if (lVar4 == 0) {
      local_c0 = 0x3da3d70a;
    }
    else {
      local_c0 = FUN_180bfabf0(lVar4);
    }
    FUN_1801dee50(param_1,&local_b8,&local_e0,&local_e0);
    puVar9 = (undefined8 *)*puVar9;
  } while( true );
}

