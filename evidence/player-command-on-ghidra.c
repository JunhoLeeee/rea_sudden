
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined8 FUN_180d14020(longlong *param_1,undefined4 param_2)

{
  code *pcVar1;
  bool bVar2;
  char cVar3;
  byte bVar4;
  int iVar5;
  undefined4 uVar6;
  int iVar7;
  undefined8 uVar8;
  undefined *puVar9;
  longlong lVar10;
  undefined **ppuVar11;
  undefined8 uVar12;
  int *piVar13;
  longlong *plVar14;
  uint uVar15;
  short sVar16;
  ulonglong uVar17;
  uint uVar18;
  uint uVar19;
  undefined1 auStack_3a8 [32];
  undefined8 uStack_388;
  uint uStack_380;
  undefined8 uStack_378;
  undefined **local_368;
  undefined8 local_360;
  undefined4 local_358;
  undefined1 local_354;
  short asStack_348 [2];
  short asStack_344 [2];
  undefined **local_340;
  undefined8 local_338;
  undefined4 local_330;
  undefined1 local_32c;
  longlong alStack_328 [32];
  longlong alStack_228 [62];
  ulonglong local_38;
  ulonglong uVar20;
  
  local_38 = DAT_181905cc8 ^ (ulonglong)auStack_3a8;
  iVar5 = FUN_180d1d060();
  if (iVar5 == 0) {
LAB_180d150c3:
    return 0;
  }
  iVar5 = *(int *)(DAT_181a08d38 + 0xe9e0);
  uVar17 = 0;
  sVar16 = 0;
  if (((iVar5 == 0x30) || (iVar5 == 0x31)) || (iVar5 == 0x34)) {
    local_360 = 0;
    local_368 = &PTR_FUN_1816154e8;
    local_354 = 0;
    local_338 = 0;
    local_340 = &PTR_FUN_1816154e8;
    local_32c = 0;
    local_358 = param_2;
    local_330 = param_2;
    FUN_180079060(&DAT_181a1a178,&local_340);
  }
  switch(param_2) {
  case 3:
    iVar5 = *(int *)(DAT_181a08d38 + 0xe9e0);
    if ((iVar5 != 0x4c) && (iVar5 != 0x51)) {
      if (iVar5 == 0x31) {
        cVar3 = FUN_180d15b80(param_1);
        if (cVar3 != '\0') {
          return 1;
        }
        uVar8 = FUN_180ef3d70(param_1[0x168]);
        cVar3 = FUN_180d15b40(param_1,uVar8);
        if (cVar3 != '\0') {
          return 1;
        }
      }
      if (((((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x11) || (*(int *)(DAT_181a0e320 + 0xe2c) != 1))
           && (3 < *(int *)((longlong)param_1 + 0x40c) - 2U)) &&
          ((plVar14 = (longlong *)FUN_180d45400(*(undefined8 *)(DAT_181a19c68 + 0x430)),
           plVar14 != (longlong *)0x0 &&
           ((iVar5 = (**(code **)(*plVar14 + 0x198))(plVar14), iVar5 != 0xb ||
            (lVar10 = (**(code **)(*plVar14 + 0x120))(plVar14), *(int *)(lVar10 + 0xc) != 5)))))) &&
         ((lVar10 = (**(code **)(*plVar14 + 0x120))(plVar14), *(int *)(lVar10 + 0xc) != 0x24 ||
          ((iVar5 = (**(code **)(*plVar14 + 0x2d0))(plVar14), iVar5 != 0 &&
           (iVar5 = (**(code **)(*plVar14 + 0x198))(plVar14), iVar5 != 0x23)))))) {
        uVar8 = (**(code **)(*plVar14 + 0x120))(plVar14);
        cVar3 = FUN_180c58940(uVar8,4);
        if ((cVar3 == '\0') ||
           ((iVar5 = (**(code **)(*plVar14 + 0x198))(plVar14), iVar5 != 0x23 &&
            (iVar5 = (**(code **)(*plVar14 + 0x198))(plVar14), iVar5 != 0x28)))) {
          uVar8 = (**(code **)(*plVar14 + 0x120))(plVar14);
          cVar3 = FUN_180c5a0e0(uVar8);
          if ((cVar3 == '\0') ||
             ((iVar5 = (**(code **)(*plVar14 + 0x198))(plVar14), iVar5 != 0x2a &&
              (iVar5 = (**(code **)(*plVar14 + 0x310))(plVar14), iVar5 != 1)))) {
            uVar8 = (**(code **)(*plVar14 + 0x120))(plVar14);
            cVar3 = FUN_180c5a120(uVar8);
            if ((cVar3 == '\0') ||
               ((iVar5 = (**(code **)(*plVar14 + 0x198))(plVar14), iVar5 != 0x2c &&
                (iVar5 = (**(code **)(*plVar14 + 0x340))(plVar14), iVar5 != 1)))) {
              uVar8 = (**(code **)(*plVar14 + 0x120))(plVar14);
              cVar3 = FUN_180c5a160(uVar8);
              if ((cVar3 == '\0') ||
                 (((iVar5 = (**(code **)(*plVar14 + 0x198))(plVar14), iVar5 != 0x2e &&
                   (iVar5 = (**(code **)(*plVar14 + 0x370))(plVar14), iVar5 != 1)) &&
                  ((iVar5 = (**(code **)(*plVar14 + 0x378))(plVar14), iVar5 == 0 ||
                   (iVar5 = (**(code **)(*plVar14 + 0x198))(plVar14), iVar5 != 3)))))) {
                uVar8 = (**(code **)(*plVar14 + 0x120))(plVar14);
                cVar3 = FUN_180c5ab10(uVar8);
                if ((cVar3 == '\0') ||
                   (iVar5 = (**(code **)(*plVar14 + 0x198))(plVar14), iVar5 != 0x32)) {
                  uStack_380 = uStack_380 & 0xffffff00;
                  uStack_388 = CONCAT71(uStack_388._1_7_,1);
                  (**(code **)(*plVar14 + 0x58))(plVar14,1,0xffffffff);
                  return 1;
                }
              }
            }
          }
        }
      }
    }
    break;
  case 4:
    uVar8 = FUN_180c6f820();
    iVar5 = FUN_180c750e0(uVar8);
    if ((iVar5 == 0) || (*(int *)((longlong)param_1 + 0x40c) == 1)) {
      bVar2 = true;
      if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x31) {
        cVar3 = FUN_180d15b80(param_1);
        bVar2 = true;
        if (cVar3 != '\0') {
          bVar2 = false;
        }
      }
      lVar10 = FUN_180feb690(DAT_1819ed0b8,*(undefined4 *)(DAT_181a0e320 + 0x160));
      if (((((lVar10 == 0) || (iVar5 = FUN_180f8cef0(*(undefined4 *)(lVar10 + 8)), iVar5 == 0)) ||
           (cVar3 = FUN_180d15b80(param_1), cVar3 == '\0')) &&
          ((bVar2 && (*(float *)(param_1 + 0x97) = *(float *)(param_1 + 0x97) + 3.1415927,
                     (char)param_1[0x186] != '\0')))) && (*(int *)((longlong)param_1 + 0x40c) == 1))
      {
        uVar8 = FUN_180dad090();
        FUN_180e21970(uVar8,2);
        return 1;
      }
    }
    break;
  case 5:
  case 6:
    *(undefined4 *)(param_1[0x168] + 0xe0) = 0;
    return 1;
  default:
    goto LAB_180d150c3;
  case 0xc:
    if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x13) {
      uVar8 = FUN_1810feba0();
      iVar5 = FUN_1811009d0(uVar8);
      if (iVar5 != 0) {
        uVar8 = FUN_1810feba0();
        iVar5 = FUN_181100aa0(uVar8);
        if (iVar5 != 0) {
          return 1;
        }
      }
    }
    else if (((*(int *)(param_1[0x168] + 0xdc) == 1) &&
             (plVar14 = (longlong *)FUN_180d45400(param_1[0x86]), plVar14 != (longlong *)0x0)) &&
            ((cVar3 = (**(code **)(*plVar14 + 0x3d8))(plVar14), cVar3 == '\x01' &&
             (cVar3 = FUN_180cffdd0(plVar14), cVar3 == '\x01')))) {
      iVar5 = (**(code **)(*plVar14 + 0x198))(plVar14);
      if (iVar5 != 0x30) {
        return 1;
      }
      FUN_180cffe10(plVar14,0x31);
    }
    FUN_180ef48b0(param_1[0x168],*(int *)(param_1[0x168] + 0xdc) == 0);
    return 1;
  case 0x13:
    if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x30) {
      return 1;
    }
    if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x44) &&
       (iVar5 = FUN_18075c160(DAT_1819ece68), iVar5 == 0)) {
      uVar8 = FUN_180c44210(DAT_181a0e320);
      cVar3 = FUN_180f741d0(uVar8);
      if (cVar3 != '\0') {
        return 1;
      }
    }
    FUN_180d41ca0(param_1);
    if (((DAT_181a19238 != -0x5e50) && (iVar5 = FUN_180c8c020(), iVar5 == 0)) &&
       (DAT_18194e9a0 != 0)) {
      FUN_1802d3080();
    }
    cVar3 = (**(code **)(*(longlong *)param_1[0x8c] + 0x88))();
    if (cVar3 == '\0') {
code_r0x000180d149bb:
      uVar8 = FUN_180c6f820();
      iVar5 = FUN_180c716a0(uVar8);
      if (((iVar5 != 0) && (3 < *(int *)((longlong)param_1 + 0x40c) - 2U)) &&
         (*(int *)(DAT_181a08d38 + 0xe9e0) == 0xf)) {
        FUN_1811be4a0(param_1[0x8c]);
        return 1;
      }
      if (*(int *)(DAT_181a08d38 + 0xe9e0) != 0x27) {
        return 1;
      }
      pcVar1 = *(code **)(*DAT_181952a40 + 0x178);
      uVar8 = (*(code *)DAT_181952a40[0x7b])();
      (*pcVar1)(DAT_181952a40,uVar8,&local_340,0);
      local_368 = local_340;
      local_360 = CONCAT44(local_360._4_4_,(undefined4)local_338);
      uStack_388 = 0;
      uVar15 = (**(code **)(*DAT_181a08d10 + 0x1d0))(DAT_181a08d10,&local_368,alStack_228,0x3d);
      if (uVar15 != 0) {
        plVar14 = alStack_228;
        uVar20 = uVar17;
        do {
          uVar18 = (uint)uVar17;
          if (*plVar14 != 0) {
            local_368 = (undefined **)((ulonglong)local_368 & 0xffffffff00000000);
            (**(code **)(*DAT_181a08d08 + 0x88))(DAT_181a08d08,*plVar14,2,&local_368);
            if (((((ulonglong)local_368 & 1) != 0) &&
                (cVar3 = (**(code **)(*DAT_181a08d10 + 0x78))(DAT_181a08d10,*plVar14,asStack_348),
                cVar3 != '\0')) &&
               (((1L << ((byte)asStack_348[0] & 0x3f) & 0xffffffffffffcffeU) != 0 ||
                (asStack_348[0] == 0x20)))) {
              if (0x1e < uVar18) break;
              alStack_328[uVar17] = *plVar14;
              uVar17 = (ulonglong)(uVar18 + 1);
            }
          }
          uVar18 = (uint)uVar17;
          uVar19 = (int)uVar20 + 1;
          uVar20 = (ulonglong)uVar19;
          plVar14 = plVar14 + 1;
        } while (uVar19 < uVar15);
        if ((uVar18 != 0) &&
           (cVar3 = (**(code **)(*DAT_181a08d10 + 0x78))(DAT_181a08d10,alStack_328[0],asStack_344),
           cVar3 != '\0')) {
          sVar16 = asStack_344[0];
        }
      }
      uVar8 = FUN_180c6f820();
      iVar5 = FUN_180c71410(uVar8);
      if (((iVar5 == 0) && (*(int *)(DAT_181aa0ff0 + 0x2724) == 0)) && (sVar16 != 0x26)) {
        lVar10 = FUN_180d45400(param_1[0x86]);
        cVar3 = (**(code **)(*(longlong *)param_1[0x8c] + 0x80))();
        if (cVar3 == '\0') {
          return 1;
        }
        if (lVar10 == 0) {
          return 1;
        }
        cVar3 = FUN_180ce1bb0(lVar10);
        if (cVar3 == '\0') {
          return 1;
        }
        uVar8 = (**(code **)(*(longlong *)param_1[0x8c] + 0x10))();
        cVar3 = FUN_180c344c0(DAT_181a0e320,uVar8);
        if (cVar3 != '\0') {
          return 1;
        }
        if (*(char *)(DAT_181a0e320 + 0x171) != '\0') {
          return 1;
        }
        (**(code **)(*param_1 + 0x60))(param_1);
        return 1;
      }
      uVar8 = FUN_180c6f820();
      iVar5 = FUN_180c71410(uVar8);
      if (iVar5 != 1) {
        return 1;
      }
      uVar8 = (**(code **)(*(longlong *)param_1[0x8c] + 0x10))();
      lVar10 = FUN_180ec3760(DAT_181a08d38 + 0xef88,uVar8);
      if (lVar10 == 0) {
        return 1;
      }
      lVar10 = FUN_180c8a270(DAT_181a19238 + 0x5e50,*(undefined1 *)(lVar10 + 0x88));
code_r0x000180d14c57:
      if (lVar10 == 0) {
        return 1;
      }
      cVar3 = (**(code **)(*(longlong *)param_1[0x8c] + 0x80))();
      if (cVar3 == '\0') {
        return 1;
      }
code_r0x000180d14c78:
      (**(code **)(*param_1 + 0x60))(param_1);
      return 1;
    }
    uVar8 = FUN_180c6f820();
    iVar5 = FUN_180c7ad00(uVar8);
    lVar10 = DAT_181a0e320;
    if (iVar5 == 0) {
code_r0x000180d14268:
      if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x2f) &&
         (plVar14 = (longlong *)param_1[0x8c], (int)plVar14[0xbf] != 0)) {
        if (DAT_1819ecef0 == 0) {
          return 1;
        }
        if (*(int *)((longlong)plVar14 + 0x5fc) == 0) {
          return 1;
        }
        if (*(int *)(DAT_1819ecef0 + 0x275c) != 0) {
          return 1;
        }
        uVar8 = (**(code **)(*plVar14 + 0x10))();
        FUN_180d3b560(param_1,uVar8);
        return 1;
      }
      uVar8 = FUN_180c6f820();
      uVar6 = FUN_180c71ff0(uVar8);
      cVar3 = FUN_180f8cec0(uVar6);
      if (cVar3 == '\x01') {
        lVar10 = (**(code **)(*(longlong *)param_1[0x8c] + 0x10))();
      }
      else {
        iVar5 = FUN_1811be260();
        uVar15 = *(int *)(DAT_181a08d38 + 0xe9e0) - 0x15;
        if (((((uVar15 < 0x36) && ((0x22000080020209U >> ((ulonglong)uVar15 & 0x3f) & 1) != 0)) ||
             (cVar3 = FUN_180f0ab10(), cVar3 == '\x01')) || (*(int *)(DAT_181a08d38 + 0xe9e0) == 5))
           && (((iVar5 == -1 || (iVar5 = FUN_1811aa180(param_1[0x88]), iVar5 != 0)) &&
               (*(int *)(DAT_181aa0ff0 + 0x2724) == 0)))) {
          (**(code **)(*param_1 + 0x60))(param_1);
        }
        if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 9) && (*(int *)(DAT_181aa0ff0 + 0x2724) == 0)) {
          (**(code **)(*param_1 + 0x60))(param_1);
        }
        if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 6) && (*(int *)(DAT_181aa0ff0 + 0x2724) == 0)) {
          (**(code **)(*param_1 + 0x60))(param_1);
        }
        if (((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x33) &&
            (lVar10 = (**(code **)(*(longlong *)param_1[0x8c] + 0x10))(),
            *(int *)(DAT_181aa0ff0 + 0x2724) == 0)) &&
           ((lVar10 != *(longlong *)(DAT_181a0e320 + 0x240) ||
            ((*(char *)(DAT_181a0e320 + 0x23d) == -1 && (*(char *)(DAT_181a0e320 + 0x858) != '\0')))
            ))) {
          (**(code **)(*param_1 + 0x60))(param_1);
        }
        if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x14) {
          uVar8 = (**(code **)(*(longlong *)param_1[0x8c] + 0x10))();
          bVar4 = FUN_180c2d330(DAT_181a0e320,uVar8);
          uVar8 = FUN_180c6f820();
          iVar5 = FUN_180c71410(uVar8);
          if (iVar5 == 1) {
            if (bVar4 < 3) {
              bVar4 = *(byte *)((ulonglong)bVar4 + 0x2f0 + DAT_181a0e320);
            }
            else {
              bVar4 = 0xff;
            }
            uVar8 = FUN_180c6f820();
            uVar15 = FUN_180c71410(uVar8);
            if ((bVar4 != uVar15) && (*(int *)(DAT_181aa0ff0 + 0x2724) == 0)) {
              (**(code **)(*param_1 + 0x60))(param_1);
            }
          }
        }
        if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x1b) || (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x2d)
           ) {
          lVar10 = (**(code **)(*(longlong *)param_1[0x8c] + 0x10))();
          uVar8 = FUN_180c6f820();
          iVar5 = FUN_180c71410(uVar8);
          if (iVar5 == 1) {
            if (*(int *)(DAT_181a0e320 + 0x3e0) == 0) {
              if (lVar10 == *(longlong *)(DAT_181a0e320 + 0x3d8)) {
                return 1;
              }
              if (*(int *)((longlong)param_1 + 0x2c) == 0) {
                if (lVar10 == 0) {
                  return 1;
                }
                cVar3 = (**(code **)(*(longlong *)param_1[0x8c] + 0x90))();
                if (cVar3 == '\0') {
                  return 1;
                }
                local_368 = (undefined **)0x0;
                iVar5 = (**(code **)(*DAT_181a08d08 + 0x48))(DAT_181a08d08,&local_368);
                if (iVar5 == 0) {
                  (**(code **)(*local_368 + 8))();
                }
                else {
                  local_368 = (undefined **)0x0;
                }
                (**(code **)(*local_368 + 0x48))(local_368,0xda,8);
                (**(code **)(*local_368 + 0x48))(local_368,4,8);
                (**(code **)(*local_368 + 0x48))(local_368,0,8);
                (**(code **)(*local_368 + 0x48))(local_368,1,1);
                pcVar1 = *(code **)(*DAT_181952a40 + 0x3a8);
                ppuVar11 = (undefined **)(**(code **)(*local_368 + 0x38))();
                local_340 = ppuVar11;
                if (ppuVar11 != (undefined **)0x0) {
                  (**(code **)(*ppuVar11 + 8))(ppuVar11);
                }
                (*pcVar1)(DAT_181952a40,ppuVar11,1);
                if (ppuVar11 != (undefined **)0x0) {
                  (**(code **)(*ppuVar11 + 0x10))(ppuVar11);
                }
                *(undefined4 *)((longlong)param_1 + 0x2c) = 1;
              }
              else {
                local_368 = (undefined **)0x0;
                iVar5 = (**(code **)(*DAT_181a08d08 + 0x48))(DAT_181a08d08,&local_368);
                if (iVar5 == 0) {
                  (**(code **)(*local_368 + 8))();
                }
                else {
                  local_368 = (undefined **)0x0;
                }
                (**(code **)(*local_368 + 0x48))(local_368,0xda,8);
                (**(code **)(*local_368 + 0x48))(local_368,4,8);
                (**(code **)(*local_368 + 0x48))(local_368,0,8);
                (**(code **)(*local_368 + 0x48))(local_368,0,1);
                pcVar1 = *(code **)(*DAT_181952a40 + 0x3a8);
                ppuVar11 = (undefined **)(**(code **)(*local_368 + 0x38))();
                local_340 = ppuVar11;
                if (ppuVar11 != (undefined **)0x0) {
                  (**(code **)(*ppuVar11 + 8))(ppuVar11);
                }
                (*pcVar1)(DAT_181952a40,ppuVar11,1);
                if (ppuVar11 != (undefined **)0x0) {
                  (**(code **)(*ppuVar11 + 0x10))(ppuVar11);
                }
                *(undefined4 *)((longlong)param_1 + 0x2c) = 0;
              }
              if (local_368 != (undefined **)0x0) {
                (**(code **)(*local_368 + 0x10))();
              }
              return 1;
            }
            goto code_r0x000180d14c78;
          }
          if ((lVar10 != 0) &&
             (cVar3 = (**(code **)(*(longlong *)param_1[0x8c] + 0x98))(), cVar3 != '\0')) {
            uVar8 = FUN_180c6f820();
            iVar5 = FUN_180c71410(uVar8);
            if (iVar5 == 0) {
              local_368 = (undefined **)0x0;
              iVar5 = (**(code **)(*DAT_181a08d08 + 0x48))(DAT_181a08d08,&local_368);
              if (iVar5 == 0) {
                (**(code **)(*local_368 + 8))();
              }
              else {
                local_368 = (undefined **)0x0;
              }
              (**(code **)(*local_368 + 0x48))(local_368,0xda,8);
              (**(code **)(*local_368 + 0x48))(local_368,4,8);
              (**(code **)(*local_368 + 0x48))(local_368,8,8);
              pcVar1 = *(code **)(*DAT_181952a40 + 0x3a8);
              ppuVar11 = (undefined **)(**(code **)(*local_368 + 0x38))();
              local_340 = ppuVar11;
              if (ppuVar11 != (undefined **)0x0) {
                (**(code **)(*ppuVar11 + 8))(ppuVar11);
              }
              (*pcVar1)(DAT_181952a40,ppuVar11,1);
              if (ppuVar11 != (undefined **)0x0) {
                (**(code **)(*ppuVar11 + 0x10))(ppuVar11);
              }
              if (local_368 != (undefined **)0x0) {
                (**(code **)(*local_368 + 0x10))();
              }
              return 1;
            }
          }
        }
        if (*(int *)(DAT_181a08d38 + 0xe9e0) != 0x22) {
          if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x28) && (*(int *)(DAT_181a0e320 + 0x334) != 0))
          {
            uVar8 = (**(code **)(*(longlong *)param_1[0x8c] + 0x10))();
            iVar5 = FUN_180711050(DAT_1819ecf88,uVar8);
            if (iVar5 != -1) {
              uVar8 = FUN_180c6f820();
              iVar7 = FUN_180c71410(uVar8);
              if ((iVar5 != iVar7) && (*(int *)(DAT_181aa0ff0 + 0x2724) == 0)) {
                (**(code **)(*param_1 + 0x60))(param_1);
              }
            }
          }
          if (((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x3a) ||
              (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x50)) && (*(int *)(DAT_181a0e320 + 0x334) != 0))
          {
            uVar8 = (**(code **)(*(longlong *)param_1[0x8c] + 0x10))();
            uVar12 = FUN_181080a00();
            piVar13 = (int *)FUN_181082ba0(uVar12,uVar8);
            if (((piVar13 != (int *)0x0) && (*piVar13 == 0)) &&
               (*(int *)(DAT_181aa0ff0 + 0x2724) == 0)) {
              (**(code **)(*param_1 + 0x60))(param_1);
            }
          }
          if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x45) {
            FUN_180f8b2a0();
          }
          if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 7) || (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x20))
          {
            uVar8 = FUN_180c6f820();
            uVar15 = FUN_180c71410(uVar8);
            if ((*(byte *)(DAT_181a0e320 + 0x23d) != uVar15) &&
               (*(int *)(DAT_181a0e320 + 0x334) != 0)) {
              if (*(int *)(DAT_181aa0ff0 + 0x2724) == 0) {
                (**(code **)(*param_1 + 0x60))(param_1);
              }
              FUN_180c2b300(DAT_181a0e320,1);
            }
          }
          iVar5 = FUN_180f8c9d0();
          if (((iVar5 == 0x42) && (*(int *)(DAT_181a0e320 + 0x334) != 0)) &&
             ((**(code **)(*(longlong *)param_1[0x8c] + 0x10))(),
             *(int *)(DAT_181aa0ff0 + 0x2724) == 0)) {
            (**(code **)(*param_1 + 0x60))(param_1);
          }
          goto code_r0x000180d149bb;
        }
        lVar10 = (**(code **)(*(longlong *)param_1[0x8c] + 0x10))();
      }
      goto code_r0x000180d14c57;
    }
    switch(*(undefined4 *)(DAT_181a08d38 + 0xe9e0)) {
    case 6:
    case 9:
      uVar8 = 0x655;
      break;
    case 7:
    case 0x20:
    case 0x28:
    case 0x42:
      uVar8 = 0x656;
      break;
    default:
      goto code_r0x000180d14268;
    case 0x11:
      iVar5 = (**(code **)(*DAT_181a1a340 + 0x48))(DAT_181a1a340,0xb);
      if ((*(int *)(lVar10 + 0xe28) != 0x14) && (iVar5 != 0)) {
        return 1;
      }
      if (*(int *)(DAT_181aa0ff0 + 0x2724) != 0) {
        return 1;
      }
      (**(code **)(*param_1 + 0x60))(param_1);
      return 1;
    case 0x33:
      puVar9 = &UNK_181616400;
      goto code_r0x000180d141d4;
    }
    puVar9 = (undefined *)FUN_180d90880(uVar8);
code_r0x000180d141d4:
    uStack_378 = 0;
    uStack_380 = 0xffffffff;
    uStack_388 = CONCAT44(uStack_388._4_4_,0x40400000);
    FUN_180d7a090(DAT_181a1b3e8,puVar9,0x10,7);
    break;
  case 0x5a:
    func_0x0001811bb530(param_1[0x89]);
    return 1;
  }
  return 1;
}

