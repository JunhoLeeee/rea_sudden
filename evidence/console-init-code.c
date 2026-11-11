
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined8 FUN_140090bf0(longlong param_1,longlong param_2,short param_3)

{
  undefined8 *puVar1;
  undefined2 uVar2;
  int iVar3;
  undefined4 uVar4;
  int iVar5;
  longlong lVar6;
  short sVar7;
  undefined1 auStack_218 [32];
  undefined4 local_1f8;
  undefined4 local_1e8;
  undefined4 local_1e4;
  undefined4 local_1e0 [2];
  undefined1 local_1d8 [416];
  ulonglong local_38;
  
  local_38 = DAT_1403eef38 ^ (ulonglong)auStack_218;
  iVar3 = FUN_14018fc98(0x101,local_1d8);
  if (iVar3 == 0) {
    puVar1 = (undefined8 *)(param_1 + 0xb74);
    *(undefined1 *)(param_1 + 0xb70) = 1;
    *puVar1 = 0;
    *(undefined8 *)(param_1 + 0xb7c) = 0;
    sVar7 = 0x6cf0;
    if (param_3 == 0) {
      param_3 = 0x6cf0;
    }
    *(undefined2 *)puVar1 = 2;
    uVar2 = FUN_14018fcc2(param_3);
    *(undefined2 *)(param_1 + 0xb76) = uVar2;
    if (param_2 == 0) {
      uVar4 = 0;
    }
    else {
      uVar4 = FUN_14018fcc8(param_2);
    }
    *(undefined4 *)(param_1 + 0xb78) = uVar4;
    local_1e8 = 1;
    lVar6 = FUN_14018fcd4(2,2,0x11);
    if (lVar6 == -1) {
      FUN_1400bfea0("ERROR cm_BindToPort - socket()");
    }
    else {
      iVar3 = FUN_14018fcb6(lVar6,0x8004667e,&local_1e8);
      if (iVar3 == 0) {
        local_1e4 = 0;
        local_1f8 = 4;
        iVar3 = FUN_14018fcce(lVar6,0xffff,4,&local_1e4);
        if (iVar3 == 0) {
          while( true ) {
            uVar2 = FUN_14018fcc2(sVar7);
            *(undefined2 *)(param_1 + 0xb76) = uVar2;
            iVar3 = FUN_14018fcaa(lVar6,puVar1,0x10);
            if (iVar3 == 0) {
              if (puVar1 != (undefined8 *)0x0) {
                local_1e0[0] = 0x10;
                FUN_14018fcbc(lVar6,puVar1,local_1e0);
              }
              *(longlong *)(param_1 + 0xb68) = lVar6;
              return 1;
            }
            iVar5 = FUN_14018fcda();
            if (iVar5 != 0x2740) break;
            sVar7 = sVar7 + 1;
          }
          FUN_1400bfea0("ERROR cm_BindToPort - bind() %d",iVar3);
          FUN_14018fcb0(lVar6);
        }
        else {
          FUN_1400bfea0("ERROR cm_BindToPort - setsockopt() %d",iVar3);
          FUN_14018fcb0(lVar6);
        }
      }
      else {
        FUN_1400bfea0("ERROR cm_BindToPort - ioctlsocket() %d",iVar3);
        FUN_14018fcb0(lVar6);
      }
    }
    *(undefined8 *)(param_1 + 0xb68) = 0xffffffffffffffff;
  }
  return 0;
}

