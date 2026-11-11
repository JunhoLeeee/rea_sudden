"""Installed-build command bytes and verified control-bit fragments.

This does not implement the whole movement manager. UI, mode, weapon and
character gates between these blocks remain in the native analysis ledger.
"""
from dataclasses import dataclass


COMMAND_BYTE_COUNT = 255
# Action identities come from the original engine's AddAction declarations.
BASIC_DIRECTION_MASKS = {10: 0x8, 11: 0x4, 0: 0x1, 1: 0x2, 14: 0x100, 13: 0x80}


def _index(command):
    if type(command) is not int or not -(1 << 31) <= command < 1 << 32:
        raise ValueError('command must fit the native 32-bit argument')
    return command & 0xffffffff


def _flags(value):
    if type(value) is not int or not 0 <= value < 1 << 32:
        raise ValueError('control flags must be uint32')
    return value


class CommandBytes:
    """255 supplied engine command bytes; native +0xcc0 storage behavior.

    query corresponds to 140086060 -> 1400911e0, clear to
    140083510 -> 14008b9e0. New key/device-to-command writes are not invented.
    """
    def __init__(self, snapshot):
        if not isinstance(snapshot, (bytes, bytearray)) or len(snapshot) != COMMAND_BYTE_COUNT:
            raise ValueError('exactly 255 source command bytes required')
        self._bytes = bytearray(snapshot)

    def query(self, command):
        index = _index(command)
        return self._bytes[index] if index < COMMAND_BYTE_COUNT else 0

    def clear(self, command):
        index = _index(command)
        if index < COMMAND_BYTE_COUNT:
            self._bytes[index] = 0

    def snapshot(self):
        return bytes(self._bytes)


def poll_basic_direction_bits(commands):
    """Read six verified action queries; caller retains normal-path gates."""
    result = 0
    for action, mask in BASIC_DIRECTION_MASKS.items():
        if commands.query(action):
            result |= mask
    return result


def poll_run_control_bit(commands, current, *, runlock, mode, player_458_first,
                         mode_36_override=0):
    """Replay 180efa892..180efa924 after the caller's normal-path gates.

    Action 7's raw byte is compared with (runlock != 0), rather than first
    converting both operands to bool. The source only ORs 0x200; no branch
    clears an existing run bit. mode_36_override is the supplied return of
    FUN_180f8c590, not a fabricated mode state.
    """
    flags = _flags(current)
    for value in (runlock, mode, player_458_first, mode_36_override):
        if type(value) is not int or not -(1 << 31) <= value < 1 << 31:
            raise ValueError('int32 context fields required')
    if player_458_first != 0:
        return flags
    if mode != 0x13 or runlock != 0:
        if commands.query(7) != int(runlock != 0):
            flags |= 0x200
    if mode == 0x36 and mode_36_override == 1:
        flags |= 0x200
    return flags


@dataclass(frozen=True)
class ControlPostprocess:
    flags: int
    jump_latch_write: int | None


def postprocess_control_flags(current, previous):
    """Replay 180efac77..180efaccf after callers supply the full flags.

    None means that block makes no write to +0x46c, not that it clears it.
    """
    flags, old = _flags(current), _flags(previous)
    if flags & 0x4 and flags & 0x40:
        flags |= 0x100
    if flags & 0x8 and flags & 0x40:
        flags |= 0x80
    if flags & 0x30193:
        flags |= 0x800
    return ControlPostprocess(flags, 1 if flags & 0x10 and not old & 0x10 else None)


def begin_control_frame(current):
    """180ef9f7e..180ef9f8a copies +0x8c to +0xe4 and clears current."""
    return {'previous': _flags(current), 'current': 0}


def mode_50_control_filter(current, previous):
    """Replay 180efa1de..180efa1ff only after its mode/state gates pass.

    The enclosing frame calls this after normal-control postprocessing and
    before a later player-supplied flag OR. It explicitly clears +0x46c.
    Calling postprocess_control_flags again here would invent a source step.
    """
    flags, old = _flags(current), _flags(previous)
    return ControlPostprocess((flags & 0xfdfcf400) | (old & 0x20), 0)
