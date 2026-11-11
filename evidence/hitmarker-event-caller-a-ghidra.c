
undefined8
FUN_180cf9b70(longlong *param_1,byte param_2,undefined4 param_3,float *param_4,float *param_5,
             float *param_6,float *param_7,longlong *param_8,char param_9,longlong param_10)

{
  float fVar1;
  code *pcVar2;
  float *pfVar3;
  char cVar4;
  char cVar5;
  undefined1 uVar6;
  byte bVar7;
  int iVar8;
  undefined4 uVar9;
  undefined4 uVar10;
  undefined4 uVar11;
  int iVar12;
  undefined4 uVar13;
  longlong lVar14;
  undefined8 uVar15;
  longlong lVar16;
  longlong lVar17;
  longlong lVar18;
  float *pfVar19;
  longlong *plVar20;
  ulonglong uVar21;
  uint uVar22;
  uint uVar23;
  undefined8 *puVar24;
  undefined8 uVar25;
  bool bVar26;
  undefined4 uVar27;
  float fVar28;
  float fVar29;
  float fVar30;
  float fVar31;
  float fVar32;
  float fVar33;
  int local_res8;
  undefined8 in_stack_fffffffffffffde0;
  undefined8 uVar34;
  undefined8 in_stack_fffffffffffffde8;
  ulonglong in_stack_fffffffffffffdf0;
  undefined8 local_1f8;
  float local_1f0;
  int local_1e8;
  longlong local_1e0;
  undefined8 local_1d8;
  uint local_1d0;
  longlong *local_1c8;
  float local_1c0;
  undefined8 local_1b8;
  float local_1b0;
  ulonglong local_1a8 [2];
  undefined8 local_198;
  float local_190;
  undefined4 local_188;
  uint local_184;
  int local_180;
  uint local_17c;
  longlong *local_178;
  undefined8 local_170;
  float local_168;
  undefined8 local_164;
  float local_15c;
  undefined4 local_158;
  undefined1 local_150 [3];
  byte bStack_14d;
  uint local_14c;
  undefined8 local_148;
  undefined8 uStack_140;
  undefined8 local_138;
  undefined4 local_130;
  undefined8 local_128;
  undefined8 local_120;
  undefined4 local_118;
  undefined8 local_108;
  float local_100;
  undefined8 local_fc;
  float local_f4;
  undefined8 local_f0;
  undefined4 local_e8;
  undefined4 local_e4;
  code *local_e0;
  undefined8 local_d8;
  code *local_d0;
  longlong **local_c8;
  undefined8 local_c0;
  
  pfVar3 = param_6;
  uVar11 = (undefined4)((ulonglong)in_stack_fffffffffffffde8 >> 0x20);
  uVar9 = 0;
  local_184 = 0;
  lVar17 = *(longlong *)(param_6 + 8);
  local_1e8 = 0;
  uVar25 = 1;
  local_1d8 = CONCAT44(local_1d8._4_4_,1);
  local_180 = 0;
  *(undefined4 *)(param_1 + 0x22) = 0;
  local_1e0 = lVar17;
  local_res8 = FUN_180d4a140(*(undefined8 *)(param_6 + 10));
  lVar14 = (**(code **)(*param_1 + 0x450))(param_1,(int)param_1[0xbc]);
  lVar16 = DAT_181a08d38;
  if (lVar14 != 0) {
    uVar15 = (**(code **)(*param_1 + 0x450))(param_1,(int)param_1[0xbc]);
    lVar16 = FUN_180ec3ed0(lVar16 + 0xef88,uVar15);
    if (lVar16 != 0) {
      local_184 = (uint)*(byte *)(lVar16 + 0x1a8);
      if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x32) &&
         (lVar14 = FUN_180ec3e70(DAT_181a08d38 + 0xef88,lVar17), lVar14 != 0)) {
        lVar17 = *(longlong *)(lVar16 + 0x208);
        local_1e0 = lVar17;
      }
      if (local_184 != 0) {
        *(undefined8 *)(pfVar3 + 8) = *(undefined8 *)(lVar16 + 0x208);
      }
    }
  }
  if ((((param_8 != (longlong *)0x0) && (param_7 != (float *)0x0)) && (pfVar3[0xb] == -NAN)) &&
     ((pfVar3[10] == -NAN && (lVar17 != 0)))) {
    *(undefined4 *)((longlong)param_1 + 0xb6c) = 0;
    (**(code **)(*DAT_181a08d08 + 0x88))(DAT_181a08d08,*(undefined8 *)(pfVar3 + 8),2,local_150);
    local_14c = (uint)(bStack_14d & 1);
    local_1b8 = FUN_180ec3320(DAT_181a08d38 + 0xef88,lVar17);
    uVar10 = (undefined4)((ulonglong)in_stack_fffffffffffffde0 >> 0x20);
    if (local_1b8 == 0) {
      lVar16 = FUN_180ec3e70(DAT_181a08d38 + 0xef88,lVar17);
      uVar27 = (undefined4)((ulonglong)in_stack_fffffffffffffde0 >> 0x20);
      uVar10 = 0;
      if (lVar16 == 0) {
        lVar16 = FUN_180ec4990(DAT_181a08d38 + 0xef88,lVar17);
        iVar8 = *(int *)(DAT_181a08d38 + 0xe9e0);
        if (lVar16 == 0) {
          if (iVar8 == 0x37) {
            lVar16 = FUN_180ec4ab0(DAT_181a08d38 + 0xef88,lVar17);
            if (lVar16 != 0) {
              local_res8 = *(int *)(lVar16 + 0xb4);
            }
          }
          else if (((iVar8 - 0x4bU & 0xfffffffd) == 0) &&
                  (lVar16 = FUN_180ec4b70(DAT_181a08d38 + 0xef88,lVar17), lVar16 != 0)) {
            local_res8 = *(int *)(lVar16 + 0xb8);
          }
          lVar16 = FUN_180ec4c90(DAT_181a08d38 + 0xef88,lVar17);
          if (lVar16 != 0) {
            local_res8 = *(int *)(lVar16 + 0xdc);
          }
          plVar20 = (longlong *)FUN_180ec37c0(DAT_181a08d38 + 0xef88,lVar17);
          lVar17 = local_1e0;
          uVar27 = (undefined4)((ulonglong)in_stack_fffffffffffffde0 >> 0x20);
          if (plVar20 == (longlong *)0x0) {
            *(undefined4 *)(param_1 + 0x22) = 0;
            local_1c8 = (longlong *)FUN_180eb42d0(*(undefined8 *)(DAT_181a08d38 + 0xef48),local_1e0)
            ;
            uVar10 = (undefined4)((ulonglong)in_stack_fffffffffffffde0 >> 0x20);
            if (local_1c8 != (longlong *)0x0) {
              local_188 = (**(code **)(*local_1c8 + 0x128))(local_1c8);
              cVar4 = (**(code **)(*DAT_181a08cf0 + 0x200))(DAT_181a08cf0,local_1c8[3]);
              uVar10 = (undefined4)((ulonglong)in_stack_fffffffffffffde0 >> 0x20);
              if (cVar4 == '\x01') {
                local_170 = *(undefined8 *)param_5;
                local_168 = param_5[2];
                local_164 = *(undefined8 *)(param_5 + 3);
                local_15c = param_5[5];
                local_158 = 0x7f7fffff;
                puVar24 = &param_6;
                local_178 = param_1;
                cVar4 = FUN_180d099d0(local_1c8[3],&local_178,&local_1f8,&local_198,puVar24);
              }
              else {
                uVar27 = (**(code **)(*local_1c8 + 0xc0))();
                in_stack_fffffffffffffde0 = CONCAT44(uVar10,uVar27);
                puVar24 = &param_6;
                cVar4 = FUN_180d09570(local_188,local_1c8[3],param_5,param_5 + 3,puVar24,
                                      in_stack_fffffffffffffde0);
              }
              uVar10 = (undefined4)((ulonglong)in_stack_fffffffffffffde0 >> 0x20);
              local_1d0 = (uint)param_6._0_4_;
              if (cVar4 != '\0') {
                if ((((int)param_1[0x7c] == 0) || (lVar17 = param_1[0xd], lVar17 == 0)) ||
                   ((0x25 < *(uint *)(lVar17 + 0xc) ||
                    ((0x3004480c00U >> ((longlong)(int)*(uint *)(lVar17 + 0xc) & 0x3fU) & 1) == 0)))
                   ) {
LAB_180cfac1a:
                  uVar21 = param_1[0xe];
                }
                else {
                  uVar11 = FUN_180c58cd0(lVar17,1);
                  uVar21 = FUN_180c64560(DAT_181a0e3a0,uVar11);
                  if (uVar21 == 0) goto LAB_180cfac1a;
                }
                local_1a8[0] = uVar21;
                if (((int)param_1[0x7c] == 0) &&
                   (iVar8 = (**(code **)(*param_1 + 0x340))(param_1), iVar8 == 0)) {
                  iVar8 = *(int *)(uVar21 + 0x24);
                }
                else {
                  iVar8 = *(int *)(uVar21 + 0x28);
                }
                param_6 = (float *)CONCAT44(param_6._4_4_,(float)iVar8);
                cVar4 = FUN_180c65d90(DAT_181a0e3a0,*(undefined4 *)(param_1[0xd] + 4));
                uVar11 = (undefined4)((ulonglong)puVar24 >> 0x20);
                uVar10 = (undefined4)((ulonglong)in_stack_fffffffffffffde0 >> 0x20);
                uVar27 = (undefined4)(in_stack_fffffffffffffdf0 >> 0x20);
                if (cVar4 != '\0') {
                  local_1d8 = FUN_180ec3680(DAT_181a08d38 + 0xef88,*(undefined4 *)(param_1[0xd] + 4)
                                           );
                  uVar11 = (undefined4)((ulonglong)puVar24 >> 0x20);
                  uVar10 = (undefined4)((ulonglong)in_stack_fffffffffffffde0 >> 0x20);
                  uVar27 = (undefined4)(in_stack_fffffffffffffdf0 >> 0x20);
                  if (local_1d8 != 0) {
                    fVar28 = 0.0;
                    if (*(int *)(local_1d8 + 0x16c) == 0) {
                      if ((*(char *)(local_1d8 + 0x168) == '\x01') && (param_1[0xd] != 0)) {
                        iVar8 = FUN_180c58c90();
                        uVar11 = (undefined4)((ulonglong)puVar24 >> 0x20);
                        uVar10 = (undefined4)((ulonglong)in_stack_fffffffffffffde0 >> 0x20);
                        uVar27 = (undefined4)(in_stack_fffffffffffffdf0 >> 0x20);
                        uVar21 = local_1a8[0];
                        uVar22 = 0;
                        if (0 < iVar8) {
                          do {
                            iVar12 = FUN_180c58cd0(param_1[0xd],uVar22);
                            uVar11 = (undefined4)((ulonglong)puVar24 >> 0x20);
                            uVar10 = (undefined4)((ulonglong)in_stack_fffffffffffffde0 >> 0x20);
                            uVar27 = (undefined4)(in_stack_fffffffffffffdf0 >> 0x20);
                            if (iVar12 == *(int *)(local_1a8[0] + 0x20)) {
                              iVar8 = FUN_1810aedb0(local_1d8 + 0x18,uVar22);
                              fVar28 = (float)iVar8;
                              uVar21 = local_1a8[0];
                              break;
                            }
                            uVar22 = uVar22 + 1;
                            uVar21 = local_1a8[0];
                          } while ((int)uVar22 < iVar8);
                        }
                      }
                    }
                    else {
                      fVar28 = (float)*(int *)(local_1d8 + 0x16c);
                    }
                    param_6 = (float *)CONCAT44(param_6._4_4_,param_6._0_4_ + fVar28);
                  }
                }
                if (param_1[0xd] != 0) {
                  FUN_180c5a290(param_1[0xd],&param_6,*(undefined4 *)((longlong)param_1 + 0xb5c));
                }
                iVar8 = *(int *)(DAT_181a08d38 + 0xe9e0);
                if ((iVar8 == 0x20) || (iVar8 == 0x27)) {
                  param_6 = (float *)CONCAT44(param_6._4_4_,0x461c4000);
                  iVar8 = *(int *)(DAT_181a08d38 + 0xe9e0);
                }
                if (iVar8 != 0x36) {
                  uVar15 = FUN_180c6f820();
                  cVar4 = FUN_180c74bd0(uVar15);
                  if (cVar4 != '\0') {
                    uVar15 = FUN_180c6f820();
                    iVar8 = FUN_180c71410(uVar15);
                    lVar17 = FUN_180c6f820();
                    if ((*(int *)(lVar17 + 0x80) == iVar8) && (*(int *)(param_1[0xd] + 0x247c) == 3)
                       ) {
                      param_6 = (float *)CONCAT44(param_6._4_4_,param_6._0_4_ * 2.0);
                    }
                  }
                }
                if ((param_1[0xe] != 0) && (cVar4 = FUN_180c53830(), cVar4 != '\0')) {
                  (**(code **)(*DAT_181952a40 + 0x178))(DAT_181952a40,local_1e0,&local_1f8,0);
                  fVar28 = ((float)local_1f8 - *param_5) * ((float)local_1f8 - *param_5) +
                           (local_1f8._4_4_ - param_5[1]) * (local_1f8._4_4_ - param_5[1]) +
                           (local_1f0 - param_5[2]) * (local_1f0 - param_5[2]);
                  if (fVar28 < 0.0) {
                    fVar28 = sqrtf(fVar28);
                  }
                  else {
                    fVar28 = SQRT(fVar28);
                  }
                  fVar28 = (float)FUN_180c53850(param_1[0xe],fVar28);
                  param_6 = (float *)CONCAT44(param_6._4_4_,param_6._0_4_ * fVar28);
                }
                iVar8 = FUN_180c65c90(DAT_181a0e3a0,*(undefined4 *)(param_1[0xd] + 4));
                if ((iVar8 != 0) && (0 < *(int *)((longlong)param_1 + 0x5e4))) {
                  param_6 = (float *)CONCAT44(param_6._4_4_,
                                              param_6._0_4_ *
                                              (*(float *)(param_1[0xe] + 0xc4) /
                                              (float)*(int *)((longlong)param_1 + 0x5e4)));
                }
                local_1f8 = *(code **)(*local_1c8 + 0x118);
                uVar15 = *(undefined8 *)param_5;
                local_1a8[0] = CONCAT44(local_1a8[0]._4_4_,param_5[2]);
                local_1e8 = *(undefined4 *)(uVar21 + 0x20);
                if (param_1[0xd] != 0) {
                  uVar9 = *(undefined4 *)(param_1[0xd] + 4);
                }
                local_1d8._0_4_ = (float)(int)param_1[0x7c];
                uVar13 = FUN_180c53990(uVar21);
                uVar22 = local_1d0;
                local_190 = (float)local_1a8[0];
                in_stack_fffffffffffffdf0 = CONCAT44(uVar27,(float)local_1d8);
                puVar24 = &local_198;
                uVar34 = CONCAT44(uVar10,local_1e8);
                local_198 = uVar15;
                (*local_1f8)(local_1c8,param_6._0_4_,uVar13,local_1d0,CONCAT44(uVar11,uVar9),uVar34,
                             puVar24,in_stack_fffffffffffffdf0);
                uVar11 = (undefined4)((ulonglong)puVar24 >> 0x20);
                uVar10 = (undefined4)((ulonglong)uVar34 >> 0x20);
                local_1e8 = FUN_180d9c430(DAT_181a1d4f8,local_188,uVar22);
                (*(code *)((ulonglong)param_1 ^ param_1[3]))
                          (uVar22 & 0xff,(ulonglong)param_1 ^ 0x3cd24a783cd24a78,(int)param_1[0xbc])
                ;
                if (*(uint *)(param_1 + 0xbc) < 4) {
                  *(undefined1 *)
                   ((longlong)(int)*(uint *)(param_1 + 0xbc) + 0x531 + (longlong)param_1) = 0xfe;
                }
                local_1d8 = (ulonglong)local_1d8._4_4_ << 0x20;
                iVar8 = FUN_180c65c90(DAT_181a0e3a0,*(undefined4 *)(param_1[0xd] + 4));
                lVar17 = local_1e0;
                if (iVar8 != 0) {
                  *(undefined4 *)(param_10 + 0xc) = *(undefined4 *)((longlong)param_1 + 0x5e4);
                  local_1d8 = CONCAT44(local_1d8._4_4_,
                                       (uint)(*(int *)((longlong)param_1 + 0x5e4) <
                                             *(int *)(param_1[0xe] + 0xc0)));
                }
              }
            }
            plVar20 = (longlong *)FUN_180eb42d0(*(undefined8 *)(DAT_181a08d38 + 0xef58),lVar17);
            if (plVar20 != (longlong *)0x0) {
              uVar9 = (**(code **)(*plVar20 + 0x128))(plVar20);
              local_1a8[0] = CONCAT44(local_1a8[0]._4_4_,uVar9);
              pfVar19 = param_5 + 3;
              cVar4 = (**(code **)(*DAT_181a08cf0 + 0x200))(DAT_181a08cf0,plVar20[3]);
              if (cVar4 == '\x01') {
                local_170 = *(undefined8 *)param_5;
                local_168 = param_5[2];
                local_164 = *(undefined8 *)pfVar19;
                local_15c = param_5[5];
                local_158 = 0x7f7fffff;
                puVar24 = &param_6;
                local_178 = param_1;
                cVar4 = FUN_180d099d0(plVar20[3],&local_178,&local_1f8,&local_198,puVar24);
                uVar9 = (undefined4)((ulonglong)puVar24 >> 0x20);
              }
              else {
                uVar9 = (**(code **)(*plVar20 + 0xc0))(plVar20);
                uVar15 = CONCAT44(uVar11,uVar9);
                puVar24 = &param_6;
                cVar4 = FUN_180d08790(DAT_181a1d500,local_1a8[0] & 0xffffffff,plVar20[3],param_5,
                                      pfVar19,puVar24,uVar15);
                uVar11 = (undefined4)((ulonglong)uVar15 >> 0x20);
                uVar9 = (undefined4)((ulonglong)pfVar19 >> 0x20);
                uVar10 = (undefined4)((ulonglong)puVar24 >> 0x20);
              }
              local_1d0 = (uint)param_6._0_4_;
              lVar17 = local_1e0;
              if (cVar4 != '\0') {
                bVar7 = (**(code **)(*param_1 + 0x1a8))(param_1);
                uVar27 = (undefined4)(in_stack_fffffffffffffdf0 >> 0x20);
                uVar22 = (uint)bVar7;
                if (((((int)param_1[0x7c] == 0) || (lVar17 = param_1[0xd], lVar17 == 0)) ||
                    (0x25 < *(uint *)(lVar17 + 0xc))) ||
                   ((0x3004480c00U >> ((longlong)(int)*(uint *)(lVar17 + 0xc) & 0x3fU) & 1) == 0)) {
LAB_180cfb13c:
                  uVar23 = uVar22;
                  lVar17 = param_1[0xe];
                }
                else {
                  uVar13 = FUN_180c58cd0(lVar17,1);
                  lVar17 = FUN_180c64560(DAT_181a0e3a0,uVar13);
                  uVar23 = 1;
                  uVar22 = 1;
                  if (lVar17 == 0) goto LAB_180cfb13c;
                }
                local_198 = *(undefined8 *)(param_5 + 3);
                local_190 = param_5[5];
                local_1f8 = *(code **)param_5;
                local_1f0 = param_5[2];
                uVar34 = CONCAT44(uVar10,uVar23);
                uVar15 = CONCAT44(uVar9,local_1d0);
                FUN_1807794e0(DAT_1819ecf40,plVar20,&local_1f8,&local_198,uVar15,uVar34,
                              CONCAT44(uVar11,(int)param_1[0x7c]));
                uVar9 = (undefined4)((ulonglong)uVar15 >> 0x20);
                uVar11 = (undefined4)((ulonglong)uVar34 >> 0x20);
                if (((int)param_1[0x7c] == 0) &&
                   (iVar8 = (**(code **)(*param_1 + 0x340))(param_1), iVar8 == 0)) {
                  iVar8 = *(int *)(lVar17 + 0x24);
                }
                else {
                  iVar8 = *(int *)(lVar17 + 0x28);
                }
                param_6 = (float *)CONCAT44(param_6._4_4_,(float)iVar8);
                lVar16 = 0;
                if (param_1[0xd] != 0) {
                  FUN_180c5a290(param_1[0xd],&param_6,*(undefined4 *)((longlong)param_1 + 0xb5c));
                  lVar16 = param_1[0xd];
                }
                iVar8 = FUN_180c65c90(DAT_181a0e3a0,*(undefined4 *)(lVar16 + 4));
                if ((iVar8 != 0) && (0 < *(int *)((longlong)param_1 + 0x5e4))) {
                  param_6 = (float *)CONCAT44(param_6._4_4_,
                                              param_6._0_4_ *
                                              (*(float *)(param_1[0xe] + 0xc4) /
                                              (float)*(int *)((longlong)param_1 + 0x5e4)));
                }
                local_1f8 = *(code **)(*plVar20 + 0x118);
                local_1e8 = (int)param_1[0x7c];
                uVar15 = *(undefined8 *)param_5;
                local_1c8 = (longlong *)CONCAT44(local_1c8._4_4_,*(undefined4 *)(lVar17 + 0x20));
                if (param_1[0xd] == 0) {
                  local_188 = 0;
                }
                else {
                  local_188 = *(undefined4 *)(param_1[0xd] + 4);
                }
                local_1d8._0_4_ = param_5[2];
                uVar10 = FUN_180c53990(lVar17);
                local_190 = (float)local_1d8;
                in_stack_fffffffffffffdf0 = CONCAT44(uVar27,local_1e8);
                puVar24 = &local_198;
                local_198 = uVar15;
                (*local_1f8)(plVar20,param_6._0_4_,uVar10,local_1d0,CONCAT44(uVar9,local_188),
                             CONCAT44(uVar11,local_1c8._0_4_),puVar24,in_stack_fffffffffffffdf0);
                uVar11 = (undefined4)((ulonglong)puVar24 >> 0x20);
                local_1e8 = FUN_180d9c430(DAT_181a1d4f8,local_1a8[0] & 0xffffffff,local_1d0);
                local_1d8 = (ulonglong)local_1d8._4_4_ << 0x20;
                iVar8 = FUN_180c65c90(DAT_181a0e3a0,*(undefined4 *)(param_1[0xd] + 4));
                lVar17 = local_1e0;
                if (iVar8 != 0) {
                  *(undefined4 *)(param_10 + 0xc) = *(undefined4 *)((longlong)param_1 + 0x5e4);
                  local_1d8 = CONCAT44(local_1d8._4_4_,
                                       (uint)(*(int *)((longlong)param_1 + 0x5e4) <
                                             *(int *)(param_1[0xe] + 0xc0)));
                }
              }
            }
            lVar16 = FUN_180ec5af0(DAT_181a08d38 + 0xef88,lVar17);
            lVar14 = local_1b8;
            if ((lVar16 != 0) &&
               (lVar18 = (**(code **)(*param_1 + 0x450))(param_1,(int)param_1[0xbc]),
               lVar14 = local_1b8, lVar18 != 0)) {
              lVar17 = *(longlong *)(lVar16 + 0x20);
              local_1e0 = lVar17;
              uVar6 = FUN_180ce0830(param_1,lVar17);
              (*(code *)((ulonglong)param_1 ^ param_1[3]))
                        (uVar6,(ulonglong)param_1 ^ 0x3cd24a783cd24a78,(int)param_1[0xbc]);
              if (*(uint *)(param_1 + 0xbc) < 4) {
                *(undefined1 *)
                 ((longlong)(int)*(uint *)(param_1 + 0xbc) + 0x531 + (longlong)param_1) =
                     *(undefined1 *)(lVar16 + 0x80);
              }
              *(undefined1 *)((longlong)param_1 + 0x5ca) = 1;
              lVar14 = local_1b8;
            }
          }
          else {
            local_1e0 = plVar20[4];
            iVar8 = FUN_180fc8d00(plVar20);
            if (iVar8 == 0) {
              param_9 = '\x01';
            }
            local_1d0 = FUN_180d47b50(*(undefined8 *)(DAT_181a19c68 + 0x430));
            param_6 = (float *)CONCAT71(param_6._1_7_,(char)plVar20[0x11]);
            iVar8 = (**(code **)(*param_1 + 0x340))(param_1);
            if ((iVar8 == 0) &&
               ((((int)param_1[0x7c] != 1 || (0x25 < *(uint *)(param_1[0xd] + 0xc))) ||
                ((0x3000480c00U >> ((longlong)(int)*(uint *)(param_1[0xd] + 0xc) & 0x3fU) & 1) == 0)
                ))) {
              iVar8 = *(int *)(param_1[0xd] + 0xc);
              if (((iVar8 == 2) || (iVar8 == 8)) ||
                 ((*(int *)(param_1[0xd] + 0x247c) != 1 && (iVar8 == 0x25)))) goto LAB_180cfa815;
            }
            else {
LAB_180cfa815:
              iVar8 = *(int *)(DAT_181a08d38 + 0xe9e0);
              if ((iVar8 != 0x21 && iVar8 != 0x22) && (iVar8 != 0x44)) {
                uVar15 = FUN_180c6f820();
                iVar8 = FUN_180c7ad00(uVar15);
                if ((iVar8 == 0) && (lVar17 = FUN_180c6f820(), *(char *)(lVar17 + 0x6f88) == '\0'))
                {
                  uVar15 = FUN_180c6f820();
                  iVar8 = FUN_180c750e0(uVar15);
                  if (iVar8 == 0) {
                    uVar15 = FUN_180c6f820();
                    uVar10 = FUN_180c73fa0(uVar15,0x13);
                  }
                }
              }
            }
            *(undefined4 *)(param_1 + 0x22) = uVar10;
            cVar4 = (**(code **)(*DAT_181a08cf0 + 0x200))(DAT_181a08cf0,plVar20[4]);
            if (cVar4 == '\x01') {
              local_170 = *(undefined8 *)param_5;
              local_168 = param_5[2];
              local_164 = *(undefined8 *)(param_5 + 3);
              local_15c = param_5[5];
              local_158 = 0x7f7fffff;
              local_178 = param_1;
              cVar4 = FUN_180d099d0(plVar20[4],&local_178,&local_1f8,&local_198,local_1a8);
            }
            else {
              uVar10 = (**(code **)(*plVar20 + 0xc0))(plVar20);
              lVar17 = plVar20[4];
              uVar9 = FUN_180d0bf50(plVar20);
              cVar4 = FUN_180d09570(uVar9,lVar17,param_5,param_5 + 3,local_1a8,
                                    CONCAT44(uVar27,uVar10));
            }
            uVar22 = (uint)(float)local_1a8[0];
            if (cVar4 != '\0') {
              local_1f8 = (code *)0x0;
              local_1f0 = 0.0;
              FUN_180fc3300(plVar20,(uint)(float)local_1a8[0] & 0xff,&local_1f8);
              cVar4 = FUN_180fcc790(plVar20,(int)param_1[0x22],local_1d0,&local_1f8);
              if (cVar4 != '\0') {
                FUN_180d47b80(*(undefined8 *)(DAT_181a19c68 + 0x430));
              }
              local_1c8 = (longlong *)0x0;
              iVar8 = (**(code **)(*DAT_181a08d08 + 0x48))(DAT_181a08d08,&local_1c8);
              if (iVar8 == 0) {
                (**(code **)(*local_1c8 + 8))();
              }
              else {
                local_1c8 = (longlong *)0x0;
              }
              (**(code **)(*local_1c8 + 0x48))(local_1c8,0x7d,8);
              (**(code **)(*local_1c8 + 0x48))(local_1c8,(ulonglong)param_6 & 0xff,6);
              (**(code **)(*local_1c8 + 0x48))(local_1c8,uVar22 & 0xff,8);
              if ((((*(uint *)(param_1[0xd] + 0xc) < 0x26) &&
                   ((0x3004480c00U >> ((longlong)(int)*(uint *)(param_1[0xd] + 0xc) & 0x3fU) & 1) !=
                    0)) && ((int)param_1[0x7c] != 0)) ||
                 (iVar8 = (**(code **)(*param_1 + 0x340))(param_1), iVar8 != 0)) {
                uVar15 = 1;
              }
              else {
                uVar15 = 0;
              }
              (**(code **)(*local_1c8 + 0x48))(local_1c8,uVar15,1);
              (**(code **)(*local_1c8 + 0x48))(local_1c8,(int)param_1[0x22],0x20);
              (**(code **)(*local_1c8 + 0x48))(local_1c8,(undefined1)local_1d0,8);
              pcVar2 = *(code **)(*DAT_181952a40 + 0x3a8);
              pfVar19 = (float *)(**(code **)(*local_1c8 + 0x38))();
              param_6 = pfVar19;
              if (pfVar19 != (float *)0x0) {
                (**(code **)(*(longlong *)pfVar19 + 8))(pfVar19);
              }
              (*pcVar2)(DAT_181952a40,pfVar19,1);
              if (pfVar19 != (float *)0x0) {
                (**(code **)(*(longlong *)pfVar19 + 0x10))(pfVar19);
              }
              if (local_1c8 != (longlong *)0x0) {
                (**(code **)(*local_1c8 + 0x10))();
              }
            }
            local_1d8 = local_1d8 & 0xffffffff00000000;
            lVar14 = local_1b8;
            lVar17 = local_1e0;
          }
        }
        else {
          if (iVar8 == 0x1b) {
            return 1;
          }
          if (iVar8 == 0x2d) {
            return 1;
          }
          lVar18 = (**(code **)(*param_1 + 0x450))(param_1,(int)param_1[0xbc]);
          lVar14 = local_1b8;
          if (lVar18 != 0) {
            lVar17 = *(longlong *)(lVar16 + 0x20);
            local_1e0 = lVar17;
            cVar4 = FUN_180ce0830(param_1,lVar17);
            if (cVar4 == -1) {
              return 1;
            }
            (*(code *)((ulonglong)param_1 ^ param_1[3]))
                      (cVar4,(ulonglong)param_1 ^ 0x3cd24a783cd24a78,(int)param_1[0xbc]);
            uVar6 = (**(code **)(*param_1 + 0x440))(param_1,(int)param_1[0xbc]);
            local_1e8 = FUN_180d9c430(DAT_181a1d500,*(undefined4 *)(lVar16 + 0x240),uVar6);
            if (*(uint *)(param_1 + 0xbc) < 4) {
              *(undefined1 *)((longlong)(int)*(uint *)(param_1 + 0xbc) + 0x531 + (longlong)param_1)
                   = *(undefined1 *)(lVar16 + 0x289);
            }
            *(undefined1 *)((longlong)param_1 + 0x5c9) = 1;
            local_180 = 1;
            local_1d8 = local_1d8 & 0xffffffff00000000;
            iVar8 = FUN_180c65c90(DAT_181a0e3a0,*(undefined4 *)(param_1[0xd] + 4));
            lVar14 = local_1b8;
            if ((iVar8 != 0) &&
               (*(undefined4 *)(param_10 + 0xc) = *(undefined4 *)((longlong)param_1 + 0x5e4),
               *(int *)((longlong)param_1 + 0x5e4) < *(int *)(param_1[0xe] + 0xc0))) {
              local_1d8 = CONCAT44(local_1d8._4_4_,1);
            }
          }
        }
      }
      else {
        iVar8 = FUN_180f8c9d0();
        if ((iVar8 != 0x31) &&
           ((*(int **)(lVar16 + 0x6c0) == (int *)0x0 || (**(int **)(lVar16 + 0x6c0) != 3)))) {
          uVar9 = FUN_180c8c020(DAT_181a19238 + 0x5e50);
          cVar4 = FUN_180f8c1a0(uVar9,(int)*(char *)(lVar16 + 0x328));
          if (cVar4 != '\0') {
            return 1;
          }
        }
        iVar8 = FUN_180f8c9d0();
        if ((iVar8 == 0x44) && (param_1[0xd] != 0)) {
          param_6 = (float *)CONCAT71(param_6._1_7_,1);
          uVar15 = FUN_180c44210(DAT_181a0e320);
          FUN_180f6d120(uVar15,*(undefined4 *)(param_1[0xd] + 4),(int)param_1[0xe9],lVar16,&param_6)
          ;
          if ((char)param_6 == '\0') {
            uVar25 = FUN_180c44210(DAT_181a0e320);
            local_1f8 = *(code **)pfVar3;
            local_1f0 = pfVar3[2];
            FUN_180f72140(uVar25,&local_1f8,0xffffffff);
            return 1;
          }
        }
        cVar4 = FUN_180c510a0();
        if (cVar4 == '\x01') {
          local_184 = (uint)*(byte *)(lVar16 + 0x1a8);
        }
        lVar18 = (**(code **)(*param_1 + 0x450))(param_1,(int)param_1[0xbc]);
        lVar14 = local_1b8;
        if (lVar18 != 0) {
          lVar17 = *(longlong *)(lVar16 + 0x20);
          local_1e0 = lVar17;
          cVar4 = FUN_180ce0830(param_1,lVar17);
          if (cVar4 == -1) {
            return 1;
          }
          (*(code *)((ulonglong)param_1 ^ param_1[3]))
                    (cVar4,(ulonglong)param_1 ^ 0x3cd24a783cd24a78,(int)param_1[0xbc]);
          if (*(char *)(lVar16 + 0x1a8) == '\0') {
            uVar6 = (**(code **)(*param_1 + 0x440))(param_1,(int)param_1[0xbc]);
            uVar15 = DAT_181a1d4f8;
          }
          else {
            uVar6 = (**(code **)(*param_1 + 0x440))();
            uVar15 = DAT_181a1d508;
          }
          local_1e8 = FUN_180d9c430(uVar15,*(undefined4 *)(lVar16 + 0x140),uVar6);
          if (0.0 < *(float *)(lVar16 + 0x1b0)) {
            *(int *)((longlong)param_1 + 0xb6c) = local_1e8;
          }
          *(undefined1 *)(param_1 + 0xb9) = 1;
          if (*(uint *)(param_1 + 0xbc) < 4) {
            *(undefined1 *)((longlong)(int)*(uint *)(param_1 + 0xbc) + 0x531 + (longlong)param_1) =
                 *(undefined1 *)(lVar16 + 0x189);
          }
          local_1d8 = local_1d8 & 0xffffffff00000000;
          iVar8 = FUN_180c65c90(DAT_181a0e3a0,*(undefined4 *)(param_1[0xd] + 4));
          if (iVar8 != 0) {
            *(undefined4 *)(param_10 + 0xc) = *(undefined4 *)((longlong)param_1 + 0x5e4);
            local_1d8 = CONCAT44(local_1d8._4_4_,
                                 (uint)(*(int *)((longlong)param_1 + 0x5e4) <
                                       *(int *)(param_1[0xe] + 0xc0)));
          }
          cVar4 = FUN_180761a20(DAT_1819ecf68);
          lVar14 = local_1b8;
          if (cVar4 != '\0') {
            bVar7 = (**(code **)(*param_1 + 0x1a8))(param_1);
            uVar22 = (uint)bVar7;
            if (((*(uint *)(param_1[0xd] + 0xc) < 0x26) &&
                ((0x3004480c00U >> ((longlong)(int)*(uint *)(param_1[0xd] + 0xc) & 0x3fU) & 1) != 0)
                ) && ((int)param_1[0x7c] != 0)) {
              uVar22 = 1;
            }
            switch(*(undefined4 *)(DAT_181a08d38 + 0xe9e0)) {
            default:
              lVar14 = param_1[0x7c];
              bVar7 = (**(code **)(*param_1 + 0x440))(param_1,(int)param_1[0xbc]);
              lVar17 = local_1e0;
              local_1f8 = *(code **)(param_5 + 3);
              local_1f0 = param_5[5];
              local_1c8 = *(longlong **)param_5;
              local_1c0 = param_5[2];
              in_stack_fffffffffffffdf0 =
                   CONCAT44((int)(in_stack_fffffffffffffdf0 >> 0x20),(int)lVar14);
              uVar15 = CONCAT44(uVar11,uVar22);
              FUN_180762860(DAT_1819ecf68,local_1e0,*(undefined4 *)(lVar16 + 0x140),&local_1c8,
                            &local_1f8,CONCAT44(uVar27,(uint)bVar7),uVar15,in_stack_fffffffffffffdf0
                           );
              uVar11 = (undefined4)((ulonglong)uVar15 >> 0x20);
              lVar14 = local_1b8;
              break;
            case 0xffffffff:
            case 0x21:
            case 0x27:
            case 0x30:
            case 0x31:
            case 0x32:
            case 0x34:
            case 0x36:
            case 0x44:
              lVar14 = local_1b8;
              lVar17 = local_1e0;
            }
          }
        }
      }
    }
    else {
      if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x27) {
        if (*(int *)(param_1[0xd] + 4) == 0x45c) {
          return 1;
        }
      }
      else if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x41) {
        FUN_180f0a3e0(local_1b8);
      }
      local_1e0 = *(longlong *)(local_1b8 + 0x20);
      lVar17 = (longlong)(int)*(uint *)(param_1 + 0xbc);
      cVar4 = '\0';
      if ((*(uint *)(param_1 + 0xbc) < 4) &&
         (*(undefined1 *)(lVar17 + 0x5cb + (longlong)param_1) = 0, param_5 != (float *)0x0)) {
        cVar4 = FUN_18118b6b0(&DAT_181aa13b0,local_1b8,param_5,&DAT_181aa13c4,&local_198);
        if (cVar4 == '\0') {
          iVar8 = FUN_180c65c90(DAT_181a0e3a0,*(undefined4 *)(param_1[0xd] + 4));
          fVar1 = DAT_181aa13cc;
          fVar29 = DAT_181aa13c8;
          fVar28 = DAT_181aa13c4;
          if (iVar8 != 0) {
            local_1f0 = DAT_181aa13cc - param_5[2];
            local_1f8 = (code *)CONCAT44(DAT_181aa13c8 - param_5[1],DAT_181aa13c4 - *param_5);
            pfVar19 = (float *)FUN_1801e2e00(&local_1f8);
            local_1f0 = pfVar19[2] * 100.0 + fVar1;
            local_1f8 = (code *)CONCAT44(pfVar19[1] * 100.0 + fVar29,*pfVar19 * 100.0 + fVar28);
            cVar4 = FUN_18118b6b0(&DAT_181aa13b0,local_1b8,param_5,&local_1f8,&local_198);
            if (cVar4 != '\0') {
              *(undefined1 *)(lVar17 + 0x5cb + (longlong)param_1) = 3;
            }
          }
        }
        else {
          *(undefined1 *)(lVar17 + 0x5cb + (longlong)param_1) = 2;
          if ((local_1e0 != 0) && (cVar5 = FUN_180ce0830(param_1), cVar5 != -1)) {
            *(undefined1 *)(lVar17 + 0x5cb + (longlong)param_1) = 1;
          }
        }
      }
      lVar16 = FUN_180c8a330(DAT_181a19238 + 0x5e50,local_1e0);
      if (lVar16 != 0) {
        iVar8 = FUN_180f8c9d0();
        if ((iVar8 == 0x31) &&
           (cVar5 = FUN_180ec3480(DAT_181a08d38 + 0xef88,*(undefined1 *)(lVar16 + 0x88)),
           cVar5 != '\0')) {
          return 1;
        }
        iVar8 = FUN_180f8c9d0();
        if (iVar8 == 0x42) {
          uVar15 = FUN_180c6f820();
          iVar8 = FUN_180c79f80(uVar15);
          if ((iVar8 == 0) &&
             (cVar5 = FUN_180ec3480(DAT_181a08d38 + 0xef88,*(undefined1 *)(lVar16 + 0x88)),
             cVar5 != '\0')) {
            return 1;
          }
        }
        uVar9 = FUN_180c8c020(DAT_181a19238 + 0x5e50);
        param_6 = (float *)CONCAT44(param_6._4_4_,uVar9);
        iVar8 = FUN_180c8bf60(DAT_181a19238 + 0x5e50,*(undefined4 *)(lVar16 + 0xc0));
        local_1a8[0] = CONCAT44(local_1a8[0]._4_4_,iVar8);
        if (((((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x16) || (param_6._0_4_ != 0.0)) || (iVar8 != 2)
             ) || (cVar5 = (**(code **)(*param_1 + 0x1a8))(param_1), cVar5 == '\0')) &&
           (((iVar8 = FUN_180f8c9d0(), iVar8 != 0x31 && (cVar5 = FUN_180f8ca20(), cVar5 != '\0')) &&
            (cVar5 = FUN_180f8c1a0((ulonglong)param_6 & 0xffffffff,local_1a8[0] & 0xffffffff),
            cVar5 != '\0')))) {
          return 1;
        }
        if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x32) {
          return 1;
        }
      }
      lVar18 = (**(code **)(*param_1 + 0x450))(param_1,(int)param_1[0xbc]);
      lVar14 = local_1b8;
      lVar17 = local_1e0;
      if (lVar18 != 0) {
        cVar5 = FUN_180ce0830(param_1,local_1e0);
        if ((*(uint *)(param_1 + 0xbc) < 4) && (cVar4 != '\0')) {
          cVar5 = '\x03';
        }
        if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x36) && (cVar5 == '\0')) {
          cVar5 = '\x03';
        }
        else if (cVar5 == -1) {
          return 1;
        }
        (*(code *)((ulonglong)param_1 ^ param_1[3]))(cVar5,(ulonglong)param_1 ^ 0x3cd24a783cd24a78);
        uVar6 = (**(code **)(*param_1 + 0x440))(param_1,(int)param_1[0xbc]);
        local_1e8 = FUN_180d9c430(DAT_181a1d4f8,*(undefined4 *)(local_1b8 + 0x90),uVar6);
        if (*(uint *)(param_1 + 0xbc) < 4) {
          *(undefined1 *)((longlong)(int)*(uint *)(param_1 + 0xbc) + 0x531 + (longlong)param_1) =
               *(undefined1 *)(local_1b8 + 0xa0);
        }
        local_1d8 = local_1d8 & 0xffffffff00000000;
        iVar8 = FUN_180c65c90(DAT_181a0e3a0,*(undefined4 *)(param_1[0xd] + 4));
        if ((iVar8 != 0) &&
           (*(undefined4 *)(param_10 + 0xc) = *(undefined4 *)((longlong)param_1 + 0x5e4),
           cVar4 == '\0')) {
          local_1d8 = CONCAT44(local_1d8._4_4_,
                               (uint)(*(int *)((longlong)param_1 + 0x5e4) <
                                     *(int *)(param_1[0xe] + 0xc0)));
        }
        bVar7 = (**(code **)(*param_1 + 0x1a8))(param_1);
        uVar22 = (uint)bVar7;
        if (((*(uint *)(param_1[0xd] + 0xc) < 0x26) &&
            ((0x3004480c00U >> ((longlong)(int)*(uint *)(param_1[0xd] + 0xc) & 0x3fU) & 1) != 0)) &&
           ((int)param_1[0x7c] != 0)) {
          uVar22 = 1;
        }
        uVar23 = *(int *)(DAT_181a08d38 + 0xe9e0) + 1;
        lVar17 = local_1e0;
        lVar14 = local_1b8;
        if (((0x33 < uVar23) || ((0x8010400000001U >> ((ulonglong)uVar23 & 0x3f) & 1) == 0)) &&
           ((*(int *)(DAT_181a08d38 + 0xe9e0) != 0x40 &&
            (uVar21 = (ulonglong)(int)param_1[0xbc],
            *(char *)(uVar21 + 0x5cb + (longlong)param_1) == '\0')))) {
          if (lVar16 != 0) {
            FUN_180762840(DAT_1819ecf68,*(undefined1 *)(lVar16 + 0x88));
            uVar21 = (ulonglong)*(uint *)(param_1 + 0xbc);
          }
          uVar9 = (undefined4)(in_stack_fffffffffffffdf0 >> 0x20);
          lVar16 = param_1[0x7c];
          bVar7 = (**(code **)(*param_1 + 0x440))(param_1,uVar21);
          lVar14 = local_1b8;
          lVar17 = local_1e0;
          local_1f8 = *(code **)(param_5 + 3);
          local_1f0 = param_5[5];
          local_1c8 = *(longlong **)param_5;
          local_1c0 = param_5[2];
          in_stack_fffffffffffffdf0 = CONCAT44(uVar9,(int)lVar16);
          uVar15 = CONCAT44(uVar11,uVar22);
          FUN_180762860(DAT_1819ecf68,local_1e0,*(undefined4 *)(local_1b8 + 0x90),&local_1c8,
                        &local_1f8,CONCAT44(uVar10,(uint)bVar7),uVar15,in_stack_fffffffffffffdf0);
          uVar11 = (undefined4)((ulonglong)uVar15 >> 0x20);
        }
      }
    }
    if ((char)local_14c != '\0') {
      fVar28 = *pfVar3;
      if (((fVar28 == 0.0) && (pfVar3[1] == 0.0)) && ((pfVar3[2] == 0.0 && (lVar14 != 0)))) {
        uVar6 = (**(code **)(*param_1 + 0x440))(param_1,(int)param_1[0xbc]);
        FUN_180e879b0(lVar14,uVar6,pfVar3);
        fVar28 = *pfVar3;
      }
      lVar16 = (longlong)(int)param_1[0xbc] + 0x3f;
      *(float *)(param_1 + lVar16 * 3) = fVar28;
      *(float *)((longlong)param_1 + lVar16 * 0x18 + 4) = pfVar3[1];
      *(float *)(param_1 + lVar16 * 3 + 1) = pfVar3[2];
      lVar16 = (longlong)(int)param_1[0xbc];
      if (*(char *)(lVar16 + 0x5cb + (longlong)param_1) != '\0') {
        *(float *)(param_1 + lVar16 * 3 + 0xbd) = DAT_181aa13d0;
        *(float *)((longlong)param_1 + lVar16 * 0x18 + 0x5ec) = DAT_181aa13d4;
        *(float *)(param_1 + lVar16 * 3 + 0xbe) = DAT_181aa13d8;
      }
      if (*param_8 != 0) {
        (**(code **)(*DAT_181a08d10 + 0x178))(DAT_181a08d10,lVar17,&local_1f8,0);
        if (*param_8 == lVar17) {
          local_1b0 = param_7[2] - local_1f0;
          fVar29 = param_7[1] - local_1f8._4_4_;
          fVar28 = *param_7 - (float)local_1f8;
        }
        else {
          (**(code **)(*DAT_181a08d10 + 0x178))(DAT_181a08d10,*param_8,&local_1b8,0);
          local_1b0 = param_7[2] - local_1b0;
          fVar29 = param_7[1] - local_1b8._4_4_;
          fVar28 = *param_7 - (float)local_1b8;
        }
        if ((*pfVar3 - (float)local_1f8) * (*pfVar3 - (float)local_1f8) +
            (pfVar3[1] - local_1f8._4_4_) * (pfVar3[1] - local_1f8._4_4_) +
            (pfVar3[2] - local_1f0) * (pfVar3[2] - local_1f0) <=
            fVar29 * fVar29 + fVar28 * fVar28 + local_1b0 * local_1b0) goto LAB_180cfb670;
      }
      *param_8 = lVar17;
      fVar28 = *pfVar3;
      if ((((fVar28 == 0.0) && (pfVar3[1] == 0.0)) && (pfVar3[2] == 0.0)) && (lVar14 != 0)) {
        uVar6 = (**(code **)(*param_1 + 0x440))(param_1,(int)param_1[0xbc]);
        FUN_180e879b0(lVar14,uVar6,pfVar3);
        *param_7 = *pfVar3;
        param_7[1] = pfVar3[1];
        param_7[2] = pfVar3[2];
        fVar28 = *pfVar3;
      }
      *param_7 = fVar28;
      param_7[1] = pfVar3[1];
      param_7[2] = pfVar3[2];
      if (*(char *)((longlong)(int)param_1[0xbc] + 0x5cb + (longlong)param_1) != '\0') {
        *param_7 = DAT_181aa13d0;
        param_7[1] = DAT_181aa13d4;
        param_7[2] = DAT_181aa13d8;
      }
    }
  }
LAB_180cfb670:
  if (local_184 == 0) {
    if (local_res8 == 0) {
      if (*(int *)(DAT_181a08d38 + 0xe9e0) != -1) {
        if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x32) {
          lVar17 = FUN_180c8a330(DAT_181a19238 + 0x5e50,local_1e0);
          if (lVar17 != 0) {
            return 1;
          }
        }
        else {
          lVar17 = (**(code **)(*param_1 + 0x450))(param_1,(int)param_1[0xbc]);
          if (lVar17 != 0) {
            local_res8 = (local_1e8 == 1) + 3;
          }
        }
      }
      iVar8 = local_1e8;
      lVar17 = FUN_180ec37c0(DAT_181a08d38 + 0xef88,*(undefined8 *)(pfVar3 + 8));
      if ((lVar17 != 0) &&
         (lVar16 = (**(code **)(*param_1 + 0x450))(param_1,(int)param_1[0xbc]), lVar16 != 0)) {
        local_res8 = 3;
      }
      if (((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x1b) || (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x2d))
         && ((iVar8 == 0 && (lVar17 == 0)))) {
        local_180 = 1;
      }
      if (local_res8 == 0) {
        local_res8 = FUN_180d4a190(*(undefined8 *)(pfVar3 + 8));
      }
    }
  }
  else {
    bVar7 = (**(code **)(*param_1 + 0x440))(param_1,(int)param_1[0xbc]);
    local_res8 = bVar7 + 0x28;
  }
  uVar22 = *(uint *)(param_1 + 0xbc);
  if (uVar22 < 4) {
    if (*(char *)((longlong)(int)uVar22 + 0x5cb + (longlong)param_1) == '\0') {
      if (((DAT_181a1b510 != 0) && (lVar17 = FUN_1802e2600(), lVar17 != 0)) &&
         (*(char *)((longlong)(int)uVar22 + 0x5cb + (longlong)param_1) != '\0')) {
        local_res8 = 0xd5;
      }
    }
    else {
      local_res8 = 0xd5;
    }
  }
  if (local_180 != 0) {
    return 1;
  }
  iVar8 = FUN_180c3eb20(DAT_181a0e320);
  if (iVar8 != 0) {
    uVar15 = FUN_180c6f820();
    iVar8 = FUN_180c71410(uVar15);
    if ((iVar8 == 1) && (local_res8 - 3U < 2)) {
      return 1;
    }
  }
  if ((*(int *)(DAT_181a08d38 + 0xe9e0) == 0x14) &&
     ((**(code **)(*DAT_181a08d08 + 0x88))(DAT_181a08d08,*(undefined8 *)(pfVar3 + 8),2,&param_8),
     ((ulonglong)param_8 & 0x2000) != 0)) {
    local_res8 = 0xef;
  }
  iVar8 = FUN_180f8c9d0();
  if ((iVar8 == 0x32) && (DAT_181aa0e70 != 0)) {
    bVar26 = (char)param_1[0xb9] != '\x01';
    if (bVar26) {
      local_1f8 = (code *)0x0;
      local_1f0 = 0.0;
      puVar24 = &local_1f8;
    }
    else {
      local_198 = *(undefined8 *)param_7;
      local_190 = param_7[2];
      puVar24 = &local_198;
    }
    FUN_181157c60(DAT_181aa0e70,!bVar26,puVar24);
  }
  (*(code *)DAT_181952a40[0x27])(&local_17c);
  if (local_17c == param_2) {
    lVar17 = local_1e0;
    if ((param_9 == '\0') &&
       ((*(int *)(param_1[0xd] + 0xc) != 0x14 ||
        (lVar16 = FUN_180f8e740(DAT_181a2bf40,local_res8), lVar17 = local_1e0,
        *(int *)(lVar16 + 0x28) != 1)))) {
      lVar17 = local_1e0;
      in_stack_fffffffffffffdf0 = in_stack_fffffffffffffdf0 & 0xffffffffffffff00;
      uVar15 = CONCAT44(uVar11,local_res8);
      FUN_180cffe20(param_1,param_2,local_1e0,pfVar3,pfVar3 + 3,param_4,uVar15,
                    in_stack_fffffffffffffdf0);
      uVar11 = (undefined4)((ulonglong)uVar15 >> 0x20);
    }
    if ((DAT_1819ecdd0 != 0) && (cVar4 = FUN_1806db1c0(), cVar4 != '\0')) {
      lVar16 = FUN_180c8a330(DAT_181a19238 + 0x5e50,lVar17);
      if (lVar16 == 0) {
        lVar16 = FUN_180ec3e70(DAT_181a08d38 + 0xef88,lVar17);
        if (lVar16 == 0) {
          lVar17 = FUN_180eb42d0(*(undefined8 *)(DAT_181a08d38 + 0xef48),lVar17);
          if ((lVar17 != 0) && (*(int *)(lVar17 + 0x180) == 0)) {
            FUN_1806df270(DAT_1819ecdd0,local_1e8 == 1);
          }
        }
        else if (0.0 < *(float *)(lVar16 + 0x1b0)) {
          *(int *)((longlong)param_1 + 0xb6c) = local_1e8;
        }
      }
      else if (*(int *)(lVar16 + 0x2f0) == 1) {
        *(int *)((longlong)param_1 + 0xb6c) = local_1e8;
      }
    }
  }
  else {
    lVar17 = DAT_181a08d38 + 0xef88;
    if (lVar17 != 0) {
      FUN_180c8a420(DAT_181a19238 + 0x5e50);
      param_8 = (longlong *)0x0;
      iVar8 = (**(code **)(*DAT_181a08d08 + 0x48))(DAT_181a08d08,&param_8);
      if (iVar8 == 0) {
        (**(code **)(*param_8 + 8))();
      }
      else {
        param_8 = (longlong *)0x0;
      }
      (**(code **)(*param_8 + 0x48))(param_8,6,8);
      (**(code **)(*param_8 + 0x48))(param_8,(uint)param_2,8);
      (**(code **)(*param_8 + 0x48))(param_8,param_3,0x10);
      (**(code **)(*param_8 + 0x48))(param_8,0,0x10);
      local_1f8 = (code *)0x0;
      local_1f0 = 0.0;
      (**(code **)(*param_8 + 0xa0))(param_8,&local_1f8);
      (**(code **)(*param_8 + 0x58))(param_8,pfVar3,0x60);
      if (param_2 != 0xff) {
        (**(code **)(*param_8 + 0x48))(param_8,0,1);
        (**(code **)(*param_8 + 0x48))(param_8,0,1);
        (**(code **)(*param_8 + 0x48))(param_8,0,1);
        (**(code **)(*param_8 + 0x48))(param_8,0,0x20);
        (**(code **)(*param_8 + 0x48))(param_8,0,1);
      }
      (**(code **)(*param_8 + 0x48))(param_8,0,1);
      (**(code **)(*param_8 + 0x48))(param_8,0,1);
      if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x13) {
        (**(code **)(*param_8 + 0x48))(param_8,0,1);
      }
      (**(code **)(*param_8 + 0x48))(param_8,0,1);
      (**(code **)(*param_8 + 0x48))(param_8,0,1);
      (**(code **)(*param_8 + 0x48))(param_8,0,1);
      pfVar19 = (float *)(**(code **)(*param_8 + 0x38))();
      param_6 = pfVar19;
      if (pfVar19 != (float *)0x0) {
        (**(code **)(*(longlong *)pfVar19 + 8))(pfVar19);
      }
      FUN_180ebccd0(lVar17,0,pfVar19);
      if (pfVar19 != (float *)0x0) {
        (**(code **)(*(longlong *)pfVar19 + 0x10))(pfVar19);
      }
      if (param_8 != (longlong *)0x0) {
        (**(code **)(*param_8 + 0x10))();
      }
    }
  }
  if (((*(uint *)(param_1[0xd] + 0xc) < 0x26) &&
      ((0x3004480c00U >> ((longlong)(int)*(uint *)(param_1[0xd] + 0xc) & 0x3fU) & 1) != 0)) &&
     ((int)param_1[0x7c] != 0)) {
    return 1;
  }
  if ((float)local_1d8 == 0.0) {
    return 1;
  }
  lVar17 = FUN_180f8e740(DAT_181a2bf40,local_res8);
  if (lVar17 == 0) {
    return 1;
  }
  cVar4 = (**(code **)(*param_1 + 0x1a8))(param_1);
  if (cVar4 != '\0') {
    return 1;
  }
  if (*(int *)(lVar17 + 0x28) == 0) {
    if (1 < local_res8 - 3U) {
      return 1;
    }
    local_1b8 = *(longlong *)param_4;
    local_1b0 = param_4[2];
    local_1f8 = *(code **)pfVar3;
    local_1f0 = pfVar3[2];
    iVar8 = (**(code **)(*param_1 + 0x310))(param_1);
    if (((iVar8 == 0) && (iVar8 = (**(code **)(*param_1 + 0x340))(param_1), iVar8 == 0)) &&
       (iVar8 = (**(code **)(*param_1 + 0x370))(param_1), iVar8 == 0)) {
      cVar4 = FUN_180c59f30(param_1[0xd]);
      uVar22 = 0;
      if ((cVar4 != '\0') && (uVar22 = 0, *(int *)(param_1[0xd] + 0xc) == 2)) {
        cVar4 = (**(code **)(*param_1 + 0x430))(param_1);
        uVar22 = (uint)(cVar4 != '\0');
      }
    }
    else {
      uVar22 = 2;
    }
    fVar1 = local_1f0;
    fVar28 = (float)local_1f8;
    fVar32 = (float)local_1f8 - *(float *)((longlong)param_1 + 0x524);
    fVar29 = local_1f8._4_4_;
    fVar33 = local_1f8._4_4_ - *(float *)(param_1 + 0xa5);
    fVar31 = local_1f0 - *(float *)((longlong)param_1 + 0x52c);
    iVar8 = FUN_180c594a0(param_1[0xd],uVar22);
    fVar31 = fVar33 * fVar33 + fVar32 * fVar32 + fVar31 * fVar31;
    if (fVar31 < 0.0) {
      fVar31 = sqrtf(fVar31);
    }
    else {
      fVar31 = SQRT(fVar31);
    }
    if ((float)iVar8 - fVar31 < 1.0) {
      return 1;
    }
    if (param_10 != 0) {
      *(undefined8 *)(param_10 + 0x10) = 0;
    }
    *param_5 = (float)local_1b8 + fVar28;
    param_5[1] = local_1b8._4_4_ + fVar29;
    param_5[2] = local_1b0 + fVar1;
    *(int *)((longlong)param_1 + 0x5e4) = *(int *)((longlong)param_1 + 0x5e4) + 1;
    return 0;
  }
  iVar8 = *(int *)(lVar17 + 0x30);
  param_8 = (longlong *)CONCAT44(param_8._4_4_,iVar8);
  local_148 = 0;
  uStack_140 = 0;
  local_138 = 0;
  local_130 = 0;
  local_128 = 0;
  local_120 = 0xffffffffffffffff;
  local_118 = 0;
  local_d8 = 0;
  local_c0 = 0;
  local_f0 = 0;
  local_e8 = 0;
  local_e4 = 7;
  fVar30 = (float)(iVar8 + 1);
  fVar28 = param_4[2];
  fVar29 = param_4[1];
  fVar1 = *param_4;
  fVar31 = pfVar3[2];
  local_168 = fVar30 * fVar28 + fVar31;
  fVar32 = pfVar3[1];
  fVar33 = *pfVar3;
  local_15c = fVar31 - fVar28;
  local_170 = CONCAT44(fVar30 * fVar29 + fVar32,fVar30 * fVar1 + fVar33);
  local_164 = CONCAT44(fVar32 - fVar29,fVar33 - fVar1);
  local_158 = 0x7f7fffff;
  local_e0 = FUN_180d0a6e0;
  local_c8 = &local_178;
  local_d0 = FUN_180d08320;
  local_108 = local_170;
  local_100 = local_168;
  local_fc = local_164;
  local_f4 = local_15c;
  if (*(int *)(lVar17 + 0x20) == 0xc9) {
    *pfVar3 = fVar1 + fVar33;
    pfVar3[1] = fVar29 + fVar32;
    pfVar3[2] = fVar28 + fVar31;
    if (local_17c == param_2) {
      local_178 = param_1;
      FUN_180cffe20(param_1,param_2,*(undefined8 *)(pfVar3 + 8),pfVar3,pfVar3 + 3,param_4,
                    CONCAT44(uVar11,0xc9),in_stack_fffffffffffffdf0 & 0xffffffffffffff00);
    }
    else {
      lVar16 = DAT_181a08d38 + 0xef88;
      local_178 = param_1;
      if (lVar16 != 0) {
        FUN_180c8a420(DAT_181a19238 + 0x5e50);
        param_8 = (longlong *)0x0;
        iVar8 = (**(code **)(*DAT_181a08d08 + 0x48))(DAT_181a08d08,&param_8);
        if (iVar8 == 0) {
          (**(code **)(*param_8 + 8))();
        }
        else {
          param_8 = (longlong *)0x0;
        }
        (**(code **)(*param_8 + 0x48))(param_8,6,8);
        (**(code **)(*param_8 + 0x48))(param_8,(uint)param_2,8);
        (**(code **)(*param_8 + 0x48))(param_8,param_3,0x10);
        (**(code **)(*param_8 + 0x48))(param_8,0,0x10);
        local_1f8 = (code *)0x0;
        local_1f0 = 0.0;
        (**(code **)(*param_8 + 0xa0))(param_8,&local_1f8);
        (**(code **)(*param_8 + 0x58))(param_8,pfVar3,0x60);
        if (param_2 != 0xff) {
          (**(code **)(*param_8 + 0x48))(param_8,0,1);
          (**(code **)(*param_8 + 0x48))(param_8,0,1);
          (**(code **)(*param_8 + 0x48))(param_8,0,1);
          (**(code **)(*param_8 + 0x48))(param_8,0,0x20);
          (**(code **)(*param_8 + 0x48))(param_8,0,1);
        }
        (**(code **)(*param_8 + 0x48))(param_8,0,1);
        (**(code **)(*param_8 + 0x48))(param_8,0,1);
        if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x13) {
          (**(code **)(*param_8 + 0x48))(param_8,0,1);
        }
        (**(code **)(*param_8 + 0x48))(param_8,0,1);
        (**(code **)(*param_8 + 0x48))(param_8,0,1);
        (**(code **)(*param_8 + 0x48))(param_8,0,1);
        pfVar19 = (float *)(**(code **)(*param_8 + 0x38))();
        param_6 = pfVar19;
        if (pfVar19 != (float *)0x0) {
          (**(code **)(*(longlong *)pfVar19 + 8))(pfVar19);
        }
        FUN_180ebccd0(lVar16,0,pfVar19);
        if (pfVar19 != (float *)0x0) {
          (**(code **)(*(longlong *)pfVar19 + 0x10))(pfVar19);
        }
        if (param_8 != (longlong *)0x0) {
          (**(code **)(*param_8 + 0x10))();
        }
      }
    }
    local_198 = *(undefined8 *)param_4;
    local_190 = param_4[2];
    fVar28 = 0.0;
    local_1f0 = pfVar3[2];
    local_1f8 = (code *)*(undefined8 *)pfVar3;
LAB_180cfc099:
    uVar25 = FUN_180cda350(param_1,*(undefined4 *)(lVar17 + 0x404),*(undefined4 *)(lVar17 + 0x2c),
                           fVar28,&local_1f8,param_5,param_5 + 3,&local_198,param_10);
  }
  else {
    if (DAT_181a2b600 == 0) {
      local_178 = param_1;
      cVar4 = (**(code **)(*DAT_181952a40 + 0x210))(DAT_181952a40,&local_108,&local_148,0);
    }
    else {
      pcVar2 = *(code **)(*DAT_181952a40 + 0x210);
      local_178 = param_1;
      uVar15 = FUN_180ef9480();
      cVar4 = (*pcVar2)(DAT_181952a40,&local_108,&local_148,uVar15);
      iVar8 = (int)param_8;
    }
    if (cVar4 != '\0') {
      *(undefined4 *)(param_1 + 0xe4) = 1;
      fVar28 = ((float)local_148 - *pfVar3) * ((float)local_148 - *pfVar3) +
               (local_148._4_4_ - pfVar3[1]) * (local_148._4_4_ - pfVar3[1]) +
               ((float)uStack_140 - pfVar3[2]) * ((float)uStack_140 - pfVar3[2]);
      if (fVar28 < 0.0) {
        fVar28 = sqrtf(fVar28);
      }
      else {
        fVar28 = SQRT(fVar28);
      }
      if ((float)iVar8 <= fVar28) {
        return 1;
      }
      iVar8 = FUN_180d4a140(local_120);
      if ((((local_res8 == 0xf2) || (iVar8 == 0xf2)) || (local_res8 == 0xf3)) ||
         ((iVar8 == 0xf3 || (local_res8 == iVar8)))) {
        local_148 = CONCAT44(local_148._4_4_ + param_4[1],(float)local_148 + *param_4);
        uStack_140 = CONCAT44(uStack_140._4_4_,(float)uStack_140 + param_4[2]);
        if ((local_17c != param_2) &&
           (param_6 = (float *)(DAT_181a08d38 + 0xef88), param_6 != (float *)0x0)) {
          FUN_180c8a420(DAT_181a19238 + 0x5e50);
          param_8 = (longlong *)0x0;
          iVar8 = (**(code **)(*DAT_181a08d08 + 0x48))(DAT_181a08d08,&param_8);
          if (iVar8 == 0) {
            (**(code **)(*param_8 + 8))();
          }
          else {
            param_8 = (longlong *)0x0;
          }
          (**(code **)(*param_8 + 0x48))(param_8,6,8);
          (**(code **)(*param_8 + 0x48))(param_8,(uint)param_2,8);
          (**(code **)(*param_8 + 0x48))(param_8,param_3,0x10);
          (**(code **)(*param_8 + 0x48))(param_8,0,0x10);
          local_1f8 = (code *)0x0;
          local_1f0 = 0.0;
          (**(code **)(*param_8 + 0xa0))(param_8,&local_1f8);
          (**(code **)(*param_8 + 0x58))(param_8,&local_148,0x60);
          if (param_2 != 0xff) {
            (**(code **)(*param_8 + 0x48))(param_8,0,1);
            (**(code **)(*param_8 + 0x48))(param_8,0,1);
            (**(code **)(*param_8 + 0x48))(param_8,0,1);
            (**(code **)(*param_8 + 0x48))(param_8,0,0x20);
            (**(code **)(*param_8 + 0x48))(param_8,0,1);
          }
          (**(code **)(*param_8 + 0x48))(param_8,0,1);
          (**(code **)(*param_8 + 0x48))(param_8,0,1);
          if (*(int *)(DAT_181a08d38 + 0xe9e0) == 0x13) {
            (**(code **)(*param_8 + 0x48))(param_8,0,1);
          }
          (**(code **)(*param_8 + 0x48))(param_8,0,1);
          (**(code **)(*param_8 + 0x48))(param_8,0,1);
          (**(code **)(*param_8 + 0x48))(param_8,0,1);
          plVar20 = (longlong *)(**(code **)(*param_8 + 0x38))();
          if (plVar20 != (longlong *)0x0) {
            (**(code **)(*plVar20 + 8))(plVar20);
          }
          FUN_180ebccd0(param_6,0,plVar20);
          if (plVar20 != (longlong *)0x0) {
            (**(code **)(*plVar20 + 0x10))(plVar20);
          }
          if (param_8 != (longlong *)0x0) {
            (**(code **)(*param_8 + 0x10))();
          }
        }
        if ((param_9 == '\0') && (*(int *)(param_1[0xd] + 0xc) == 0x14)) {
          FUN_180cffe20(param_1,param_2,local_1e0,pfVar3,pfVar3 + 3,param_4,
                        CONCAT44(uVar11,local_res8),1);
        }
        local_198 = *(undefined8 *)param_4;
        local_190 = param_4[2];
        local_1f0 = (float)uStack_140;
        local_1f8 = (code *)local_148;
        goto LAB_180cfc099;
      }
    }
    if ((param_9 == '\0') && (*(int *)(param_1[0xd] + 0xc) == 0x14)) {
      FUN_180cffe20(param_1,param_2,local_1e0,pfVar3,pfVar3 + 3,param_4,CONCAT44(uVar11,local_res8),
                    in_stack_fffffffffffffdf0 & 0xffffffffffffff00);
    }
  }
  return uVar25;
}

