
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined8 FUN_1806db9a0(longlong *param_1)

{
  code *pcVar1;
  longlong *plVar2;
  size_t sVar3;
  undefined1 uVar4;
  uint uVar5;
  uint uVar6;
  int iVar7;
  longlong lVar8;
  longlong lVar9;
  int *piVar10;
  byte *pbVar11;
  ulonglong uVar12;
  char ****ppppcVar13;
  void *_Memory;
  char *****pppppcVar14;
  longlong *plVar15;
  char *****pppppcVar16;
  ulonglong uVar17;
  char *****pppppcVar18;
  float fVar19;
  float fVar20;
  undefined1 auStack_3d8 [32];
  undefined1 *local_3b8;
  float local_3b0;
  undefined4 local_3a8;
  undefined8 local_398;
  uint uStack_390;
  undefined4 uStack_38c;
  undefined1 local_388 [16];
  char ****local_378 [2];
  size_t local_368;
  ulonglong local_360;
  char ****local_358 [2];
  longlong local_348;
  ulonglong local_340;
  void *local_338 [3];
  ulonglong local_320;
  undefined4 local_318;
  undefined4 uStack_314;
  uint uStack_310;
  undefined4 uStack_30c;
  undefined1 local_308 [128];
  undefined1 local_288 [256];
  char local_188 [272];
  ulonglong local_78;
  
  local_78 = DAT_181905cc8 ^ (ulonglong)auStack_3d8;
  local_398 = FUN_181387aac(0xe8);
  lVar9 = 0;
  lVar8 = lVar9;
  if (local_398 != 0) {
    lVar8 = FUN_180d50ee0(local_398);
  }
  param_1[0x97] = lVar8;
  local_3b8._0_4_ = 0xffffffff;
  FUN_180d4f0c0(lVar8,0x200,0x10,1);
  local_3a8 = 0xffffffff;
  local_3b0 = (float)((uint)local_3b0 & 0xffffff00);
  local_3b8 = (undefined1 *)CONCAT44(local_3b8._4_4_,3);
  FUN_180d4e5c0(param_1[0x97],&DAT_181689868,0,1);
  local_398 = FUN_181387aac(0xe8);
  if (local_398 != 0) {
    lVar9 = FUN_180d50ee0(local_398);
  }
  param_1[0xdf] = lVar9;
  local_3b8._0_4_ = 0xffffffff;
  FUN_180d4f0c0(lVar9,0x100,0x10,1);
  FUN_180d4f680(param_1[0xdf],0,0x686868,1);
  local_3a8 = 0xffffffff;
  local_3b0 = (float)((uint)local_3b0 & 0xffffff00);
  local_3b8._0_4_ = 3;
  FUN_180d4e5c0(param_1[0xdf],&DAT_181689868,0,1);
  uVar5 = FUN_180d61d70(DAT_181a1b390);
  fVar19 = (float)FUN_180d61d10(DAT_181a1b390);
  uVar6 = FUN_180d61dc0(DAT_181a1b390);
  fVar20 = (float)FUN_180d61d40(DAT_181a1b390);
  lVar8 = FUN_180d617b0(DAT_181a1b390,"sa_interface2\\hud\\crosshair\\black.dtx",1);
  param_1[0x85] = lVar8;
  (**(code **)(*DAT_181952a48 + 0x208))(DAT_181952a48,param_1 + 0x86,0xffffffff);
  local_3b0 = 1.0;
  local_3b8._0_4_ = 0x3f800000;
  (**(code **)(*DAT_181952a48 + 0x1c8))(DAT_181952a48,param_1 + 0x86,0,0);
  local_3b8 = (undefined1 *)CONCAT44(local_3b8._4_4_,fVar19 * (float)uVar5 + fVar19 * (float)uVar5);
  local_3b0 = fVar20 * (float)uVar6 + fVar20 * (float)uVar6;
  (**(code **)(*DAT_181952a48 + 0x1a8))(DAT_181952a48,param_1 + 0x86,0,0);
  plVar15 = param_1 + 3;
  lVar8 = 8;
  do {
    (**(code **)(*DAT_181952a48 + 0x208))(DAT_181952a48,plVar15,0xffffffff);
    plVar2 = DAT_181952a40;
    plVar15 = plVar15 + 0xc;
    lVar8 = lVar8 + -1;
  } while (lVar8 != 0);
  _DAT_1819f76b0 = "ScopeLRGap";
  FUN_1802ccc20(local_308,0x80,&DAT_1814a5a28,0);
  _DAT_1819f76a0 = (*(code *)plVar2[0x45])("ScopeLRGap");
  if (_DAT_1819f76a0 == 0) {
    local_3b8 = local_308;
    FUN_1802ccc20(local_288,0x100,"\"%s\" \"%s\"","ScopeLRGap");
    (*(code *)plVar2[0x7a])(local_288);
    _DAT_1819f76a0 = (*(code *)plVar2[0x45])("ScopeLRGap");
    if (_DAT_1819f76a0 != 0) goto LAB_1806dbcbb;
  }
  else {
LAB_1806dbcbb:
    _DAT_1819f76a8 = plVar2;
  }
  plVar15 = DAT_181952a40;
  _DAT_1819f76c8 = "ScopeUPGap";
  FUN_1802ccc20(local_308,0x80,&DAT_1814a5a28,0);
  _DAT_1819f76b8 = (*(code *)plVar15[0x45])("ScopeUPGap");
  if (_DAT_1819f76b8 == 0) {
    local_3b8 = local_308;
    FUN_1802ccc20(local_288,0x100,"\"%s\" \"%s\"","ScopeUPGap");
    (*(code *)plVar15[0x7a])(local_288);
    _DAT_1819f76b8 = (*(code *)plVar15[0x45])("ScopeUPGap");
    if (_DAT_1819f76b8 != 0) goto LAB_1806dbd52;
  }
  else {
LAB_1806dbd52:
    _DAT_1819f76c0 = plVar15;
  }
  plVar15 = DAT_181952a40;
  _DAT_1819f76e0 = "ScopeLRRadius";
  FUN_1802ccc20(local_308,0x80,&DAT_1814a5a28,0x3fd820c4a0000000);
  _DAT_1819f76d0 = (*(code *)plVar15[0x45])("ScopeLRRadius");
  if (_DAT_1819f76d0 == 0) {
    local_3b8 = local_308;
    FUN_1802ccc20(local_288,0x100,"\"%s\" \"%s\"","ScopeLRRadius");
    (*(code *)plVar15[0x7a])(local_288);
    _DAT_1819f76d0 = (*(code *)plVar15[0x45])("ScopeLRRadius");
    if (_DAT_1819f76d0 != 0) goto LAB_1806dbdee;
  }
  else {
LAB_1806dbdee:
    _DAT_1819f76d8 = plVar15;
  }
  plVar15 = DAT_181952a40;
  _DAT_1819f76f8 = "ScopeUDRadius";
  FUN_1802ccc20(local_308,0x80,&DAT_1814a5a28,0x3fd5c28f60000000);
  _DAT_1819f76e8 = (*(code *)plVar15[0x45])("ScopeUDRadius");
  if (_DAT_1819f76e8 == 0) {
    local_3b8 = local_308;
    FUN_1802ccc20(local_288,0x100,"\"%s\" \"%s\"","ScopeUDRadius");
    (*(code *)plVar15[0x7a])(local_288);
    _DAT_1819f76e8 = (*(code *)plVar15[0x45])("ScopeUDRadius");
    if (_DAT_1819f76e8 == 0) goto LAB_1806dbe91;
  }
  _DAT_1819f76f0 = plVar15;
LAB_1806dbe91:
  uVar4 = FUN_180d66970("CrosshairStyle",0);
  FUN_1806dee60(param_1,uVar4,0);
  memset(local_188,0,0x104);
  strcpy_s(local_188,0x104,"SA_INTERFACE\\HUD\\SCOPE\\scope.dtx");
  pcVar1 = *(code **)(*DAT_181952a40 + 0x418);
  local_368 = 0;
  local_360 = 0xf;
  local_378[0] = (char ****)0x0;
  local_378[0] = (char ****)FUN_181387aac(0x30);
  local_368 = 0x20;
  local_360 = 0x2f;
  *(undefined4 *)local_378[0] = 0x495f4153;
  builtin_strncpy((char *)((longlong)local_378[0] + 4),"NTER",4);
  *(undefined4 *)(local_378[0] + 1) = 0x45434146;
  builtin_strncpy((char *)((longlong)local_378[0] + 0xc),"\\HUD",4);
  *(undefined4 *)(local_378[0] + 2) = 0x4f43535c;
  builtin_strncpy((char *)((longlong)local_378[0] + 0x14),"PE\\s",4);
  *(undefined4 *)(local_378[0] + 3) = 0x65706f63;
  builtin_strncpy((char *)((longlong)local_378[0] + 0x1c),".dtx",4);
  *(char *)(local_378[0] + 4) = '\0';
  (*pcVar1)(DAT_181952a40,local_378,1);
  if (0xf < local_360) {
    ppppcVar13 = local_378[0];
    if ((0xfff < local_360 + 1) &&
       (ppppcVar13 = (char ****)local_378[0][-1],
       (char *)0x1f < (char *)((longlong)local_378[0] + (-8 - (longlong)ppppcVar13)))) {
                    /* WARNING: Subroutine does not return */
      _invalid_parameter_noinfo_noreturn();
    }
    free(ppppcVar13);
  }
  pcVar1 = *(code **)(*DAT_181952a40 + 0x418);
  local_368 = 0;
  local_360 = 0xf;
  local_378[0] = (char ****)0x0;
  local_378[0] = (char ****)FUN_181387aac(0x30);
  local_368 = 0x23;
  local_360 = 0x2f;
  *(undefined4 *)local_378[0] = 0x495f4153;
  builtin_strncpy((char *)((longlong)local_378[0] + 4),"NTER",4);
  *(undefined4 *)(local_378[0] + 1) = 0x45434146;
  builtin_strncpy((char *)((longlong)local_378[0] + 0xc),"\\HUD",4);
  *(undefined4 *)(local_378[0] + 2) = 0x4f43535c;
  builtin_strncpy((char *)((longlong)local_378[0] + 0x14),"PE\\s",4);
  *(undefined4 *)(local_378[0] + 3) = 0x65706f63;
  builtin_strncpy((char *)((longlong)local_378[0] + 0x1c),"_BD.",4);
  *(undefined2 *)(local_378[0] + 4) = 0x7464;
  *(char *)((longlong)local_378[0] + 0x22) = 'x';
  *(char *)((longlong)local_378[0] + 0x23) = '\0';
  (*pcVar1)(DAT_181952a40,local_378,1);
  if (0xf < local_360) {
    ppppcVar13 = local_378[0];
    if ((0xfff < local_360 + 1) &&
       (ppppcVar13 = (char ****)local_378[0][-1],
       (char *)0x1f < (char *)((longlong)local_378[0] + (-8 - (longlong)ppppcVar13)))) {
                    /* WARNING: Subroutine does not return */
      _invalid_parameter_noinfo_noreturn();
    }
    free(ppppcVar13);
  }
  pcVar1 = *(code **)(*DAT_181952a40 + 0x418);
  local_368 = 0;
  local_360 = 0xf;
  local_378[0] = (char ****)0x0;
  local_378[0] = (char ****)FUN_181387aac(0x30);
  local_368 = 0x26;
  local_360 = 0x2f;
  *(undefined4 *)local_378[0] = 0x495f4153;
  builtin_strncpy((char *)((longlong)local_378[0] + 4),"NTER",4);
  *(undefined4 *)(local_378[0] + 1) = 0x45434146;
  builtin_strncpy((char *)((longlong)local_378[0] + 0xc),"\\HUD",4);
  *(undefined4 *)(local_378[0] + 2) = 0x4f43535c;
  builtin_strncpy((char *)((longlong)local_378[0] + 0x14),"PE\\s",4);
  *(undefined4 *)(local_378[0] + 3) = 0x65706f63;
  builtin_strncpy((char *)((longlong)local_378[0] + 0x1c),"_blo",4);
  *(undefined4 *)(local_378[0] + 4) = 0x642e6b63;
  ((char *)((longlong)local_378[0] + 0x24))[0] = 't';
  ((char *)((longlong)local_378[0] + 0x24))[1] = 'x';
  *(char *)((longlong)local_378[0] + 0x26) = '\0';
  (*pcVar1)(DAT_181952a40,local_378,1);
  if (0xf < local_360) {
    ppppcVar13 = local_378[0];
    if ((0xfff < local_360 + 1) &&
       (ppppcVar13 = (char ****)local_378[0][-1],
       (char *)0x1f < (char *)((longlong)local_378[0] + (-8 - (longlong)ppppcVar13)))) {
                    /* WARNING: Subroutine does not return */
      _invalid_parameter_noinfo_noreturn();
    }
    free(ppppcVar13);
  }
  pcVar1 = *(code **)(*DAT_181952a40 + 0x418);
  local_368 = 0;
  local_360 = 0xf;
  local_378[0] = (char ****)0x0;
  local_378[0] = (char ****)FUN_181387aac(0x30);
  local_368 = 0x23;
  local_360 = 0x2f;
  *(undefined4 *)local_378[0] = 0x495f4153;
  builtin_strncpy((char *)((longlong)local_378[0] + 4),"NTER",4);
  *(undefined4 *)(local_378[0] + 1) = 0x45434146;
  builtin_strncpy((char *)((longlong)local_378[0] + 0xc),"\\HUD",4);
  *(undefined4 *)(local_378[0] + 2) = 0x4f43535c;
  builtin_strncpy((char *)((longlong)local_378[0] + 0x14),"PE\\s",4);
  *(undefined4 *)(local_378[0] + 3) = 0x65706f63;
  builtin_strncpy((char *)((longlong)local_378[0] + 0x1c),"_bj.",4);
  *(undefined2 *)(local_378[0] + 4) = 0x7464;
  *(char *)((longlong)local_378[0] + 0x22) = 'x';
  *(char *)((longlong)local_378[0] + 0x23) = '\0';
  (*pcVar1)(DAT_181952a40,local_378,1);
  if (0xf < local_360) {
    ppppcVar13 = local_378[0];
    if ((0xfff < local_360 + 1) &&
       (ppppcVar13 = (char ****)local_378[0][-1],
       (char *)0x1f < (char *)((longlong)local_378[0] + (-8 - (longlong)ppppcVar13)))) {
                    /* WARNING: Subroutine does not return */
      _invalid_parameter_noinfo_noreturn();
    }
    free(ppppcVar13);
  }
  pcVar1 = *(code **)(*DAT_181952a40 + 0x418);
  local_368 = 0;
  local_360 = 0xf;
  local_378[0] = (char ****)0x0;
  local_378[0] = (char ****)FUN_181387aac(0x30);
  local_368 = 0x28;
  local_360 = 0x2f;
  *local_378[0] = (char ***)0x5245544e495f4153;
  local_378[0][1] = (char ***)0x4455485c45434146;
  *(undefined4 *)(local_378[0] + 2) = 0x4f43535c;
  builtin_strncpy((char *)((longlong)local_378[0] + 0x14),"PE\\s",4);
  *(undefined4 *)(local_378[0] + 3) = 0x65706f63;
  builtin_strncpy((char *)((longlong)local_378[0] + 0x1c),"_blo",4);
  local_378[0][4] = (char ***)0x7874642e32306b63;
  *(char *)(local_378[0] + 5) = '\0';
  (*pcVar1)(DAT_181952a40,local_378,1);
  if (0xf < local_360) {
    pppppcVar14 = (char *****)local_378[0];
    if ((0xfff < local_360 + 1) &&
       (pppppcVar14 = (char *****)local_378[0][-1],
       (char *)0x1f < (char *)((longlong)local_378[0] + (-8 - (longlong)pppppcVar14)))) {
                    /* WARNING: Subroutine does not return */
      _invalid_parameter_noinfo_noreturn();
    }
    free(pppppcVar14);
  }
  lVar8 = FUN_180d617b0(DAT_181a1b390,"SA_INTERFACE\\HUD\\SCOPE\\scope.dtx",1);
  param_1[0x99] = lVar8;
  local_3b0 = 1.0;
  local_3b8._0_4_ = 0x3f800000;
  FUN_1800abe00(param_1 + 0x1b,lVar8,0,0);
  lVar8 = FUN_180d617b0(DAT_181a1b390,"SA_INTERFACE\\HUD\\SCOPE\\Scope_RedSpot.dtx",1);
  param_1[0x9b] = lVar8;
  local_3b0 = 0.375;
  local_3b8._0_4_ = 0x3ec00000;
  FUN_1800abe00(param_1 + 0x3f,lVar8,0,0);
  lVar8 = FUN_180d617b0(DAT_181a1b390,"sa_interface2\\HUD\\MVP\\scope.dtx",1);
  param_1[0xa1] = lVar8;
  local_3b0 = 1.0;
  local_3b8 = (undefined1 *)CONCAT44(local_3b8._4_4_,0x3f800000);
  FUN_1800abe00(param_1 + 0xa2,lVar8,0,0);
  lVar8 = FUN_180d617b0(DAT_181a1b390,"sa_interface\\HUD\\scope\\Rail_Scope.dtx",1);
  param_1[0xdb] = lVar8;
  lVar8 = FUN_180d617b0(DAT_181a1b390,"sa_interface\\HUD\\scope\\scope_trg41.dtx",1);
  param_1[0xdc] = lVar8;
  piVar10 = (int *)(*(code *)DAT_181952a40[3])("sa_interface\\HUD\\scope");
  do {
    if (piVar10 == (int *)0x0) {
      lVar8 = FUN_180d617b0(DAT_181a1b390,"sa_interface2\\HUD\\crosshair\\Launcher.dtx",1);
      param_1[0xc6] = lVar8;
      local_3b0 = 1.0;
      local_3b8 = (undefined1 *)CONCAT44(local_3b8._4_4_,0x3f800000);
      FUN_1800abe00(param_1 + 199,lVar8,0,0);
      (**(code **)(*param_1 + 0x40))(param_1);
      (**(code **)(*param_1 + 0x38))(param_1);
      (**(code **)(param_1[100] + 8))();
      return 1;
    }
    if ((*piVar10 == 1) && (*(longlong *)(piVar10 + 4) != 0)) {
      pcVar1 = *(code **)(*DAT_181952a40 + 0x418);
      local_348 = 0;
      local_340 = 0xf;
      local_358[0] = (char ****)0x0;
      lVar8 = -1;
      do {
        lVar8 = lVar8 + 1;
      } while (*(char *)(*(longlong *)(piVar10 + 4) + lVar8) != '\0');
      FUN_18004dca0(local_358);
      (*pcVar1)(DAT_181952a40,local_358,1);
      if (0xf < local_340) {
        pppppcVar14 = (char *****)local_358[0];
        if ((0xfff < local_340 + 1) &&
           (pppppcVar14 = (char *****)local_358[0][-1],
           (char *)0x1f < (char *)((longlong)local_358[0] + (-8 - (longlong)pppppcVar14)))) {
                    /* WARNING: Subroutine does not return */
          _invalid_parameter_noinfo_noreturn();
        }
        free(pppppcVar14);
      }
      local_368 = 0;
      local_360 = 0xf;
      local_378[0] = (char ****)0x0;
      lVar8 = -1;
      do {
        lVar8 = lVar8 + 1;
      } while (*(char *)(*(longlong *)(piVar10 + 2) + lVar8) != '\0');
      FUN_18004dca0(local_378);
      uVar17 = local_360;
      sVar3 = local_368;
      pppppcVar14 = (char *****)local_378[0];
      pppppcVar16 = local_378;
      if (0xf < local_360) {
        pppppcVar16 = (char *****)local_378[0];
      }
      if (local_368 != 0) {
        for (pbVar11 = memchr(pppppcVar16,0x2e,local_368); pbVar11 != (byte *)0x0;
            pbVar11 = memchr(pbVar11 + 1,0x2e,
                             (size_t)((longlong)pppppcVar16 + (sVar3 - (longlong)(pbVar11 + 1))))) {
          if (*pbVar11 == 0x2e) {
            uVar5 = 0;
          }
          else {
            uVar5 = -(uint)(*pbVar11 < 0x2e) | 1;
          }
          if (uVar5 == 0) {
            uVar12 = (longlong)pbVar11 - (longlong)pppppcVar16;
            goto LAB_1806dc52e;
          }
        }
      }
      uVar12 = 0xffffffffffffffff;
LAB_1806dc52e:
      if (uVar12 != 0xffffffffffffffff) {
        local_348 = 0;
        local_340 = 0xf;
        local_358[0] = (char ****)0x0;
        if (sVar3 < uVar12) {
          uVar12 = sVar3;
        }
        pppppcVar16 = local_378;
        if (0xf < uVar17) {
          pppppcVar16 = pppppcVar14;
        }
        FUN_18004dca0(local_358,pppppcVar16,uVar12);
        pppppcVar14 = local_358;
        if (0xf < local_340) {
          pppppcVar14 = (char *****)local_358[0];
        }
        pppppcVar18 = (char *****)((longlong)pppppcVar14 + local_348);
        pppppcVar16 = local_358;
        if (0xf < local_340) {
          pppppcVar16 = (char *****)local_358[0];
        }
        if (pppppcVar16 != pppppcVar18) {
          lVar8 = (longlong)pppppcVar14 - (longlong)pppppcVar16;
          do {
            iVar7 = tolower((int)*(char *)pppppcVar16);
            *(char *)((longlong)pppppcVar16 + lVar8) = (char)iVar7;
            pppppcVar16 = (char *****)((longlong)pppppcVar16 + 1);
          } while (pppppcVar16 != pppppcVar18);
        }
        local_398 = FUN_180d617b0(DAT_181a1b390,*(undefined8 *)(piVar10 + 4),0);
        uStack_390 = uStack_390 & 0xffffff00;
        FUN_18004f260(local_338,local_358);
        local_318 = (undefined4)local_398;
        uStack_314 = local_398._4_4_;
        uStack_310 = uStack_390;
        uStack_30c = uStack_38c;
        FUN_1806da030(param_1 + 0xd3,local_388,local_338);
        if (0xf < local_320) {
          _Memory = local_338[0];
          if ((0xfff < local_320 + 1) &&
             (_Memory = *(void **)((longlong)local_338[0] + -8),
             0x1f < (ulonglong)((longlong)local_338[0] + (-8 - (longlong)_Memory)))) {
                    /* WARNING: Subroutine does not return */
            _invalid_parameter_noinfo_noreturn();
          }
          free(_Memory);
        }
        pppppcVar14 = (char *****)local_378[0];
        uVar17 = local_360;
        if (0xf < local_340) {
          pppppcVar14 = (char *****)local_358[0];
          if ((0xfff < local_340 + 1) &&
             (pppppcVar14 = (char *****)local_358[0][-1],
             (char *)0x1f < (char *)((longlong)local_358[0] + (-8 - (longlong)pppppcVar14)))) {
                    /* WARNING: Subroutine does not return */
            _invalid_parameter_noinfo_noreturn();
          }
          free(pppppcVar14);
          pppppcVar14 = (char *****)local_378[0];
          uVar17 = local_360;
        }
      }
      if (0xf < uVar17) {
        pppppcVar16 = pppppcVar14;
        if ((0xfff < uVar17 + 1) &&
           (pppppcVar16 = (char *****)pppppcVar14[-1],
           (char *)0x1f < (char *)((longlong)pppppcVar14 + (-8 - (longlong)pppppcVar16)))) {
                    /* WARNING: Subroutine does not return */
          _invalid_parameter_noinfo_noreturn();
        }
        free(pppppcVar16);
      }
    }
    piVar10 = *(int **)(piVar10 + 6);
  } while( true );
}

