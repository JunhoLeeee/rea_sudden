
undefined8
FUN_1400a5570(byte *param_1,undefined8 *param_2,byte *param_3,longlong param_4,int *param_5)

{
  bool bVar1;
  byte bVar2;
  int iVar3;
  byte *pbVar4;
  longlong lVar5;
  bool bVar6;
  
  *param_5 = 0;
  do {
    bVar1 = false;
    iVar3 = 0;
    bVar2 = *param_1;
    while (bVar2 == 0x20) {
      pbVar4 = param_1 + 1;
      param_1 = param_1 + 1;
      bVar2 = *pbVar4;
    }
    if (bVar2 == 0) {
      return 0;
    }
    lVar5 = 0;
    pbVar4 = param_3;
    while (bVar2 != 0) {
      if (bVar2 == 0x25) {
        bVar2 = param_1[1];
        param_1 = param_1 + 1;
        bVar6 = bVar2 == 0;
LAB_1400a5684:
        if (!bVar6) goto LAB_1400a5686;
        break;
      }
      if (((bVar2 == 0x3b) || (bVar2 < 0x20)) || (bVar2 == 0x7f)) {
        *pbVar4 = 0;
        if (*param_3 == 0) {
          *param_2 = param_1 + 1;
          return 1;
        }
        goto LAB_1400a561c;
      }
      if (bVar2 == 0x28) {
        iVar3 = iVar3 + 1;
        if (iVar3 != 1) goto LAB_1400a5686;
LAB_1400a56a2:
        bVar2 = param_1[1];
        param_1 = param_1 + 1;
      }
      else {
        if (bVar2 == 0x29) {
          iVar3 = iVar3 + -1;
          if (iVar3 != 0) {
LAB_1400a5686:
            *pbVar4 = bVar2;
            if (0xff < lVar5) {
              *pbVar4 = 0;
              pbVar4 = pbVar4 + -1;
              lVar5 = lVar5 + -1;
            }
            pbVar4 = pbVar4 + 1;
            lVar5 = lVar5 + 1;
            goto LAB_1400a56a2;
          }
          param_1 = param_1 + 1;
          break;
        }
        if (bVar2 != 0x22) {
          if (bVar2 == 0x20) {
            bVar6 = iVar3 == 0;
            goto LAB_1400a5684;
          }
          goto LAB_1400a5686;
        }
        if (iVar3 == 0) {
          iVar3 = 1;
        }
        else {
          bVar1 = true;
          param_1 = param_1 + 1;
        }
        if (bVar1) break;
        bVar2 = param_1[1];
        param_1 = param_1 + 1;
      }
    }
    *pbVar4 = 0;
    if (*param_3 == 0) {
      return 0;
    }
LAB_1400a561c:
    *(byte **)(param_4 + (longlong)*param_5 * 8) = param_3;
    *param_5 = *param_5 + 1;
    param_3 = pbVar4 + 1;
    if (0x1d < *param_5) {
      return 0;
    }
  } while( true );
}

