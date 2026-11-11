
undefined8 FUN_180d151d0(longlong param_1,int param_2)

{
  longlong lVar1;
  undefined **local_28;
  undefined8 local_20;
  int local_18;
  undefined1 local_14;
  
  if (((((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x40) && (DAT_181a19238 != -0x5e50)) &&
       (lVar1 = FUN_180c8a160(), lVar1 != 0)) &&
      ((*(char *)(lVar1 + 0x2b4) == '\0' && (param_2 == 0x3d)))) && (*(int *)(param_1 + 0x34c) != 0)
     ) {
    *(undefined4 *)(param_1 + 0x35c) = 1;
  }
  if (((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x4c) && (param_2 == 0x3d)) &&
     (*(int *)(param_1 + 0x34c) != 0)) {
    *(undefined4 *)(param_1 + 0x35c) = 1;
  }
  if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x30) || (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x31)) {
    local_20 = 0;
    local_28 = &PTR_FUN_1816154e8;
    local_14 = 0;
    local_18 = param_2;
    FUN_180079060(&DAT_181a1a198,&local_28);
  }
  return 1;
}

