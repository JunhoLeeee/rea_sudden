
longlong * FUN_14029b650(longlong *param_1,longlong *param_2)

{
  ulonglong uVar1;
  ulonglong uVar2;
  ulonglong uVar3;
  longlong lVar4;
  code *pcVar5;
  longlong lVar6;
  longlong *plVar7;
  ulonglong uVar8;
  longlong lVar9;
  ulonglong uVar10;
  longlong *plVar11;
  
  if (param_1 != param_2) {
    plVar7 = param_2;
    if (7 < (ulonglong)param_2[3]) {
      plVar7 = (longlong *)*param_2;
    }
    uVar2 = param_2[2];
    uVar3 = param_1[3];
    if (uVar3 < uVar2) {
      if (0x7ffffffffffffffe < uVar2) {
                    /* WARNING: Subroutine does not return */
        FUN_140027fd0();
      }
      uVar8 = uVar2 | 7;
      uVar10 = 0x7ffffffffffffffe;
      if (((uVar8 < 0x7fffffffffffffff) && (uVar3 <= 0x7ffffffffffffffe - (uVar3 >> 1))) &&
         (uVar1 = (uVar3 >> 1) + uVar3, uVar10 = uVar8, uVar8 < uVar1)) {
        uVar10 = uVar1;
      }
      lVar6 = FUN_140030400(param_1,uVar10 + 1);
      param_1[3] = uVar10;
      param_1[2] = uVar2;
      FUN_1402b8fa7(lVar6,plVar7,uVar2 * 2);
      *(undefined2 *)(uVar2 * 2 + lVar6) = 0;
      if (7 < uVar3) {
        lVar4 = *param_1;
        lVar9 = lVar4;
        if (0xfff < uVar3 * 2 + 2) {
          lVar9 = *(longlong *)(lVar4 + -8);
          if (0x1f < (lVar4 - lVar9) - 8U) {
            (*(code *)0x3d7636)(lVar4 - lVar9,uVar3 * 2 + 0x29);
            pcVar5 = (code *)swi(3);
            plVar7 = (longlong *)(*pcVar5)();
            return plVar7;
          }
        }
        thunk_FUN_1402b909d(lVar9);
      }
      *param_1 = lVar6;
    }
    else {
      plVar11 = param_1;
      if (7 < uVar3) {
        plVar11 = (longlong *)*param_1;
      }
      param_1[2] = uVar2;
      FUN_1402b8fad(plVar11,plVar7,uVar2 * 2);
      *(undefined2 *)(uVar2 * 2 + (longlong)plVar11) = 0;
    }
  }
  return param_1;
}

