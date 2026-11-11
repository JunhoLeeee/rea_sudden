"""Read bounded resource samples; preserve offsets and hashes, infer no format."""
import argparse
from collections import Counter
import hashlib
import json
import math
from pathlib import Path

def sample(stream, offset, length):
    stream.seek(offset)
    blob = stream.read(length)
    counts = Counter(blob)
    entropy = -sum((n / len(blob)) * math.log2(n / len(blob)) for n in counts.values()) if blob else 0
    return dict(offset=offset, bytes=len(blob), sha256=hashlib.sha256(blob).hexdigest(),
                entropy_bits_per_byte=entropy, first_64_hex=blob[:64].hex(),
                zero_fraction=counts[0] / len(blob) if blob else 0)

def probe(path, root):
    before = path.stat()
    offsets = sorted(set([0, max(0, before.st_size // 2 - 2048), max(0, before.st_size - 4096)]))
    with path.open('rb') as stream:
        ranges = [sample(stream, offset, min(4096, before.st_size - offset)) for offset in offsets]
    after = path.stat()
    if (before.st_size, before.st_mtime_ns) != (after.st_size, after.st_mtime_ns):
        raise RuntimeError(f'Changed during probe: {path}')
    return dict(path=str(path.relative_to(root)), bytes=before.st_size,
                mtime_ns=before.st_mtime_ns, ranges=ranges,
                identity_scope='selected-read-ranges-only')

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('root', type=Path)
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    root = args.root.resolve(strict=True)
    paths = sorted((root / 'game').glob('*.pkg'))
    chosen = [root / 'engine.rez']
    prefixes = ['global_', 'game_file_', 'sa_scripts_', 'sa_text_', 'sa_interface_', 'sa_worlds_', 'sa_weaponsi_']
    for prefix in prefixes:
        matched = [p for p in paths if p.name.startswith(prefix)]
        if matched:
            chosen.append(matched[0])
    report = dict(root=str(root), observations=[probe(p, root) for p in chosen],
                  limitations=['Ordinary Python filesystem evidence, not REA Evidence.',
                               'High entropy does not establish encryption or compression.',
                               'Only selected ranges are hashed; full-file identity remains unknown.',
                               'No file extraction, decoding or target execution.'])
    with args.output.open('x', encoding='utf-8') as out:
        json.dump(report, out, ensure_ascii=False, indent=2)
    print(json.dumps(dict(files=len(chosen), bytes_read=sum(r['bytes'] for o in report['observations'] for r in o['ranges']), output=str(args.output))))

if __name__ == '__main__':
    main()
