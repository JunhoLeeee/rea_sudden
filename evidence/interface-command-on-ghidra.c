
undefined8 FUN_180570e30(longlong param_1,int param_2)

{
  uint uVar1;
  bool bVar2;
  char cVar3;
  SHORT SVar4;
  ushort uVar5;
  int iVar6;
  undefined4 uVar7;
  undefined4 uVar8;
  longlong lVar9;
  undefined8 uVar10;
  undefined8 uVar11;
  undefined4 auStackX_18 [4];
  
  if ((DAT_181a08da8 != 0) && (*(int *)(DAT_181a08da8 + 8) != 0)) {
    return 1;
  }
  switch(param_2) {
  case 0x12:
    if ((((DAT_1819ecee0 == 0) || (*(int *)(DAT_1819ecee0 + 0xcf8) == 0)) ||
        (*(char *)(DAT_1819ecee0 + 0xd9) != '\0')) &&
       (iVar6 = FUN_1810f9ef0(DAT_181a1b420), iVar6 == 0)) {
      uVar1 = *(uint *)(DAT_181a08d38 + 0xe9e0);
      if ((((uVar1 != 0x13) && (*(int *)(param_1 + 0xa8) == 1)) &&
          (((uVar1 < 0x3e && ((0x2006000000000006U >> ((longlong)(int)uVar1 & 0x3fU) & 1) != 0)) ||
           (((iVar6 = FUN_180f8c9d0(), iVar6 == 0x42 ||
             (*(int *)(DAT_181a08d38 + 0xe9e0) - 0x4fU < 2)) ||
            (cVar3 = FUN_180f8ca20(), cVar3 != '\0')))))) &&
         (iVar6 = FUN_180d1d790(DAT_181a19c68), iVar6 == 0)) {
        FUN_18075b180(DAT_1819ecdf8,0xc);
        return 1;
      }
    }
    break;
  default:
    uVar11 = FUN_180c9d890(param_1);
    return uVar11;
  case 0x48:
    if ((((DAT_1819ecee0 == 0) || (*(int *)(DAT_1819ecee0 + 0xcf8) == 0)) ||
        (*(char *)(DAT_1819ecee0 + 0xd9) != '\0')) &&
       (iVar6 = FUN_1810f9ef0(DAT_181a1b420), iVar6 == 0)) {
      uVar1 = *(uint *)(DAT_181a08d38 + 0xe9e0);
      if ((((uVar1 != 0x13) && (*(int *)(param_1 + 0xa8) == 1)) &&
          (((uVar1 < 0x3e && ((0x2006000000000006U >> ((longlong)(int)uVar1 & 0x3fU) & 1) != 0)) ||
           (((iVar6 = FUN_180f8c9d0(), iVar6 == 0x42 ||
             (*(int *)(DAT_181a08d38 + 0xe9e0) - 0x4fU < 2)) ||
            (cVar3 = FUN_180f8ca20(), cVar3 != '\0')))))) &&
         (iVar6 = FUN_180d1d790(DAT_181a19c68), iVar6 == 0)) {
        FUN_18075b180(DAT_1819ecdf8,6);
        return 1;
      }
    }
    break;
  case 0x4a:
  case 0x5e:
    if (((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x11) && (cVar3 = FUN_180f8ca20(), cVar3 == '\0')) &&
       (param_2 == 0x5e)) {
      return 0;
    }
    SVar4 = GetKeyState(0x11);
    if ((char)SVar4 < '\0') {
      param_2 = 0x5e;
    }
    else {
      SVar4 = GetKeyState(0xa3);
      if ((char)SVar4 < '\0') {
        param_2 = 0x5e;
      }
      else {
        uVar5 = GetKeyState(0xa2);
        if ((uVar5 & 0x80) != 0) {
          param_2 = 0x5e;
        }
      }
    }
    if (*(int *)(param_1 + 0xa8) != 1) {
      return 1;
    }
    iVar6 = FUN_180d1d950(DAT_181a19c68);
    if (iVar6 != 0) {
      return 1;
    }
    if (*(char *)(param_1 + 0x74) != '\0') {
      FUN_1810fb360(param_1 + 0x68);
    }
    if (*(char *)(param_1 + 0x1d) != '\0') {
      FUN_1810fabf0(param_1 + 0x10);
    }
    if ((DAT_181a08d58 != (longlong *)0x0) &&
       (iVar6 = (**(code **)(*DAT_181a08d58 + 0x1d0))(), iVar6 != 0)) {
      return 1;
    }
    if (*(char *)(DAT_1819ecf40 + 0x1f84) != '\0') {
      return 1;
    }
    if (*(char *)(DAT_1819ecf40 + 0x1f85) != '\0') {
      return 1;
    }
    if (*(int *)(DAT_181a1b3d8 + 0x38) != 0) {
      FUN_180f18450(DAT_181a1b3d8,1);
      return 1;
    }
    switch(*(undefined4 *)(DAT_181a08d38 + 0xe9e0)) {
    case 0x4c:
      if (param_2 != 0x4a) {
        return 1;
      }
      lVar9 = FUN_180c44210(DAT_181a0e320);
      if (lVar9 == 0) {
        return 1;
      }
      bVar2 = false;
      if ((*(uint *)(lVar9 + 0x28) == 6) || (*(uint *)(lVar9 + 0x28) < 2)) {
        bVar2 = true;
      }
      iVar6 = FUN_180d1d780(DAT_181a19c68);
      if ((iVar6 == 1) && (!bVar2)) {
        return 1;
      }
      FUN_181352c70(*(undefined8 *)(DAT_181a1b3d8 + 0x30));
      FUN_180f18090(DAT_181a1b3d8,0);
      return 1;
    case 0x4e:
      iVar6 = FUN_181335210(DAT_1819fcbf8);
      if (iVar6 != 0) {
        return 1;
      }
      uVar11 = *(undefined8 *)(DAT_181a1b3d8 + 0x30);
      break;
    case 0x51:
      if (((*(char *)(DAT_181a08d38 + 0xeee0) == '\0') && (*(int *)(DAT_181a08d38 + 0x10460) == 0))
         && ((DAT_181a0e320 != 0 && (*(char *)(DAT_181a0e320 + 0x171) == '\0')))) {
        return 1;
      }
    default:
      uVar11 = *(undefined8 *)(DAT_181a1b3d8 + 0x30);
    }
    FUN_181352c70(uVar11);
    FUN_180f18090(DAT_181a1b3d8,param_2 != 0x4a);
    return 1;
  case 0x66:
    if (*(int *)(param_1 + 0xa8) != 1) {
      return 0;
    }
    FUN_18075ebe0(DAT_1819ece30,0);
    return 0;
  case 0x67:
    if (*(int *)(param_1 + 0xa8) != 1) {
      return 0;
    }
    FUN_18075ebe0(DAT_1819ece30,1);
    return 0;
  case 0x6a:
    if ((((DAT_1819ecee0 == 0) || (*(int *)(DAT_1819ecee0 + 0xcf8) == 0)) ||
        (*(char *)(DAT_1819ecee0 + 0xd9) != '\0')) &&
       (iVar6 = FUN_1810f9ef0(DAT_181a1b420), iVar6 == 0)) {
      uVar1 = *(uint *)(DAT_181a08d38 + 0xe9e0);
      if (((uVar1 != 0x13) && (*(int *)(param_1 + 0xa8) == 1)) &&
         ((((uVar1 < 0x3e && ((0x2006000000000006U >> ((longlong)(int)uVar1 & 0x3fU) & 1) != 0)) ||
           (((iVar6 = FUN_180f8c9d0(), iVar6 == 0x42 ||
             (*(int *)(DAT_181a08d38 + 0xe9e0) - 0x4fU < 2)) ||
            (cVar3 = FUN_180f8ca20(), cVar3 != '\0')))) &&
          (iVar6 = FUN_180d1d790(DAT_181a19c68), iVar6 == 0)))) {
        FUN_18075b180(DAT_1819ecdf8,0);
      }
    }
    break;
  case 0x71:
    if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0xf) {
      return 1;
    }
    if (*(int *)(DAT_181a08d38 + 0xe9e0) - 0x11U < 3) {
      return 1;
    }
    lVar9 = FUN_180c6f820();
    if (*(char *)(lVar9 + 0x6f88) == '\x01') {
      return 1;
    }
    iVar6 = FUN_1810f9ef0(DAT_181a1b420);
    if (iVar6 != 0) {
      return 1;
    }
    if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0xd) &&
       (iVar6 = FUN_1807805e0(DAT_1819eceb0), iVar6 != 0)) {
      return 1;
    }
    if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x41) && (cVar3 = FUN_180f06800(), cVar3 == '\x01')) {
      return 1;
    }
    if (*(int *)(param_1 + 0xa8) != 1) {
      return 0;
    }
    iVar6 = FUN_180d1d790(DAT_181a19c68);
    if (iVar6 != 0) {
      return 0;
    }
    iVar6 = FUN_180f8c9d0();
    bVar2 = false;
    if ((iVar6 == 0x31) && (cVar3 = FUN_180f8ca20(), bVar2 = false, cVar3 != '\0')) {
      bVar2 = true;
    }
    uVar11 = FUN_180c6f820();
    iVar6 = FUN_180c71410(uVar11);
    if (iVar6 == 0) {
      uVar11 = FUN_180c6f820();
      uVar7 = FUN_180c73f60(uVar11);
    }
    else {
      uVar11 = FUN_180c6f820();
      uVar7 = FUN_180c73f70(uVar11);
    }
    uVar11 = FUN_1810fb920();
    uVar10 = FUN_180c6f820();
    auStackX_18[0] = FUN_180c71ff0(uVar10);
    cVar3 = FUN_1810fc140(uVar11,auStackX_18);
    if (cVar3 != '\0') {
      uVar11 = FUN_180c6f820();
      uVar10 = FUN_180c6f820();
      uVar7 = FUN_180c71410(uVar10);
      uVar7 = FUN_180c71f40(uVar11,uVar7);
    }
    if (DAT_181a07fc0 != 0) {
      uVar11 = FUN_180c6f820();
      uVar8 = FUN_180c71410(uVar11);
      iVar6 = func_0x000180b312e0(DAT_181a07fc0,uVar8);
      if (iVar6 != 0) goto code_r0x0001805714f0;
    }
    if ((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x22) && (!bVar2)) {
      uVar11 = FUN_180c6f820();
      uVar8 = FUN_180c736d0(uVar11);
      cVar3 = FUN_180d9f9b0(DAT_181a1d4f8,uVar7,uVar8);
      if (cVar3 == '\0') {
        return 0;
      }
    }
code_r0x0001805714f0:
    FUN_18075b180(DAT_1819ecdf8,0x12);
    return 0;
  case 0x7a:
    iVar6 = FUN_180ca12b0(param_1);
    if (iVar6 == 0) {
      return 0;
    }
    iVar6 = FUN_180ca1360(param_1);
    if (iVar6 == 0) {
      return 0;
    }
    iVar6 = FUN_180d1d790(DAT_181a19c68);
    if (iVar6 == 0) {
      FUN_180311fb0(DAT_18194eea0,0);
      return 1;
    }
    break;
  case 0x7b:
    iVar6 = FUN_180ca12b0(param_1);
    if (iVar6 == 0) {
      return 0;
    }
    iVar6 = FUN_180ca1360(param_1);
    if (iVar6 == 0) {
      return 0;
    }
    iVar6 = FUN_180d1d790(DAT_181a19c68);
    if (iVar6 == 0) {
      FUN_180311fb0(DAT_18194eea0,1);
      return 1;
    }
  }
  return 1;
}

