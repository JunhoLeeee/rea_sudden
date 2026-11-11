
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined8 FUN_140073ea0(undefined1 *param_1,char param_2,undefined8 *param_3)

{
  undefined4 uVar1;
  longlong lVar2;
  longlong lVar3;
  code *pcVar4;
  undefined8 uVar5;
  longlong *plVar6;
  undefined1 *puVar7;
  undefined1 auStack_158 [32];
  undefined1 local_138 [256];
  ulonglong local_38;
  
  local_38 = DAT_1403eef38 ^ (ulonglong)auStack_158;
  lVar2 = (*(code *)0x3d57a2)();
  FUN_1400bfea0("[MD5] pModuleName(%s) bModuleAlreadyLoaded(%d)",param_1,lVar2 != 0);
  lVar3 = (*(code *)0x3d57c8)(param_1);
  if (lVar3 == 0) {
    uVar1 = (*(code *)0x3d5664)();
    FUN_1402b8fb3(local_138,0,0x100);
    FUN_1400741c0(local_138,"ERROR(%d) FailLoadLibrary = %s",uVar1,param_1);
    FUN_1400bfea0(local_138);
    uVar5 = 0;
  }
  else {
    if (lVar2 == 0) {
      pcVar4 = (code *)(*(code *)0x3d57b6)(lVar3,"SetMasterDatabase");
      if (pcVar4 != (code *)0x0) {
        FUN_1400bfea0("[MD5] MasterFn");
        uVar5 = FUN_1400e3330();
        (*pcVar4)(uVar5);
      }
    }
    FUN_1400bfea0("[MD5] Bind");
    plVar6 = operator_new(0x30);
    if (plVar6 == (longlong *)0x0) {
      plVar6 = (longlong *)0x0;
    }
    else {
      plVar6[2] = 0;
      plVar6[4] = 0;
      plVar6[5] = 0xf;
    }
    *plVar6 = lVar3;
    *(undefined4 *)(plVar6 + 1) = 1;
    puVar7 = &DAT_14035494d;
    if (param_2 != '\0') {
      puVar7 = param_1;
    }
    lVar2 = -1;
    do {
      lVar2 = lVar2 + 1;
    } while (puVar7[lVar2] != '\0');
    FUN_14002fc20(plVar6 + 2);
    *param_3 = plVar6;
    FUN_1400bfea0("[MD5] ModuleType");
    uVar5 = 0xffffffff;
  }
  return uVar5;
}

