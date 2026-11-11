
undefined1 FUN_181327c30(longlong param_1,undefined8 param_2,undefined8 param_3,undefined1 param_4)

{
  int *piVar1;
  
  *(undefined1 *)(param_1 + 0x15) = 1;
  piVar1 = (int *)FUN_18132b9f0();
  if (piVar1 != (int *)0x0) {
    if (*piVar1 == 4) {
      return (char)piVar1[2];
    }
    FUN_181329000(param_1,"Type mismatch - [%s]:%s",param_2,param_3);
  }
  *(undefined1 *)(param_1 + 0x15) = 0;
  return param_4;
}

