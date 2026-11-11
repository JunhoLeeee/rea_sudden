
undefined8 FUN_180f01740(longlong param_1,float *param_2,float *param_3)

{
  code *pcVar1;
  char cVar2;
  char cVar3;
  char cVar4;
  char cVar5;
  int iVar6;
  longlong *plVar7;
  longlong *local_res10;
  float local_108;
  float local_104;
  float local_100;
  float local_fc;
  float local_f8;
  float local_f4;
  undefined8 local_f0;
  undefined4 local_e8;
  undefined4 local_e4;
  code *local_e0;
  undefined8 local_d8;
  code *local_d0;
  undefined8 local_c8;
  undefined8 local_c0;
  undefined4 local_b8;
  undefined4 local_b4;
  undefined4 local_b0;
  undefined8 local_a8;
  undefined8 uStack_a0;
  undefined8 local_98;
  undefined4 local_90;
  undefined8 local_88;
  undefined8 local_80;
  undefined4 local_78;
  
  if (DAT_181a08d00 != (longlong *)0x0) {
    (**(code **)(*DAT_181a08d00 + 8))(DAT_181a08d00,*(undefined8 *)(param_1 + 0x20));
  }
  local_a8 = 0;
  uStack_a0 = 0;
  local_98 = 0;
  local_90 = 0;
  local_88 = 0;
  local_80 = 0xffffffffffffffff;
  local_78 = 0;
  local_d8 = 0;
  local_c0 = 0;
  local_f0 = 0;
  local_e8 = 0;
  local_e4 = 7;
  local_e0 = FUN_180f036e0;
  local_d0 = FUN_180f03760;
  local_c8 = 0;
  local_100 = param_3[2] + param_2[2];
  local_104 = param_3[1] + param_2[1];
  local_108 = *param_3 + *param_2;
  local_f4 = param_3[2] * 10000.0 + param_2[2];
  local_f8 = param_3[1] * 10000.0 + param_2[1];
  local_fc = *param_3 * 10000.0 + *param_2;
  cVar2 = (**(code **)(*DAT_181952a40 + 0x210))
                    (DAT_181952a40,&local_108,&local_a8,*(undefined8 *)(DAT_181a2b600 + 0x110));
  if (cVar2 == '\0') {
    (**(code **)(*DAT_181952a40 + 0x30))
              (DAT_181952a40,"[CMoveMgr] CheckThroughWorldEndLess - CP_DAMAGE");
    local_100 = param_3[2] + param_2[2];
    local_104 = param_3[1] + param_2[1];
    local_108 = *param_3 + *param_2 + 24.0;
    local_f4 = param_3[2] * 10000.0 + param_2[2];
    local_f8 = param_3[1] * 10000.0 + param_2[1];
    local_fc = *param_3 * 10000.0 + *param_2 + 24.0;
    cVar2 = (**(code **)(*DAT_181952a40 + 0x210))
                      (DAT_181952a40,&local_108,&local_a8,*(undefined8 *)(DAT_181a2b600 + 0x110));
    local_100 = param_3[2] + param_2[2];
    local_104 = param_3[1] + param_2[1];
    local_108 = *param_3 + (*param_2 - 24.0);
    local_f4 = param_3[2] * 10000.0 + param_2[2];
    local_f8 = param_3[1] * 10000.0 + param_2[1];
    local_fc = *param_3 * 10000.0 + (*param_2 - 24.0);
    cVar3 = (**(code **)(*DAT_181952a40 + 0x210))
                      (DAT_181952a40,&local_108,&local_a8,*(undefined8 *)(DAT_181a2b600 + 0x110));
    local_100 = param_3[2] + param_2[2] + 24.0;
    local_104 = param_3[1] + param_2[1];
    local_108 = *param_3 + *param_2;
    local_f4 = param_3[2] * 10000.0 + param_2[2] + 24.0;
    local_f8 = param_3[1] * 10000.0 + param_2[1];
    local_fc = *param_3 * 10000.0 + *param_2;
    cVar4 = (**(code **)(*DAT_181952a40 + 0x210))
                      (DAT_181952a40,&local_108,&local_a8,*(undefined8 *)(DAT_181a2b600 + 0x110));
    local_100 = param_3[2] + (param_2[2] - 24.0);
    local_104 = param_3[1] + param_2[1];
    local_108 = *param_3 + *param_2;
    local_f4 = param_3[2] * 10000.0 + (param_2[2] - 24.0);
    local_f8 = param_3[1] * 10000.0 + param_2[1];
    local_fc = *param_3 * 10000.0 + *param_2;
    cVar5 = (**(code **)(*DAT_181952a40 + 0x210))
                      (DAT_181952a40,&local_108,&local_a8,*(undefined8 *)(DAT_181a2b600 + 0x110));
    if ((cVar5 == '\0') && (cVar4 == '\0' && (cVar3 == '\0' && cVar2 == '\0'))) {
      local_a8 = CONCAT44(local_f8,local_fc);
      uStack_a0 = CONCAT44(uStack_a0._4_4_,local_f4);
      local_res10 = (longlong *)0x0;
      iVar6 = (**(code **)(*DAT_181a08d08 + 0x48))(DAT_181a08d08,&local_res10);
      if (iVar6 == 0) {
        (**(code **)(*local_res10 + 8))();
      }
      else {
        local_res10 = (longlong *)0x0;
      }
      (**(code **)(*local_res10 + 0x48))(local_res10,0x77,8);
      (**(code **)(*local_res10 + 0x48))(local_res10,2,8);
      (**(code **)(*local_res10 + 0x48))(local_res10,5,8);
      (**(code **)(*local_res10 + 0x48))(local_res10,0x47c35000,0x20);
      local_b8 = 0;
      local_b4 = 0xbf800000;
      local_b0 = 0;
      (**(code **)(*local_res10 + 0x58))(local_res10,&local_b8,0x60);
      (**(code **)(*local_res10 + 0x48))(local_res10,0,1);
      (**(code **)(*local_res10 + 0x48))(local_res10,0,8);
      (**(code **)(*local_res10 + 0x48))(local_res10,3,8);
      pcVar1 = *(code **)(*DAT_181952a40 + 0x3a8);
      plVar7 = (longlong *)(**(code **)(*local_res10 + 0x38))();
      if (plVar7 != (longlong *)0x0) {
        (**(code **)(*plVar7 + 8))(plVar7);
      }
      (*pcVar1)(DAT_181952a40,plVar7,1);
      if (plVar7 != (longlong *)0x0) {
        (**(code **)(*plVar7 + 0x10))(plVar7);
      }
      if (local_res10 != (longlong *)0x0) {
        (**(code **)(*local_res10 + 0x10))();
      }
    }
  }
  return 1;
}

