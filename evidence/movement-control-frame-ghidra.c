
void FUN_180ef9f70(longlong param_1)

{
  bool bVar1;
  char cVar2;
  int iVar3;
  undefined4 uVar4;
  longlong lVar5;
  undefined8 uVar6;
  undefined8 uVar7;
  
  *(undefined4 *)(param_1 + 0xe4) = *(undefined4 *)(param_1 + 0x8c);
  *(undefined4 *)(param_1 + 0x8c) = 0;
  if (*(longlong *)(param_1 + 0x20) != 0) {
    bVar1 = false;
    if (((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x41) && (cVar2 = FUN_180f07640(), cVar2 == '\x01'))
       && (cVar2 = FUN_180f09050(), bVar1 = false, cVar2 == '\x01')) {
      bVar1 = true;
    }
    iVar3 = FUN_180d1d790(DAT_181a19c68);
    if (((iVar3 != 0) && (*(int *)(DAT_181a08d38 + 0xe9e0) != 0x2f)) || (bVar1)) {
      cVar2 = FUN_180d19f30(DAT_181a19c68);
      if (cVar2 == '\x03') {
        FUN_180efa3f0(param_1);
        *(uint *)(param_1 + 0x8c) =
             *(uint *)(param_1 + 0x8c) | *(uint *)(*(longlong *)(DAT_181a19c68 + 0x458) + 4);
      }
      else {
        *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x40);
        if ((*(uint *)(param_1 + 0x40) & 0x10) != 0) {
          *(undefined4 *)(param_1 + 0x46c) = 1;
        }
      }
      uVar4 = FUN_180d454b0(*(undefined8 *)(DAT_181a19c68 + 0x430));
      lVar5 = FUN_180c64490(DAT_181a0e3a0,uVar4);
      if (lVar5 != 0) {
        iVar3 = FUN_180c59050(lVar5,0,0);
        if ((((iVar3 == 2) || (iVar3 = FUN_180c59050(lVar5,0,0), iVar3 == 0xe)) ||
            (iVar3 = FUN_180c59050(lVar5,0,0), iVar3 == 0x11)) &&
           (((*(int *)(param_1 + 0xf0) != 0 && ((*(uint *)(param_1 + 0xe4) & 0x400) != 0)) &&
            (cVar2 = (**(code **)(DAT_181952a40 + 0x3c0))(8), cVar2 != '\0')))) {
          *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x400;
        }
        iVar3 = FUN_180c59050(lVar5,0,0);
        if (((iVar3 == 0xe) && (iVar3 = FUN_180c59050(lVar5,0,0), iVar3 == 0x11)) &&
           ((*(int *)(param_1 + 0xf0) != 0 &&
            (((*(uint *)(param_1 + 0xe4) & 0x1000) != 0 &&
             (cVar2 = (**(code **)(DAT_181952a40 + 0x3c0))(0x3d), cVar2 != '\0')))))) {
          *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x1000;
        }
        cVar2 = FUN_180c58940(lVar5,4);
        if (((cVar2 != '\0') && ((*(uint *)(param_1 + 0xe4) & 0x40000000) != 0)) &&
           (cVar2 = (**(code **)(DAT_181952a40 + 0x3c0))(0x77), cVar2 != '\0')) {
          *(uint *)(param_1 + 0x8c) = *(uint *)(param_1 + 0x8c) | 0x40000000;
          return;
        }
      }
    }
    else {
      *(undefined4 *)(param_1 + 0xf0) = 1;
      FUN_180efa3f0(param_1);
      lVar5 = DAT_181a08d38;
      if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x50) {
        uVar6 = (**(code **)(DAT_181952a40 + 0x3d8))();
        lVar5 = FUN_180ec3230(lVar5 + 0xef88,uVar6);
        if ((lVar5 != 0) && (cVar2 = FUN_180e9d200(lVar5), cVar2 != '\0')) {
          *(undefined4 *)(param_1 + 0x46c) = 0;
          *(uint *)(param_1 + 0x8c) =
               *(uint *)(param_1 + 0x8c) & 0xfdfcf400 | *(uint *)(param_1 + 0xe4) & 0x20;
        }
      }
      uVar6 = FUN_180c6f820();
      cVar2 = FUN_180c74bd0(uVar6);
      if (((cVar2 != '\0') && (*(int *)(DAT_181a08d38 + 0xe9e0) != 0x36)) &&
         (((*(uint *)(param_1 + 0x8c) & 0x810) != 0 && (DAT_181a1b3d0 != 0)))) {
        if (((*(uint *)(param_1 + 0x8c) & 0x220) == 0x200) &&
           (cVar2 = (**(code **)(DAT_181952a40 + 0x3c0))(5), cVar2 == '\0')) {
          uVar6 = (**(code **)(DAT_181952a40 + 0x3d8))();
          uVar7 = 0;
        }
        else {
          uVar6 = (**(code **)(DAT_181952a40 + 0x3d8))();
          uVar7 = 1;
        }
        FUN_18110e220(DAT_181a1b3d0,uVar6,uVar7);
      }
      *(uint *)(param_1 + 0x8c) =
           *(uint *)(param_1 + 0x8c) | *(uint *)(*(longlong *)(DAT_181a19c68 + 0x458) + 4);
    }
  }
  return;
}

