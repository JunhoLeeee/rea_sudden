"""Build/search an offline catalog of checksum-validated package index records."""
import argparse
import json
from pathlib import Path
import sqlite3

ROOT = Path(__file__).resolve().parents[1]

def build(path):
    if path.exists():
        raise ValueError('Catalog destination must be new')
    connection = sqlite3.connect(path)
    try:
        connection.executescript('''
            CREATE TABLE packages(id INTEGER PRIMARY KEY, name TEXT UNIQUE,
              artifact_path TEXT, header_sha256 TEXT, index_sha256 TEXT, payload_base INTEGER,
              manifest_path TEXT);
            CREATE TABLE members(package_id INTEGER, ordinal INTEGER, path TEXT,
              flags INTEGER, raw_bytes INTEGER, stored_bytes INTEGER, source_offset INTEGER,
              expected_md5 TEXT, PRIMARY KEY(package_id, ordinal));
        ''')
        for index_path in sorted((ROOT / 'evidence/package-indexes').glob('*.json')):
            record = json.loads(index_path.read_text(encoding='utf-8'))
            h = record['header']
            package_id = connection.execute('INSERT INTO packages(name,artifact_path,header_sha256,index_sha256,payload_base,manifest_path) VALUES(?,?,?,?,?,?)',
                (Path(h['path']).name, h['path'], h['observed_header_sha256'], record['index_raw_sha256'], record['payload_base'], str(index_path))).lastrowid
            connection.executemany('INSERT INTO members VALUES(?,?,?,?,?,?,?,?)',
                ((package_id, m['index'], m['path'], m['flags'], m['field12'], m['field16'],
                  record['payload_base'] + 1024 * m['field8'], m['digest_hex']) for m in record['members']))
        connection.execute('CREATE INDEX member_path ON members(path COLLATE NOCASE)')
        connection.commit()
        print(json.dumps(dict(packages=connection.execute('SELECT COUNT(*) FROM packages').fetchone()[0],
                              members=connection.execute('SELECT COUNT(*) FROM members').fetchone()[0], database=str(path))))
    finally:
        connection.close()

def search(path, query, limit):
    connection = sqlite3.connect(path.resolve().as_uri() + '?mode=ro', uri=True)
    connection.row_factory = sqlite3.Row
    try:
        escaped = query.replace('\\', '\\\\').replace('%', '\\%').replace('_', '\\_')
        rows = connection.execute('''SELECT p.name AS package,m.path,m.raw_bytes,m.flags
            FROM members m JOIN packages p ON p.id=m.package_id
            WHERE m.path LIKE ? ESCAPE '\\' ORDER BY m.path,p.name LIMIT ?''', ('%' + escaped + '%', limit))
        print(json.dumps([dict(r) for r in rows], indent=2, ensure_ascii=False))
    finally:
        connection.close()

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest='command', required=True)
    b = sub.add_parser('build')
    b.add_argument('database', type=Path)
    s = sub.add_parser('search')
    s.add_argument('database', type=Path)
    s.add_argument('query')
    s.add_argument('--limit', type=int, default=30)
    args = parser.parse_args()
    if args.command == 'build':
        build(args.database)
    else:
        if not 1 <= args.limit <= 1000:
            raise ValueError('limit must be in 1..1000')
        search(args.database, args.query, args.limit)

if __name__ == '__main__':
    main()
