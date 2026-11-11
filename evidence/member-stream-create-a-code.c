
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined8 * FUN_14029bf30(undefined8 *param_1,undefined8 *param_2,undefined8 **param_3)

{
  int *piVar1;
  longlong *plVar2;
  int iVar3;
  longlong lVar4;
  code *pcVar5;
  undefined8 *puVar6;
  undefined4 uVar7;
  undefined8 uVar8;
  undefined8 *puVar9;
  ulonglong uVar10;
  longlong lVar11;
  longlong *plVar12;
  undefined1 auStack_228 [32];
  undefined4 local_208;
  undefined4 local_200;
  undefined4 local_1f8;
  undefined4 local_1e8;
  undefined8 *local_1e0;
  undefined8 *puStack_1d8;
  undefined8 *local_1d0;
  undefined8 *local_1c8;
  undefined8 *puStack_1c0;
  undefined8 **local_1b8;
  undefined8 *local_1b0;
  longlong *plStack_1a8;
  undefined8 *local_1a0;
  undefined **local_198;
  undefined1 local_190 [184];
  int local_d8;
  undefined1 local_c8 [128];
  ulonglong local_48;
  
  local_48 = DAT_1403eef38 ^ (ulonglong)auStack_228;
  uVar8 = 0;
  local_1e8 = 0;
  local_1e0 = (undefined8 *)0x0;
  puStack_1d8 = (undefined8 *)0x0;
  local_1d0 = (undefined8 *)0x0;
  lVar11 = *(longlong *)(param_2[1] + 0x18);
  lVar4 = *(longlong *)(param_2[1] + 0x20);
  local_1a0 = param_1;
  do {
    local_1c8 = param_1;
    local_1b8 = param_3;
    if (lVar11 == lVar4) {
      local_1b0 = operator_new(0x58);
      if (local_1b0 != (void *)0x0) {
        local_1b8 = &local_1c8;
        puStack_1c0 = (undefined8 *)0x0;
        if (param_3[1] != (undefined8 *)0x0) {
          LOCK();
          piVar1 = (int *)(param_3[1] + 1);
          *piVar1 = *piVar1 + 1;
          UNLOCK();
          puStack_1c0 = param_3[1];
        }
        local_1c8 = *param_3;
        local_208 = 0;
        uVar8 = FUN_14029a940(local_1b0,&local_1c8,&local_1e0,param_2[5]);
      }
      FUN_140299bf0(param_1,uVar8);
      local_1b0 = (undefined8 *)*param_1;
      plVar12 = (longlong *)0x0;
      if (param_1[1] != 0) {
        LOCK();
        piVar1 = (int *)(param_1[1] + 8);
        *piVar1 = *piVar1 + 1;
        UNLOCK();
        plVar12 = (longlong *)param_1[1];
      }
      local_1e8 = 3;
      plStack_1a8 = plVar12;
      FUN_14029d9d0(local_1b0,*(undefined4 *)param_2[4]);
      local_1e8 = 1;
      if (plVar12 != (longlong *)0x0) {
        LOCK();
        plVar2 = plVar12 + 1;
        lVar11 = *plVar2;
        *(int *)plVar2 = (int)*plVar2 + -1;
        UNLOCK();
        if ((int)lVar11 == 1) {
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
      puVar6 = puStack_1d8;
      puVar9 = local_1e0;
      if (local_1e0 != (undefined8 *)0x0) {
        for (; puVar9 != puVar6; puVar9 = puVar9 + 0x19) {
          (**(code **)*puVar9)(puVar9,0);
        }
        lVar11 = SUB168(SEXT816(-0x5c28f5c28f5c28f5) *
                        SEXT816((longlong)local_1d0 - (longlong)local_1e0),8) +
                 ((longlong)local_1d0 - (longlong)local_1e0);
        uVar10 = ((lVar11 >> 7) - (lVar11 >> 0x3f)) * 200;
        puVar9 = local_1e0;
        if (0xfff < uVar10) {
          uVar10 = uVar10 + 0x27;
          puVar9 = (undefined8 *)local_1e0[-1];
          if (0x1f < (ulonglong)((longlong)local_1e0 + (-8 - (longlong)puVar9))) {
            (*(code *)0x3d7636)();
            pcVar5 = (code *)swi(3);
            puVar9 = (undefined8 *)(*pcVar5)();
            return puVar9;
          }
        }
        thunk_FUN_1402b909d(puVar9,uVar10);
      }
      return param_1;
    }
    if ((*(byte *)(param_2[1] + 4) & 0x20) == 0) {
      if (*(char *)param_2[2] != '\0') {
        if (*(char *)param_2[2] != '\0') {
          uVar7 = *(undefined4 *)param_2[3];
          goto LAB_14029bfe8;
        }
      }
      else {
        FUN_1402a83f0(*param_2,lVar11,local_c8);
      }
    }
    else {
      uVar7 = FUN_1402a8630(*param_2);
LAB_14029bfe8:
      FUN_1402a84a0(*param_2,lVar11,uVar7,local_c8);
    }
    iVar3 = *(int *)param_2[6];
    local_198 = Lambda::SnowCipher::vftable;
    local_1f8 = 0;
    local_200 = 0;
    local_208 = 0;
    FUN_1402abee0(local_190,local_c8,0x80,0);
    local_d8 = (int)(iVar3 + (iVar3 >> 0x1f & 3U)) >> 2;
    FUN_1402ace20(local_190,local_d8);
    puVar9 = puStack_1d8;
    if (puStack_1d8 == local_1d0) {
      FUN_14029a1e0(&local_1e0,puStack_1d8,&local_198);
    }
    else {
      local_1b0 = puStack_1d8;
      *puStack_1d8 = Lambda::ICipher::vftable;
      *puStack_1d8 = Lambda::SnowCipher::vftable;
      FUN_1402abc00(puStack_1d8 + 1,local_190);
      *(int *)(puVar9 + 0x18) = local_d8;
      puStack_1d8 = puStack_1d8 + 0x19;
    }
    local_198 = Lambda::SnowCipher::vftable;
    FUN_1402acd10(local_190);
    local_198 = Lambda::ICipher::vftable;
    lVar11 = lVar11 + 0x10;
    param_3 = local_1b8;
    param_1 = local_1c8;
  } while( true );
}

