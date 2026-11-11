
void FUN_180ef9550(undefined8 *param_1)

{
  undefined8 *puVar1;
  longlong *plVar2;
  char cVar3;
  longlong lVar4;
  longlong *plVar5;
  longlong *_Memory;
  int iVar6;
  undefined8 uVar7;
  
  *(undefined4 *)(param_1 + 0x23) = 0xc4fa0000;
  puVar1 = param_1 + 5;
  *(int *)((longlong)param_1 + 0xac4) = (int)param_1;
  *param_1 = 0;
  param_1[1] = 0;
  *(undefined8 *)((longlong)param_1 + 0x8c) = 0;
  *(undefined8 *)((longlong)param_1 + 0xe4) = 0;
  *(undefined4 *)(param_1 + 8) = 0;
  param_1[6] = puVar1;
  *puVar1 = puVar1;
  param_1[0xb] = 0;
  param_1[10] = 0;
  *(undefined4 *)((longlong)param_1 + 0xec) = 0;
  *(undefined4 *)(param_1 + 0x1e) = 1;
  *(undefined8 *)((longlong)param_1 + 0x464) = 0;
  *(undefined4 *)((longlong)param_1 + 0x46c) = 0;
  *(undefined8 *)((longlong)param_1 + 0xc4) = 1;
  *(undefined4 *)((longlong)param_1 + 0xcc) = 0;
  *(undefined8 *)((longlong)param_1 + 0xd4) = 0;
  *(undefined4 *)((longlong)param_1 + 0x124) = 1;
  *(undefined4 *)((longlong)param_1 + 0x7c) = 0;
  *(undefined4 *)((longlong)param_1 + 0x11c) = 0;
  *(undefined8 *)((longlong)param_1 + 0x74) = 0xffffffffffffffff;
  *(undefined4 *)(param_1 + 0x1c) = 0;
  *(undefined4 *)((longlong)param_1 + 0x94) = 0x3f800000;
  *(undefined4 *)(param_1 + 0x21) = 0;
  *(undefined4 *)(param_1 + 0x15a) = 0;
  *(undefined4 *)(param_1 + 0x88) = 0;
  *(undefined4 *)(param_1 + 0x24) = 1;
  param_1[0x89] = 0;
  if (*(int *)(param_1 + 0xc) == 0) {
    *(undefined4 *)(param_1 + 0x8c) = 0xcb189680;
  }
  *(undefined4 *)((longlong)param_1 + 0xaf4) = 0;
  *(undefined2 *)((longlong)param_1 + 0xad4) = 0;
  param_1[0x15b] = 0;
  param_1[0x15c] = 0;
  *(undefined4 *)(param_1 + 0x15d) = 0;
  param_1[2] = 0;
  param_1[3] = 0;
  uVar7 = FUN_180c6f820();
  iVar6 = FUN_180c72040(uVar7);
  if (iVar6 == 0) {
    uVar7 = FUN_180c6f820();
    iVar6 = FUN_180c720b0(uVar7);
    if (iVar6 == 0) {
      plVar2 = param_1 + 0x167;
      lVar4 = *plVar2;
      cVar3 = *(char *)((longlong)*(longlong **)(lVar4 + 8) + 0x19);
      _Memory = *(longlong **)(lVar4 + 8);
      while (cVar3 == '\0') {
        FUN_180f037c0(plVar2,plVar2,_Memory[2]);
        plVar5 = (longlong *)*_Memory;
        free(_Memory);
        _Memory = plVar5;
        cVar3 = *(char *)((longlong)plVar5 + 0x19);
      }
      *(longlong *)(lVar4 + 8) = lVar4;
      *(longlong *)lVar4 = lVar4;
      *(longlong *)(lVar4 + 0x10) = lVar4;
      param_1[0x168] = 0;
    }
  }
  return;
}

