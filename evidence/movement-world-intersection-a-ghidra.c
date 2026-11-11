
undefined8 FUN_180f036e0(longlong param_1,longlong param_2)

{
  uint local_res10 [6];
  
  if ((param_2 != 0) && (param_1 == param_2)) {
    return 1;
  }
  (**(code **)(*DAT_181a08d08 + 0x88))(DAT_181a08d08,param_1,2,local_res10);
  if ((((local_res10[0] & 0x1000000) == 0) &&
      ((**(code **)(*DAT_181a08d08 + 0x88))(DAT_181a08d08,param_1,0,local_res10),
      (local_res10[0] & 1) != 0)) && ((local_res10[0] >> 0xf & 1) == 0)) {
    return 1;
  }
  return 0;
}

