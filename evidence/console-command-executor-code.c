
/* WARNING: Function: __chkstk replaced with injection: alloca_probe */
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

void FUN_1400a4520(longlong param_1,undefined8 param_2,uint param_3,uint param_4)

{
  char cVar1;
  char cVar2;
  bool bVar3;
  bool bVar4;
  char *pcVar5;
  char cVar6;
  int iVar7;
  longlong lVar8;
  ulonglong uVar9;
  longlong lVar10;
  code *pcVar11;
  uint uVar12;
  longlong lVar13;
  char *pcVar14;
  double dVar15;
  undefined1 auStack_1698 [32];
  char *local_1678;
  char *local_1670 [63];
  int local_1478;
  undefined8 local_1470;
  undefined1 local_1468 [5120];
  char local_68 [56];
  ulonglong local_30;
  
  local_30 = DAT_1403eef38 ^ (ulonglong)auStack_1698;
  FUN_1402b8fb3(&local_1678,0,0x200);
  local_1478 = 0;
  FUN_1402b8fb3(local_1468,0,0x1400);
  local_1470 = param_2;
  cVar6 = FUN_1400a5430(&local_1678);
  do {
    if (cVar6 == '\0') {
      return;
    }
    if (0 < local_1478) {
      if ((param_3 & 2) == 0) {
        for (lVar8 = *(longlong *)(param_1 + 0x38); lVar8 != param_1 + 0x30;
            lVar8 = *(longlong *)(lVar8 + 8)) {
          pcVar14 = local_1678;
          while( true ) {
            cVar6 = *pcVar14;
            cVar1 = pcVar14[**(longlong **)(lVar8 + 0x10) - (longlong)local_1678];
            cVar2 = cVar6 + -0x20;
            if (0x19 < (byte)(cVar6 + 0x9fU)) {
              cVar2 = cVar6;
            }
            cVar6 = cVar1 + -0x20;
            if (0x19 < (byte)(cVar1 + 0x9fU)) {
              cVar6 = cVar1;
            }
            if (cVar6 != cVar2) break;
            if (cVar1 == '\0') {
              (*(code *)(*(longlong **)(lVar8 + 0x10))[1])(local_1478 + -1,local_1670);
              goto LAB_1400a48b6;
            }
            pcVar14 = pcVar14 + 1;
          }
        }
      }
      if (local_1478 == 2) {
        if ((param_3 & 1) == 0) {
          bVar4 = false;
          bVar3 = false;
          if (*local_1678 == '+') {
            uVar12 = param_4 | 1;
LAB_1400a4686:
            pcVar14 = local_1678 + 1;
          }
          else {
            pcVar14 = local_1678;
            uVar12 = param_4;
            if (*local_1678 == '-') {
              bVar3 = true;
              goto LAB_1400a4686;
            }
          }
          lVar8 = -1;
          do {
            lVar13 = lVar8 + 1;
            lVar8 = lVar8 + 1;
          } while (pcVar14[lVar13] != '\0');
          lVar8 = FUN_1400bc630(*(undefined8 *)(param_1 + 0x70),pcVar14,(int)lVar8 + 1);
          if ((lVar8 == 0) || (lVar8 = FUN_1400bc9c0(lVar8), lVar8 == 0)) {
            bVar4 = true;
            lVar8 = FUN_1400a42c0(param_1,pcVar14);
          }
          uVar12 = uVar12 | *(uint *)(lVar8 + 0x30);
          *(uint *)(lVar8 + 0x30) = uVar12;
          if (bVar3) {
            *(uint *)(lVar8 + 0x30) = uVar12 & 0xfffffffe;
          }
          if ((*local_1670[0] == '!') && (local_1670[0][1] == '\0')) {
            if (*(char **)(lVar8 + 0x18) == (char *)0x0) {
              local_1670[0] = "1";
            }
            else {
              iVar7 = (*(code *)0x3d78fe)((int)**(char **)(lVar8 + 0x18));
              if ((iVar7 != 0) || (**(char **)(lVar8 + 0x18) == '-')) {
                FUN_1400780f0(local_68,0x32,&DAT_14030bf4c,(int)*(float *)(lVar8 + 0x20) == 0);
                local_1670[0] = local_68;
              }
            }
          }
          pcVar5 = local_1670[0];
          pcVar14 = *(char **)(lVar8 + 0x18);
          if (pcVar14 == (char *)0x0) {
LAB_1400a47a0:
            uVar9 = 0xffffffffffffffff;
            do {
              uVar9 = uVar9 + 1;
            } while (local_1670[0][uVar9] != '\0');
            if (uVar9 < 0x10) {
              (*(code *)0x3d7794)(lVar8,local_1670[0],0xf);
              *(undefined1 *)(lVar8 + 0xf) = 0;
              lVar10 = lVar8;
            }
            else {
              lVar13 = -1;
              do {
                lVar10 = lVar13 + 1;
                lVar13 = lVar13 + 1;
              } while (local_1670[0][lVar10] != '\0');
              iVar7 = (int)lVar13 + 1;
              lVar13 = FUN_1400bc630(*(undefined8 *)(param_1 + 0x78),local_1670[0],iVar7);
              if (lVar13 == 0) {
                lVar13 = FUN_1400bc1f0(*(undefined8 *)(param_1 + 0x78),pcVar5,iVar7);
                lVar10 = 0;
                if (lVar13 == 0) goto LAB_1400a4820;
              }
              lVar10 = FUN_1400bc9a0(lVar13,0);
            }
LAB_1400a4820:
            *(longlong *)(lVar8 + 0x18) = lVar10;
            dVar15 = (double)(*(code *)0x3d770c)(local_1670[0]);
            *(float *)(lVar8 + 0x20) = (float)dVar15;
            FUN_1400a51b0(param_1,lVar8);
          }
          else {
            lVar13 = (longlong)local_1670[0] - (longlong)pcVar14;
            do {
              cVar6 = *pcVar14;
              cVar1 = pcVar14[lVar13];
              if (cVar6 != cVar1) break;
              pcVar14 = pcVar14 + 1;
            } while (cVar1 != '\0');
            if (cVar6 != cVar1) goto LAB_1400a47a0;
            FUN_1400a51b0(param_1,lVar8);
            if (!bVar4) goto LAB_1400a48b6;
          }
          if (bVar4) {
            pcVar11 = *(code **)(param_1 + 0x60);
          }
          else {
            pcVar11 = *(code **)(param_1 + 0x68);
          }
          if (pcVar11 != (code *)0x0) {
            (*pcVar11)(param_1,lVar8);
          }
        }
      }
      else if (local_1478 == 1) {
        lVar8 = -1;
        do {
          lVar13 = lVar8 + 1;
          lVar8 = lVar8 + 1;
        } while (local_1678[lVar13] != '\0');
        lVar8 = FUN_1400bc630(*(undefined8 *)(param_1 + 0x70),local_1678,(int)lVar8 + 1);
        if (((lVar8 != 0) && (lVar8 = FUN_1400bc9c0(lVar8), lVar8 != 0)) &&
           (*(longlong *)(lVar8 + 0x18) != 0)) {
          (**(code **)(param_1 + 0x48))("%s = %s",*(undefined8 *)(lVar8 + 0x10));
        }
      }
    }
LAB_1400a48b6:
    cVar6 = FUN_1400a5430(&local_1678);
  } while( true );
}

