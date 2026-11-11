
ulonglong FUN_180c71f40(longlong param_1,uint param_2)

{
  uint uVar1;
  undefined1 uVar2;
  undefined4 uVar3;
  ulonglong uVar4;
  
  uVar4 = (ulonglong)*(uint *)(param_1 + 0x154c);
  if (0x7fffffff < *(uint *)(param_1 + 0x154c)) {
    if (1 < param_2) {
      return 0xffff;
    }
    uVar1 = *(uint *)(param_1 + 0x1544 + (longlong)(int)param_2 * 4);
    if (*(char *)(param_1 + 0x6f88) == '\0') {
      return (ulonglong)uVar1;
    }
    uVar3 = FUN_180d9dda0(DAT_181a1d4f8,uVar1);
    uVar2 = FUN_180d9f710(DAT_181a1d4f8,uVar1);
    uVar4 = FUN_18110c8d0(DAT_181a927b8,uVar1,uVar3,uVar2);
  }
  return uVar4;
}

