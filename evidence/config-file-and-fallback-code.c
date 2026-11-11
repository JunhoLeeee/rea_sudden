
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined8
FUN_1400a4af0(undefined8 param_1,undefined8 param_2,undefined4 param_3,undefined4 param_4)

{
  int iVar1;
  longlong lVar2;
  longlong lVar3;
  uint uVar4;
  undefined8 *puVar5;
  undefined1 auStack_248 [32];
  undefined1 local_228 [512];
  ulonglong local_28;
  
  local_28 = DAT_1403eef38 ^ (ulonglong)auStack_248;
  iVar1 = FUN_1402b9199(param_2,"autoexec.cfg");
  if (iVar1 == 0) {
    uVar4 = 0;
    puVar5 = &DAT_1403dbed0;
    do {
      FUN_1400a4520(param_1,*puVar5,param_3,param_4);
      uVar4 = uVar4 + 1;
      puVar5 = puVar5 + 1;
    } while (uVar4 < 0x164);
  }
  else {
    lVar2 = (*(code *)0x3d7704)(param_2,&DAT_140303470);
    if (lVar2 == 0) {
      return 0;
    }
    lVar3 = (*(code *)0x3d79b8)(local_228,500,lVar2);
    while (lVar3 != 0) {
      FUN_1400a4520(param_1,local_228,param_3,param_4);
      lVar3 = (*(code *)0x3d79b8)(local_228,500,lVar2);
    }
    (*(code *)0x3d76ea)(lVar2);
  }
  return 1;
}

