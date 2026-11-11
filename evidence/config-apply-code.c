
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

void FUN_140093d10(undefined8 param_1,undefined4 param_2)

{
  int iVar1;
  char *pcVar2;
  uint uVar3;
  undefined1 auStack_248 [32];
  undefined8 local_228;
  undefined1 local_218 [512];
  ulonglong local_18;
  
  local_18 = DAT_1403eef38 ^ (ulonglong)auStack_248;
  iVar1 = (**(code **)(*DAT_1403fe670 + 0x10))();
  if (iVar1 != 0) {
    uVar3 = 0;
    if (iVar1 != 1) {
      do {
        pcVar2 = (char *)(**(code **)(*DAT_1403fe670 + 0x18))(DAT_1403fe670,uVar3);
        if (*pcVar2 == '+') {
          local_228 = (**(code **)(*DAT_1403fe670 + 0x18))(DAT_1403fe670,uVar3 + 1);
          FUN_1400780f0(local_218,0x200,"(%s) (%s)",pcVar2 + 1);
          FUN_1400a4510(&DAT_140404dc0,local_218,param_2);
        }
        uVar3 = uVar3 + 1;
      } while (uVar3 < iVar1 - 1U);
    }
    FUN_1400780f0(local_218,0x200,"(windowed) (%d)",DAT_1404104f8);
    FUN_1400a4510(&DAT_140404dc0,local_218,param_2);
  }
  return;
}

