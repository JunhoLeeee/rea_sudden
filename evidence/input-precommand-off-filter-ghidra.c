
undefined8 FUN_181121f50(int param_1)

{
  longlong lVar1;
  
  if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x21) {
    if (param_1 == 0x13) {
      if (DAT_181a1b3b8 != 0) {
        FUN_18116a480(DAT_181a1b3b8,0);
      }
    }
    else if (param_1 == 0x45) {
      lVar1 = FUN_18111c360();
      if ((*(int *)(lVar1 + 8) != 1) && (lVar1 = FUN_18111c360(), *(int *)(lVar1 + 8) != 2)) {
        return 0;
      }
      if (DAT_181a1b4b0 != (longlong *)0x0) {
        (**(code **)(*DAT_181a1b4b0 + 0x68))(DAT_181a1b4b0,0,1);
      }
      return 1;
    }
  }
  return 0;
}

