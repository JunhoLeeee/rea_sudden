
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined4 * FUN_1801df180(undefined4 *param_1)

{
  void *pvVar1;
  void *pvVar2;
  char cVar3;
  longlong lVar4;
  longlong *plVar5;
  undefined1 auStack_a8 [32];
  longlong *local_88;
  undefined4 *local_80;
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
  plVar5 = (longlong *)0x0;
  *param_1 = 0;
  *(undefined8 *)(param_1 + 2) = 0;
  *(undefined8 *)(param_1 + 4) = 0;
  local_88 = (longlong *)param_1;
  local_80 = param_1;
  lVar4 = FUN_181387aac(0x38);
  *(longlong *)lVar4 = lVar4;
  *(longlong *)(lVar4 + 8) = lVar4;
  *(longlong *)(param_1 + 2) = lVar4;
  *(undefined8 *)(param_1 + 6) = 0;
  *(undefined8 *)(param_1 + 8) = 0;
  *(undefined8 *)(param_1 + 10) = 0;
  *(undefined8 *)(param_1 + 0xc) = 7;
  *(undefined8 *)(param_1 + 0xe) = 8;
  *param_1 = 0x3f800000;
  FUN_1801e00e0(param_1 + 6,0x10,*(undefined8 *)(param_1 + 2));
  local_78 = 0;
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
    plVar5 = local_88;
  }
  local_68 = plVar5;
  plStack_60 = plVar5;
  cVar3 = FUN_180077760("sa_scripts\\GameplaySettings.txt",&local_78);
  plVar5 = plStack_60;
  if (cVar3 == '\0') {
    if (plStack_60 == (longlong *)0x0) goto LAB_1801df338;
    pvVar2 = (void *)*plStack_60;
    while ((pvVar2 != (void *)0x0 && (pvVar2 != (void *)plVar5[2]))) {
      pvVar1 = *(void **)((longlong)pvVar2 + 0x10);
      free(pvVar2);
      *plVar5 = (longlong)pvVar1;
      pvVar2 = pvVar1;
    }
  }
  else {
    FUN_1801df810(param_1,&local_78);
    plVar5 = plStack_60;
    if (plStack_60 == (longlong *)0x0) goto LAB_1801df338;
    pvVar2 = (void *)*plStack_60;
    while ((pvVar2 != (void *)0x0 && (pvVar2 != (void *)plVar5[2]))) {
      pvVar1 = *(void **)((longlong)pvVar2 + 0x10);
      free(pvVar2);
      *plVar5 = (longlong)pvVar1;
      pvVar2 = pvVar1;
    }
  }
  lVar4 = *plVar5;
  if ((lVar4 != 0) && (lVar4 == plVar5[2])) {
    *(undefined8 *)(lVar4 + 8) = 0;
  }
  free((void *)plVar5[4]);
  free(plVar5);
LAB_1801df338:
  free(local_48);
  free(pvStack_50);
  return param_1;
}

