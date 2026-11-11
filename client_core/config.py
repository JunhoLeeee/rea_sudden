"""Observed console syntax and a bounded configuration replay model.

Tokenizer: FUN_1400a5570. Variables: observed portions of FUN_1400a4520.
AddAction and rangebind declarations are recorded, not dispatched into game code.
Native callbacks, rendering, networking and physics are intentionally unresolved.
"""
from dataclasses import dataclass
import math
import re
import struct

def tokenize(text):
    """Yield commands using observed space/control/semicolon and percent syntax.

Outer parentheses or quotes group a token. Control bytes and semicolons end a
command even inside a group; percent quotes the following byte. Token text is
limited to 256 bytes and a command to 30 tokens, matching observed bounds.
"""
    text = text.split('\0', 1)[0]
    if any(ord(c) > 255 for c in text):
        raise ValueError('Byte-oriented tokenizer: text must fit Latin-1')
    pos, count = 0, len(text)
    command = []
    while pos < count:
        while pos < count and text[pos] == ' ':
            pos += 1
        if pos == count:
            break
        depth, chars = 0, []
        while pos < count:
            c = text[pos]
            if c == '%':
                pos += 1
                if pos == count:
                    break
                c = text[pos]
            elif c == ';' or ord(c) < 32 or ord(c) == 127:
                break
            elif c == '(':
                depth += 1
                if depth == 1:
                    pos += 1
                    continue
            elif c == ')':
                depth -= 1
                if depth == 0:
                    pos += 1
                    break
            elif c == '"':
                if depth == 0:
                    depth = 1
                    pos += 1
                    continue
                pos += 1
                break
            elif c == ' ' and depth == 0:
                break
            if len(chars) < 256:
                chars.append(c)
            pos += 1
        token = ''.join(chars)
        if token:
            command.append(token)
            if len(command) >= 30:
                yield command
                return
        if pos >= count:
            break
        c = text[pos]
        if c == ';' or ord(c) < 32 or ord(c) == 127:
            if command:
                yield command
                command = []
            pos += 1
        elif not token:
            # Empty token ends this parse in the native routine.
            break
    if command:
        yield command

def atof32(text):
    """C-style numeric prefix, rounded to the observed float storage width."""
    m = re.match(r'^[\t\n\v\f\r ]*([+-]?(?:(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?|inf(?:inity)?|nan))', text, re.I)
    value = float(m[1]) if m else 0.0
    try:
        return struct.unpack('<f', struct.pack('<f', value))[0]
    except OverflowError:
        return math.copysign(math.inf, value)

@dataclass
class Variable:
    name: str
    value: str
    numeric: float
    flags: int = 0

class ConfigState:
    """Replay declarations and the observed variable subset without game execution."""
    def __init__(self):
        self.variables = {}
        self.actions = []
        self.bindings = []
        self.unresolved = []
        self.queries = []

    def apply(self, tokens, source=None, execution_flags=0, variable_flags=0):
        if not tokens:
            return
        command, args = tokens[0], tokens[1:]
        key = command.casefold()
        if not (execution_flags & 2) and key == 'addaction':
            if len(args) != 2:
                self.unresolved.append(dict(source=source, tokens=tokens, reason='AddAction arity'))
                return
            try:
                action_id = int(args[1], 10)
            except ValueError:
                self.unresolved.append(dict(source=source, tokens=tokens, reason='Invalid action ID'))
                return
            self.actions.append(dict(name=args[0], id=action_id, source=source))
            return
        if not (execution_flags & 2) and key == 'rangebind':
            entry = dict(source=source, tokens=tokens, device=args[0] if args else None,
                         control=args[1] if len(args) > 1 else None,
                         ranges=[], semantics='declaration-only; native callback unverified')
            try:
                if len(args) < 5 or (len(args) - 2) % 3:
                    raise ValueError('Expected device/control and min/max/action triples')
                for i in range(2, len(args), 3):
                    entry['ranges'].append(dict(minimum=float(args[i]), maximum=float(args[i + 1]), action=args[i + 2]))
            except ValueError as exc:
                entry['issue'] = str(exc)
            self.bindings.append(entry)
            return
        if len(args) == 1:
            if execution_flags & 1:
                return
            name = command[1:] if command[:1] in '+-' else command
            key = name.casefold()
            previous = self.variables.get(key)
            flags = variable_flags | (previous.flags if previous else 0)
            if command.startswith('+'):
                flags |= 1
            elif command.startswith('-'):
                flags &= ~1
            value = args[0]
            if value == '!':
                if previous is None:
                    value = '1'
                elif previous.value and (previous.value[0].isascii() and previous.value[0].isdigit() or previous.value[0] == '-'):
                    value = str(int(int(previous.numeric) == 0))
            self.variables[key] = Variable(previous.name if previous else name, value, atof32(value), flags)
        elif not args:
            self.queries.append(command)
        elif not (execution_flags & 2):
            self.unresolved.append(dict(source=source, tokens=tokens, reason='Native command callback not implemented'))

    def replay(self, text, source=None, execution_flags=0):
        for tokens in tokenize(text):
            self.apply(tokens, source, execution_flags=execution_flags)

    def bootstrap(self, rows, display_text=None, display_source=None):
        """Observed CClientMgr::Init order: variable pass, then callback pass.

        Native command-line overrides and native callbacks remain outside this model.
        """
        for execution_flags in [2, 1]:
            for row in rows:
                self.replay(row['command'], dict(index=row['index'], address=row['string_address']), execution_flags)
            if display_text is not None:
                self.replay(display_text, display_source, execution_flags)

    def as_dict(self):
        return dict(variables={k: vars(v) for k, v in self.variables.items()},
                    actions=self.actions, bindings=self.bindings,
                    unresolved=self.unresolved, queries=self.queries,
                    limitations=['Offline model; no game process, native callbacks or live bindings.',
                                 'Variable callback registration, notifications and special native commands are not reproduced.',
                                 'Malformed rangebind records remain visible rather than silently corrected.'])
