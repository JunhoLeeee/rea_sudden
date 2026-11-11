
undefined4 FUN_1402acd70(longlong param_1)

{
  uint uVar1;
  undefined4 uVar2;
  uint uVar3;
  
  uVar3 = *(uint *)(param_1 + 0x90);
  if (uVar3 == 0x10) {
    FUN_1402ad1f0();
    uVar3 = *(uint *)(param_1 + 0x94);
    if (uVar3 != 0) {
      *(int *)(param_1 + 0x98) = *(int *)(param_1 + 0x98) + 0x10;
      uVar1 = *(uint *)(param_1 + 0x98);
      if (uVar1 % uVar3 == 0) {
        if ((ulonglong)((*(longlong *)(param_1 + 0xa8) - *(longlong *)(param_1 + 0xa0)) / 0x94) <=
            (ulonglong)uVar1 / (ulonglong)uVar3) {
          FUN_1402ad020(param_1,(ulonglong)uVar1 % (ulonglong)uVar3);
        }
      }
    }
    uVar3 = 0;
    *(undefined4 *)(param_1 + 0x90) = 0;
  }
  uVar2 = *(undefined4 *)(param_1 + 0x50 + (ulonglong)uVar3 * 4);
  *(uint *)(param_1 + 0x90) = uVar3 + 1;
  return uVar2;
}

