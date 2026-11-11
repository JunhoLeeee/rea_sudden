
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

ulonglong FUN_1811d4010(undefined8 param_1,undefined4 param_2,int param_3,int param_4)

{
  code *pcVar1;
  char cVar2;
  int iVar3;
  uint *puVar4;
  ulonglong uVar5;
  longlong lVar6;
  undefined1 auStack_68 [32];
  int local_48;
  undefined1 local_38 [8];
  undefined1 local_30 [8];
  ulonglong local_28;
  
  local_28 = DAT_181905cc8 ^ (ulonglong)auStack_68;
  uVar5 = local_28;
  if ((param_3 < 0) ||
     (lVar6 = *(longlong *)(DAT_181a1d4f8 + 0x26a8) - *(longlong *)(DAT_181a1d4f8 + 0x26a0),
     lVar6 = SUB168(SEXT816(-0x51ef0057087fd47b) * SEXT816(lVar6),8) + lVar6, uVar5 = 0,
     (int)(lVar6 >> 0xd) - (int)(lVar6 >> 0x3f) <= param_3)) {
    return uVar5 & 0xffffffffffffff00;
  }
  if ((param_4 != 10) && (param_4 != 0x11)) {
    local_48 = param_4;
    lVar6 = FUN_1811d41a0(param_1,local_38,param_2,param_3);
    if ((ulonglong)(longlong)param_4 < 0x40) {
      uVar5 = *(ulonglong *)(lVar6 + ((ulonglong)(longlong)param_4 >> 6) * 8);
      return CONCAT71((int7)(uVar5 >> 8),(uVar5 >> ((byte)param_4 & 0x3f) & 1) != 0);
    }
    FUN_180d443d0(lVar6);
    pcVar1 = (code *)swi(3);
    uVar5 = (*pcVar1)();
    return uVar5;
  }
  cVar2 = FUN_180d9f8f0(DAT_181a1d4f8,param_3);
  if (param_4 == 10) {
    if (cVar2 != '\0') {
      local_48 = 10;
      puVar4 = (uint *)FUN_1811d41a0(param_1,local_30,param_2,param_3);
      return (ulonglong)((byte)(*puVar4 >> 10) & 1);
    }
    iVar3 = FUN_180d9e8c0(DAT_181a1d4f8,param_3);
    return (ulonglong)(0 < iVar3);
  }
  if (param_4 != 0x11) {
    return 0;
  }
  if (cVar2 != '\0') {
    local_48 = 0x11;
    puVar4 = (uint *)FUN_1811d41a0(param_1,local_38,param_2,param_3);
    return (ulonglong)((byte)(*puVar4 >> 0x11) & 1);
  }
  iVar3 = FUN_180d9d910(DAT_181a1d4f8,param_3);
  return (ulonglong)(iVar3 != 0x5a);
}

