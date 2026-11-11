
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

void FUN_14027ca40(longlong param_1)

{
  undefined8 *puVar1;
  longlong *plVar2;
  longlong *plVar3;
  longlong *plVar4;
  undefined8 *puVar5;
  code *pcVar6;
  undefined4 uVar7;
  undefined4 uVar8;
  undefined4 uVar9;
  longlong **pplVar10;
  undefined8 *****pppppuVar11;
  char cVar12;
  int iVar13;
  undefined8 ****ppppuVar14;
  longlong *plVar15;
  longlong lVar16;
  undefined8 *puVar17;
  longlong **pplVar18;
  undefined8 uVar19;
  undefined8 uVar20;
  undefined8 uVar21;
  undefined8 uVar22;
  ulonglong uVar23;
  undefined8 *puVar24;
  ulonglong uVar25;
  undefined8 *puVar26;
  ulonglong uVar27;
  longlong **pplVar28;
  undefined8 *****pppppuVar30;
  longlong **pplVar31;
  longlong lVar32;
  longlong **pplVar33;
  bool bVar34;
  undefined1 auStack_3f8 [32];
  undefined8 local_3d8;
  undefined4 local_3c8;
  longlong *local_3c0;
  ulonglong uStack_3b8;
  longlong **local_3b0;
  undefined8 local_3a8;
  longlong local_3a0 [2];
  undefined1 local_390 [56];
  undefined1 local_358 [72];
  undefined8 ****local_310;
  undefined4 uStack_308;
  undefined4 uStack_304;
  longlong local_300;
  ulonglong uStack_2f8;
  undefined8 ****local_2f0 [2];
  ulonglong local_2e0;
  ulonglong local_2d8;
  undefined1 local_2d0 [32];
  undefined1 local_2b0 [40];
  undefined8 local_288 [3];
  int iStack_26c;
  int local_268;
  ulonglong local_38;
  longlong **pplVar29;
  
  local_38 = DAT_1403eef38 ^ (ulonglong)auStack_3f8;
  local_3c8 = 0;
  local_3c0 = (longlong *)0x0;
  uStack_3b8 = 0;
  local_3a0[0] = param_1;
  local_3c0 = operator_new(0x260);
  *local_3c0 = (longlong)local_3c0;
  local_3c0[1] = (longlong)local_3c0;
  plVar15 = (longlong *)(param_1 + 0x58);
  lVar16 = *(longlong *)(param_1 + 0x68);
  if (0x7ffffffffffffffeU - lVar16 < 2) {
                    /* WARNING: Subroutine does not return */
    FUN_140027fd0();
  }
  if (7 < *(ulonglong *)(param_1 + 0x70)) {
    plVar15 = (longlong *)*plVar15;
  }
  local_2f0[0] = (undefined8 *****)0x0;
  local_2e0 = 0;
  local_2d8 = 0;
  uVar25 = lVar16 + 2;
  uVar27 = 7;
  pppppuVar30 = local_2f0;
  pppppuVar11 = (undefined8 *****)local_2f0[0];
  if (7 < uVar25) {
    uVar27 = uVar25 | 7;
    if (uVar27 < 0x7fffffffffffffff) {
      if (uVar27 < 10) {
        uVar27 = 10;
      }
      if (0x7fffffffffffffff < uVar27 + 1) goto LAB_14027d12b;
      uVar23 = (uVar27 + 1) * 2;
      if (uVar23 < 0x1000) {
        pppppuVar30 = (undefined8 *****)0x0;
        pppppuVar11 = (undefined8 *****)0x0;
        if (uVar23 != 0) {
          pppppuVar30 = operator_new(uVar23);
          pppppuVar11 = pppppuVar30;
        }
        goto LAB_14027cb7e;
      }
    }
    else {
      uVar27 = 0x7ffffffffffffffe;
      uVar23 = 0xfffffffffffffffe;
    }
    if (uVar23 + 0x27 <= uVar23) {
LAB_14027d12b:
                    /* WARNING: Subroutine does not return */
      FUN_140027ec0();
    }
    ppppuVar14 = operator_new(uVar23 + 0x27);
    if (ppppuVar14 == (undefined8 ****)0x0) goto LAB_14027cc62;
    pppppuVar30 = (undefined8 *****)((longlong)ppppuVar14 + 0x27U & 0xffffffffffffffe0);
    pppppuVar30[-1] = ppppuVar14;
    pppppuVar11 = pppppuVar30;
  }
LAB_14027cb7e:
  local_2f0[0] = pppppuVar11;
  local_2e0 = uVar25;
  local_2d8 = uVar27;
  FUN_1402b8fa7(pppppuVar30,plVar15,lVar16 * 2);
  *(undefined4 *)(lVar16 * 2 + (longlong)pppppuVar30) = 0x2a005c;
  *(undefined2 *)((longlong)pppppuVar30 + uVar25 * 2) = 0;
  local_3c8 = 1;
  lVar16 = param_1 + 0xd0;
  if (7 < *(ulonglong *)(param_1 + 0xe8)) {
    lVar16 = *(longlong *)(param_1 + 0xd0);
  }
  plVar15 = (longlong *)FUN_140063900(local_2f0,lVar16,*(undefined8 *)(param_1 + 0xe0));
  local_310 = (undefined8 ****)*plVar15;
  uStack_308 = (undefined4)plVar15[1];
  uStack_304 = *(undefined4 *)((longlong)plVar15 + 0xc);
  local_300 = plVar15[2];
  uStack_2f8 = plVar15[3];
  plVar15[2] = 0;
  plVar15[3] = 7;
  *(undefined2 *)plVar15 = 0;
  local_3c8 = 3;
  pppppuVar30 = &local_310;
  if (7 < uStack_2f8) {
    pppppuVar30 = (undefined8 *****)local_310;
  }
  lVar16 = (*(code *)0x3d8598)(pppppuVar30,local_288);
  local_3c8 = 1;
  if (7 < uStack_2f8) {
    uVar25 = uStack_2f8 * 2 + 2;
    pppppuVar30 = (undefined8 *****)local_310;
    if (0xfff < uVar25) {
      uVar25 = uStack_2f8 * 2 + 0x29;
      pppppuVar30 = (undefined8 *****)local_310[-1];
      if (0x1f < (ulonglong)((longlong)local_310 + (-8 - (longlong)pppppuVar30))) {
LAB_14027cc62:
        (*(code *)0x3d7636)();
        pcVar6 = (code *)swi(3);
        (*pcVar6)();
        return;
      }
    }
    thunk_FUN_1402b909d(pppppuVar30,uVar25);
  }
  local_300 = 0;
  uStack_2f8 = 7;
  local_310 = (undefined8 ****)((ulonglong)local_310 & 0xffffffffffff0000);
  local_3c8 = 0;
  if (7 < local_2d8) {
    uVar25 = local_2d8 * 2 + 2;
    pppppuVar30 = (undefined8 *****)local_2f0[0];
    if (0xfff < uVar25) {
      uVar25 = local_2d8 * 2 + 0x29;
      pppppuVar30 = (undefined8 *****)local_2f0[0][-1];
      if (0x1f < (ulonglong)((longlong)local_2f0[0] + (-8 - (longlong)pppppuVar30))) {
        (*(code *)0x3d7636)();
        pcVar6 = (code *)swi(3);
        (*pcVar6)();
        return;
      }
    }
    thunk_FUN_1402b909d(pppppuVar30,uVar25);
  }
  local_2e0 = 0;
  local_2d8 = 7;
  local_2f0[0] = (undefined8 ****)((ulonglong)local_2f0[0] & 0xffffffffffff0000);
  if (lVar16 == -1) {
    FUN_14002f780(local_2d0,&DAT_140354950);
    uVar19 = FUN_1402717c0(local_3a0,L"Exception",0,0x30);
    uVar20 = FUN_1402717d0(&local_3b0,L"Lambda::FileSystem::LoadPknAll",0,0x30);
    uVar21 = FUN_1402717f0(local_2f0,L"C:\\Git\\lapacker\\lib\\FileSystemLib\\FileSystem.cpp",0,0x30
                          );
    uVar22 = FUN_1402717b0(&local_310,&DAT_1403319a0,0,0x30);
    local_3d8 = uVar20;
    uVar20 = FUN_140276320(local_390,0x30c,uVar22,uVar21);
    uVar19 = FUN_140276270(local_358,uVar20,uVar19);
    FUN_1402a0290(local_2b0,uVar19,0x14,local_2d0);
                    /* WARNING: Subroutine does not return */
    FUN_1402b8f9b(local_2b0,&DAT_1403d3758);
  }
  do {
    plVar15 = local_3c0;
    if ((iStack_26c != 0) || (local_268 != 0)) {
      if (uStack_3b8 == 0x6bca1af286bca1) {
                    /* WARNING: Subroutine does not return */
        FUN_140261b6b("list too long");
      }
      local_3b0 = &local_3c0;
      local_3a8 = 0;
      puVar17 = operator_new(0x260);
      lVar32 = 4;
      puVar1 = local_288;
      puVar5 = puVar17 + 2;
      do {
        puVar26 = puVar5;
        puVar24 = puVar1;
        uVar19 = puVar24[1];
        *puVar26 = *puVar24;
        puVar26[1] = uVar19;
        uVar19 = puVar24[3];
        puVar26[2] = puVar24[2];
        puVar26[3] = uVar19;
        uVar19 = puVar24[5];
        puVar26[4] = puVar24[4];
        puVar26[5] = uVar19;
        uVar19 = puVar24[7];
        puVar26[6] = puVar24[6];
        puVar26[7] = uVar19;
        uVar19 = puVar24[9];
        puVar26[8] = puVar24[8];
        puVar26[9] = uVar19;
        uVar19 = puVar24[0xb];
        puVar26[10] = puVar24[10];
        puVar26[0xb] = uVar19;
        uVar19 = puVar24[0xd];
        puVar26[0xc] = puVar24[0xc];
        puVar26[0xd] = uVar19;
        uVar19 = puVar24[0xf];
        puVar26[0xe] = puVar24[0xe];
        puVar26[0xf] = uVar19;
        lVar32 = lVar32 + -1;
        puVar1 = puVar24 + 0x10;
        puVar5 = puVar26 + 0x10;
      } while (lVar32 != 0);
      uVar19 = puVar24[0x11];
      puVar26[0x10] = puVar24[0x10];
      puVar26[0x11] = uVar19;
      uVar19 = puVar24[0x13];
      puVar26[0x12] = puVar24[0x12];
      puVar26[0x13] = uVar19;
      uVar19 = puVar24[0x15];
      puVar26[0x14] = puVar24[0x14];
      puVar26[0x15] = uVar19;
      uVar19 = puVar24[0x17];
      puVar26[0x16] = puVar24[0x16];
      puVar26[0x17] = uVar19;
      uVar7 = *(undefined4 *)((longlong)puVar24 + 0xc4);
      uVar8 = *(undefined4 *)(puVar24 + 0x19);
      uVar9 = *(undefined4 *)((longlong)puVar24 + 0xcc);
      *(undefined4 *)(puVar26 + 0x18) = *(undefined4 *)(puVar24 + 0x18);
      *(undefined4 *)((longlong)puVar26 + 0xc4) = uVar7;
      *(undefined4 *)(puVar26 + 0x19) = uVar8;
      *(undefined4 *)((longlong)puVar26 + 0xcc) = uVar9;
      uStack_3b8 = uStack_3b8 + 1;
      puVar1 = (undefined8 *)plVar15[1];
      *puVar17 = plVar15;
      puVar17[1] = puVar1;
      local_3a8 = 0;
      plVar15[1] = (longlong)puVar17;
      *puVar1 = puVar17;
    }
    iVar13 = (*(code *)0x3d820a)(lVar16,local_288);
  } while (iVar13 != 0);
  (*(code *)0x3d81ea)(lVar16);
  uVar25 = uStack_3b8;
  plVar15 = local_3c0;
  if ((uStack_3b8 != 0) && (uStack_3b8 != 1)) {
    uVar27 = uStack_3b8 >> 1;
    local_3b0 = (longlong **)FUN_140273ef0(local_3c0,uVar27,&LAB_14027d410);
    pplVar18 = (longlong **)FUN_140273ef0(&local_3b0,uVar25 - uVar27,&LAB_14027d410);
    pplVar28 = local_3b0;
    pplVar33 = (longlong **)*plVar15;
    cVar12 = (**(code **)(DAT_14045fde0 + 0x108))
                       ((longlong)local_3b0 + 0x3c,(longlong)pplVar33 + 0x3c);
    pplVar31 = pplVar33;
    pplVar10 = pplVar28;
    while (pplVar29 = pplVar28, cVar12 == '\0') {
      pplVar31 = (longlong **)*pplVar31;
      if (pplVar31 == pplVar28) goto LAB_14027cf23;
      cVar12 = (**(code **)(DAT_14045fde0 + 0x108))
                         ((longlong)pplVar28 + 0x3c,(longlong)pplVar31 + 0x3c);
      pplVar10 = pplVar33;
    }
LAB_14027ceb3:
    pplVar28 = (longlong **)*pplVar28;
    if (pplVar28 != pplVar18) goto code_r0x00014027cebb;
    goto LAB_14027ced4;
  }
LAB_14027cf33:
  plVar15 = (longlong *)*local_3c0;
  bVar34 = plVar15 == local_3c0;
  do {
    if (bVar34) {
LAB_14027cfe1:
      *(undefined8 *)local_3c0[1] = 0;
      puVar1 = (undefined8 *)*local_3c0;
      while (puVar1 != (undefined8 *)0x0) {
        puVar5 = (undefined8 *)*puVar1;
        thunk_FUN_1402b909d(puVar1,0x260);
        puVar1 = puVar5;
      }
      thunk_FUN_1402b909d(local_3c0,0x260);
      return;
    }
    local_300 = 0;
    uStack_2f8 = 7;
    local_310 = (undefined8 ****)0x0;
    FUN_14002f970(&local_310,&DAT_140354950,0);
    FUN_14027b100(param_1,plVar15 + 2);
    if (7 < uStack_2f8) {
      if (0xfff < uStack_2f8 * 2 + 2) {
        if (0x1f < (ulonglong)((longlong)local_310 + (-8 - (longlong)local_310[-1]))) {
          (*(code *)0x3d7636)(local_310[-1],uStack_2f8 * 2 + 0x29);
          goto LAB_14027cfe1;
        }
      }
      thunk_FUN_1402b909d();
    }
    local_300 = 0;
    uStack_2f8 = 7;
    local_310 = (undefined8 ****)((ulonglong)local_310 & 0xffffffffffff0000);
    plVar15 = (longlong *)*plVar15;
    bVar34 = plVar15 == local_3c0;
  } while( true );
code_r0x00014027cebb:
  cVar12 = (**(code **)(DAT_14045fde0 + 0x108))((longlong)pplVar28 + 0x3c,(longlong)pplVar31 + 0x3c)
  ;
  if (cVar12 != '\0') goto LAB_14027ceb3;
LAB_14027ced4:
  plVar2 = pplVar29[1];
  *plVar2 = (longlong)pplVar28;
  plVar3 = pplVar28[1];
  *plVar3 = (longlong)pplVar31;
  plVar4 = pplVar31[1];
  *plVar4 = (longlong)pplVar29;
  pplVar31[1] = plVar3;
  pplVar28[1] = plVar2;
  pplVar29[1] = plVar4;
  pplVar33 = pplVar10;
  if (pplVar28 != pplVar18) {
    do {
      pplVar31 = (longlong **)*pplVar31;
      if (pplVar31 == pplVar28) goto LAB_14027cf23;
      cVar12 = (**(code **)(DAT_14045fde0 + 0x108))
                         ((longlong)pplVar28 + 0x3c,(longlong)pplVar31 + 0x3c);
      pplVar29 = pplVar28;
    } while (cVar12 == '\0');
    goto LAB_14027ceb3;
  }
LAB_14027cf23:
  *plVar15 = (longlong)pplVar33;
  param_1 = local_3a0[0];
  goto LAB_14027cf33;
}

