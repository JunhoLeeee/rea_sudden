"""Resolve saved preview references after relocating a checkout.

Historical evidence retains the producing machine's absolute paths. Only the
repository-owned previews subtree is rebased; identity checks stay with callers.
"""
from pathlib import PureWindowsPath


def preview_path(recorded, root):
    # PureWindowsPath handles both slash styles, doubled separators, and drive
    # prefixes independently of the operating system reading the evidence.
    path = PureWindowsPath(recorded)
    parts = path.parts
    if '..' in parts or parts.count('previews') != 1:
        raise ValueError('Expected an unambiguous preview reference without traversal')
    index = parts.index('previews')
    if not path.is_absolute() and index != 0:
        raise ValueError('Relative preview references must start at previews')
    if len(parts) <= index + 1:
        raise ValueError('Preview reference has no file')
    target = root.joinpath(*parts[index:]).resolve(strict=True)
    target.relative_to((root / 'previews').resolve(strict=True))
    return target
