
undefined4 FUN_180ca0680(longlong param_1,undefined4 param_2)

{
  code *pcVar1;
  char cVar2;
  int iVar3;
  undefined4 uVar4;
  undefined4 uVar5;
  longlong lVar6;
  undefined8 uVar7;
  undefined8 uVar8;
  undefined *puVar9;
  undefined4 uVar10;
  float fVar11;
  undefined1 local_res8 [8];
  undefined8 auStack_38 [2];
  undefined8 uStack_28;
  undefined8 uStack_20;
  
  if (*(char *)(param_1 + 0x8ed0) == '\0') {
    return 0;
  }
  if (((DAT_181a08d58 != (longlong *)0x0) &&
      (iVar3 = (**(code **)(*DAT_181a08d58 + 0x1d0))(), iVar3 != 0)) ||
     (*(int *)(DAT_181a1b3d8 + 0x38) != 0)) {
    return 1;
  }
  FUN_180d48200(local_res8);
  uVar10 = 0;
  uVar5 = 0;
  switch(param_2) {
  case 8:
    goto code_r0x000180ca08f2;
  case 9:
  case 0x3c:
  case 0x49:
  case 0x5c:
  case 0x65:
  case 0x68:
    if (DAT_1819ecf58 != 0) {
      FUN_1806d9680(DAT_1819ecf58,param_2);
    }
code_r0x000180ca09ad:
    uVar7 = FUN_180c6f820();
    iVar3 = FUN_180c74120(uVar7);
    if (iVar3 == 0) {
      uVar7 = FUN_180c6f820();
      iVar3 = FUN_180c74980(uVar7);
      if (iVar3 == 0) {
        if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0xc) {
          uVar7 = FUN_180c6f820();
          fVar11 = (float)FUN_180c7c0c0(uVar7);
          if (0.0 < fVar11) goto code_r0x000180ca0877;
        }
        func_0x0001810fae70(param_1 + 0x10,1);
        uVar5 = uVar10;
        break;
      }
    }
  case 0x40:
    goto code_r0x000180ca0877;
  case 0x42:
  case 0x43:
    if ((((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x31) ||
         ((cVar2 = FUN_180d15b80(DAT_181a19c68), cVar2 == '\0' &&
          (lVar6 = FUN_180d15f80(DAT_181a19c68), lVar6 == 0)))) &&
        ((lVar6 = FUN_180feb690(DAT_1819ed0b8,*(undefined4 *)(DAT_181a0e320 + 0x160)), lVar6 == 0 ||
         ((iVar3 = FUN_180f8cef0(*(undefined4 *)(lVar6 + 8)), iVar3 == 0 ||
          (cVar2 = FUN_180d15b80(DAT_181a19c68), cVar2 == '\0')))))) &&
       ((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x19 || (iVar3 = FUN_180c00060(), iVar3 != 3))))
    goto code_r0x000180ca09ad;
    goto code_r0x000180ca0877;
  case 0x45:
    iVar3 = FUN_180f8c9d0();
    if (((iVar3 == 0x32) && (DAT_181aa0e70 != 0)) && (*(char *)(DAT_181aa0e70 + 0x70) == '\x01'))
    goto code_r0x000180ca0877;
    (**(code **)(*DAT_181a1b3a8 + 0x70))(DAT_181a1b3a8,0);
    uVar4 = FUN_180f8c9d0();
    uVar5 = uVar10;
    switch(uVar4) {
    case 0x31:
      if (DAT_18194eb80 != 0) {
        uVar7 = FUN_180c6f820();
        cVar2 = FUN_180c814c0(uVar7);
        if (cVar2 != '\0') {
          FUN_1802e0c10(DAT_18194eb80,0);
        }
      }
      break;
    case 0x42:
      if (DAT_18194edb0 != 0) {
        FUN_180302db0(DAT_18194edb0,0);
      }
      break;
    case 0x44:
      if (DAT_181949b50 != 0) {
        FUN_1800d5880(DAT_181949b50,0);
      }
      break;
    case 0x49:
      FUN_1802c28f0(DAT_1819ecdc0,0);
      break;
    case 0x4c:
      if ((DAT_181a1b3f0 != (longlong *)0x0) &&
         (iVar3 = (**(code **)(DAT_181a1b3f0[0x61] + 0x1d0))(), iVar3 == 1)) {
        (**(code **)(*DAT_181a1b3f0 + 0x68))();
      }
      break;
    case 0x50:
      if ((DAT_181a1b3b0 != 0) && (*(char *)(DAT_181a1b3b0 + 0x1430) == '\x01')) {
        *(undefined1 *)(DAT_181a1b3b0 + 0x1430) = 0;
      }
    }
    break;
  case 0x5d:
    iVar3 = FUN_180f8c9d0();
    if (iVar3 == 0x31) {
      uVar7 = FUN_180c6f820();
      iVar3 = FUN_180c72040(uVar7);
      if (iVar3 == 0) {
        uVar7 = FUN_180c6f820();
        iVar3 = FUN_180c720b0(uVar7);
        if (iVar3 == 0) goto code_r0x000180ca0741;
      }
    }
    else {
code_r0x000180ca0741:
      iVar3 = FUN_180f8c9d0();
      if (iVar3 == 0x44) {
        uVar7 = FUN_180c44210(DAT_181a0e320);
        cVar2 = FUN_180f72b50(uVar7);
        if (cVar2 == '\x01') goto code_r0x000180ca08f2;
      }
      cVar2 = FUN_180f852d0();
      if ((((cVar2 != '\x01') &&
           ((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x31 ||
            ((cVar2 = FUN_180d15b80(DAT_181a19c68), cVar2 == '\0' &&
             (lVar6 = FUN_180d15f80(DAT_181a19c68), lVar6 == 0)))))) &&
          ((lVar6 = FUN_180feb690(DAT_1819ed0b8,*(undefined4 *)(DAT_181a0e320 + 0x160)), lVar6 == 0
           || ((iVar3 = FUN_180f8cef0(*(undefined4 *)(lVar6 + 8)), iVar3 == 0 ||
               (cVar2 = FUN_180d15b80(DAT_181a19c68), cVar2 == '\0')))))) &&
         ((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x19 || (iVar3 = FUN_180c00060(), iVar3 != 3)))) {
        uVar7 = FUN_180c6f820();
        iVar3 = FUN_180c74120(uVar7);
        if (iVar3 == 0) {
          uVar7 = FUN_180c6f820();
          iVar3 = FUN_180c74980(uVar7);
          if (iVar3 == 0) {
            if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0xc) {
              uVar7 = FUN_180c6f820();
              fVar11 = (float)FUN_180c7c0c0(uVar7);
              if (0.0 < fVar11) goto code_r0x000180ca0877;
            }
            if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x16) {
              if (*(char *)(DAT_1819ecf18 + 100) == '\0') {
code_r0x000180ca08b7:
                if (((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x37) ||
                    (lVar6 = FUN_180c6f820(), *(int *)(lVar6 + 0x6aa0) == 3)) ||
                   (lVar6 = FUN_180c6f820(), *(int *)(lVar6 + 0x6aa0) == 4)) {
                  func_0x000180d1ed20(DAT_181a19c68);
                  uVar5 = 1;
                  goto code_r0x000180ca0d3f;
                }
              }
            }
            else if ((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x2f) ||
                    (((DAT_1819ecef0 == 0 || (*(int *)(DAT_1819ecef0 + 0x275c) == 0)) &&
                     (iVar3 = func_0x000180d19660(DAT_181a19c68), 1 < iVar3 - 0x614U))))
            goto code_r0x000180ca08b7;
            goto code_r0x000180ca0877;
          }
        }
      }
    }
code_r0x000180ca08f2:
    uVar5 = 1;
    break;
  case 0x72:
    lVar6 = FUN_180feb690(DAT_1819ed0b8,*(undefined4 *)(DAT_181a0e320 + 0x160));
    if (((lVar6 == 0) || (*(int *)(lVar6 + 0x1550) != 0xc)) ||
       ((*(int *)(lVar6 + 0x1524) == 0xc || (uVar5 = uVar10, *(int *)(lVar6 + 0x1524) == 0x13)))) {
      uVar5 = uVar10;
      switch(*(undefined4 *)(DAT_181a08d38 + 0xe9e0)) {
      case 0x21:
      case 0x32:
      case 0x34:
      case 0x41:
      case 0x42:
code_r0x000180ca0ce7:
        lVar6 = *DAT_181a1b3e0;
        puVar9 = &UNK_18160f448;
code_r0x000180ca0d37:
        (**(code **)(lVar6 + 0x98))
                  (DAT_181a1b3e0,puVar9,0,1,0,0,0xffffffff,0,0,0,&DAT_181689868,0,0xffffffff);
        uVar5 = uVar10;
        break;
      default:
        uVar7 = FUN_180c6f820();
        uVar8 = FUN_180c6f820();
        uVar5 = FUN_180c71410(uVar8);
        uVar5 = FUN_180c71f40(uVar7,uVar5);
        if ((lVar6 != 0) && (*(int *)(lVar6 + 0x1524) == 0x13)) {
          uVar7 = FUN_1810feba0();
          uVar8 = FUN_180c6f820();
          uVar5 = FUN_180c71410(uVar8);
          uVar5 = func_0x000181102040(uVar7,uVar5);
        }
        uVar7 = FUN_180c6f820();
        uVar4 = FUN_180c736d0(uVar7);
        cVar2 = FUN_180d9fc30(DAT_181a1d4f8,uVar5,uVar4);
        if (cVar2 != '\0') {
          uVar7 = FUN_180c6f820();
          FUN_180c78740(uVar7);
          uVar7 = FUN_180c6f820();
          cVar2 = FUN_180c74bd0(uVar7);
          if (cVar2 != '\0') goto code_r0x000180ca0ce7;
          uVar7 = FUN_180c6f820();
          iVar3 = FUN_180c78790(uVar7);
          lVar6 = *DAT_181a1b3e0;
          if (iVar3 == 0) {
            puVar9 = &UNK_18160f480;
          }
          else {
            puVar9 = &UNK_18160f470;
          }
          goto code_r0x000180ca0d37;
        }
        uVar7 = FUN_180c6f820();
        FUN_180c78730(uVar7,0);
        uVar5 = uVar10;
        break;
      case 0x31:
        pcVar1 = *(code **)(*DAT_181a1b3e0 + 0x98);
        auStack_38[0] = 0;
        uStack_28 = 0;
        uStack_20 = 0xf;
        FUN_18004dca0(auStack_38,"SA_TEXT_SURVIVAL_MSG_22",0x17);
        uVar7 = FUN_180d90970(auStack_38);
        (*pcVar1)(DAT_181a1b3e0,uVar7,0,1,0,0,0xffffffff,0,0,0,&DAT_181689868,0,0xffffffff);
        break;
      case 0x40:
      case 0x49:
      case 0x4c:
        break;
      }
    }
    break;
  case 0x75:
    iVar3 = FUN_180ca12b0(param_1);
    uVar5 = uVar10;
    if (iVar3 != 0) {
      uVar5 = FUN_180ca1420(param_1,1,0x40000000);
      goto code_r0x000180ca0d3f;
    }
    break;
  case 0x76:
    iVar3 = FUN_180ca12b0(param_1);
    if (iVar3 != 0) {
      uVar5 = FUN_180ca1420(param_1,2,0x40000000);
      goto code_r0x000180ca0d3f;
    }
  }
code_r0x000180ca0d3f:
  FUN_180d48230(local_res8);
  return uVar5;
code_r0x000180ca0877:
  uVar5 = 1;
  goto code_r0x000180ca0d3f;
}

