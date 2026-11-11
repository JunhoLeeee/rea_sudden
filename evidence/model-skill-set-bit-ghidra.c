
void FUN_180da03b0(longlong param_1,longlong param_2,int param_3)

{
  ulonglong *puVar1;
  int iVar2;
  undefined4 uVar3;
  
  if ((param_3 != 0) && ((ulonglong)(longlong)param_3 < 0x40)) {
    puVar1 = (ulonglong *)(param_2 + 0x2e88 + ((ulonglong)(longlong)param_3 >> 6) * 8);
    *puVar1 = *puVar1 | 1L << ((byte)param_3 & 0x3f);
    if (param_3 == 9) {
      iVar2 = FUN_1813277d0(param_1 + 0x10,&DAT_181a1d510,"MyEmotionView",0);
      FUN_180da03b0(param_1,param_2,-(iVar2 != 0) & 0x1d);
      uVar3 = FUN_181327db0(param_1 + 0x10,&DAT_181a1d510,"MyEmotionViewOffset",0);
      *(undefined4 *)(param_2 + 0x994) = uVar3;
    }
    else if (param_3 == 0xb) {
      FUN_181328110(param_1 + 0x10,&DAT_181a1d510,"GhostFXHeadPath",&DAT_181689868,param_2 + 0x2910,
                    0x7f);
      FUN_181328110(param_1 + 0x10,&DAT_181a1d510,"GhostFXNormalPath",&DAT_181689868,
                    param_2 + 0x298f,0x7f);
      return;
    }
  }
  return;
}

