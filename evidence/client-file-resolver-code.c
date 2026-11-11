
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

int FUN_1400bdc40(undefined8 param_1,longlong param_2,int param_3,undefined1 *param_4)

{
  int iVar1;
  longlong lVar2;
  longlong lVar3;
  undefined1 auStack_498 [32];
  undefined4 local_478 [2];
  undefined8 local_470;
  undefined2 local_468;
  undefined1 local_466;
  char acStack_459 [529];
  undefined1 local_248 [528];
  ulonglong local_38;
  
  local_38 = DAT_1403eef38 ^ (ulonglong)auStack_498;
  *param_4 = 0;
  local_468 = 0xffff;
  local_466 = 0;
  local_478[0] = 0;
  local_470 = param_1;
  lVar2 = (**(code **)(*DAT_140406198 + 0x48))(DAT_140406198,local_478,5);
  if ((lVar2 == 0) || (iVar1 = FUN_1400b39c0(*(undefined8 *)(lVar2 + 0x20)), iVar1 != 1)) {
    FUN_1402b8fb3(acStack_459 + 1,0,0x208);
    FUN_1402b8fb3(local_248,0,0x208);
    (*(code *)0x3d5806)(0x208,acStack_459 + 1);
    lVar2 = -1;
    do {
      lVar3 = lVar2;
      lVar2 = lVar3 + 1;
    } while (acStack_459[lVar3 + 2] != '\0');
    if ((acStack_459[lVar3 + 1] != '\\') && (acStack_459[lVar3 + 1] != '/')) {
      (*(code *)0x3d7940)(acStack_459 + 1,0x208,&DAT_140301900);
    }
    (*(code *)0x3d7940)(acStack_459 + 1,0x208,param_1);
    (*(code *)0x3d7940)(local_248,0x208,"game_file\\");
    (*(code *)0x3d7940)(local_248,0x208,param_1);
    iVar1 = (**(code **)(*DAT_140406198 + 0x68))(DAT_140406198,local_248,acStack_459 + 1);
    if (iVar1 != 0) {
      FUN_1400bfea0("[MD5] CopyFile_1");
      return iVar1;
    }
    *param_4 = 1;
    if (param_3 != 0) {
      (*(code *)0x3d7794)(param_2,acStack_459 + 1,(longlong)param_3 + -1);
      *(undefined1 *)(param_2 + -1 + (longlong)param_3) = 0;
    }
    FUN_1400bfea0("[MD5] CopyFile_2");
  }
  else {
    FUN_1400bfea0("[MD5] GetTree");
    FUN_1400b37d0(*(undefined8 *)(lVar2 + 0x20),param_1,param_2,param_3);
  }
  return 0;
}

