"""Observed DAT vertex reads and Gouraud stream copies, without game execution.

The native allocation stride is 68. Version 85 reads only its 44-byte prefix;
the loader does not write the trailing 24 bytes in the observed read routine.
Those bytes remain unknown here, rather than being invented as zero vectors.
"""
from dataclasses import dataclass


RUNTIME_VERTEX_STRIDE = 68


@dataclass(frozen=True)
class RenderVertex:
    prefix: bytes
    extension: bytes | None

    def __post_init__(self):
        if type(self.prefix) is not bytes or len(self.prefix) != 44:
            raise ValueError('Expected the 44-byte vertex prefix')
        if self.extension is not None and (type(self.extension) is not bytes or len(self.extension) != 24):
            raise ValueError('Expected a 24-byte extension or unknown bytes')

    @classmethod
    def from_stored(cls, data, version):
        """Replay the read sizes of 0x1401ea230; no other DAT layout is implied."""
        if type(version) is not int or not 85 <= version < 1 << 32:
            raise ValueError('Version is outside the observed unsigned >=85 guard')
        expected = 44 if version < 86 else 68
        if type(data) is not bytes or len(data) != expected:
            raise ValueError(f'Expected exactly {expected} source bytes')
        return cls(data[:44], data[44:] if version >= 86 else None)

    def gouraud(self):
        """0x140215350: XYZ and the color DWORD, copied without arithmetic."""
        return self.prefix[:12] + self.prefix[28:32]

    def gouraud_texture(self):
        """0x140215760: XYZ, normal, color DWORD, UV0 (36 bytes)."""
        return self.prefix[:12] + self.prefix[32:44] + self.prefix[28:32] + self.prefix[12:20]
