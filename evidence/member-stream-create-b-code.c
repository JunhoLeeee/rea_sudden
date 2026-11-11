
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined8 * FUN_14029c2a0(undefined8 *param_1,undefined8 *param_2,undefined8 *param_3)

{
  longlong lVar1;
  int *piVar2;
  longlong *plVar3;
  int iVar4;
  undefined4 uVar5;
  void *pvVar6;
  undefined8 uVar7;
  longlong *plVar8;
  bool bVar9;
  undefined1 auStack_218 [32];
  undefined4 local_1f8;
  undefined4 local_1f0;
  undefined4 local_1e8;
  undefined4 local_1d8;
  undefined8 local_1d0;
  undefined8 uStack_1c8;
  undefined8 *local_1c0;
  longlong *plStack_1b8;
  undefined8 *local_1b0;
  void *local_1a8;
  undefined ***local_1a0;
  undefined **local_198;
  undefined1 local_190 [184];
  int local_d8;
  undefined1 local_c8 [128];
  ulonglong local_48;
  
  local_48 = DAT_1403eef38 ^ (ulonglong)auStack_218;
  uVar7 = 0;
  local_1d8 = 0;
  lVar1 = param_2[1] + 0x30;
  local_1b0 = param_1;
  if ((*(byte *)(param_2[1] + 4) & 0x20) == 0) {
    bVar9 = *(char *)param_2[2] != '\0';
    if (!bVar9) {
      FUN_1402a83f0(*param_2,lVar1,local_c8);
      goto LAB_14029c329;
    }
    if (!bVar9) {
      if (bVar9 != true) goto LAB_14029c329;
      goto LAB_14029c30f;
    }
    uVar5 = *(undefined4 *)param_2[3];
  }
  else {
LAB_14029c30f:
    uVar5 = FUN_1402a8630(*param_2);
  }
  FUN_1402a84a0(*param_2,lVar1,uVar5,local_c8);
LAB_14029c329:
  pvVar6 = operator_new(0x58);
  local_1a8 = pvVar6;
  if (pvVar6 != (void *)0x0) {
    local_1a0 = &local_198;
    local_1c0 = &local_1d0;
    iVar4 = *(int *)param_2[6];
    local_198 = Lambda::SnowCipher::vftable;
    local_1e8 = 0;
    local_1f0 = 0;
    local_1f8 = 0;
    FUN_1402abee0(local_190,local_c8,0x80,0);
    local_d8 = (int)(iVar4 + (iVar4 >> 0x1f & 3U)) >> 2;
    FUN_1402ace20(local_190,local_d8);
    uStack_1c8 = 0;
    if (param_3[1] != 0) {
      LOCK();
      piVar2 = (int *)(param_3[1] + 8);
      *piVar2 = *piVar2 + 1;
      UNLOCK();
      uStack_1c8 = param_3[1];
    }
    local_1d0 = *param_3;
    uVar7 = FUN_14029aba0(pvVar6,&local_1d0,&local_198,0);
  }
  FUN_140299bf0(param_1,uVar7);
  local_1c0 = (undefined8 *)*param_1;
  plVar8 = (longlong *)0x0;
  if (param_1[1] != 0) {
    LOCK();
    piVar2 = (int *)(param_1[1] + 8);
    *piVar2 = *piVar2 + 1;
    UNLOCK();
    plVar8 = (longlong *)param_1[1];
  }
  local_1d8 = 3;
  plStack_1b8 = plVar8;
  FUN_14029d9d0(local_1c0,*(undefined4 *)param_2[4]);
  local_1d8 = 1;
  if (plVar8 != (longlong *)0x0) {
    LOCK();
    plVar3 = plVar8 + 1;
    lVar1 = *plVar3;
    *(int *)plVar3 = (int)*plVar3 + -1;
    UNLOCK();
    if ((int)lVar1 == 1) {
      (**(code **)*plVar8)(plVar8);
      LOCK();
      piVar2 = (int *)((longlong)plVar8 + 0xc);
      iVar4 = *piVar2;
      *piVar2 = *piVar2 + -1;
      UNLOCK();
      if (iVar4 == 1) {
        (**(code **)(*plVar8 + 8))(plVar8);
      }
    }
  }
  return param_1;
}

