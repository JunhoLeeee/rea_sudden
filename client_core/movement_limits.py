"""Supplied-state replay of installed CShell FUN_180ef1ff0.

Source: evidence/movement-max-velocity-ghidra.json plus selected native bytes.
Opaque context fields intentionally retain offsets until their full owners and
state transitions are established. This is a speed-limit consumer, not a full
physics step or a claim that an original server selected these values.
"""
from dataclasses import dataclass
import math
import struct


def f32(value):
    value=float(value)
    if not math.isfinite(value):
        raise ValueError('finite scalar profile required')
    return struct.unpack('<f',struct.pack('<f',value))[0]


@dataclass(frozen=True)
class MovementLimitContext:
    flags: int
    scalar_f8: float
    scalar_100: float
    scalar_f4: float
    scalar_104: float
    state_50: int = 0
    state_e8: int = 0
    player_state_3a0: int = 0
    player_flag_5ec: int = 0
    helper_d1ca50: int = 0
    player_458_first: int = 0
    player_byte_540: int = 0
    damage_timer_450: float = 0
    damage_penalty_b28: float = 0
    damage_move_penalty_cvar: float = .5
    mode: int = 0
    global_ecee0_present: bool = False
    global_ecee0_cf8: int = 0
    mode_d_bonus_matches: bool = False
    mode_d_bonus_multiplier: float = 0


@dataclass(frozen=True)
class MovementLimitResult:
    limit: float
    selected_field: str
    pre_penalty_limit: float
    effective_penalty: float
    mode_d_flag_30_write: int | None


def movement_limit(context):
    c=context
    if type(c.flags) is not int or not 0 <= c.flags < 1 << 32:
        raise ValueError('uint32 flags required')
    for value in (c.state_50,c.state_e8,c.player_state_3a0,c.player_flag_5ec,c.helper_d1ca50,
                  c.player_458_first,c.player_byte_540,c.mode,c.global_ecee0_cf8):
        if type(value) is not int or not -(1 << 31) <= value < 1 << 31:
            raise ValueError('int32 context fields required')
    slow,fast,s50,se8=map(f32,(c.scalar_f8,c.scalar_100,c.scalar_f4,c.scalar_104))
    run,duck=bool(c.flags&0x200),bool(c.flags&0x20)
    if c.state_50:
        value,field=s50,'+0xf4'
        if not run:value=f32(value*.5)
        if duck:value=f32(value/3.0)
    elif c.state_e8:
        value,field=se8,'+0x104'
        if not run:value=f32(value*.5)
    else:
        state_group=c.player_state_3a0>0 or bool(c.player_flag_5ec)
        if c.helper_d1ca50:state_group=False
        special_four=c.player_state_3a0==4
        blocked_group=not special_four and state_group
        if run and not duck and not blocked_group and c.player_458_first==0:
            value,field=fast,'+0x100'
        else:
            value,field=slow,'+0xf8'
    if c.player_byte_540 in (1,4) and slow<value:
        value=f32(value-f32(value-slow))
    pre_penalty=value
    penalty=f32(0)
    side_effect=None
    if f32(c.damage_timer_450)!=0:
        penalty=f32(c.damage_move_penalty_cvar)
        override=f32(c.damage_penalty_b28)
        if c.mode==0x13 and override>0:penalty=override
        if c.global_ecee0_present and c.global_ecee0_cf8 and override>0:penalty=override
        if c.mode!=0x16:
            shifted=(c.mode-0x22)&0xffffffff
            if shifted<0x23 and (0x400002001>>shifted)&1 and override>0:
                penalty=override
            if c.mode==0xd:
                extra=f32(0)
                if c.mode_d_bonus_matches:
                    extra=f32(f32(c.mode_d_bonus_multiplier)*penalty)
                    side_effect=1
                if penalty<=extra:penalty=extra
                return MovementLimitResult(f32(f32(1.0-penalty)*value),field,pre_penalty,penalty,side_effect)
        penalty=override if override>0 else f32(0)
    return MovementLimitResult(f32(f32(1.0-penalty)*value),field,pre_penalty,penalty,side_effect)
