"""Observed material declarations for warehouse DTX headers.

Only empty command strings and the captured AlphaRef form are accepted. Other
commands can change linked textures/modes and must not silently become normal.
RTexture flags are modeled after successful renderer texture construction.
"""
from dataclasses import dataclass
import math
import re
import struct

from .render_shader import TextureShaderState


@dataclass(frozen=True)
class TextureMaterial:
    internal_flags: int
    render_flags: int
    alpha_ref: int
    command: str

    def shader_state(self):
        """Fresh SharedTexture mode/+3c remain zero for these command forms."""
        return TextureShaderState(0, 0, self.render_flags)


def material_from_dtx_header(blob):
    if not isinstance(blob, (bytes, bytearray)) or len(blob) < 164:
        raise ValueError('Expected an observed DTX header')
    if struct.unpack_from('<Ii', blob) != (0, -5):
        raise ValueError('Unsupported DTX header identity')
    field = bytes(blob[36:164])
    if b'\0' not in field:
        raise ValueError('Unterminated DTX command string')
    command = field.split(b'\0', 1)[0]
    match = re.fullmatch(rb'(?i:alpharef) ([0-9]{1,5})', command)
    if command and match is None:
        raise ValueError('DTX commands outside the captured material profile')
    reference = int(match[1]) if match else 0
    if reference > 65535:
        raise ValueError('AlphaRef outside the captured WORD profile')
    flags, = struct.unpack_from('<I', blob, 16)
    # 0x1401e04a8..0x1401e04e6 -> byte write at 0x1401e05bd.
    render_flags = (flags & 1) | ((flags >> 9) & 0xe)
    return TextureMaterial(flags, render_flags, reference, command.decode('ascii'))


def gouraud_texel(texture, vertex, *, saturate, fullbright=False):
    """Ideal normalized stages, before fog/framebuffer blend/alpha testing.

    Fullbright stage 1 uses BLENDCURRENTALPHA: the factor is texture alpha times
    vertex alpha from stage 0. This is not a final framebuffer-pixel oracle.
    """
    if len(texture) != 4 or len(vertex) != 4 or any(
            not math.isfinite(value) or not 0 <= value <= 1 for value in (*texture, *vertex)):
        raise ValueError('Expected two normalized RGBA inputs')
    gain = 2 if saturate else 1
    rgb = tuple(min(1., texture[i]*vertex[i]*gain) for i in range(3))
    alpha = texture[3]*vertex[3]
    if fullbright:
        rgb = tuple(texture[i]*alpha + rgb[i]*(1-alpha) for i in range(3))
    return (*rgb, alpha)
