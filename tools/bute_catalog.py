"""Index recovered Bute-style declarations, retaining raw values and locations.

This does not evaluate scripts, infer inheritance, or turn declarations into
confirmed game behavior. Duplicate section/key declarations are preserved.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re
import sqlite3

def decode(blob):
    if blob.startswith((b'\xff\xfe', b'\xfe\xff')):
        return blob.decode('utf-16'), 'utf-16'
    for encoding in ['utf-8-sig', 'cp949', 'latin-1']:
        try:
            return blob.decode(encoding), encoding
        except UnicodeDecodeError:
            pass

def uncomment(line):
    quoted = False
    for i, char in enumerate(line):
        if char == '"':
            quoted = not quoted
        if not quoted and line[i:i + 2] == '//':
            return line[:i]
    return line

def value_kind(raw):
    if len(raw) >= 2 and raw.startswith('"') and raw.endswith('"'):
        return 'string', raw[1:-1]
    if re.fullmatch(r'[+-]?\d+', raw):
        return 'integer', int(raw)
    if re.fullmatch(r'[+-]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?', raw):
        return 'float', float(raw)
    if raw.startswith('<') and raw.endswith('>'):
        try:
            return 'vector', [float(v.strip()) for v in raw[1:-1].split(',')]
        except ValueError:
            pass
    return 'uninterpreted', raw

def parse(text):
    section = None
    in_block = False
    for lineno, original in enumerate(text.splitlines(), 1):
        # Preserve quoted slashes and discard multiline C-style comment text.
        cleaned, quoted, pos = [], False, 0
        while pos < len(original):
            if in_block:
                end = original.find('*/', pos)
                if end < 0:
                    break
                in_block, pos = False, end + 2
                continue
            char = original[pos]
            if char == '"':
                quoted = not quoted
            if not quoted and original[pos:pos + 2] == '//':
                break
            if not quoted and original[pos:pos + 2] == '/*':
                in_block, pos = True, pos + 2
                continue
            cleaned.append(char)
            pos += 1
        line = ''.join(cleaned).strip()
        if not line:
            continue
        match = re.fullmatch(r'\[([^\]]+)\]', line)
        if match:
            section = match[1]
            yield dict(kind='section', line=lineno, section=section)
            continue
        match = re.fullmatch(r'([^=]+?)\s*=\s*(.*)', line)
        if section is not None and match:
            key, raw = match[1].strip(), match[2].strip()
            kind, value = value_kind(raw)
            yield dict(kind='field', section=section, line=lineno, key=key,
                       raw=raw, value_kind=kind, value=value)
        else:
            yield dict(kind='unparsed', line=lineno, raw=original)

def build(directory, output):
    if output.exists():
        raise ValueError('Destination must be new')
    db = sqlite3.connect(output)
    reports = []
    try:
        db.executescript('''CREATE TABLE sources(id INTEGER PRIMARY KEY,path TEXT,sha256 TEXT,encoding TEXT);
          CREATE TABLE sections(id INTEGER PRIMARY KEY,source_id INTEGER,name TEXT,line INTEGER);
          CREATE TABLE fields(section_id INTEGER,name TEXT,raw TEXT,kind TEXT,value_json TEXT,line INTEGER);
          CREATE TABLE issues(source_id INTEGER,line INTEGER,raw TEXT);''')
        for name in ['weapons.txt', 'layout.txt', 'mission.txt', 'playerskill.txt', 'modelbutes.txt', 'damagefx.txt', 'damagetypes.txt']:
            path = directory / name
            if not path.is_file():
                reports.append(dict(file=name, status='missing'))
                continue
            blob = path.read_bytes()
            text, encoding = decode(blob)
            sid = db.execute('INSERT INTO sources(path,sha256,encoding) VALUES(?,?,?)',
                             (str(path), hashlib.sha256(blob).hexdigest(), encoding)).lastrowid
            current = None
            count = dict(file=name, sections=0, fields=0, unparsed=0, encoding=encoding)
            for row in parse(text):
                if row['kind'] == 'section':
                    current = db.execute('INSERT INTO sections(source_id,name,line) VALUES(?,?,?)', (sid, row['section'], row['line'])).lastrowid
                    count['sections'] += 1
                elif row['kind'] == 'field':
                    db.execute('INSERT INTO fields VALUES(?,?,?,?,?,?)', (current, row['key'], row['raw'], row['value_kind'], json.dumps(row['value'], ensure_ascii=False), row['line']))
                    count['fields'] += 1
                else:
                    db.execute('INSERT INTO issues VALUES(?,?,?)', (sid, row['line'], row['raw']))
                    count['unparsed'] += 1
            reports.append(count)
        db.execute('CREATE INDEX field_name ON fields(name COLLATE NOCASE)')
        db.execute('CREATE INDEX section_name ON sections(name COLLATE NOCASE)')
        db.commit()
    finally:
        db.close()
    summary = dict(database=str(output), files=reports,
                   limitations=['Declarations only; runtime reachability, units and overrides remain unverified.',
                                'Duplicate fields/sections preserved; inheritance and precedence are not inferred.'])
    output.with_suffix('.summary.json').write_text(json.dumps(summary, indent=2), encoding='utf-8')
    print(json.dumps(summary))

if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('directory', type=Path)
    p.add_argument('database', type=Path)
    args = p.parse_args()
    build(args.directory, args.database)
