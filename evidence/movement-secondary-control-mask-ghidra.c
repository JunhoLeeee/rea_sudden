
undefined8 FUN_180f01f50(longlong param_1,uint param_2)

{
  longlong *plVar1;
  longlong lVar2;
  
  if (*(longlong *)(DAT_181a19c68 + 0x430) != 0) {
    plVar1 = (longlong *)FUN_180d45400();
    if (plVar1 != (longlong *)0x0) {
      lVar2 = (**(code **)(*plVar1 + 0x120))(plVar1);
      if (*(int *)(lVar2 + 0xc) == 0x16) {
        *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | param_2;
        return 1;
      }
    }
  }
  return 0;
}

