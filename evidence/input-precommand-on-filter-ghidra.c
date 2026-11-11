
undefined8 FUN_181121ae0(int param_1)

{
  undefined4 uVar1;
  char cVar2;
  int iVar3;
  undefined8 uVar4;
  longlong lVar5;
  longlong lVar6;
  int *piVar7;
  undefined8 uVar8;
  undefined *puVar9;
  
  if ((int)DAT_181a08d38[0x1d3c] != 0x21) {
    return 0;
  }
  FUN_1808d18a0(DAT_181a07150,0x10);
  if (param_1 != 0x13) {
    if (param_1 == 0x45) {
      if ((int)DAT_181a08d38[0x1d3c] != 0x21) {
        return 0;
      }
      uVar4 = FUN_180c6f820();
      iVar3 = FUN_180c74810(uVar4);
      if (((iVar3 == 0) && (lVar5 = FUN_18111c360(), *(int *)(lVar5 + 8) != 1)) &&
         (lVar5 = FUN_18111c360(), *(int *)(lVar5 + 8) != 2)) {
        return 1;
      }
      if (DAT_181a1b4b0 == (longlong *)0x0) {
        return 1;
      }
      (**(code **)(*DAT_181a1b4b0 + 0x68))(DAT_181a1b4b0,1);
      return 1;
    }
    if (param_1 != 0x6b) {
      return 0;
    }
    if (DAT_181a1b3b8 == 0) {
      return 0;
    }
    cVar2 = FUN_181168dd0();
    if (cVar2 == '\0') {
      return 0;
    }
    if (*(int *)(DAT_181a1b3b8 + 0x13b0) < 0) {
      return 0;
    }
    uVar4 = FUN_180dad090();
    FUN_180e36e70(uVar4);
    return 0;
  }
  lVar5 = (**(code **)(*DAT_181a08d38 + 0x1b0))();
  if (lVar5 == 0) {
    return 0;
  }
  lVar5 = (**(code **)(*DAT_181a08d38 + 0x1b0))();
  if (*(longlong *)(lVar5 + 0x460) == 0) {
    return 0;
  }
  lVar5 = (**(code **)(*DAT_181a08d38 + 0x1b0))();
  cVar2 = (**(code **)(**(longlong **)(lVar5 + 0x460) + 0x88))();
  if (cVar2 == '\0') {
    return 0;
  }
  lVar5 = (**(code **)(*DAT_181a08d38 + 0x1b0))();
  uVar4 = (**(code **)(**(longlong **)(lVar5 + 0x460) + 0x10))();
  if (((DAT_181a08d38 + 0x1df1 != (longlong *)0x0) &&
      (lVar5 = FUN_180ec3760(DAT_181a08d38 + 0x1df1,uVar4), lVar5 != 0)) &&
     ((lVar5 = FUN_180ec3230(DAT_181a08d38 + 0x1df1,*(undefined8 *)(lVar5 + 0x1168)), lVar5 != 0 &&
      (lVar5 = *(longlong *)(lVar5 + 0x20), lVar5 != 0)))) {
    uVar4 = FUN_180c6f820();
    iVar3 = FUN_180c71ff0(uVar4);
    if (iVar3 != 0x67) {
      uVar4 = FUN_180c6f820();
      lVar6 = FUN_180c737c0(uVar4);
      if (*(int *)(lVar6 + 0x30) == 2) {
        if (DAT_181a1b3b8 == 0) {
          return 1;
        }
        lVar5 = (**(code **)(*DAT_181a08d38 + 0x1b0))();
        uVar4 = (**(code **)(**(longlong **)(lVar5 + 0x460) + 0x10))();
        FUN_18116a480(DAT_181a1b3b8,uVar4);
        return 1;
      }
    }
    lVar5 = FUN_180c8a330(DAT_181a19238 + 0x5e50,lVar5);
    if (lVar5 != 0) {
      uVar1 = *(undefined4 *)(lVar5 + 0xc0);
      uVar4 = FUN_180dad090();
      FUN_180e37140(uVar4,uVar1);
      return 1;
    }
    uVar4 = FUN_180dad090();
    FUN_180e37140(uVar4,0);
    return 1;
  }
  lVar5 = (**(code **)(*DAT_181a08d38 + 0x1b0))();
  lVar5 = (**(code **)(**(longlong **)(lVar5 + 0x460) + 0x10))();
  lVar6 = FUN_18111c360();
  if (*(longlong *)(lVar6 + 0x18) == lVar5) {
    uVar4 = FUN_180dad090();
    FUN_180e371a0(uVar4);
    return 1;
  }
  lVar5 = FUN_18111c360();
  if (*(int *)(lVar5 + 8) != 1) {
    return 0;
  }
  FUN_18111c360();
  lVar5 = (**(code **)(*DAT_181a08d38 + 0x1b0))();
  uVar4 = (**(code **)(**(longlong **)(lVar5 + 0x460) + 0x10))();
  if (DAT_181a1b4c8 != (longlong *)0x0) {
    FUN_1811ccc20();
  }
  lVar5 = FUN_180ec3ed0(DAT_181a08d38 + 0x1df1,uVar4);
  if (lVar5 == 0) {
    return 0;
  }
  piVar7 = (int *)FUN_1811277b0(*(undefined4 *)(lVar5 + 0x19c));
  if (piVar7 == (int *)0x0) {
    return 0;
  }
  iVar3 = *piVar7;
  if (iVar3 == 0) {
    uVar8 = FUN_180c6f820();
    iVar3 = FUN_180c70530(uVar8);
    if (iVar3 < piVar7[9]) {
      return 0;
    }
    if (piVar7[2] == 0) {
      return 0;
    }
    if (piVar7[2] == piVar7[1]) {
      return 0;
    }
    if (DAT_181a1b4c8 == (longlong *)0x0) {
      return 1;
    }
    iVar3 = piVar7[4];
    puVar9 = &DAT_18165e520;
    uVar8 = 5;
  }
  else if (iVar3 == 1) {
    uVar8 = FUN_180c6f820();
    iVar3 = FUN_180c70530(uVar8);
    if (iVar3 < piVar7[8]) {
      return 0;
    }
    if (DAT_181a1b4c8 == (longlong *)0x0) {
      return 1;
    }
    iVar3 = piVar7[3];
    puVar9 = &DAT_18165e514;
    uVar8 = 4;
  }
  else {
    if (iVar3 != 2) goto LAB_181121ef1;
    if (DAT_181a1b4c8 == (longlong *)0x0) {
      return 1;
    }
    iVar3 = piVar7[5];
    puVar9 = &DAT_18165e52c;
    uVar8 = 6;
  }
  FUN_1811ccc90(DAT_181a1b4c8,1,uVar8,puVar9,iVar3);
LAB_181121ef1:
  if (DAT_181a1b4c8 != (longlong *)0x0) {
    FUN_1811ccc00(DAT_181a1b4c8,uVar4,0x43960000,0);
    lVar5 = FUN_18111c360();
    uVar1 = *(undefined4 *)(lVar5 + 0x2c);
    *(undefined4 *)((longlong)DAT_181a1b4c8 + 0x8c) = uVar1;
    (**(code **)(*DAT_181a1b4c8 + 0x68))
              (DAT_181a1b4c8,CONCAT71((uint7)(uint3)((uint)uVar1 >> 8),1),0);
  }
  return 1;
}

