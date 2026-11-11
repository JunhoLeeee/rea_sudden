"""Observed lightmap selection and null-color-key uploads for this engine build.

Device results and the cached 32BitLightMaps integer are supplied inputs. This
does not query a GPU, run the game, or reproduce filtering/blend precision.
"""
from dataclasses import dataclass
from typing import Callable


@dataclass(frozen=True)
class LightmapFormat:
    code: int
    checked: tuple[int, ...]
    unchecked_fallback: bool = False


def select_lightmap_format(cached_32bit: int, check: Callable[[int], int]) -> LightmapFormat:
    """Replay 0x1401e11c0..0x1401e130f with a stable supplied setting.

    The native branch requires HRESULT == 0, not merely SUCCEEDED(hr). Its
    final R5G6B5 fallback is assigned without checking format 23.
    """
    if type(cached_32bit) is not int or not -(1 << 31) <= cached_32bit < 1 << 31:
        raise ValueError('Cached setting must be int32')
    candidates = (20, 22, 21, 24, 25) if cached_32bit != 0 else (24, 25)
    checked = []
    for code in candidates:
        checked.append(code)
        result = check(code)
        if type(result) is not int or not -(1 << 31) <= result < 1 << 32:
            raise ValueError('Expected a 32-bit HRESULT integer')
        if result == 0:
            return LightmapFormat(code, tuple(checked))
    return LightmapFormat(23, tuple(checked), True)


def upload_rgb(triplets: bytes, format_code: int) -> bytes:
    """Tightly packed destination rows, excluding device pitch padding.

    Source is decoded DAT RGB. Type 8->8 is the observed byte copy, even though
    D3D format 20 interprets those bytes as BGR. Type 8->3 writes BGR0. The
    16-bit lookup floors channel * ((1<<bits)-1) / 255; it does not drop bits.
    Supported outputs are exactly the format-selector's six candidates.
    """
    if not isinstance(triplets, (bytes, bytearray)) or len(triplets) % 3:
        raise ValueError('Expected complete RGB triplets')
    if type(format_code) is not int:
        raise ValueError('Expected an integer format code')
    if format_code == 20:
        return bytes(triplets)
    if format_code not in (21, 22, 23, 24, 25):
        raise ValueError('Format outside observed lightmap selection')
    out = bytearray()
    for offset in range(0, len(triplets), 3):
        red, green, blue = triplets[offset:offset + 3]
        if format_code in (21, 22):
            out.extend((blue, green, red, 0))
        else:
            green_max, red_shift, green_shift = (63, 11, 5) if format_code == 23 else (31, 10, 5)
            packed = ((red * 31 // 255) << red_shift |
                      (green * green_max // 255) << green_shift |
                      blue * 31 // 255)
            out.extend(packed.to_bytes(2, 'little'))
    return bytes(out)
