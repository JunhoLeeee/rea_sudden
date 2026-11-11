
longlong FUN_1402acd30(longlong param_1,int param_2)

{
  uint7 uVar1;
  longlong lVar2;
  int iVar3;
  
  lVar2 = *(longlong *)(param_1 + 0xa8) - *(longlong *)(param_1 + 0xa0);
  iVar3 = (int)(lVar2 / 0x94) + (int)(lVar2 >> 0x3f) + (int)-(lVar2 >> 0x3f);
  uVar1 = (uint7)((ulonglong)-(lVar2 >> 0x3f) >> 8);
  if ((param_2 < iVar3) && (iVar3 != 0)) {
    return CONCAT71(uVar1,1);
  }
  return (ulonglong)uVar1 << 8;
}

