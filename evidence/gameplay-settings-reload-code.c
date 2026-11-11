
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

void FUN_1801dff80(undefined8 param_1)

{
  void *pvVar1;
  longlong lVar2;
  void *_Memory;
  char cVar3;
  longlong *plVar4;
  undefined1 auStack_a8 [32];
  longlong *local_88;
  undefined8 local_78;
  undefined8 uStack_70;
  longlong *local_68;
  longlong *plStack_60;
  undefined8 local_58;
  void *pvStack_50;
  void *local_48;
  undefined8 uStack_40;
  undefined8 local_38;
  undefined8 uStack_30;
  undefined4 local_28;
  undefined8 local_20;
  ulonglong local_18;
  
  local_18 = DAT_181905cc8 ^ (ulonglong)auStack_a8;
  local_78 = 0;
  plVar4 = (longlong *)0x0;
  uStack_70 = 0;
  local_68 = (longlong *)0x0;
  plStack_60 = (longlong *)0x0;
  local_58 = 0;
  pvStack_50 = (void *)0x0;
  local_48 = (void *)0x0;
  uStack_40 = 0;
  local_38 = 0;
  uStack_30 = 0x400;
  local_28 = 0;
  local_20 = 0;
  local_88 = (longlong *)FUN_181387aac(0x28);
  if (local_88 != (longlong *)0x0) {
    *local_88 = 0;
    local_88[1] = 0x10000;
    local_88[2] = 0;
    local_88[3] = 0;
    local_88[4] = 0;
    plVar4 = local_88;
  }
  local_68 = plVar4;
  plStack_60 = plVar4;
  cVar3 = FUN_180077760("sa_scripts\\GameplaySettings.txt",&local_78);
  if (cVar3 != '\0') {
    FUN_1801df810(param_1,&local_78);
  }
  plVar4 = plStack_60;
  if (plStack_60 != (longlong *)0x0) {
    _Memory = (void *)*plStack_60;
    while ((_Memory != (void *)0x0 && (_Memory != (void *)plVar4[2]))) {
      pvVar1 = *(void **)((longlong)_Memory + 0x10);
      free(_Memory);
      *plVar4 = (longlong)pvVar1;
      _Memory = pvVar1;
    }
    lVar2 = *plVar4;
    if ((lVar2 != 0) && (lVar2 == plVar4[2])) {
      *(undefined8 *)(lVar2 + 8) = 0;
    }
    free((void *)plVar4[4]);
    free(plVar4);
  }
  free(local_48);
  free(pvStack_50);
  return;
}

