
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined8 * FUN_1811d4290(longlong param_1,undefined8 *param_2,uint param_3,int param_4)

{
  uint uVar1;
  char cVar2;
  char cVar3;
  longlong lVar4;
  longlong lVar5;
  int iVar6;
  longlong lVar7;
  undefined8 *puVar8;
  int *piVar9;
  undefined8 uVar10;
  undefined8 *puVar11;
  ulonglong uVar12;
  undefined8 *puVar13;
  undefined8 *puVar14;
  undefined8 *puVar15;
  undefined1 auStack_48 [32];
  undefined4 local_28;
  ulonglong local_20;
  
  local_20 = DAT_181905cc8 ^ (ulonglong)auStack_48;
  lVar4 = *(longlong *)(param_1 + 0x28);
  lVar5 = *(longlong *)(param_1 + 0x18);
  uVar12 = (((((ulonglong)param_3 & 0xff ^ 0xcbf29ce484222325) * 0x100000001b3 ^
             (ulonglong)(param_3 >> 8) & 0xff) * 0x100000001b3 ^ (ulonglong)(param_3 >> 0x10) & 0xff
            ) * 0x100000001b3 ^ (ulonglong)(param_3 >> 0x18)) * 0x100000001b3 &
           *(ulonglong *)(param_1 + 0x40);
  lVar7 = *(longlong *)(lVar4 + 8 + uVar12 * 0x10);
  local_28 = param_3;
  if (lVar7 != lVar5) {
    uVar1 = *(uint *)(lVar7 + 0x10);
    while (param_3 != uVar1) {
      if (lVar7 == *(longlong *)(lVar4 + uVar12 * 0x10)) goto LAB_1811d4433;
      lVar7 = *(longlong *)(lVar7 + 8);
      uVar1 = *(uint *)(lVar7 + 0x10);
    }
    if (lVar7 == 0) {
      lVar7 = lVar5;
    }
    if (lVar7 != lVar5) {
      local_28._1_1_ = (byte)(param_3 >> 8);
      local_28._2_1_ = (byte)(param_3 >> 0x10);
      local_28._3_1_ = (byte)(param_3 >> 0x18);
      uVar12 = *(ulonglong *)(param_1 + 0x40) &
               (((((ulonglong)(param_3 & 0xff) ^ 0xcbf29ce484222325) * 0x100000001b3 ^
                 (ulonglong)local_28._1_1_) * 0x100000001b3 ^ (ulonglong)local_28._2_1_) *
                0x100000001b3 ^ (ulonglong)local_28._3_1_) * 0x100000001b3;
      lVar7 = *(longlong *)(lVar4 + 8 + uVar12 * 0x10);
      if (lVar7 == lVar5) {
LAB_1811d44dd:
                    /* WARNING: Subroutine does not return */
        std::_Xout_of_range("invalid unordered_map<K, T> key");
      }
      uVar1 = *(uint *)(lVar7 + 0x10);
      while (param_3 != uVar1) {
        if (lVar7 == *(longlong *)(lVar4 + uVar12 * 0x10)) goto LAB_1811d44dd;
        lVar7 = *(longlong *)(lVar7 + 8);
        uVar1 = *(uint *)(lVar7 + 0x10);
      }
      puVar11 = *(undefined8 **)(lVar7 + 0x18);
      puVar14 = (undefined8 *)puVar11[1];
      cVar2 = *(char *)((longlong)puVar14 + 0x19);
      puVar8 = puVar11;
      puVar15 = puVar14;
      cVar3 = cVar2;
      while (cVar3 == '\0') {
        if (*(int *)(puVar15 + 4) < param_4) {
          puVar13 = (undefined8 *)puVar15[2];
          puVar15 = puVar8;
        }
        else {
          puVar13 = (undefined8 *)*puVar15;
        }
        puVar8 = puVar15;
        puVar15 = puVar13;
        cVar3 = *(char *)((longlong)puVar13 + 0x19);
      }
      if (((*(char *)((longlong)puVar8 + 0x19) == '\0') && (*(int *)(puVar8 + 4) <= param_4)) &&
         (puVar8 != puVar11)) {
        while (cVar2 == '\0') {
          if (*(int *)(puVar14 + 4) < param_4) {
            puVar8 = (undefined8 *)puVar14[2];
            puVar14 = puVar11;
          }
          else {
            puVar8 = (undefined8 *)*puVar14;
          }
          puVar11 = puVar14;
          puVar14 = puVar8;
          cVar2 = *(char *)((longlong)puVar8 + 0x19);
        }
        if ((*(char *)((longlong)puVar11 + 0x19) != '\0') || (param_4 < *(int *)(puVar11 + 4))) {
                    /* WARNING: Subroutine does not return */
          std::_Xout_of_range("invalid map<K, T> key");
        }
        uVar10 = puVar11[5];
        goto LAB_1811d44b9;
      }
    }
  }
LAB_1811d4433:
  if ((((DAT_181a19238 + 0x5e50 == 0) ||
       (piVar9 = (int *)FUN_180c8a1e0(DAT_181a19238 + 0x5e50,param_3), piVar9 == (int *)0x0)) ||
      (*piVar9 != 0)) &&
     ((*(int *)(DAT_181a19238 + 0xa8) != 6 && (*(int *)(DAT_181a19238 + 0xa8) != 3)))) {
LAB_1811d4486:
    *param_2 = 0;
    *(undefined1 *)(param_2 + 1) = 0;
    return param_2;
  }
  iVar6 = FUN_180d9dda0(DAT_181a1d4f8,param_4);
  if (iVar6 == 0) {
    uVar10 = FUN_18020a3d0();
    puVar11 = (undefined8 *)FUN_18020a600(uVar10,&local_28);
  }
  else {
    if (iVar6 != 1) goto LAB_1811d4486;
    uVar10 = FUN_18020a3d0();
    puVar11 = (undefined8 *)FUN_18020a300(uVar10,&local_28);
  }
  uVar10 = *puVar11;
LAB_1811d44b9:
  *param_2 = uVar10;
  *(undefined1 *)(param_2 + 1) = 1;
  return param_2;
}

