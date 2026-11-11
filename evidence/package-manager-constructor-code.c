
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined4 * FUN_140275900(undefined4 *param_1,undefined4 *param_2)

{
  undefined8 *puVar1;
  ushort uVar2;
  ulonglong uVar3;
  longlong lVar4;
  ushort *puVar5;
  undefined4 *puVar6;
  char cVar7;
  int iVar8;
  void *pvVar9;
  ushort ****ppppuVar10;
  undefined8 uVar11;
  ushort *****pppppuVar12;
  ushort *puVar13;
  undefined8 *puVar14;
  undefined8 uVar15;
  undefined8 uVar16;
  undefined8 uVar17;
  ulonglong uVar18;
  longlong lVar19;
  uint uVar20;
  longlong lVar21;
  undefined8 *puVar22;
  ushort *puVar23;
  undefined8 *puVar24;
  bool bVar25;
  undefined1 auStack_248 [32];
  undefined8 local_228;
  uint local_218;
  uint local_214;
  undefined4 *local_210;
  undefined8 *local_208;
  ushort ****local_200;
  ushort *local_1f8;
  uint uStack_1f0;
  undefined4 uStack_1ec;
  undefined4 *local_1e8;
  undefined8 *local_1e0;
  ushort *local_1d8;
  uint uStack_1d0;
  undefined4 uStack_1cc;
  undefined4 *local_1c0;
  undefined8 *local_1b8;
  ushort ****local_1b0;
  undefined1 local_1a8 [16];
  undefined1 local_198 [16];
  undefined1 local_188 [16];
  undefined1 local_178 [16];
  undefined1 local_168 [56];
  undefined1 local_130 [72];
  ushort ****local_e8 [2];
  ulonglong local_d8;
  ulonglong local_d0;
  undefined2 local_c8;
  undefined6 uStack_c6;
  undefined8 uStack_c0;
  undefined8 local_b8;
  undefined8 uStack_b0;
  undefined1 local_a8 [32];
  undefined1 local_88 [40];
  undefined1 local_60 [32];
  ulonglong local_40;
  
  local_40 = DAT_1403eef38 ^ (ulonglong)auStack_248;
  local_218 = 0;
  local_214 = 0;
  *param_1 = 0;
  param_1[1] = *param_2;
  *(undefined8 *)(param_1 + 2) = 0;
  puVar13 = (ushort *)(param_1 + 4);
  puVar13[0] = 0;
  puVar13[1] = 0;
  puVar13[2] = 0;
  puVar13[3] = 0;
  *(undefined8 *)(param_1 + 6) = 0;
  local_210 = param_2;
  local_1f8 = puVar13;
  local_1c0 = param_1;
  pvVar9 = operator_new(0x40);
  *(void **)pvVar9 = pvVar9;
  *(void **)((longlong)pvVar9 + 8) = pvVar9;
  *(void **)((longlong)pvVar9 + 0x10) = pvVar9;
  *(undefined2 *)((longlong)pvVar9 + 0x18) = 0x101;
  *(void **)puVar13 = pvVar9;
  *(undefined8 *)(param_1 + 8) = 0;
  *(undefined8 *)(param_1 + 10) = 0;
  *(undefined8 *)(param_1 + 0xc) = 0;
  puVar14 = (undefined8 *)(param_1 + 0xe);
  *puVar14 = 0;
  *(undefined8 *)(param_1 + 0x10) = 0;
  local_208 = puVar14;
  pvVar9 = operator_new(0x40);
  *(void **)pvVar9 = pvVar9;
  *(void **)((longlong)pvVar9 + 8) = pvVar9;
  *(void **)((longlong)pvVar9 + 0x10) = pvVar9;
  *(undefined2 *)((longlong)pvVar9 + 0x18) = 0x101;
  *puVar14 = pvVar9;
  puVar14 = (undefined8 *)(param_1 + 0x12);
  *puVar14 = 0;
  *(undefined8 *)(param_1 + 0x14) = 0;
  local_200 = (ushort ****)puVar14;
  pvVar9 = operator_new(0x60);
  *(void **)pvVar9 = pvVar9;
  *(void **)((longlong)pvVar9 + 8) = pvVar9;
  *(void **)((longlong)pvVar9 + 0x10) = pvVar9;
  *(undefined2 *)((longlong)pvVar9 + 0x18) = 0x101;
  *puVar14 = pvVar9;
  *(undefined8 *)(param_1 + 0x16) = 0;
  *(undefined8 *)(param_1 + 0x1a) = 0;
  *(undefined8 *)(param_1 + 0x1c) = 0;
  puVar14 = (undefined8 *)(param_2 + 4);
  uVar3 = *(ulonglong *)(param_2 + 8);
  puVar22 = puVar14;
  if (7 < *(ulonglong *)(param_2 + 10)) {
    puVar22 = (undefined8 *)*puVar14;
  }
  if (uVar3 < 8) {
    uVar11 = puVar22[1];
    *(undefined8 *)(param_1 + 0x16) = *puVar22;
    *(undefined8 *)(param_1 + 0x18) = uVar11;
    uVar18 = 7;
  }
  else {
    uVar18 = uVar3 | 7;
    if (0x7ffffffffffffffe < uVar18) {
      uVar18 = 0x7ffffffffffffffe;
    }
    uVar11 = FUN_140030400(param_1 + 0x16,uVar18 + 1);
    *(undefined8 *)(param_1 + 0x16) = uVar11;
    FUN_1402b8fa7(uVar11,puVar22,uVar3 * 2 + 2);
  }
  *(ulonglong *)(param_1 + 0x1a) = uVar3;
  *(ulonglong *)(param_1 + 0x1c) = uVar18;
  pppppuVar12 = (ushort *****)(param_1 + 0x1e);
  *pppppuVar12 = (ushort ****)0x0;
  *(undefined8 *)(param_1 + 0x20) = 0;
  local_200 = (ushort ****)pppppuVar12;
  ppppuVar10 = operator_new(0x70);
  *ppppuVar10 = (ushort ***)ppppuVar10;
  ppppuVar10[1] = (ushort ***)ppppuVar10;
  ppppuVar10[2] = (ushort ***)ppppuVar10;
  *(undefined2 *)(ppppuVar10 + 3) = 0x101;
  *pppppuVar12 = ppppuVar10;
  puVar22 = (undefined8 *)(param_1 + 0x22);
  *puVar22 = 0;
  *(undefined8 *)(param_1 + 0x24) = 0;
  local_208 = puVar22;
  pvVar9 = operator_new(0x50);
  *(void **)pvVar9 = pvVar9;
  *(void **)((longlong)pvVar9 + 8) = pvVar9;
  *(void **)((longlong)pvVar9 + 0x10) = pvVar9;
  *(undefined2 *)((longlong)pvVar9 + 0x18) = 0x101;
  *puVar22 = pvVar9;
  *(undefined8 *)(param_1 + 0x26) = 0;
  *(undefined8 *)(param_1 + 0x28) = 0;
  pvVar9 = operator_new(0x20);
  *(void **)pvVar9 = pvVar9;
  *(void **)((longlong)pvVar9 + 8) = pvVar9;
  *(void **)(param_1 + 0x26) = pvVar9;
  puVar1 = (undefined8 *)(param_1 + 0x34);
  *puVar1 = 0;
  *(undefined8 *)(param_1 + 0x38) = 0;
  *(undefined8 *)(param_1 + 0x3a) = 0;
  puVar22 = (undefined8 *)(param_2 + 0xc);
  uVar3 = *(ulonglong *)(param_2 + 0x10);
  puVar24 = puVar22;
  if (7 < *(ulonglong *)(param_2 + 0x12)) {
    puVar24 = (undefined8 *)*puVar22;
  }
  if (uVar3 < 8) {
    uVar11 = puVar24[1];
    *puVar1 = *puVar24;
    *(undefined8 *)(param_1 + 0x36) = uVar11;
    uVar18 = 7;
  }
  else {
    uVar18 = uVar3 | 7;
    if (0x7ffffffffffffffe < uVar18) {
      uVar18 = 0x7ffffffffffffffe;
    }
    uVar11 = FUN_140030400(puVar1,uVar18 + 1);
    *puVar1 = uVar11;
    FUN_1402b8fa7(uVar11,puVar24,uVar3 * 2 + 2);
  }
  puVar6 = local_210;
  *(ulonglong *)(param_1 + 0x38) = uVar3;
  *(ulonglong *)(param_1 + 0x3a) = uVar18;
  param_1[0x3c] = 2;
  *(undefined1 *)(param_1 + 0x3d) = *(undefined1 *)((longlong)local_210 + 0x51);
  *(undefined1 *)((longlong)param_1 + 0xf5) = *(undefined1 *)((longlong)local_210 + 0x52);
  *(undefined1 *)((longlong)param_1 + 0xf6) = *(undefined1 *)((longlong)local_210 + 0x53);
  *(undefined1 *)((longlong)param_1 + 0xf7) = *(undefined1 *)(local_210 + 0x15);
  *(undefined8 *)(param_1 + 0x3e) = 0;
  *(undefined8 *)(param_1 + 0x40) = 0;
  pvVar9 = operator_new(0x30);
  *(void **)pvVar9 = pvVar9;
  *(void **)((longlong)pvVar9 + 8) = pvVar9;
  *(void **)(param_1 + 0x3e) = pvVar9;
  *(undefined8 *)(param_1 + 0x42) = *(undefined8 *)(puVar6 + 0x16);
  *(undefined1 *)(param_1 + 0x44) = *(undefined1 *)(puVar6 + 0x19);
  FUN_1402968a0(param_1 + 0x46,puVar14,puVar22);
  param_1[0x70] = puVar6[0x1a];
  param_1[0x71] = puVar6[0x1b];
  FUN_14027a800(param_1);
  lVar4 = (*(longlong **)(puVar6 + 2))[1];
  lVar19 = **(longlong **)(puVar6 + 2);
  uVar20 = local_218;
  for (; lVar19 != lVar4; lVar19 = lVar19 + 0x20) {
    uVar11 = FUN_140295e10(local_60,lVar19);
    local_200 = (ushort ****)local_e8;
    FUN_1400612f0(local_e8,uVar11);
    FUN_1400612f0(&local_c8,lVar19);
    local_218 = uVar20 | 1;
    local_1f8 = *(ushort **)(param_1 + 0x12);
    puVar13 = *(ushort **)(local_1f8 + 4);
    uStack_1d0 = 0;
    cVar7 = *(char *)((longlong)puVar13 + 0x19);
    puVar23 = local_1f8;
    local_1d8 = puVar13;
    while (puVar5 = puVar13, cVar7 == '\0') {
      pppppuVar12 = local_e8;
      if (7 < local_d0) {
        pppppuVar12 = (ushort *****)local_e8[0];
      }
      puVar13 = puVar5 + 0x10;
      if (7 < *(ulonglong *)(puVar5 + 0x1c)) {
        puVar13 = *(ushort **)(puVar5 + 0x10);
      }
      uVar3 = *(ulonglong *)(puVar5 + 0x18);
      uVar18 = uVar3;
      if (local_d8 < uVar3) {
        uVar18 = local_d8;
      }
      if (uVar18 != 0) {
        lVar21 = (longlong)puVar13 - (longlong)pppppuVar12;
        do {
          uVar2 = *(ushort *)(lVar21 + (longlong)pppppuVar12);
          bVar25 = uVar2 < *(ushort *)pppppuVar12;
          if (uVar2 != *(ushort *)pppppuVar12) goto LAB_140275cfd;
          pppppuVar12 = (ushort *****)((longlong)pppppuVar12 + 2);
          uVar18 = uVar18 - 1;
        } while (uVar18 != 0);
      }
      bVar25 = uVar3 < local_d8;
LAB_140275cfd:
      if (!bVar25) {
        puVar13 = *(ushort **)puVar5;
        puVar23 = puVar5;
      }
      else {
        puVar13 = *(ushort **)(puVar5 + 8);
      }
      uStack_1d0 = (uint)!bVar25;
      cVar7 = *(char *)((longlong)puVar13 + 0x19);
      local_1d8 = puVar5;
    }
    if (*(char *)((longlong)puVar23 + 0x19) == '\0') {
      puVar13 = puVar23 + 0x10;
      if (7 < *(ulonglong *)(puVar23 + 0x1c)) {
        puVar13 = *(ushort **)(puVar23 + 0x10);
      }
      pppppuVar12 = local_e8;
      if (7 < local_d0) {
        pppppuVar12 = (ushort *****)local_e8[0];
      }
      uVar3 = *(ulonglong *)(puVar23 + 0x18);
      uVar18 = local_d8;
      if (uVar3 < local_d8) {
        uVar18 = uVar3;
      }
      if (uVar18 != 0) {
        lVar21 = (longlong)pppppuVar12 - (longlong)puVar13;
        do {
          uVar2 = *(ushort *)((longlong)puVar13 + lVar21);
          if (uVar2 != *puVar13) {
            if (uVar2 < *puVar13) goto LAB_140275d81;
            goto LAB_140275e52;
          }
          puVar13 = puVar13 + 1;
          uVar18 = uVar18 - 1;
        } while (uVar18 != 0);
      }
      if (local_d8 < uVar3) goto LAB_140275d81;
    }
    else {
LAB_140275d81:
      local_214 = local_218;
      if (*(longlong *)(param_1 + 0x14) == 0x2aaaaaaaaaaaaaa) {
                    /* WARNING: Subroutine does not return */
        FUN_140098f40();
      }
      local_1e0 = (undefined8 *)0x0;
      local_1e8 = param_1 + 0x12;
      puVar14 = operator_new(0x60);
      local_208 = puVar14 + 4;
      local_1e0 = puVar14;
      local_1b8 = local_208;
      FUN_1400612f0(local_208,local_e8);
      puVar14[10] = 0;
      puVar14[0xb] = 0;
      puVar14[8] = CONCAT62(uStack_c6,local_c8);
      puVar14[9] = uStack_c0;
      *(undefined4 *)(puVar14 + 10) = (undefined4)local_b8;
      *(undefined4 *)((longlong)puVar14 + 0x54) = local_b8._4_4_;
      *(undefined4 *)(puVar14 + 0xb) = (undefined4)uStack_b0;
      *(undefined4 *)((longlong)puVar14 + 0x5c) = uStack_b0._4_4_;
      local_b8 = 0;
      uStack_b0 = 7;
      local_c8 = 0;
      *puVar14 = local_1f8;
      puVar14[1] = local_1f8;
      puVar14[2] = local_1f8;
      *(undefined2 *)(puVar14 + 3) = 0;
      local_1e0 = (undefined8 *)0x0;
      local_1f8 = local_1d8;
      uStack_1f0 = uStack_1d0;
      uStack_1ec = uStack_1cc;
      FUN_140284260(param_1 + 0x12,&local_1f8,puVar14);
    }
LAB_140275e52:
    uVar20 = local_218 & 0xfffffffe;
    local_214 = uVar20;
    if (7 < uStack_b0) {
      if (0xfff < uStack_b0 * 2 + 2) {
        lVar21 = *(longlong *)(CONCAT62(uStack_c6,local_c8) + -8);
        if (0x1f < (CONCAT62(uStack_c6,local_c8) - lVar21) - 8U) {
          (*(code *)0x3d7636)(lVar21,uStack_b0 * 2 + 0x29);
          goto LAB_140275fae;
        }
      }
      thunk_FUN_1402b909d();
    }
    local_b8 = 0;
    uStack_b0 = 7;
    local_c8 = 0;
    local_1b0 = (ushort ****)local_e8;
    FUN_14002f8c0(local_e8);
    FUN_14002f8c0(local_60);
    puVar6 = local_210;
  }
  DAT_1403ef150 = puVar6[0x18] << 10;
  if (*(longlong *)(param_1 + 0x42) == 0) {
    *(undefined1 **)(param_1 + 0x42) = &LAB_14027e470;
  }
  iVar8 = (*(code *)0x3d83be)(param_1 + 0x2a,0x400);
  if (iVar8 == 0) {
    (*(code *)0x3d594c)(L"InitializeCriticalSectionAndSpinCount() failed");
    FUN_14002f780(local_a8,&DAT_140354950);
    uVar11 = FUN_1402717c0(local_1a8,L"Exception",0,0x30);
    uVar15 = FUN_1402717d0(local_198,L"Lambda::FileSystem::FileSystem",0,0x30);
    uVar16 = FUN_1402717f0(local_188,L"C:\\Git\\lapacker\\lib\\FileSystemLib\\FileSystem.cpp",0,0x30
                          );
    uVar17 = FUN_1402717b0(local_178,&DAT_1403318d0,0,0x30);
    local_228 = uVar15;
    uVar15 = FUN_140276320(local_168,0x98,uVar17,uVar16);
    uVar11 = FUN_140276270(local_130,uVar15,uVar11);
    FUN_1402a0290(local_88,uVar11,0xd,local_a8);
                    /* WARNING: Subroutine does not return */
    FUN_1402b8f9b(local_88,&DAT_1403d3758);
  }
  DAT_14045fde0 = param_1;
  FUN_140291120(param_1 + 0x70);
  if (((param_1[1] - 2 & 0xfffffffd) == 0) && (*(char *)(puVar6 + 0x14) != '\0')) {
    if ((*(char *)((longlong)puVar6 + 0x65) != '\0') &&
       (cVar7 = FUN_140298520(param_1 + 0x46), cVar7 == '\0')) {
LAB_140275fae:
      FUN_14002f780(local_a8,&DAT_140354950);
      uVar11 = FUN_1402717c0(local_178,L"Exception",0,0x30);
      uVar15 = FUN_1402717d0(local_188,L"Lambda::FileSystem::FileSystem",0,0x30);
      uVar16 = FUN_1402717f0(local_198,L"C:\\Git\\lapacker\\lib\\FileSystemLib\\FileSystem.cpp",0,
                             0x30);
      uVar17 = FUN_1402717b0(local_1a8,&DAT_1403318d8,0,0x30);
      local_228 = uVar15;
      uVar15 = FUN_140276320(local_168,0xa9,uVar17,uVar16);
      uVar11 = FUN_140276270(local_130,uVar15,uVar11);
      FUN_1402a0290(local_88,uVar11,0x10,local_a8);
                    /* WARNING: Subroutine does not return */
      FUN_1402b8f9b(local_88,&DAT_1403d3758);
    }
    FUN_14027ca40(param_1);
  }
  return param_1;
}

