
void FUN_1806df270(longlong param_1,char param_2)

{
  char cVar1;
  int iVar2;
  uint uVar3;
  longlong *plVar4;
  
  cVar1 = FUN_1806db1c0();
  if (cVar1 != '\0') {
    plVar4 = (longlong *)(param_1 + 0x768);
    iVar2 = (**(code **)(*plVar4 + 0x1d0))(plVar4);
    if (iVar2 == 0) {
      *(undefined4 *)(param_1 + 0x132c) = 0;
    }
    else if (*(float *)(param_1 + 0x1320) < *(float *)(param_1 + 0x132c)) {
      *(float *)(param_1 + 0x132c) = *(float *)(param_1 + 0x1320);
    }
    uVar3 = *(uint *)(param_1 + 0x1314);
    *(uint *)(param_1 + 0x1330) = uVar3;
    if (param_2 != '\0') {
      uVar3 = *(uint *)(param_1 + 0x1318);
      *(uint *)(param_1 + 0x1330) = uVar3;
    }
    *(uint *)(param_1 + 0x1334) = uVar3 >> 0x18;
    if (uVar3 != 0) {
      for (; plVar4 != (longlong *)(param_1 + 0x1308); plVar4 = plVar4 + 0x5d) {
        FUN_180b41250(plVar4,*(undefined4 *)(param_1 + 0x1330));
        (**(code **)(*plVar4 + 0x198))(plVar4,1);
      }
    }
  }
  return;
}

