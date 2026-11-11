
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined8 * FUN_14029c4c0(undefined8 *param_1,undefined8 *param_2,undefined8 *param_3)

{
  longlong lVar1;
  int *piVar2;
  longlong *plVar3;
  int iVar4;
  undefined4 uVar5;
  undefined8 *puVar6;
  undefined8 *puVar7;
  undefined8 *puVar8;
  longlong *plVar9;
  bool bVar10;
  undefined1 auStack_308 [32];
  undefined4 local_2e8;
  undefined4 local_2e0;
  undefined4 local_2d8;
  undefined4 local_2c8;
  undefined8 local_2b8;
  longlong *plStack_2b0;
  undefined8 *local_2a8;
  undefined ***local_2a0;
  undefined8 *local_298;
  undefined ***local_290;
  longlong *plStack_288;
  undefined8 *local_280;
  undefined8 local_278;
  longlong *plStack_270;
  undefined8 *local_268;
  undefined **local_260;
  undefined1 local_258 [184];
  int local_1a0;
  undefined **local_198;
  undefined1 local_190 [184];
  int local_d8;
  undefined1 local_c8 [128];
  ulonglong local_48;
  
  local_48 = DAT_1403eef38 ^ (ulonglong)auStack_308;
  puVar7 = (undefined8 *)0x0;
  local_2c8 = 0;
  lVar1 = param_2[1] + 0x30;
  local_268 = param_1;
  if ((*(byte *)(param_2[1] + 4) & 0x20) == 0) {
    bVar10 = *(char *)param_2[2] != '\0';
    if (!bVar10) {
      FUN_1402a83f0(*param_2,lVar1,local_c8);
      goto LAB_14029c553;
    }
    if (!bVar10) {
      if (bVar10 != true) goto LAB_14029c553;
      goto LAB_14029c536;
    }
    uVar5 = *(undefined4 *)param_2[3];
  }
  else {
LAB_14029c536:
    uVar5 = FUN_1402a8630(*param_2);
  }
  FUN_1402a84a0(*param_2,lVar1,uVar5,local_c8);
LAB_14029c553:
  puVar6 = operator_new(0x58);
  puVar8 = puVar7;
  if (puVar6 != (undefined8 *)0x0) {
    local_2a0 = &local_260;
    iVar4 = *(int *)param_2[6];
    local_260 = Lambda::SnowCipher::vftable;
    local_2d8 = 0;
    local_2e0 = 0;
    local_2e8 = 0;
    local_2a8 = puVar6;
    FUN_1402abee0(local_258,local_c8,0x80,0);
    local_1a0 = (int)(iVar4 + (iVar4 >> 0x1f & 3U)) >> 2;
    FUN_1402ace20(local_258,local_1a0);
    local_290 = &local_260;
    plStack_2b0 = (longlong *)0x0;
    if (param_3[1] != 0) {
      LOCK();
      piVar2 = (int *)(param_3[1] + 8);
      *piVar2 = *piVar2 + 1;
      UNLOCK();
      plStack_2b0 = (longlong *)param_3[1];
    }
    local_2b8 = *param_3;
    local_298 = &local_2b8;
    local_2a0 = &local_198;
    local_280 = &local_278;
    local_198 = Lambda::SnowCipher::vftable;
    FUN_1402abc00(local_190,local_258);
    local_d8 = local_1a0;
    if (plStack_2b0 != (longlong *)0x0) {
      LOCK();
      *(int *)(plStack_2b0 + 1) = (int)plStack_2b0[1] + 1;
      UNLOCK();
    }
    local_278 = local_2b8;
    plStack_270 = plStack_2b0;
    FUN_14029aba0(puVar6,&local_278,&local_198,0x400);
    plVar9 = plStack_2b0;
    *puVar6 = Lambda::CipherHeaderStream<Lambda::SnowCipher>::vftable;
    if (plStack_2b0 != (longlong *)0x0) {
      LOCK();
      plVar3 = plStack_2b0 + 1;
      lVar1 = *plVar3;
      *(int *)plVar3 = (int)*plVar3 + -1;
      UNLOCK();
      if ((int)lVar1 == 1) {
        (**(code **)*plStack_2b0)(plStack_2b0);
        LOCK();
        piVar2 = (int *)((longlong)plVar9 + 0xc);
        iVar4 = *piVar2;
        *piVar2 = *piVar2 + -1;
        UNLOCK();
        if (iVar4 == 1) {
          (**(code **)(*plVar9 + 8))(plVar9);
        }
      }
    }
    local_260 = Lambda::SnowCipher::vftable;
    FUN_1402acd10(local_258);
    local_260 = Lambda::ICipher::vftable;
    puVar8 = puVar6;
  }
  *param_1 = 0;
  param_1[1] = 0;
  local_2a8 = puVar8;
  local_280 = operator_new(0x18);
  if (local_280 != (undefined8 *)0x0) {
    *local_280 = 0;
    local_280[1] = 0;
    *(undefined4 *)(local_280 + 1) = 1;
    *(undefined4 *)((longlong)local_280 + 0xc) = 1;
    *local_280 = std::_Ref_count<Lambda::CipherHeaderStream<Lambda::SnowCipher>_>::vftable;
    local_280[2] = puVar8;
    puVar7 = local_280;
  }
  *param_1 = puVar8;
  param_1[1] = puVar7;
  local_2a8 = (undefined8 *)0x0;
  local_290 = (undefined ***)*param_1;
  plVar9 = (longlong *)0x0;
  if (param_1[1] != 0) {
    LOCK();
    piVar2 = (int *)(param_1[1] + 8);
    *piVar2 = *piVar2 + 1;
    UNLOCK();
    plVar9 = (longlong *)param_1[1];
  }
  local_2c8 = 3;
  plStack_288 = plVar9;
  FUN_14029d9d0(local_290,*(undefined4 *)param_2[4]);
  local_2c8 = 1;
  if (plVar9 != (longlong *)0x0) {
    LOCK();
    plVar3 = plVar9 + 1;
    lVar1 = *plVar3;
    *(int *)plVar3 = (int)*plVar3 + -1;
    UNLOCK();
    if ((int)lVar1 == 1) {
      (**(code **)*plVar9)(plVar9);
      LOCK();
      piVar2 = (int *)((longlong)plVar9 + 0xc);
      iVar4 = *piVar2;
      *piVar2 = *piVar2 + -1;
      UNLOCK();
      if (iVar4 == 1) {
        (**(code **)(*plVar9 + 8))(plVar9);
      }
    }
  }
  return param_1;
}

