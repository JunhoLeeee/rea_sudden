
undefined8 *
FUN_14029ca20(undefined8 *param_1,undefined8 *param_2,longlong param_3,undefined8 param_4)

{
  int *piVar1;
  longlong *plVar2;
  int iVar3;
  undefined8 uVar4;
  undefined8 uVar5;
  longlong *plVar6;
  longlong lVar7;
  undefined8 *puVar8;
  void *pvVar9;
  undefined8 *puVar10;
  undefined8 *puVar11;
  longlong *plVar12;
  longlong lVar13;
  undefined8 local_d0;
  undefined8 uStack_c8;
  undefined8 local_c0;
  longlong *plStack_b8;
  undefined8 local_b0;
  undefined8 uStack_a8;
  undefined8 *local_a0;
  undefined1 local_98 [8];
  longlong *local_90;
  undefined1 local_88 [8];
  longlong *local_80;
  undefined1 local_78 [8];
  longlong *local_70;
  undefined1 local_68 [8];
  longlong *local_60;
  undefined1 local_58 [8];
  longlong *local_50;
  
  puVar11 = (undefined8 *)0x0;
  *param_1 = 0;
  param_1[1] = 0;
  if (param_2[1] != 0) {
    LOCK();
    piVar1 = (int *)(param_2[1] + 8);
    *piVar1 = *piVar1 + 1;
    UNLOCK();
  }
  *param_1 = *param_2;
  param_1[1] = param_2[1];
  if ((*(byte *)(*(longlong *)(param_3 + 8) + 4) & 4) != 0) {
    puVar8 = (undefined8 *)FUN_14029c4c0(local_98,param_3,param_1,param_4,1);
    uVar4 = *puVar8;
    uVar5 = puVar8[1];
    *puVar8 = 0;
    puVar8[1] = 0;
    *param_1 = uVar4;
    plVar6 = (longlong *)param_1[1];
    param_1[1] = uVar5;
    if (plVar6 != (longlong *)0x0) {
      LOCK();
      plVar12 = plVar6 + 1;
      lVar7 = *plVar12;
      *(int *)plVar12 = (int)*plVar12 + -1;
      UNLOCK();
      if ((int)lVar7 == 1) {
        (**(code **)*plVar6)(plVar6);
        LOCK();
        piVar1 = (int *)((longlong)plVar6 + 0xc);
        iVar3 = *piVar1;
        *piVar1 = *piVar1 + -1;
        UNLOCK();
        if (iVar3 == 1) {
          (**(code **)(*plVar6 + 8))(plVar6);
        }
      }
    }
    if (local_90 != (longlong *)0x0) {
      LOCK();
      plVar6 = local_90 + 1;
      lVar7 = *plVar6;
      *(int *)plVar6 = (int)*plVar6 + -1;
      UNLOCK();
      if ((int)lVar7 == 1) {
        (**(code **)*local_90)(local_90);
        LOCK();
        piVar1 = (int *)((longlong)local_90 + 0xc);
        iVar3 = *piVar1;
        *piVar1 = *piVar1 + -1;
        UNLOCK();
        if (iVar3 == 1) {
          (**(code **)(*local_90 + 8))(local_90);
        }
      }
    }
  }
  lVar7 = *(longlong *)(param_3 + 8);
  lVar13 = *(longlong *)(lVar7 + 0x20) - *(longlong *)(lVar7 + 0x18) >> 4;
  if ((*(byte *)(lVar7 + 4) & 2) != 0) {
    if (lVar13 == 0) {
      puVar8 = (undefined8 *)FUN_14029c2a0(local_78,param_3,param_1);
      uVar4 = *puVar8;
      uVar5 = puVar8[1];
      *puVar8 = 0;
      puVar8[1] = 0;
      *param_1 = uVar4;
      plVar6 = (longlong *)param_1[1];
      param_1[1] = uVar5;
      plVar12 = local_70;
      if (plVar6 != (longlong *)0x0) {
        LOCK();
        plVar2 = plVar6 + 1;
        lVar7 = *plVar2;
        *(int *)plVar2 = (int)*plVar2 + -1;
        UNLOCK();
        if ((int)lVar7 == 1) {
          (**(code **)*plVar6)(plVar6);
          LOCK();
          piVar1 = (int *)((longlong)plVar6 + 0xc);
          iVar3 = *piVar1;
          *piVar1 = *piVar1 + -1;
          UNLOCK();
          plVar12 = local_70;
          if (iVar3 == 1) {
            (**(code **)(*plVar6 + 8))(plVar6);
            plVar12 = local_70;
          }
        }
      }
    }
    else {
      puVar8 = (undefined8 *)FUN_14029bf30(local_88);
      uVar4 = *puVar8;
      uVar5 = puVar8[1];
      *puVar8 = 0;
      puVar8[1] = 0;
      *param_1 = uVar4;
      plVar6 = (longlong *)param_1[1];
      param_1[1] = uVar5;
      plVar12 = local_80;
      if (plVar6 != (longlong *)0x0) {
        LOCK();
        plVar2 = plVar6 + 1;
        lVar7 = *plVar2;
        *(int *)plVar2 = (int)*plVar2 + -1;
        UNLOCK();
        if ((int)lVar7 == 1) {
          (**(code **)*plVar6)(plVar6);
          LOCK();
          piVar1 = (int *)((longlong)plVar6 + 0xc);
          iVar3 = *piVar1;
          *piVar1 = *piVar1 + -1;
          UNLOCK();
          plVar12 = local_80;
          if (iVar3 == 1) {
            (**(code **)(*plVar6 + 8))(plVar6);
            plVar12 = local_80;
          }
        }
      }
    }
    if (plVar12 != (longlong *)0x0) {
      LOCK();
      plVar6 = plVar12 + 1;
      lVar7 = *plVar6;
      *(int *)plVar6 = (int)*plVar6 + -1;
      UNLOCK();
      if ((int)lVar7 == 1) {
        (**(code **)*plVar12)(plVar12);
        LOCK();
        piVar1 = (int *)((longlong)plVar12 + 0xc);
        iVar3 = *piVar1;
        *piVar1 = *piVar1 + -1;
        UNLOCK();
        if (iVar3 == 1) {
          (**(code **)(*plVar12 + 8))(plVar12);
        }
      }
    }
  }
  if ((*(byte *)(*(longlong *)(param_3 + 8) + 4) & 0x20) != 0) {
    if (lVar13 == 0) {
      puVar8 = (undefined8 *)FUN_14029c2a0(local_58,param_3,param_1);
      uVar4 = *puVar8;
      uVar5 = puVar8[1];
      *puVar8 = 0;
      puVar8[1] = 0;
      *param_1 = uVar4;
      plVar6 = (longlong *)param_1[1];
      param_1[1] = uVar5;
      plVar12 = local_50;
      if (plVar6 != (longlong *)0x0) {
        LOCK();
        plVar2 = plVar6 + 1;
        lVar7 = *plVar2;
        *(int *)plVar2 = (int)*plVar2 + -1;
        UNLOCK();
        if ((int)lVar7 == 1) {
          (**(code **)*plVar6)(plVar6);
          LOCK();
          piVar1 = (int *)((longlong)plVar6 + 0xc);
          iVar3 = *piVar1;
          *piVar1 = *piVar1 + -1;
          UNLOCK();
          plVar12 = local_50;
          if (iVar3 == 1) {
            (**(code **)(*plVar6 + 8))(plVar6);
            plVar12 = local_50;
          }
        }
      }
    }
    else {
      puVar8 = (undefined8 *)FUN_14029bf30(local_68);
      uVar4 = *puVar8;
      uVar5 = puVar8[1];
      *puVar8 = 0;
      puVar8[1] = 0;
      *param_1 = uVar4;
      plVar6 = (longlong *)param_1[1];
      param_1[1] = uVar5;
      plVar12 = local_60;
      if (plVar6 != (longlong *)0x0) {
        LOCK();
        plVar2 = plVar6 + 1;
        lVar7 = *plVar2;
        *(int *)plVar2 = (int)*plVar2 + -1;
        UNLOCK();
        if ((int)lVar7 == 1) {
          (**(code **)*plVar6)(plVar6);
          LOCK();
          piVar1 = (int *)((longlong)plVar6 + 0xc);
          iVar3 = *piVar1;
          *piVar1 = *piVar1 + -1;
          UNLOCK();
          plVar12 = local_60;
          if (iVar3 == 1) {
            (**(code **)(*plVar6 + 8))(plVar6);
            plVar12 = local_60;
          }
        }
      }
    }
    if (plVar12 != (longlong *)0x0) {
      LOCK();
      plVar6 = plVar12 + 1;
      lVar7 = *plVar6;
      *(int *)plVar6 = (int)*plVar6 + -1;
      UNLOCK();
      if ((int)lVar7 == 1) {
        (**(code **)*plVar12)(plVar12);
        LOCK();
        piVar1 = (int *)((longlong)plVar12 + 0xc);
        iVar3 = *piVar1;
        *piVar1 = *piVar1 + -1;
        UNLOCK();
        if (iVar3 == 1) {
          (**(code **)(*plVar12 + 8))(plVar12);
        }
      }
    }
  }
  if ((*(byte *)(*(longlong *)(param_3 + 8) + 4) & 1) != 0) {
    pvVar9 = operator_new(0xb8);
    puVar8 = puVar11;
    if (pvVar9 != (void *)0x0) {
      local_a0 = &local_d0;
      uStack_c8 = 0;
      if (param_1[1] != 0) {
        LOCK();
        piVar1 = (int *)(param_1[1] + 8);
        *piVar1 = *piVar1 + 1;
        UNLOCK();
        uStack_c8 = param_1[1];
      }
      local_d0 = *param_1;
      puVar8 = (undefined8 *)FUN_1402a56f0(pvVar9,&local_d0);
    }
    local_b0 = 0;
    uStack_a8 = 0;
    puVar10 = operator_new(0x18);
    if (puVar10 != (undefined8 *)0x0) {
      *puVar10 = 0;
      puVar10[1] = 0;
      *(undefined4 *)(puVar10 + 1) = 1;
      *(undefined4 *)((longlong)puVar10 + 0xc) = 1;
      *puVar10 = std::_Ref_count<Lambda::ZlibStream>::vftable;
      puVar10[2] = puVar8;
      puVar11 = puVar10;
    }
    *(undefined4 *)(puVar8 + 0x14) = *(undefined4 *)(*(longlong *)(param_3 + 8) + 0xc);
    local_b0 = 0;
    uStack_a8 = 0;
    local_c0 = *param_1;
    *param_1 = puVar8;
    plVar6 = (longlong *)param_1[1];
    param_1[1] = puVar11;
    plStack_b8 = plVar6;
    if (plVar6 != (longlong *)0x0) {
      LOCK();
      plVar12 = plVar6 + 1;
      lVar7 = *plVar12;
      *(int *)plVar12 = (int)*plVar12 + -1;
      UNLOCK();
      if ((int)lVar7 == 1) {
        (**(code **)*plVar6)(plVar6);
        LOCK();
        piVar1 = (int *)((longlong)plVar6 + 0xc);
        iVar3 = *piVar1;
        *piVar1 = *piVar1 + -1;
        UNLOCK();
        if (iVar3 == 1) {
          (**(code **)(*plVar6 + 8))(plVar6);
        }
      }
    }
  }
  plVar6 = (longlong *)param_2[1];
  if (plVar6 != (longlong *)0x0) {
    LOCK();
    plVar12 = plVar6 + 1;
    lVar7 = *plVar12;
    *(int *)plVar12 = (int)*plVar12 + -1;
    UNLOCK();
    if ((int)lVar7 == 1) {
      (**(code **)*plVar6)(plVar6);
      LOCK();
      piVar1 = (int *)((longlong)plVar6 + 0xc);
      iVar3 = *piVar1;
      *piVar1 = *piVar1 + -1;
      UNLOCK();
      if (iVar3 == 1) {
        (**(code **)(*plVar6 + 8))(plVar6);
      }
    }
  }
  return param_1;
}

