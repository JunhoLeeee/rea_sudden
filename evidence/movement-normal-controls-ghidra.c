
void FUN_180efa3f0(longlong param_1)

{
  code *pcVar1;
  undefined4 *puVar2;
  char cVar3;
  int iVar4;
  undefined4 uVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  longlong lVar9;
  undefined8 uVar10;
  longlong *plVar11;
  longlong lVar12;
  uint uVar13;
  bool bVar14;
  undefined8 local_res10;
  undefined4 local_38;
  undefined4 local_34;
  undefined4 local_30;
  
  cVar3 = FUN_180bfe230(DAT_181a08d38,1);
  if (cVar3 != '\0') {
    return;
  }
  cVar3 = FUN_180d15b80(DAT_181a19c68);
  if (cVar3 != '\0') {
    return;
  }
  cVar3 = FUN_180f852d0();
  if ((cVar3 != '\0') && (lVar9 = FUN_180f852a0(), lVar9 != 0)) {
    iVar4 = FUN_180f88de0(lVar9);
    if (iVar4 == 7) {
      return;
    }
    iVar4 = FUN_180f88de0(lVar9);
    if (iVar4 == 2) {
      return;
    }
  }
  cVar3 = FUN_180bfe230(DAT_181a08d38,2);
  if (cVar3 == '\0') {
    iVar4 = FUN_180cb2180(DAT_181a19238);
    if (iVar4 == 0) {
      *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | *(uint *)(param_1 + 0xe4) & 0x20;
      return;
    }
    uVar10 = FUN_180c6f820();
    iVar4 = FUN_180c74120(uVar10);
    if (iVar4 != 0) {
      uVar10 = FUN_180c6f820();
      iVar4 = FUN_180c740f0(uVar10);
      if (iVar4 == 0) {
        lVar9 = FUN_180c6f820();
        if (*(char *)(lVar9 + 0x6d80) != '\0') {
          return;
        }
        lVar9 = FUN_180c6f820();
        if (*(int *)(lVar9 + 0x68b4) != 0) {
          return;
        }
        lVar9 = FUN_180c6f820();
        if (*(int *)(lVar9 + 0x6888) != 0) {
          return;
        }
        uVar10 = FUN_180c6f820();
        iVar4 = FUN_180c750e0(uVar10);
        if (iVar4 != 0) {
          return;
        }
      }
    }
    if (*(int *)((longlong)DAT_181a19c68 + 0x50c) != 0) {
      local_res10 = 0;
      (*(code *)DAT_181952a40[8])(&local_res10);
      if (0.0 <= (float)local_res10) {
        if (0.0 < (float)local_res10) {
          *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x100;
        }
      }
      else {
        *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x80;
      }
      if (0.0 <= local_res10._4_4_) {
        if (0.0 < local_res10._4_4_) {
          *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 2;
        }
      }
      else {
        *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 1;
      }
    }
    cVar3 = (*(code *)DAT_181952a40[0x78])(10);
    if (cVar3 != '\0') {
      *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 8;
    }
    cVar3 = (*(code *)DAT_181952a40[0x78])(0xb);
    if (cVar3 != '\0') {
      *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 4;
    }
    uVar10 = FUN_180c6f820();
    iVar4 = FUN_180c740f0(uVar10);
    if (iVar4 == 0) {
      uVar10 = FUN_180c6f820();
      iVar4 = FUN_180c74980(uVar10);
      if (iVar4 != 0) goto LAB_180efa5f7;
    }
    else {
LAB_180efa5f7:
      (*(code *)DAT_181952a40[0x78])(7);
      (*(code *)DAT_181952a40[0x78])(5);
    }
    cVar3 = (*(code *)DAT_181952a40[0x78])(7);
    if ((((cVar3 != '\0') &&
         (plVar11 = (longlong *)FUN_180d45400(DAT_181a19c68[0x86]), plVar11 != (longlong *)0x0)) &&
        (cVar3 = (**(code **)(*plVar11 + 0x3d8))(plVar11), cVar3 == '\x01')) &&
       (cVar3 = FUN_180cffdd0(plVar11), cVar3 == '\x01')) {
      iVar4 = (**(code **)(*plVar11 + 0x198))(plVar11);
      if (iVar4 == 0x2f) {
        (*(code *)DAT_181952a40[0x79])(7);
      }
      else if (iVar4 == 0x30) {
        FUN_180cffe10(plVar11,0x31);
      }
    }
    cVar3 = (*(code *)DAT_181952a40[0x78])(5);
    if (((cVar3 != '\0') && (*(int *)(param_1 + 0xc4) != 0)) &&
       ((*(int *)(param_1 + 0xaf8) == 0 && (iVar4 = FUN_180c3eb00(DAT_181a0e320), iVar4 == 0)))) {
      bVar14 = true;
      if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x16) &&
         (iVar4 = FUN_18072e310(DAT_1819ecf18), iVar4 == 2)) {
        bVar14 = false;
      }
      if (((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x2f) || (DAT_1819ecef0 == 0)) ||
         (*(int *)(DAT_1819ecef0 + 0x275c) == 0)) {
        if (bVar14) {
          plVar11 = (longlong *)FUN_180d45400(DAT_181a19c68[0x86]);
          if (((plVar11 != (longlong *)0x0) &&
              (cVar3 = (**(code **)(*plVar11 + 0x3d8))(plVar11), cVar3 == '\x01')) &&
             (cVar3 = FUN_180cffdd0(plVar11), cVar3 == '\x01')) {
            iVar4 = (**(code **)(*plVar11 + 0x198))(plVar11);
            if (iVar4 == 0x2f) goto LAB_180efa7ad;
            if (iVar4 == 0x30) {
              FUN_180cffe10(plVar11,0x31);
            }
          }
        }
        else if (!bVar14) goto LAB_180efa7ad;
        *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x20;
        FUN_180cac760(DAT_181a19238,0xffffffff);
      }
LAB_180efa7ad:
      if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x40) {
        uVar10 = FUN_180c44210(DAT_181a0e320);
        lVar9 = __RTDynamicCast(uVar10,0,&PTR_PTR_181906040,&PTR_PTR_18190ac90,0);
        if (((lVar9 != 0) && (cVar3 = FUN_181098a10(lVar9), cVar3 == '\0')) &&
           (cVar3 = (*(code *)DAT_181952a40[0x78])(8), cVar3 != '\0')) {
          *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) & 0xffffffdf;
        }
      }
    }
    if (((char)DAT_181a19c68[0xa8] == '\x01') || ((char)DAT_181a19c68[0xa8] == '\x04')) {
      *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) & 0xffffffdf;
    }
    if ((((*(uint *)(param_1 + 0x8c) & 0x20) == 0) && ((*(byte *)(param_1 + 0xe4) & 0x20) != 0)) &&
       (cVar3 = FUN_180ef9d30(param_1), cVar3 == '\0')) {
      *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x20;
    }
    if (((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x31) && (DAT_181a0e320 != 0)) &&
       ((*(longlong *)(DAT_181a0e320 + 0x890) != 0 && (cVar3 = FUN_181065910(), cVar3 != '\0')))) {
      bVar14 = true;
    }
    else {
      bVar14 = false;
    }
    if (*(int *)DAT_181a19c68[0x8b] == 0) {
      if (((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x13) || (*(int *)(param_1 + 0xdc) != 0)) &&
         (cVar3 = (*(code *)DAT_181952a40[0x78])(7), (bool)cVar3 != (*(int *)(param_1 + 0xdc) != 0))
         ) {
        *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x200;
      }
      if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x36) {
        uVar10 = FUN_18109cb30();
        uVar5 = FUN_18109d9a0(uVar10);
        iVar4 = FUN_180f8c590(uVar5);
        if (iVar4 == 1) {
          *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x200;
        }
      }
      cVar3 = (*(code *)DAT_181952a40[0x78])(6);
      if ((((cVar3 == '\0') || (bVar14)) || ((char)DAT_181a19c68[0xa8] == '\x01')) ||
         (((char)DAT_181a19c68[0xa8] == '\x04' || (iVar4 = FUN_180c3eb00(DAT_181a0e320), iVar4 != 0)
          ))) {
        DAT_181a2b5f0 = 1;
        *(undefined8 *)(param_1 + 0x464) = 0;
        *(undefined4 *)(param_1 + 0x46c) = 0;
      }
      else {
        iVar4 = FUN_180d1d790(DAT_181a19c68);
        if (((iVar4 == 0) && (*(int *)(param_1 + 0xaf8) == 0)) &&
           ((DAT_181a2b5f0 != 0 &&
            ((((int)DAT_181a19c68[0x10] == 0 || (*(int *)((longlong)DAT_181a19c68 + 0x84) == 0)) &&
             (*(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x10,
             *(int *)(param_1 + 0xc4) == 0)))))) {
          *(undefined4 *)(param_1 + 0x468) = 1;
          uVar5 = (**(code **)(*DAT_181952a40 + 0x110))();
          *(undefined4 *)(param_1 + 0x464) = uVar5;
        }
        DAT_181a2b5f0 = 0;
      }
    }
    if (((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x2e) || (iVar4 = FUN_180ef4440(param_1), iVar4 == 1))
       || ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x3a || (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x50)))
       ) {
      if (*(int *)(param_1 + 0xaf8) == 0) {
        *(undefined1 *)(param_1 + 0xad5) = 0;
      }
      if ((*(uint *)(param_1 + 0x8c) & 0x2000000) == 0) {
        if ((*(int *)(param_1 + 0xaf8) != 0) && (*(char *)(param_1 + 0xad5) == '\0')) {
          cVar3 = (*(code *)DAT_181952a40[0x78])(6);
          if (cVar3 == '\0') {
            *(undefined1 *)(param_1 + 0xad4) = 1;
          }
          else if (*(char *)(param_1 + 0xad4) != '\x01') goto LAB_180efab47;
          cVar3 = (*(code *)DAT_181952a40[0x78])(6);
          if (cVar3 == '\0') goto LAB_180efab47;
          iVar4 = FUN_180d1d790(DAT_181a19c68);
          if ((iVar4 == 0) &&
             (((int)DAT_181a19c68[0x10] == 0 || (*(int *)((longlong)DAT_181a19c68 + 0x84) == 0)))) {
            *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x2000000;
            *(undefined1 *)(param_1 + 0xad5) = 1;
            if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x3a) && (DAT_18194e810 != 0)) {
              FUN_1802b0c20();
            }
            if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x50) && (DAT_181949a60 != 0)) {
              FUN_18009a820();
            }
            FUN_1802eb9c0(DAT_181a1b460);
          }
        }
        *(undefined1 *)(param_1 + 0xad4) = 0;
      }
    }
  }
LAB_180efab47:
  FUN_180f02170(param_1);
  cVar3 = FUN_180bfe230(DAT_181a08d38,2);
  if (cVar3 == '\0') {
    if (*(int *)(param_1 + 300) == 1) {
      uVar13 = *(uint *)(DAT_181a08d38 + 0xe9e0);
      if ((0x39 < uVar13) || ((0x200800001480000U >> ((longlong)(int)uVar13 & 0x3fU) & 1) == 0)) {
        if ((uVar13 == 0x40) || (uVar13 == 0x4c)) goto LAB_180efad41;
        if (uVar13 != 0x44) goto LAB_180efabb7;
      }
      *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) & 0xffffffdf;
    }
    else {
LAB_180efabb7:
      if ((*(int *)(param_1 + 0xe8) == 0) || (*(int *)(param_1 + 0xaf8) == 0)) {
        if ((*(float *)((longlong)DAT_181a19c68 + 0x3e4) != 0.0) &&
           (cVar3 = FUN_180ef9d30(param_1), cVar3 == '\0')) {
          *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) & 0xffffffef;
        }
        cVar3 = (*(code *)DAT_181952a40[0x78])(0);
        if (cVar3 != '\0') {
          *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 1;
        }
        cVar3 = (*(code *)DAT_181952a40[0x78])(1);
        if (cVar3 != '\0') {
          *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 2;
        }
        cVar3 = (*(code *)DAT_181952a40[0x78])(0xe);
        if (cVar3 != '\0') {
          *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x100;
        }
        cVar3 = (*(code *)DAT_181952a40[0x78])(0xd);
        if (cVar3 != '\0') {
          *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x80;
        }
        uVar13 = *(uint *)(param_1 + 0x8c);
        if (((uVar13 & 4) != 0) && ((uVar13 & 0x40) != 0)) {
          uVar13 = uVar13 | 0x100;
          *(uint *)(param_1 + 0x8c) = uVar13;
        }
        if (((uVar13 & 8) != 0) && ((uVar13 & 0x40) != 0)) {
          uVar13 = uVar13 | 0x80;
          *(uint *)(param_1 + 0x8c) = uVar13;
        }
        if ((uVar13 & 0x30193) != 0) {
          uVar13 = uVar13 | 0x800;
          *(uint *)(param_1 + 0x8c) = uVar13;
        }
        if (((uVar13 & 0x10) != 0) && ((*(byte *)(param_1 + 0xe4) & 0x10) == 0)) {
          *(undefined4 *)(param_1 + 0x46c) = 1;
        }
        if ((((*(char *)(param_1 + 0xb92) == '\x01') && (*(int *)(param_1 + 0xaf8) == 0)) &&
            (((*(uint *)(param_1 + 0xe4) & 0x181) == 0 || ((uVar13 & 0x181) == 0)))) &&
           (((plVar11 = (longlong *)FUN_180d45400(DAT_181a19c68[0x86]), plVar11 != (longlong *)0x0
             && (cVar3 = (**(code **)(*plVar11 + 0x3d8))(plVar11), cVar3 != '\0')) &&
            (iVar4 = (**(code **)(*plVar11 + 0x198))(plVar11), iVar4 == 0x30)))) {
          FUN_180cffe10(plVar11,0x31);
          *(undefined1 *)(param_1 + 0xb92) = 0;
        }
      }
    }
  }
LAB_180efad41:
  if (*(int *)(param_1 + 0x130) == 1) {
    uVar13 = *(int *)(DAT_181a08d38 + 0xe9e0) - 0x13;
    if ((uVar13 < 0x2e) && ((0x200000000029U >> ((ulonglong)uVar13 & 0x3f) & 1) != 0))
    goto LAB_180efb48c;
  }
  else if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x16) &&
          (iVar4 = FUN_18072e310(DAT_1819ecf18), iVar4 == 2)) {
    cVar3 = (*(code *)DAT_181952a40[0x78])(0x3d);
    if (cVar3 != '\0') {
      return;
    }
    cVar3 = (*(code *)DAT_181952a40[0x78])(0x6b);
    if (cVar3 != '\0') {
      return;
    }
    goto LAB_180efb48c;
  }
  cVar3 = (*(code *)DAT_181952a40[0x78])(0x3d);
  if (cVar3 != '\0') {
    plVar11 = (longlong *)FUN_180d45400(DAT_181a19c68[0x86]);
    if (plVar11 != (longlong *)0x0) {
      lVar9 = (**(code **)(*plVar11 + 0x120))(plVar11);
      if (lVar9 != 0) {
        if (((*(uint *)(lVar9 + 0x562c) & 0x2000) != 0) &&
           ((((iVar4 = (**(code **)(*plVar11 + 0x198))(plVar11), iVar4 == 0x2b ||
              (iVar4 = (**(code **)(*plVar11 + 0x198))(plVar11), iVar4 == 0x2c)) &&
             (iVar4 = (**(code **)(*plVar11 + 0x2d0))(plVar11), iVar4 == 0)) &&
            ((*(uint *)(param_1 + 0xe4) & 0x40001000) != 0x40001000)))) {
          return;
        }
        if (((((*(uint *)(lVar9 + 0x562c) & 0x100000) != 0) &&
             ((iVar4 = (**(code **)(*plVar11 + 0x198))(plVar11), iVar4 == 0x2d ||
              (iVar4 = (**(code **)(*plVar11 + 0x198))(plVar11), iVar4 == 0x2e)))) &&
            (iVar4 = (**(code **)(*plVar11 + 0x2d0))(plVar11), iVar4 == 0)) &&
           ((*(uint *)(param_1 + 0xe4) & 0x40001000) != 0x40001000)) {
          return;
        }
      }
      iVar4 = (**(code **)(*plVar11 + 0x198))(plVar11);
      if (iVar4 == 0x32) {
        return;
      }
      if ((((*(uint *)(param_1 + 0xe4) & 0x1000) == 0) && (DAT_181a19c68 != (longlong *)0x0)) &&
         ((DAT_181a19c68[0x86] != 0 &&
          (((lVar12 = FUN_180d45400(), lVar12 != 0 && (lVar9 != 0)) &&
           (cVar3 = FUN_180c59f80(lVar9), cVar3 == '\x01')))))) {
        iVar4 = (**(code **)(*plVar11 + 0x370))(plVar11);
        if (iVar4 != 0) {
          return;
        }
        plVar11 = (longlong *)FUN_180d45400(DAT_181a19c68[0x86]);
        (**(code **)(*plVar11 + 0x298))(plVar11,0);
      }
      if ((*(uint *)(param_1 + 0xe4) & 0x1400) == 0) {
        if ((((DAT_181a19c68 != (longlong *)0x0) && (DAT_181a19c68[0x86] != 0)) &&
            ((lVar12 = FUN_180d45400(), lVar12 != 0 &&
             ((lVar9 != 0 && (iVar4 = FUN_180c59ed0(lVar9), iVar4 != 0)))))) &&
           (cVar3 = FUN_180c58940(lVar9,4), cVar3 == '\0')) {
          plVar11 = (longlong *)FUN_180d45400(DAT_181a19c68[0x86]);
          (**(code **)(*plVar11 + 0x2c0))(plVar11);
        }
        if (((((*(uint *)(param_1 + 0xe4) & 0x1400) == 0) && (DAT_181a19c68 != (longlong *)0x0)) &&
            (DAT_181a19c68[0x86] != 0)) &&
           (((lVar12 = FUN_180d45400(), lVar12 != 0 && (lVar9 != 0)) &&
            (cVar3 = FUN_180c58940(lVar9,2), cVar3 != '\0')))) {
          pcVar1 = *(code **)(*DAT_181a1a340 + 0xe0);
          uVar5 = FUN_180c58c50(lVar9);
          iVar4 = (*pcVar1)(DAT_181a1a340,uVar5);
          if (iVar4 < 1) {
            return;
          }
          plVar11 = (longlong *)FUN_180d45400(DAT_181a19c68[0x86]);
          (**(code **)(*plVar11 + 0x2c0))(plVar11);
        }
      }
    }
    if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x27) {
      uVar10 = FUN_180c6f820();
      iVar4 = FUN_180c71410(uVar10);
      if (((iVar4 == 0) && (DAT_181a19c68[0x86] != 0)) &&
         (plVar11 = (longlong *)FUN_180d45400(), plVar11 != (longlong *)0x0)) {
        lVar9 = (**(code **)(*plVar11 + 0x120))(plVar11);
        iVar4 = *(int *)(lVar9 + 4);
        if ((iVar4 == 0x45c) || (iVar4 == 0x46a)) {
          uVar10 = FUN_180c6f820();
          iVar6 = FUN_180c7ac50(uVar10);
          if (iVar6 == 0) {
            FUN_180d7a090(DAT_181a1b3e8,&DAT_18163e0e0,0x10,0xc,0x40400000,0xffffffff,0);
          }
          if (iVar4 == 0x45c) {
            if (*(char *)((longlong)plVar11 + 0x1e4) != '\0') {
              return;
            }
            puVar2 = (undefined4 *)**(undefined8 **)(param_1 + 0x110);
            local_38 = *puVar2;
            local_34 = puVar2[1];
            local_30 = puVar2[2];
            iVar4 = FUN_180f03da0(&local_38,0x3001);
            if ((iVar4 == 0x14) && (cVar3 = (*(code *)DAT_181952a40[0x78])(0x13), cVar3 != '\0')) {
              uVar10 = (**(code **)(*(longlong *)DAT_181a19c68[0x8c] + 0x10))();
              cVar3 = FUN_180c344c0(DAT_181a0e320,uVar10);
              if (cVar3 == '\0') {
                (**(code **)(*DAT_181a19c68 + 0x50))(DAT_181a19c68,0x13);
                return;
              }
            }
          }
          else if (iVar4 == 0x46a) {
            return;
          }
        }
      }
    }
    cVar3 = FUN_180f01f50(param_1,0x400);
    if (cVar3 != '\0') {
      return;
    }
    *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x1000;
    goto LAB_180efb48c;
  }
  cVar3 = (*(code *)DAT_181952a40[0x78])(0x77);
  if (cVar3 == '\0') goto LAB_180efb48c;
  if ((DAT_181a19c68 != (longlong *)0x0) && (DAT_181a19c68[0x86] != 0)) {
    plVar11 = (longlong *)FUN_180d45400();
    if (((*(uint *)(param_1 + 0xe4) >> 0x1e & 1) == 0) &&
       ((*(uint *)(param_1 + 0xe4) >> 10 & 1) == 0)) {
      if (plVar11 != (longlong *)0x0) {
        lVar9 = (**(code **)(*plVar11 + 0x120))(plVar11);
        if (lVar9 != 0) {
          cVar3 = FUN_180c58940(lVar9,4);
          if (cVar3 != '\0') {
            (**(code **)(*plVar11 + 0x2f8))(plVar11);
          }
          cVar3 = FUN_180c5a0e0(lVar9);
          if (cVar3 == '\0') {
            cVar3 = FUN_180c5a160(lVar9);
            if (cVar3 != '\0') {
              (**(code **)(*plVar11 + 0x360))(plVar11);
              uVar10 = FUN_180c6f820();
              iVar4 = FUN_180c7ad00(uVar10);
              if (iVar4 != 0) {
                return;
              }
            }
          }
          else {
            (**(code **)(*plVar11 + 0x300))(plVar11);
          }
          cVar3 = FUN_180c5ab10(lVar9);
          if (cVar3 != '\0') {
            (**(code **)(*plVar11 + 0x418))(plVar11);
          }
        }
LAB_180efb31e:
        iVar4 = (**(code **)(*plVar11 + 0x2d0))(plVar11);
        if (iVar4 == 0) {
          lVar9 = (**(code **)(*plVar11 + 0x120))(plVar11);
          cVar3 = FUN_180c58940(lVar9,0x2000);
          if (cVar3 != '\0') {
            if (0 < (int)DAT_181a19c68[0x74]) {
              return;
            }
            if (*(int *)((longlong)DAT_181a19c68 + 0x5ec) != 0) {
              return;
            }
          }
          if ((*(uint *)(lVar9 + 0x562c) & 0x2000) == 0) {
            iVar4 = (**(code **)(*plVar11 + 0x198))(plVar11);
            bVar14 = iVar4 == 9;
LAB_180efb468:
            if (bVar14) {
              return;
            }
          }
          else {
            pcVar1 = *(code **)(*DAT_181952a40 + 0x180);
            uVar10 = (**(code **)(*plVar11 + 0x218))(plVar11);
            iVar4 = (*pcVar1)(DAT_181952a40,uVar10,"prefire");
            pcVar1 = *(code **)(*DAT_181952a40 + 0x180);
            uVar10 = (**(code **)(*plVar11 + 0x218))(plVar11);
            iVar6 = (*pcVar1)(DAT_181952a40,uVar10,&DAT_1816149a4);
            pcVar1 = *(code **)(*DAT_181952a40 + 0x1a8);
            uVar10 = (**(code **)(*plVar11 + 0x218))(plVar11);
            iVar7 = (*pcVar1)(DAT_181952a40,uVar10);
            iVar8 = (**(code **)(*plVar11 + 0x198))(plVar11);
            if (iVar8 == 0xb) {
              return;
            }
            iVar8 = (**(code **)(*plVar11 + 0x198))(plVar11);
            if ((iVar8 == 3) && (iVar7 == iVar4)) {
              return;
            }
            iVar4 = (**(code **)(*plVar11 + 0x198))(plVar11);
            if (iVar4 == 3) {
              bVar14 = iVar7 == iVar6;
              goto LAB_180efb468;
            }
          }
          cVar3 = FUN_180c5a120(lVar9);
          if (cVar3 != '\0') {
            (**(code **)(*plVar11 + 0x330))(plVar11);
          }
        }
      }
    }
    else if (plVar11 != (longlong *)0x0) goto LAB_180efb31e;
  }
  *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x40000000;
LAB_180efb48c:
  cVar3 = (*(code *)DAT_181952a40[0x78])(0x6b);
  if ((cVar3 != '\0') &&
     (((*(int *)(DAT_181a08d38 + 0xe9e0) != 0xf || (DAT_1819ecee0 == 0)) ||
      (*(char *)(DAT_1819ecee0 + 0xd5) == '\0')))) {
    *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x8000;
  }
  return;
}

