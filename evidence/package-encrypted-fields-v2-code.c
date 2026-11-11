
void FUN_1402b1cc0(longlong param_1,undefined8 param_2)

{
  undefined1 uVar1;
  undefined4 uVar2;
  
  uVar2 = FUN_140290a60(param_2);
  *(undefined4 *)(param_1 + 0x30) = uVar2;
  uVar1 = FUN_140290a00(param_2);
  *(undefined1 *)(param_1 + 8) = uVar1;
  uVar2 = FUN_140290a60(param_2);
  *(undefined4 *)(param_1 + 0x34) = uVar2;
  return;
}

