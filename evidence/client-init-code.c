
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

uint FUN_14008fc10(longlong param_1,undefined8 *param_2,uint param_3,uint param_4,
                  undefined8 *param_5)

{
  byte *pbVar1;
  longlong *plVar2;
  byte bVar3;
  char cVar4;
  undefined4 uVar5;
  undefined4 uVar6;
  undefined4 uVar7;
  undefined4 uVar8;
  undefined8 *puVar9;
  char cVar10;
  int iVar11;
  uint uVar12;
  uint uVar13;
  undefined8 uVar14;
  undefined8 *puVar15;
  longlong lVar16;
  byte *pbVar17;
  longlong lVar18;
  undefined8 uVar19;
  code *pcVar20;
  longlong *plVar21;
  char *pcVar22;
  undefined8 *puVar23;
  longlong lVar24;
  uint uVar25;
  uint uVar26;
  int iVar27;
  longlong lVar28;
  undefined8 *puVar29;
  int iVar30;
  int iVar31;
  ulonglong uVar32;
  int iVar33;
  code *pcVar34;
  undefined1 auStack_568 [32];
  undefined8 **local_548;
  uint *local_540;
  uint local_538 [2];
  undefined8 *local_530;
  int local_528;
  undefined1 local_524 [12];
  undefined1 local_518 [262];
  undefined4 local_412;
  undefined4 local_40e;
  undefined4 local_408;
  undefined2 local_400;
  undefined4 local_3fc;
  undefined4 local_3f8;
  undefined1 local_3e8;
  undefined1 local_3e7 [259];
  undefined4 local_2e4;
  undefined4 local_2e0;
  undefined4 local_2dc;
  undefined1 local_2b8 [160];
  undefined8 local_218;
  undefined8 uStack_210;
  undefined8 local_208;
  undefined8 uStack_200;
  undefined8 local_1f8;
  undefined8 uStack_1f0;
  undefined8 local_1e8;
  undefined8 uStack_1e0;
  undefined2 local_1d8;
  char local_1d6 [22];
  undefined1 local_1c0 [38];
  char acStack_19a [2];
  undefined8 local_198;
  undefined1 local_88 [64];
  ulonglong local_48;
  
  local_48 = DAT_1403eef38 ^ (ulonglong)auStack_568;
  local_530 = param_5;
  local_538[0] = param_4;
  uVar14 = (*(code *)0x3d59ae)(0,1,&DAT_140307558);
  *(undefined8 *)(param_1 + 0x32d8) = uVar14;
  iVar11 = (*(code *)0x3d5664)();
  if (iVar11 == 0xb7) {
    if (DAT_1403fe5e0 != 0) {
      (*(code *)0x3d5f52)(DAT_1403fe5e0,0x10,0,0);
      DAT_1403fe5e0 = 0;
    }
    FUN_1400bfea0("[ERROR] Aleady exists");
    (*(code *)0x3d5edc)(0,&DAT_140307598,"SuddenAttack",0x10);
    return 1;
  }
  FUN_14010d090(param_1 + 0x800,param_1 + 0x3a38);
  FUN_1401290a0(1);
  FUN_1400e8990();
  pcVar20 = (code *)0x0;
  uVar13 = 0;
  *(undefined1 *)(param_1 + 0x3821) = 1;
  *(undefined8 *)(param_1 + 0x32f0) = 0;
  *(undefined2 *)(param_1 + 0x3804) = 0;
  *(undefined4 *)(param_1 + 0x3a20) = 0;
  uVar14 = (**(code **)(*DAT_1403fe5d0 + 0x60))();
  FUN_14016dc50(uVar14,param_1);
  FUN_14007e070();
  cVar10 = FUN_140091d30(param_1);
  if (cVar10 == '\0') {
    FUN_1400bfea0("[ERROR] LOADFAILEDPKG(%d)",0x61);
    FUN_1400a8e70(param_1,0x4000061);
    return 0x61;
  }
  FUN_1400bfea0("[CLIENT INIT] Init 8 - Lapacker Load");
  *(undefined8 *)(param_1 + 0x380c) = 0;
  *(undefined4 *)(param_1 + 0x3808) = 0;
  FUN_1402b8fb3(param_1 + 0xcc0,0,0xff);
  uVar12 = 0x28;
  if (param_3 < 0x29) {
    uVar12 = param_3;
  }
  if (uVar12 == 0) {
    FUN_1400a94f0(param_1,0x39);
    FUN_1400a8e70(param_1,0x4000039);
    FUN_1400bf960(0x39);
    if (0 < DAT_1403f91e4) {
      FUN_1400bfea0(DAT_1403d9848,"CClientMgr::Init","LT_NOGAMERESOURCES",&DAT_1403018f4);
    }
    return 0x39;
  }
  lVar24 = 2;
  puVar29 = (undefined8 *)(param_1 + 0x3840);
  puVar9 = param_2;
  do {
    puVar23 = puVar9;
    puVar15 = puVar29;
    uVar14 = puVar23[1];
    *puVar15 = *puVar23;
    puVar15[1] = uVar14;
    uVar14 = puVar23[3];
    puVar15[2] = puVar23[2];
    puVar15[3] = uVar14;
    uVar14 = puVar23[5];
    puVar15[4] = puVar23[4];
    puVar15[5] = uVar14;
    uVar14 = puVar23[7];
    puVar15[6] = puVar23[6];
    puVar15[7] = uVar14;
    uVar14 = puVar23[9];
    puVar15[8] = puVar23[8];
    puVar15[9] = uVar14;
    uVar14 = puVar23[0xb];
    puVar15[10] = puVar23[10];
    puVar15[0xb] = uVar14;
    uVar14 = puVar23[0xd];
    puVar15[0xc] = puVar23[0xc];
    puVar15[0xd] = uVar14;
    uVar14 = puVar23[0xf];
    puVar15[0xe] = puVar23[0xe];
    puVar15[0xf] = uVar14;
    lVar24 = lVar24 + -1;
    puVar29 = puVar15 + 0x10;
    puVar9 = puVar23 + 0x10;
  } while (lVar24 != 0);
  uVar14 = puVar23[0x11];
  local_548 = (undefined8 **)&local_528;
  puVar15[0x10] = puVar23[0x10];
  puVar15[0x11] = uVar14;
  uVar14 = puVar23[0x13];
  puVar15[0x12] = puVar23[0x12];
  puVar15[0x13] = uVar14;
  uVar14 = puVar23[0x15];
  puVar15[0x14] = puVar23[0x14];
  puVar15[0x15] = uVar14;
  uVar5 = *(undefined4 *)(puVar23 + 0x16);
  uVar6 = *(undefined4 *)((longlong)puVar23 + 0xb4);
  uVar7 = *(undefined4 *)(puVar23 + 0x17);
  uVar8 = *(undefined4 *)((longlong)puVar23 + 0xbc);
  *(uint *)(param_1 + 0x3980) = uVar12;
  *(undefined4 *)(puVar15 + 0x16) = uVar5;
  *(undefined4 *)((longlong)puVar15 + 0xb4) = uVar6;
  *(undefined4 *)(puVar15 + 0x17) = uVar7;
  *(undefined4 *)((longlong)puVar15 + 0xbc) = uVar8;
  (**(code **)(*DAT_1403fe5d8 + 0x30))(DAT_1403fe5d8,param_2,uVar12,local_2b8);
  if (local_528 == 0) {
    FUN_1400a94f0(param_1,0x1b,*param_2);
    FUN_1400a8e70(param_1,0x1b);
    FUN_1400bf960(0x1b);
    if (0 < DAT_1403f91e4) {
      FUN_1400bfea0(DAT_1403d9848,"CClientMgr::Init","LT_CANTLOADGAMERESOURCES",&DAT_1403018f4);
    }
    return 0x1b;
  }
  (**(code **)(*DAT_1403fe668 + 8))();
  FUN_140027500(0x1ff,"initialize ClientShell DLL Entity.");
  FUN_1400bfea0("[CLIENT INIT] WriteStageLog");
  uVar12 = FUN_1400bef00();
  FUN_1400bfea0("[MD5] InitClient end ");
  if (DAT_1403fe650 != (longlong *)0x0) {
    (**(code **)(*DAT_1403fe650 + 0x170))(DAT_1403fe650,DAT_14045fed0);
    FUN_140027500(0x200,"assigning NXGSM instance to CShell.");
    if (DAT_1403fe650 != (longlong *)0x0) {
      FUN_140027500(0x1f7,"EAC Start");
      (**(code **)(*DAT_1403fe650 + 0x180))();
    }
  }
  if (uVar12 != 0) {
    FUN_1400bfea0("[ERROR] InitClientShellDE (%d)",uVar12);
    FUN_1400a8e70(param_1,uVar12 | 0x4000000);
    return uVar12;
  }
  local_218 = 0x642e6c6c65687363;
  uStack_210 = CONCAT53(uStack_210._3_5_,0x6c6c);
  lVar24 = (*(code *)0x3d57a2)(&local_218);
  uVar12 = 0;
  if (lVar24 == 0) goto LAB_140090130;
  (*(code *)0x3d58a4)(lVar24,acStack_19a + 2,0x104);
  pcVar34 = pcVar20;
  do {
    lVar24 = (*(code *)0x3d795e)(acStack_19a + 2,&DAT_140368f40,0x20);
    if (lVar24 != 0) {
      (*(code *)0x3d7968)(lVar24,0,2);
      lVar16 = (*(code *)0x3d7974)(lVar24);
      (*(code *)0x3d7968)(lVar24,0,0);
      pbVar17 = operator_new(lVar16 + 8);
      lVar28 = lVar16;
      pcVar34 = pcVar20;
      goto LAB_1400900a0;
    }
    (*(code *)0x3d56c4)(10);
    uVar25 = (int)pcVar34 + 1;
    pcVar34 = (code *)(ulonglong)uVar25;
    uVar26 = uVar12;
  } while ((int)uVar25 < 5);
  goto LAB_140090125;
  while (lVar18 != 0) {
LAB_1400900a0:
    lVar18 = (*(code *)0x3d7844)(pcVar34 + (longlong)pbVar17,1,lVar28,lVar24);
    pcVar34 = pcVar34 + lVar18;
    lVar28 = lVar28 - lVar18;
    if (lVar28 == 0) break;
  }
  (*(code *)0x3d76ea)(lVar24);
  if (pbVar17 != (byte *)0x0) {
    uVar13 = 0xffffffff;
    pbVar1 = pbVar17;
    for (; lVar16 != 0; lVar16 = lVar16 + -1) {
      bVar3 = *pbVar1;
      pbVar1 = pbVar1 + 1;
      uVar13 = uVar13 >> 8 ^ *(uint *)(param_1 + 0x2dc0 + (ulonglong)((bVar3 ^ uVar13) & 0xff) * 4);
    }
    uVar13 = ~uVar13;
  }
  thunk_FUN_1402b909d(pbVar17);
  param_5 = local_530;
  uVar26 = uVar13;
LAB_140090125:
  *(uint *)(param_1 + 0x31c0) = uVar26;
  param_4 = local_538[0];
LAB_140090130:
  uVar32 = (ulonglong)param_4;
  FUN_1400bfea0("[MD5] InitClient CShell");
  FUN_1400a6890();
  FUN_1400a57b0();
  cVar10 = FUN_140090bf0(param_1,0,0x6cf0,1);
  if (cVar10 != '\0') {
    FUN_1400beb50(param_1 + 0x37d8);
    FUN_140163c20(param_1 + 0x37d8,local_1c0,0x20);
    FUN_1400780f0(local_88,0x40,"version %s",local_1c0);
    FUN_1400a4910(&DAT_140404dc0,local_88);
    iVar11 = FUN_1400bf280();
    if (iVar11 != 0) {
      uVar14 = FUN_1400cce60();
      uVar19 = FUN_1400be920();
      cVar10 = FUN_1400cd150(uVar14,uVar19);
      if (cVar10 == '\0') {
        FUN_1400a8e70(param_1,0x400001c);
        FUN_1400bf960(0x1c);
        if (0 < DAT_1403f91e4) {
          FUN_1400bfea0(DAT_1403d9848,"CClientMgr::Init","LT_CANTINITIALIZEINPUT",&DAT_1403018f4);
        }
        return 0x1c;
      }
    }
    puVar29 = param_5;
    if (param_4 != 0) {
      do {
        FUN_1400a4af0(&DAT_140404dc0,*puVar29,2);
        uVar32 = uVar32 - 1;
        puVar29 = puVar29 + 1;
      } while (uVar32 != 0);
      uVar32 = (ulonglong)local_538[0];
    }
    FUN_140093d10(param_1,2);
    uVar14 = FUN_1400be920();
    *(undefined8 *)(param_1 + 0x7e8) = uVar14;
    uVar14 = FUN_1400be8e0();
    *(undefined8 *)(param_1 + 0x7f0) = uVar14;
    if (DAT_140409360 != 0) {
      FUN_1400bfea0("Warning: NullRender is ON.");
    }
    if ((int)uVar32 != 0) {
      do {
        FUN_1400a4af0(&DAT_140404dc0,*param_5,1);
        param_5 = param_5 + 1;
        uVar32 = uVar32 - 1;
      } while (uVar32 != 0);
    }
    FUN_140093d10(param_1,1);
    *(undefined1 *)(param_1 + 0x3820) = 1;
    *(undefined8 *)(param_1 + 0x39b8) = 0;
    FUN_1402b8fb3(&local_3e8,0,0x130);
    local_3e8 = DAT_14040939c == 0;
    local_2e4 = DAT_1403e3ca0;
    local_2e0 = DAT_1403e3ca4;
    local_2dc = DAT_1403e3c9c;
    lVar24 = FUN_1400a44d0(&DAT_140404dc0,"carddesc");
    if ((lVar24 != 0) && (*(longlong *)(lVar24 + 0x18) != 0)) {
      (*(code *)0x3d7794)(local_3e7,*(longlong *)(lVar24 + 0x18),0x7f);
    }
    builtin_strncpy(local_1d6,"dDrv.dll",9);
    local_1d6[9] = '\0';
    local_1d6[10] = '\0';
    local_1d6[0xb] = '\0';
    local_1d6[0xc] = '\0';
    local_1d6[0xd] = '\0';
    local_1d6[0xe] = '\0';
    local_1d6[0xf] = '\0';
    local_1d8 = 0x6e53;
    local_530 = (undefined8 *)(*(code *)0x3d57c8)(&local_1d8);
    if (local_530 != (undefined8 *)0x0) {
      pcVar20 = (code *)(*(code *)0x3d57b6)(local_530,"SoundSysCheck");
      if (pcVar20 != (code *)0x0) {
        iVar11 = (*(code *)0x3d7818)();
        iVar33 = iVar11 % 100000 + 100;
        iVar11 = (*(code *)0x3d7818)();
        iVar30 = iVar11 % 100000 + 100;
        iVar11 = (*(code *)0x3d7818)();
        iVar31 = iVar11 % 100000 + 100;
        iVar11 = (*(code *)0x3d7818)();
        iVar27 = iVar11 % 100000 + 100;
        iVar11 = (*pcVar20)(iVar33,iVar30,iVar31,iVar27);
        uVar12 = (uint)(iVar11 == (iVar30 + iVar33) * iVar31 - (iVar31 - iVar27) * iVar33);
      }
      (*(code *)0x3d5794)(local_530);
      (*(code *)0x3d56c4)(1);
      if (uVar12 != 0) {
        local_530 = (undefined8 *)0x0;
        FUN_1402b8fb3(local_518,0,0x124);
        FUN_1402b8fb3(acStack_19a + 2,0,0x105);
        plVar21 = (longlong *)FUN_140189620();
        local_3f8 = 0x3f800000;
        local_218 = 0;
        uStack_210 = 0;
        local_208 = 0;
        uStack_200 = 0;
        local_1f8 = 0;
        uStack_1f0 = 0;
        local_408 = 2;
        local_1e8 = 0;
        uStack_1e0 = 0;
        local_412 = 0x200080;
        local_3fc = 0x3c800000;
        local_40e = 0x105622;
        local_400 = 0x32;
        (*(code *)0x3d7934)(acStack_19a + 2,0x105,"DirectSound Hardware");
        (**(code **)(*plVar21 + 0x60))(plVar21,&local_530,0,local_412._2_2_);
        puVar29 = local_530;
        if (local_530 == (undefined8 *)0x0) {
          FUN_1400bfea0("[ERROR] InitSoundSystem -> pSound3DProviderList = NULL");
          DAT_1404093a8 = 0;
          (*(code *)0x3d7934)(&local_218,0x40,"InitSoundSystem 0");
          FUN_1400a4910(&DAT_140404dc0,&local_218);
        }
        else {
          do {
            pcVar22 = acStack_19a + 2;
            lVar24 = 4 - (longlong)pcVar22;
            do {
              cVar10 = *pcVar22;
              cVar4 = pcVar22[(longlong)puVar29 + lVar24];
              if (cVar10 != cVar4) break;
              pcVar22 = pcVar22 + 1;
            } while (cVar4 != '\0');
            if (cVar10 == cVar4) {
              if (puVar29 != (undefined8 *)0x0) {
                (*(code *)0x3d7934)(local_518,0x105,(longlong)puVar29 + 4);
              }
              break;
            }
            plVar2 = puVar29 + 0x22;
            puVar29 = (undefined8 *)*plVar2;
          } while ((undefined8 *)*plVar2 != (undefined8 *)0x0);
          (**(code **)(*plVar21 + 0x68))(plVar21,local_530);
          iVar11 = (**(code **)(*plVar21 + 0x70))(plVar21,local_518);
          if (iVar11 != 0) {
            FUN_1400bfea0("[SoundError] InitSound Fail");
          }
          DAT_1404093a8 = 1;
          (*(code *)0x3d7934)(&local_218,0x40,"InitSoundSystem 1");
          FUN_1400a4910(&DAT_140404dc0,&local_218);
          FUN_1400bfea0("[ENGINE] InitSoundSystem");
        }
        FUN_14005f150();
        uVar13 = (**(code **)(*DAT_1403fe650 + 0x40))(DAT_1403fe650,&local_3e8,param_1 + 0xb20);
        FUN_1400bfea0("[ENGINE] OnEnginePreInit(%d)",uVar13);
        if (uVar13 != 0) {
          return uVar13;
        }
        lVar24 = (*(code *)0x3d57a2)("Winmm.dll");
        if (lVar24 != 0) {
          uVar14 = (*(code *)0x3d57b6)(lVar24,"timeGetTime");
          *(undefined8 *)(param_1 + 0x39d0) = uVar14;
        }
        lVar24 = (*(code *)0x3d57a2)("NTDLL.dll");
        if (lVar24 != 0) {
          uVar14 = (*(code *)0x3d57b6)(lVar24,"RtlEnterCriticalSection");
          *(undefined8 *)(param_1 + 0x39d8) = uVar14;
        }
        if (DAT_1403fe5e0 != 0) {
          (*(code *)0x3d5f52)(DAT_1403fe5e0,0x10,0,0);
          DAT_1403fe5e0 = 0;
        }
        if (DAT_1403fe678 != (longlong *)0x0) {
          (**(code **)(*DAT_1403fe678 + 8))();
        }
        local_548 = &local_530;
        iVar11 = (*(code *)0x3d62a0)(0xffffffff80000001,
                                     "SOFTWARE\\Microsoft\\Windows\\Shell\\Associations\\UrlAssociations\\http\\UserChoice"
                                     ,0,0x20119);
        if (iVar11 == 0) {
          FUN_1402b8fb3(acStack_19a + 2,0,0x100);
          local_540 = local_538;
          local_548 = (undefined8 **)(acStack_19a + 2);
          local_538[0] = 0x100;
          iVar11 = (*(code *)0x3d62b0)(local_530,"ProgId",0,local_524);
          if (iVar11 == 0) {
            (*(code *)0x3d626e)(local_530);
            (*(code *)0x3d7940)(acStack_19a + 2,0x100,"\\Application");
            local_548 = &local_530;
            iVar11 = (*(code *)0x3d62a0)(0xffffffff80000000,acStack_19a + 2,0,0x20119);
            if (iVar11 == 0) {
              local_540 = local_538;
              local_548 = (undefined8 **)(acStack_19a + 2);
              local_538[0] = 0x100;
              iVar11 = (*(code *)0x3d62b0)(local_530,"ApplicationIcon",0,local_524);
              if (iVar11 == 0) {
                lVar24 = -1;
                do {
                  lVar16 = lVar24;
                  lVar24 = lVar16 + 1;
                } while (acStack_19a[lVar16 + 3] != '\0');
                if (0xff < lVar16 - 1U) {
                    /* WARNING: Subroutine does not return */
                  FUN_140263f8c();
                }
                acStack_19a[lVar16 + 1] = '\0';
                lVar24 = -1;
                do {
                  lVar16 = lVar24 + 3;
                  lVar24 = lVar24 + 1;
                } while (acStack_19a[lVar16] != '\0');
                FUN_14002fc20(param_1 + 0x3f30,acStack_19a + 2);
                (*(code *)0x3d626e)(local_530);
              }
              else {
                FUN_1400bfea0("[DefaultWebbrowser] Cannot access default browser path.");
              }
            }
            else {
              FUN_1400bfea0("[DefaultWebbrowser] Cannot find installed program.");
            }
          }
          else {
            FUN_1400bfea0("[DefaultWebbrowser] Cannot access program id.");
          }
        }
        else {
          FUN_1400bfea0("[DefaultWebbrowser] Cannot find user choice.");
        }
        iVar11 = (**(code **)(*DAT_1403fe650 + 0x120))();
        if (iVar11 == 0) {
          FUN_1400bfea0("[ENGINE] InitStartLogo SUCCESS");
          DAT_1403fe5ec = 1;
          DAT_1403fe640 = 1;
          return 0;
        }
        FUN_1400bfea0("[ENGINE] InitStartLogo FAIL");
        (**(code **)(*DAT_1403fe650 + 0x140))();
        uVar13 = (**(code **)(*DAT_1403fe650 + 0x48))();
        FUN_1400bfea0("[ENGINE] OnEngineInitialized(%d)",uVar13);
        return uVar13;
      }
    }
    FUN_1400bfea0("ERROR Check SoundSystem 0x%08x, %d",pcVar20,0);
    uVar14 = FUN_1400be920();
    (*(code *)0x3d5edc)(uVar14,&DAT_1403077c0,"SuddenAttack",0x10);
  }
  return 1;
}

