"""Installed engine's stored shader-code to internal-ID translation.

IDs identify the loader's request. Device validation, texture/effect selection
and the eventual bound shader remain separate runtime operations.
"""
from dataclasses import dataclass


def translate_shader_code(code):
    """0x1401ef260's unsigned DWORD guard and ten-entry target table."""
    if type(code) is not int or not -(1 << 31) <= code < 1 << 32:
        raise ValueError('Expected a native 32-bit argument')
    unsigned = code & 0xffffffff
    return {1: 0, 2: 11, 4: 12, 8: 10, 9: 17}.get(unsigned, 21)


@dataclass(frozen=True)
class ShaderFeatures:
    lightmap: int
    detail_textures: int
    envmap: int
    env_bumpmap: int


@dataclass(frozen=True)
class TextureShaderState:
    # Field names retain their offsets until their complete producer is traced.
    mode_38: int
    flag_3c: int
    pixel_flags24: int | None  # None is a null pixel-data pointer, not a zero flag.


def warehouse_shader_candidate(requested, texture, features):
    """Replay the factory's pre-validation branch for warehouse request IDs.

    0x1401b295a/0x1401b2b50 select a candidate. Allocation, the cache,
    ValidateShader, and validation-failure fallback are deliberately separate.
    All texture fields and cached feature integers are supplied observations.
    """
    if type(requested) is not int or requested not in (0, 11, 12):
        raise ValueError('Expected a warehouse loader request ID (0, 11, 12)')
    if not isinstance(features, ShaderFeatures):
        raise ValueError('Explicit shader feature state required')
    for value in (features.lightmap, features.detail_textures, features.envmap, features.env_bumpmap):
        if type(value) is not int or not -(1 << 31) <= value < 1 << 31:
            raise ValueError('Cached shader features must be int32')
    if texture is not None:
        if not isinstance(texture, TextureShaderState):
            raise ValueError('Explicit texture state or null required')
        for value in (texture.mode_38, texture.flag_3c, texture.pixel_flags24):
            if value is not None and (type(value) is not int or not 0 <= value < 1 << 32):
                raise ValueError('Texture fields must be uint32')
        if texture.mode_38 is None or texture.flag_3c is None:
            raise ValueError('Texture mode and flag cannot be null')
    if requested == 11:
        return 11 if features.lightmap else None
    if requested == 12 and features.lightmap:
        if texture is None:
            return None
        if texture.mode_38 == 1:
            return 13 if features.detail_textures else 12
        if texture.mode_38 == 2:
            return 14 if features.envmap else 12
        if texture.mode_38 == 5:
            return 16 if features.env_bumpmap else 12
        if texture.mode_38 == 4:
            # Bump disabled jumps back into the EnvMapEnable branch (299b).
            return 15 if features.env_bumpmap else 14 if features.envmap else 12
        return 18 if texture.flag_3c else 12
    if texture is None:
        return 0
    if texture.flag_3c:
        return 19
    pixel_bit = texture.pixel_flags24 is not None and texture.pixel_flags24 & 1
    if texture.mode_38 == 1 and features.detail_textures:
        return 8 if pixel_bit else 2
    if texture.mode_38 == 2 and features.envmap:
        return 9 if pixel_bit else 3
    if texture.mode_38 == 3 and features.envmap:
        return 9 if pixel_bit else 4
    if texture.mode_38 == 5 and features.env_bumpmap:
        return 9 if pixel_bit else 6
    if texture.mode_38 == 4:
        # The disabled EnvBumpMap branch jumps into the type-2 pixel test;
        # it does not recheck EnvMapEnable there.
        return 9 if pixel_bit else 5 if features.env_bumpmap else 3
    return 7 if pixel_bit else 1
