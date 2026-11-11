
void FUN_1402acc90(longlong *param_1)

{
  longlong lVar1;
  code *pcVar2;
  longlong lVar3;
  ulonglong uVar4;
  
  lVar1 = *param_1;
  if (lVar1 != 0) {
    uVar4 = ((param_1[2] - lVar1) / 0x94) * 0x94;
    lVar3 = lVar1;
    if (0xfff < uVar4) {
      lVar3 = *(longlong *)(lVar1 + -8);
      if (0x1f < (lVar1 - lVar3) - 8U) {
        (*(code *)0x3d7636)(lVar1 - lVar3,uVar4 + 0x27);
        pcVar2 = (code *)swi(3);
        (*pcVar2)();
        return;
      }
    }
    thunk_FUN_1402b909d(lVar3);
    *param_1 = 0;
    param_1[1] = 0;
    param_1[2] = 0;
  }
  return;
}

