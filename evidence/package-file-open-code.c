
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Type propagation algorithm not settling */

undefined8 FUN_14027b100(longlong param_1,longlong param_2,ulonglong *param_3)

{
  ulonglong *puVar1;
  int *piVar2;
  int iVar3;
  ushort uVar4;
  undefined8 uVar5;
  longlong lVar6;
  code *pcVar7;
  undefined8 uVar8;
  char cVar9;
  undefined8 *******pppppppuVar10;
  undefined8 uVar11;
  undefined8 ******ppppppuVar12;
  undefined8 *******pppppppuVar13;
  undefined8 *puVar14;
  ushort *puVar15;
  undefined8 *puVar16;
  longlong *plVar17;
  longlong lVar18;
  ulonglong uVar19;
  undefined8 *******pppppppuVar20;
  ulonglong uVar21;
  ulonglong uVar22;
  ulonglong *puVar23;
  longlong lVar24;
  longlong lVar25;
  ulonglong *puVar26;
  uint uVar27;
  uint uVar28;
  undefined1 auStack_538 [32];
  undefined1 local_518;
  undefined4 local_510;
  undefined4 local_508;
  uint local_4f8;
  ulonglong *local_4f0;
  longlong *local_4e8;
  ulonglong *local_4e0;
  ulonglong local_4d8;
  ulonglong *puStack_4d0;
  ulonglong local_4c8;
  ulonglong *puStack_4c0;
  ulonglong *local_4b8;
  ulonglong local_4b0;
  ulonglong *puStack_4a8;
  undefined8 *local_4a0;
  undefined8 local_498;
  longlong local_490;
  ulonglong local_488;
  undefined1 local_480 [8];
  longlong *local_478;
  ulonglong *local_470;
  longlong local_468;
  ulonglong *local_460;
  longlong local_458;
  ulonglong local_450;
  undefined2 *local_440;
  undefined1 *local_438;
  ulonglong *local_430;
  ulonglong *local_428;
  ulonglong *local_420;
  undefined1 *local_418;
  undefined2 *local_410;
  ulonglong *local_408;
  ulonglong *local_400;
  ulonglong local_3f8;
  undefined1 local_3f0 [8];
  longlong *local_3e8;
  undefined8 local_3d8;
  undefined8 uStack_3d0;
  longlong local_3b8;
  undefined1 local_3b0 [16];
  undefined1 local_3a0 [24];
  undefined8 *******local_388;
  undefined8 uStack_380;
  ulonglong *local_378;
  ulonglong uStack_370;
  undefined8 *******local_368 [2];
  ulonglong local_358;
  ulonglong local_350;
  undefined8 *******local_348;
  undefined8 uStack_340;
  ulonglong *local_338;
  ulonglong uStack_330;
  undefined8 *******local_328;
  undefined8 ******ppppppuStack_320;
  undefined8 local_318;
  undefined8 uStack_310;
  ulonglong local_308;
  ulonglong *puStack_300;
  undefined8 *******local_2f8 [2];
  ulonglong *local_2e8;
  ulonglong local_2e0;
  ulonglong *local_2d8 [2];
  undefined8 local_2c8;
  ulonglong local_2c0;
  ulonglong local_2b8;
  ulonglong uStack_2b0;
  ulonglong local_2a8;
  ulonglong uStack_2a0;
  ulonglong local_298;
  ulonglong *puStack_290;
  undefined2 local_288;
  undefined6 uStack_286;
  undefined8 uStack_280;
  undefined8 local_278;
  ulonglong uStack_270;
  undefined1 local_268 [32];
  ulonglong local_248;
  ulonglong *puStack_240;
  ulonglong local_238;
  undefined8 uStack_230;
  undefined8 local_228;
  ulonglong uStack_220;
  undefined1 local_218 [32];
  undefined1 local_1f8 [32];
  undefined1 local_1d8 [32];
  undefined1 local_1b8 [32];
  undefined1 local_198 [32];
  undefined1 local_178 [32];
  undefined1 local_158 [32];
  undefined1 local_138 [32];
  undefined1 local_118 [32];
  undefined1 local_f8 [32];
  undefined1 local_d8 [32];
  undefined1 local_b8 [32];
  undefined1 local_98 [72];
  ulonglong local_50;
  
  local_50 = DAT_1403eef38 ^ (ulonglong)auStack_538;
  pppppppuVar20 = (undefined8 *******)0x0;
  local_4f8 = 0;
  local_490 = param_1 + 0xa8;
  local_4b8 = param_3;
  FUN_1402742c0(local_480,&local_490);
  local_4d8 = 0;
  puStack_4d0 = (ulonglong *)0x0;
  if (*(short *)(param_2 + 0x2c) == 0x2e) goto LAB_14027c049;
  local_378 = (ulonglong *)0x0;
  uStack_370 = 7;
  local_388 = (undefined8 *******)0x0;
  local_358 = 0;
  local_350 = 7;
  local_368[0] = (undefined8 *******)0x0;
  if (param_3[2] == 0) {
    lVar25 = -1;
    do {
      lVar25 = lVar25 + 1;
    } while (((short *)(param_2 + 0x2c))[lVar25] != 0);
    FUN_14002f970(&local_388);
    puVar26 = (ulonglong *)((longlong)local_378 - *(longlong *)(param_1 + 0xe0));
    local_338 = (ulonglong *)0x0;
    uStack_330 = 7;
    local_348 = (undefined8 *******)0x0;
    if (local_378 < puVar26) {
      puVar26 = local_378;
    }
    pppppppuVar10 = &local_388;
    if (7 < uStack_370) {
      pppppppuVar10 = local_388;
    }
    FUN_14002f970(&local_348,pppppppuVar10,puVar26);
    local_4f8 = 2;
    pppppppuVar10 = (undefined8 *******)FUN_140295e10(local_218,&local_348);
    if (local_368 != (undefined8 ********)pppppppuVar10) {
      pppppppuVar13 = pppppppuVar10;
      if ((undefined8 ******)0x7 < pppppppuVar10[3]) {
        pppppppuVar13 = (undefined8 *******)*pppppppuVar10;
      }
      FUN_14002f970(local_368,pppppppuVar13,pppppppuVar10[2]);
    }
    FUN_14002f8c0(local_218);
    local_4f8 = 0;
    if (7 < uStack_330) {
      uVar21 = uStack_330 * 2 + 2;
      pppppppuVar10 = local_348;
      if (0xfff < uVar21) {
        uVar21 = uStack_330 * 2 + 0x29;
        pppppppuVar10 = (undefined8 *******)local_348[-1];
        if (0x1f < (ulonglong)((longlong)local_348 + (-8 - (longlong)pppppppuVar10))) {
          (*(code *)0x3d7636)();
          pcVar7 = (code *)swi(3);
          uVar11 = (*pcVar7)();
          return uVar11;
        }
      }
      thunk_FUN_1402b909d(pppppppuVar10,uVar21);
    }
    local_338 = (ulonglong *)0x0;
    uStack_330 = 7;
    local_348 = (undefined8 *******)((ulonglong)local_348 & 0xffffffffffff0000);
  }
  else {
    plVar17 = (longlong *)(param_1 + 0xd0);
    local_4e8 = (longlong *)param_3[2];
    local_4c8 = *(ulonglong *)(param_1 + 0xe0);
    if (0x7ffffffffffffffeU - (longlong)local_4e8 < local_4c8) {
                    /* WARNING: Subroutine does not return */
      FUN_140027fd0();
    }
    local_4e0 = param_3;
    if (7 < param_3[3]) {
      local_4e0 = (ulonglong *)*param_3;
    }
    if (7 < *(ulonglong *)(param_1 + 0xe8)) {
      plVar17 = (longlong *)*plVar17;
    }
    local_348 = (undefined8 *******)0x0;
    local_338 = (ulonglong *)0x0;
    uStack_330 = 0;
    local_4f0 = (ulonglong *)(local_4c8 + (longlong)local_4e8);
    uVar21 = 7;
    pppppppuVar10 = &local_348;
    if ((ulonglong *)0x7 < local_4f0) {
      uVar21 = (ulonglong)local_4f0 | 7;
      if (uVar21 < 0x7fffffffffffffff) {
        if (uVar21 < 10) {
          uVar21 = 10;
        }
        if (0x7fffffffffffffff < uVar21 + 1) goto LAB_14027c674;
        uVar22 = (uVar21 + 1) * 2;
        if (uVar22 < 0x1000) {
          if (uVar22 == 0) {
            local_348 = (undefined8 *******)0x0;
            pppppppuVar10 = pppppppuVar20;
          }
          else {
            local_348 = operator_new(uVar22);
            pppppppuVar10 = local_348;
          }
          goto LAB_14027b4cd;
        }
      }
      else {
        uVar21 = 0x7ffffffffffffffe;
        uVar22 = 0xfffffffffffffffe;
      }
      if (uVar22 + 0x27 <= uVar22) {
LAB_14027c674:
                    /* WARNING: Subroutine does not return */
        FUN_140027ec0();
      }
      ppppppuVar12 = operator_new(uVar22 + 0x27);
      if (ppppppuVar12 == (undefined8 ******)0x0) {
        (*(code *)0x3d7636)();
        pcVar7 = (code *)swi(3);
        uVar11 = (*pcVar7)();
        return uVar11;
      }
      local_348 = (undefined8 *******)((longlong)ppppppuVar12 + 0x27U & 0xffffffffffffffe0);
      local_348[-1] = ppppppuVar12;
      pppppppuVar10 = local_348;
    }
LAB_14027b4cd:
    lVar25 = (longlong)local_4e8 * 2;
    local_338 = local_4f0;
    uStack_330 = uVar21;
    FUN_1402b8fa7(pppppppuVar10,local_4e0,lVar25);
    FUN_1402b8fa7((longlong)pppppppuVar10 + lVar25,plVar17,local_4c8 * 2);
    *(undefined2 *)((longlong)pppppppuVar10 + (longlong)local_4f0 * 2) = 0;
    local_388 = local_348;
    uStack_380 = uStack_340;
    local_378 = local_338;
    uStack_370 = uStack_330;
    local_4f8 = 0;
    local_338 = (ulonglong *)0x0;
    uStack_330 = 7;
    local_348 = (undefined8 *******)((ulonglong)local_348 & 0xffffffffffff0000);
    pppppppuVar10 = (undefined8 *******)FUN_140295e10(local_218,local_4b8);
    if (local_368 != (undefined8 ********)pppppppuVar10) {
      pppppppuVar13 = pppppppuVar10;
      if ((undefined8 ******)0x7 < pppppppuVar10[3]) {
        pppppppuVar13 = (undefined8 *******)*pppppppuVar10;
      }
      FUN_14002f970(local_368,pppppppuVar13,pppppppuVar10[2]);
    }
    FUN_14002f8c0(local_218);
  }
  uVar21 = 0xfffffffffffffffe;
  cVar9 = FUN_14027a470(param_1,local_368);
  if (cVar9 != '\0') {
    if (7 < local_350) {
      if (0xfff < local_350 * 2 + 2) {
        uVar21 = local_350 * 2 + 0x29;
        pppppppuVar10 = (undefined8 *******)local_368[0][-1];
        if (0x1f < (ulonglong)((longlong)local_368[0] + (-8 - (longlong)pppppppuVar10)))
        goto LAB_14027c1a9;
      }
      thunk_FUN_1402b909d();
    }
    local_358 = 0;
    local_350 = 7;
    local_368[0] = (undefined8 *******)((ulonglong)local_368[0] & 0xffffffffffff0000);
    if (7 < uStack_370) {
      if (0xfff < uStack_370 * 2 + 2) {
        uVar21 = uStack_370 * 2 + 0x29;
        pppppppuVar10 = (undefined8 *******)local_388[-1];
        if (0x1f < (ulonglong)((longlong)local_388 + (-8 - (longlong)pppppppuVar10)))
        goto LAB_14027c214;
      }
      thunk_FUN_1402b909d();
    }
    puVar26 = puStack_4d0;
    local_378 = (ulonglong *)0x0;
    uStack_370 = 7;
    local_388 = (undefined8 *******)((ulonglong)local_388 & 0xffffffffffff0000);
    if (puStack_4d0 != (ulonglong *)0x0) {
      LOCK();
      puVar23 = puStack_4d0 + 1;
      uVar21 = *puVar23;
      *(int *)puVar23 = (int)*puVar23 + -1;
      UNLOCK();
      if ((int)uVar21 == 1) {
        (**(code **)*puStack_4d0)(puStack_4d0);
        LOCK();
        piVar2 = (int *)((longlong)puVar26 + 0xc);
        iVar3 = *piVar2;
        *piVar2 = *piVar2 + -1;
        UNLOCK();
        if (iVar3 == 1) {
          (**(code **)(*puVar26 + 8))(puVar26);
        }
      }
    }
    if (local_478 != (longlong *)0x0) {
      LOCK();
      plVar17 = local_478 + 1;
      lVar25 = *plVar17;
      *(int *)plVar17 = (int)*plVar17 + -1;
      UNLOCK();
      if ((int)lVar25 == 1) {
        (**(code **)*local_478)(local_478);
        LOCK();
        piVar2 = (int *)((longlong)local_478 + 0xc);
        iVar3 = *piVar2;
        *piVar2 = *piVar2 + -1;
        UNLOCK();
        if (iVar3 == 1) {
          (**(code **)(*local_478 + 8))(local_478);
        }
      }
    }
    return 0;
  }
  local_4f0 = (ulonglong *)(param_1 + 0x58);
  local_4e8 = *(longlong **)(param_1 + 0x68);
  if (local_4e8 == (longlong *)0x7ffffffffffffffe) {
                    /* WARNING: Subroutine does not return */
    FUN_140027fd0();
  }
  if (7 < *(ulonglong *)(param_1 + 0x70)) {
    local_4f0 = (ulonglong *)*local_4f0;
  }
  local_2f8[0] = (undefined8 *******)0x0;
  local_2e8 = (ulonglong *)0x0;
  local_2e0 = 0;
  local_4e0 = (ulonglong *)((longlong)local_4e8 + 1);
  uVar22 = 7;
  pppppppuVar10 = local_2f8;
  pppppppuVar13 = local_2f8[0];
  if ((ulonglong *)0x7 < local_4e0) {
    uVar22 = (ulonglong)local_4e0 | 7;
    if (uVar22 < 0x7fffffffffffffff) {
      if (uVar22 < 10) {
        uVar22 = 10;
      }
      if (0x7fffffffffffffff < uVar22 + 1) goto LAB_14027c680;
      uVar21 = (uVar22 + 1) * 2;
      if (uVar21 < 0x1000) {
        pppppppuVar10 = pppppppuVar20;
        pppppppuVar13 = pppppppuVar20;
        if (uVar21 != 0) {
          pppppppuVar10 = operator_new(uVar21);
          pppppppuVar13 = pppppppuVar10;
        }
        goto LAB_14027b7f1;
      }
    }
    else {
      uVar22 = 0x7ffffffffffffffe;
    }
    if (uVar21 + 0x27 <= uVar21) {
LAB_14027c680:
                    /* WARNING: Subroutine does not return */
      FUN_140027ec0();
    }
    ppppppuVar12 = operator_new(uVar21 + 0x27);
    if (ppppppuVar12 == (undefined8 ******)0x0) {
      (*(code *)0x3d7636)();
      pcVar7 = (code *)swi(3);
      uVar11 = (*pcVar7)();
      return uVar11;
    }
    pppppppuVar10 = (undefined8 *******)((longlong)ppppppuVar12 + 0x27U & 0xffffffffffffffe0);
    pppppppuVar10[-1] = ppppppuVar12;
    pppppppuVar13 = pppppppuVar10;
  }
LAB_14027b7f1:
  local_2f8[0] = pppppppuVar13;
  lVar25 = (longlong)local_4e8 * 2;
  local_2e8 = local_4e0;
  local_2e0 = uVar22;
  FUN_1402b8fa7(pppppppuVar10,local_4f0,lVar25);
  *(undefined2 *)((longlong)pppppppuVar10 + lVar25) = 0x5c;
  *(undefined2 *)((longlong)pppppppuVar10 + (longlong)local_4e8 * 2 + 2) = 0;
  local_4f8 = 8;
  pppppppuVar20 = &local_388;
  if (7 < uStack_370) {
    pppppppuVar20 = local_388;
  }
  puVar26 = (ulonglong *)FUN_140063900(local_2f8,pppppppuVar20,local_378);
  local_2b8 = *puVar26;
  uStack_2b0 = puVar26[1];
  local_2a8 = puVar26[2];
  uStack_2a0 = puVar26[3];
  puVar26[2] = 0;
  puVar26[3] = 7;
  *(undefined2 *)puVar26 = 0;
  local_4f8 = 0x18;
  FUN_14029fb10(local_178,&local_2b8);
  local_4f8 = 8;
  if (7 < uStack_2a0) {
    uVar22 = uStack_2a0 * 2 + 2;
    uVar19 = local_2b8;
    if (0xfff < uVar22) {
      uVar22 = uStack_2a0 * 2 + 0x29;
      uVar19 = *(ulonglong *)(local_2b8 - 8);
      if (0x1f < (local_2b8 - uVar19) - 8) {
        (*(code *)0x3d7636)();
        pcVar7 = (code *)swi(3);
        uVar11 = (*pcVar7)();
        return uVar11;
      }
    }
    thunk_FUN_1402b909d(uVar19,uVar22);
  }
  local_2a8 = 0;
  uStack_2a0 = 7;
  local_2b8 = local_2b8 & 0xffffffffffff0000;
  local_4f8 = 0;
  if (7 < local_2e0) {
    uVar22 = local_2e0 * 2 + 2;
    pppppppuVar20 = local_2f8[0];
    if (0xfff < uVar22) {
      uVar22 = local_2e0 * 2 + 0x29;
      pppppppuVar20 = (undefined8 *******)local_2f8[0][-1];
      if (0x1f < (ulonglong)((longlong)local_2f8[0] + (-8 - (longlong)pppppppuVar20))) {
        (*(code *)0x3d7636)();
        pcVar7 = (code *)swi(3);
        uVar11 = (*pcVar7)();
        return uVar11;
      }
    }
    thunk_FUN_1402b909d(pppppppuVar20,uVar22);
  }
  local_2e8 = (ulonglong *)0x0;
  local_2e0 = 7;
  local_2f8[0] = (undefined8 *******)((ulonglong)local_2f8[0] & 0xffffffffffff0000);
  local_2c8 = 0;
  local_2c0 = 7;
  local_2d8[0] = (ulonglong *)0x0;
  FUN_14002f970(local_2d8,&DAT_140354950,0);
  local_508 = *(undefined4 *)(param_1 + 0x1c4);
  local_510 = *(undefined4 *)(param_1 + 0x1c0);
  local_518 = *(undefined1 *)(param_1 + 0xf6);
  local_400 = (ulonglong *)
              FUN_14029ba50(local_3f0,local_2d8,local_178,*(undefined1 *)(param_1 + 0xf5));
  puVar26 = puStack_4d0;
  local_3f8 = *local_400;
  local_470 = (ulonglong *)local_400[1];
  *local_400 = 0;
  local_400[1] = 0;
  local_4b0 = local_4d8;
  puStack_4a8 = puStack_4d0;
  uVar27 = 0;
  local_4d8 = local_3f8;
  puVar23 = local_470;
  if (puStack_4d0 != (ulonglong *)0x0) {
    local_4e0 = puStack_4d0;
    LOCK();
    puVar1 = puStack_4d0 + 1;
    uVar22 = *puVar1;
    *(int *)puVar1 = (int)*puVar1 + -1;
    UNLOCK();
    uVar27 = local_4f8;
    if ((int)uVar22 == 1) {
      puVar14 = (undefined8 *)*puStack_4d0;
      puStack_4d0 = local_470;
      (*(code *)*puVar14)(puVar26);
      LOCK();
      piVar2 = (int *)((longlong)puVar26 + 0xc);
      iVar3 = *piVar2;
      *piVar2 = *piVar2 + -1;
      UNLOCK();
      uVar27 = local_4f8;
      puVar23 = puStack_4d0;
      if (iVar3 == 1) {
        (**(code **)(*local_4e0 + 8))();
        uVar27 = local_4f8;
        puVar23 = puStack_4d0;
      }
    }
  }
  puStack_4d0 = puVar23;
  if (local_3e8 != (longlong *)0x0) {
    local_4e8 = local_3e8;
    LOCK();
    plVar17 = local_3e8 + 1;
    lVar25 = *plVar17;
    *(int *)plVar17 = (int)*plVar17 + -1;
    UNLOCK();
    uVar27 = local_4f8;
    if ((int)lVar25 == 1) {
      (**(code **)*local_3e8)(local_3e8);
      LOCK();
      piVar2 = (int *)((longlong)local_3e8 + 0xc);
      iVar3 = *piVar2;
      *piVar2 = *piVar2 + -1;
      UNLOCK();
      uVar27 = local_4f8;
      if (iVar3 == 1) {
        (**(code **)(*local_4e8 + 8))();
        uVar27 = local_4f8;
      }
    }
  }
  if (local_2c0 < 8) {
LAB_14027bbb5:
    local_2c8 = 0;
    local_2c0 = 7;
    local_2d8[0] = (ulonglong *)((ulonglong)local_2d8[0] & 0xffffffffffff0000);
    FUN_14029da50(local_4d8,local_368);
    local_328 = (undefined8 *******)0x0;
    local_318 = 0;
    uStack_310 = (ulonglong *)0x0;
    pppppppuVar10 = local_368;
    if (7 < local_350) {
      pppppppuVar10 = local_368[0];
    }
    uVar21 = local_358;
    if (7 < local_358) goto LAB_14027bc53;
    pppppppuVar13 = (undefined8 *******)*pppppppuVar10;
    ppppppuStack_320 = pppppppuVar10[1];
    uStack_310 = (ulonglong *)0x7;
    local_328 = pppppppuVar13;
  }
  else {
    local_468 = local_2c0 + 1;
    local_488 = local_468 * 2;
    local_4b8 = local_2d8[0];
    puVar26 = local_4b8;
    if (local_488 < 0x1000) {
LAB_14027bbb0:
      local_4b8 = puVar26;
      thunk_FUN_1402b909d();
      goto LAB_14027bbb5;
    }
    local_488 = local_488 + 0x27;
    local_460 = (ulonglong *)local_2d8[0][-1];
    local_458 = (longlong)local_2d8[0] - (longlong)local_460;
    puVar26 = local_460;
    if (local_458 - 8U < 0x20) goto LAB_14027bbb0;
    (*(code *)0x3d7636)();
LAB_14027bc53:
    puVar26 = (ulonglong *)(uVar21 | 7);
    if ((ulonglong *)0x7ffffffffffffffe < puVar26) {
      puVar26 = (ulonglong *)0x7ffffffffffffffe;
    }
    pppppppuVar13 = (undefined8 *******)FUN_140030400(&local_328,(longlong)puVar26 + 1);
    local_328 = pppppppuVar13;
    FUN_1402b8fa7(pppppppuVar13,pppppppuVar10,uVar21 * 2 + 2);
    uStack_310 = puVar26;
  }
  puVar23 = uStack_310;
  puVar26 = puStack_4d0;
  if (puStack_4d0 != (ulonglong *)0x0) {
    LOCK();
    *(int *)(puStack_4d0 + 1) = (int)puStack_4d0[1] + 1;
    UNLOCK();
    pppppppuVar13 = local_328;
    uVar27 = local_4f8;
  }
  local_4c8 = local_4d8;
  local_308 = local_4d8;
  puStack_300 = puStack_4d0;
  local_4f8 = uVar27 | 0x20;
  local_4f0 = uStack_310;
  local_318 = uVar21;
  puVar14 = (undefined8 *)FUN_140272750(param_1 + 0x88,local_3a0,&local_328);
  uVar11 = *puVar14;
  uVar8 = puVar14[1];
  local_3b8 = puVar14[2];
  if (*(char *)(local_3b8 + 0x19) == '\0') {
    puVar15 = (ushort *)(local_3b8 + 0x20);
    if (7 < *(ulonglong *)(local_3b8 + 0x38)) {
      puVar15 = *(ushort **)(local_3b8 + 0x20);
    }
    pppppppuVar20 = &local_328;
    if ((ulonglong *)0x7 < local_4f0) {
      pppppppuVar20 = pppppppuVar13;
    }
    local_450 = *(ulonglong *)(local_3b8 + 0x30);
    uVar22 = uVar21;
    if (local_450 < uVar21) {
      uVar22 = local_450;
    }
    if (uVar22 != 0) {
      lVar25 = (longlong)pppppppuVar20 - (longlong)puVar15;
      do {
        uVar4 = *(ushort *)((longlong)puVar15 + lVar25);
        if (uVar4 != *puVar15) {
          if (*puVar15 <= uVar4) goto LAB_14027be9d;
          goto LAB_14027bdad;
        }
        puVar15 = puVar15 + 1;
        uVar22 = uVar22 - 1;
      } while (uVar22 != 0);
    }
    if (uVar21 < local_450) goto LAB_14027bdad;
  }
  else {
LAB_14027bdad:
    puVar14 = (undefined8 *)(param_1 + 0x88);
    if (*(longlong *)(param_1 + 0x90) == 0x333333333333333) {
                    /* WARNING: Subroutine does not return */
      FUN_140098f40();
    }
    uVar5 = *puVar14;
    local_498 = 0;
    local_4a0 = puVar14;
    puVar16 = operator_new(0x50);
    local_4f0 = puVar16 + 4;
    *local_4f0 = (ulonglong)local_328;
    puVar16[5] = ppppppuStack_320;
    *(undefined4 *)(puVar16 + 6) = (undefined4)local_318;
    *(undefined4 *)((longlong)puVar16 + 0x34) = local_318._4_4_;
    *(undefined4 *)(puVar16 + 7) = (undefined4)uStack_310;
    *(undefined4 *)((longlong)puVar16 + 0x3c) = uStack_310._4_4_;
    local_318 = 0;
    uStack_310 = (ulonglong *)0x7;
    local_328 = (undefined8 *******)((ulonglong)local_328 & 0xffffffffffff0000);
    puVar16[8] = local_4c8;
    puVar16[9] = puVar26;
    local_308 = 0;
    puStack_300 = (ulonglong *)0x0;
    *puVar16 = uVar5;
    puVar16[1] = uVar5;
    puVar16[2] = uVar5;
    *(undefined2 *)(puVar16 + 3) = 0;
    local_498 = 0;
    local_3d8 = uVar11;
    uStack_3d0 = uVar8;
    FUN_140283d60(puVar14,&local_3d8,puVar16);
    puVar23 = uStack_310;
    pppppppuVar13 = local_328;
    puVar26 = puStack_300;
  }
LAB_14027be9d:
  local_4f8 = uVar27 & 0xffffffdf;
  pppppppuVar20 = (undefined8 *******)(ulonglong)local_4f8;
  if (puVar26 != (ulonglong *)0x0) {
    FUN_1400727e0(puVar26);
  }
  if ((ulonglong *)0x7 < puVar23) {
    uVar21 = (longlong)puVar23 * 2 + 2;
    pppppppuVar10 = pppppppuVar13;
    if (0xfff < uVar21) {
      uVar21 = (longlong)puVar23 * 2 + 0x29;
      pppppppuVar10 = (undefined8 *******)pppppppuVar13[-1];
      if (0x1f < (ulonglong)((longlong)pppppppuVar13 + (-8 - (longlong)pppppppuVar10))) {
        (*(code *)0x3d7636)();
        pcVar7 = (code *)swi(3);
        uVar11 = (*pcVar7)();
        return uVar11;
      }
    }
    thunk_FUN_1402b909d(pppppppuVar10,uVar21);
  }
  local_318 = 0;
  uStack_310 = (ulonglong *)0x7;
  local_328 = (undefined8 *******)((ulonglong)local_328 & 0xffffffffffff0000);
  if (*(char *)(param_1 + 0xf7) != '\0') {
    FUN_140286c90(param_1 + 0xf8,local_368);
  }
  FUN_14002f8c0(local_d8);
  FUN_14002f8c0(local_f8);
  FUN_14002f8c0(local_118);
  FUN_14002f8c0(local_138);
  FUN_14002f8c0(local_158);
  FUN_14002f8c0(local_178);
  if (7 < local_350) {
    uVar21 = local_350 * 2 + 2;
    pppppppuVar10 = local_368[0];
    if (0xfff < uVar21) {
      uVar21 = local_350 * 2 + 0x29;
      pppppppuVar10 = (undefined8 *******)local_368[0][-1];
      if (0x1f < (ulonglong)((longlong)local_368[0] + (-8 - (longlong)pppppppuVar10))) {
LAB_14027c1a9:
        (*(code *)0x3d7636)(pppppppuVar10,uVar21);
        pcVar7 = (code *)swi(3);
        uVar11 = (*pcVar7)();
        return uVar11;
      }
    }
    thunk_FUN_1402b909d(pppppppuVar10,uVar21);
  }
  local_358 = 0;
  local_350 = 7;
  local_368[0] = (undefined8 *******)((ulonglong)local_368[0] & 0xffffffffffff0000);
  if (7 < uStack_370) {
    uVar21 = uStack_370 * 2 + 2;
    pppppppuVar10 = local_388;
    if (0xfff < uVar21) {
      uVar21 = uStack_370 * 2 + 0x29;
      pppppppuVar10 = (undefined8 *******)local_388[-1];
      if (0x1f < (ulonglong)((longlong)local_388 + (-8 - (longlong)pppppppuVar10))) {
LAB_14027c214:
        local_350 = 7;
        local_358 = 0;
        (*(code *)0x3d7636)(pppppppuVar10,uVar21);
        pcVar7 = (code *)swi(3);
        uVar11 = (*pcVar7)();
        return uVar11;
      }
    }
    thunk_FUN_1402b909d(pppppppuVar10,uVar21);
  }
  local_378 = (ulonglong *)0x0;
  uStack_370 = 7;
  local_388 = (undefined8 *******)((ulonglong)local_388 & 0xffffffffffff0000);
LAB_14027c049:
  plVar17 = (longlong *)FUN_14029d650(local_4d8);
  lVar25 = plVar17[1];
  lVar24 = *plVar17;
  do {
    if (lVar24 == lVar25) {
      if (puStack_4d0 != (ulonglong *)0x0) {
        FUN_1400727e0();
      }
      if (local_478 != (longlong *)0x0) {
        FUN_1400727e0();
      }
      return 1;
    }
    FUN_140295e10(local_1f8,lVar24);
    uVar28 = (uint)pppppppuVar20;
    local_4f8 = uVar28 | 0x40;
    lVar6 = *(longlong *)(param_1 + 0x78);
    lVar18 = FUN_1402726f0((longlong *)(param_1 + 0x78),local_1f8);
    uVar27 = uVar28 & 0xffffffbf;
    pppppppuVar20 = (undefined8 *******)(ulonglong)uVar27;
    local_4f8 = uVar27;
    FUN_14002f8c0(local_1f8);
    if (lVar18 == lVar6) {
LAB_14027c2b7:
      if (puStack_4d0 != (ulonglong *)0x0) {
        LOCK();
        *(int *)(puStack_4d0 + 1) = (int)puStack_4d0[1] + 1;
        UNLOCK();
        uVar27 = local_4f8;
      }
      local_4c8 = local_4d8;
      puStack_4c0 = puStack_4d0;
      local_4f0 = &local_4c8;
      if (puStack_4d0 != (ulonglong *)0x0) {
        LOCK();
        *(int *)(puStack_4d0 + 1) = (int)puStack_4d0[1] + 1;
        UNLOCK();
        uVar27 = local_4f8;
      }
      local_298 = local_4d8;
      puStack_290 = puStack_4d0;
      local_440 = &local_288;
      FUN_1400612f0(&local_288,lVar24);
      FUN_1402771a0(&local_4c8);
      FUN_140295e10(local_1b8,lVar24);
      local_4f8 = uVar27 | 0x100;
      local_438 = local_268;
      FUN_1400612f0(local_268,local_1b8);
      local_430 = &local_248;
      local_248 = local_298;
      puStack_240 = puStack_290;
      local_298 = 0;
      puStack_290 = (ulonglong *)0x0;
      local_408 = &local_238;
      local_238 = CONCAT62(uStack_286,local_288);
      uStack_230 = uStack_280;
      local_228 = local_278;
      uStack_220 = uStack_270;
      local_278 = 0;
      uStack_270 = 7;
      local_288 = 0;
      local_4f8 = uVar27 | 0x300;
      FUN_140271be0(param_1 + 0x78,local_3b0,local_268);
      local_4f8 = (uVar27 | 0x300) & 0xfffffdff;
      local_428 = &local_248;
      local_420 = &local_238;
      if (7 < uStack_220) {
        uVar21 = uStack_220 * 2 + 2;
        uVar22 = local_238;
        if (0xfff < uVar21) {
          uVar21 = uStack_220 * 2 + 0x29;
          uVar22 = *(ulonglong *)(local_238 - 8);
          if (0x1f < (local_238 - uVar22) - 8) {
            (*(code *)0x3d7636)();
            pcVar7 = (code *)swi(3);
            uVar11 = (*pcVar7)();
            return uVar11;
          }
        }
        thunk_FUN_1402b909d(uVar22,uVar21);
      }
      local_228 = 0;
      uStack_220 = 7;
      local_238 = local_238 & 0xffffffffffff0000;
      if (puStack_240 != (ulonglong *)0x0) {
        FUN_1400727e0();
      }
      local_418 = local_268;
      FUN_14002f8c0(local_268);
      uVar28 = uVar27 & 0xfffffcff;
      pppppppuVar20 = (undefined8 *******)(ulonglong)uVar28;
      local_4f8 = uVar28;
      FUN_14002f8c0(local_1b8);
      local_410 = &local_288;
      FUN_14002f8c0(&local_288);
      if (puStack_290 != (ulonglong *)0x0) {
        FUN_1400727e0();
      }
      if (*(char *)(param_1 + 0xf4) != '\0') {
        if (*(char *)(param_1 + 0xf6) == '\0') {
          FUN_140295e10(local_198,lVar24);
          local_4f8 = uVar28 | 0x400;
          FUN_140277fd0(param_1,local_198);
          local_4f8 = uVar27 & 0xfffff8ff;
          pppppppuVar20 = (undefined8 *******)(ulonglong)local_4f8;
          FUN_14002f8c0(local_198);
        }
        else {
          uVar11 = FUN_14029cfe0(local_4d8,local_b8,lVar24);
          uVar11 = FUN_140295e10(local_98,uVar11);
          FUN_140277fd0(param_1,uVar11);
          FUN_14002f8c0(local_98);
          FUN_14002f8c0(local_b8);
        }
      }
    }
    else if (*(char *)(param_1 + 0x110) != '\0') {
      FUN_140295e10(local_1d8,lVar24);
      local_4f8 = uVar27 | 0x80;
      FUN_1402864f0(param_1 + 0x78,local_1d8);
      uVar27 = uVar28 & 0xffffff3f;
      local_4f8 = uVar27;
      FUN_14002f8c0(local_1d8);
      goto LAB_14027c2b7;
    }
    lVar24 = lVar24 + 0x20;
  } while( true );
}

