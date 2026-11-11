"""Observed model skill-bit accumulation and HitMarker gate, supplied state only.

Recovered from CShell 180d9fef0/180da03b0/180d9fc70/1811d4010. No character
selection, server state, Bute inheritance or reskill negotiation is simulated.
"""
import json
from pathlib import Path

SPEC = Path(__file__).resolve().parents[1] / 'spec/model-skill-flags.json'


def resolve_declaration_fields(fields):
    """Reproduce the observed typed GetInt/GetBool default behavior.

    Python bool represents Bute type 4 and int represents Bute type 1. Source
    parsing must preserve this distinction. Missing or wrong types use the
    getter's default; issues report wrong types instead of coercing them.
    """
    spec = json.loads(SPEC.read_text(encoding='utf-8'))
    resolved, issues = {}, []
    for rule in spec['fields'] + spec['conditional_fields']:
        name = rule['field']
        default = rule['default']
        value = fields.get(name, default)
        expected = bool if rule.get('getter') == '0x181327c30' else int
        if name not in fields:
            resolved[name] = default
        elif type(value) is not expected or (expected is int and not -(1 << 31) <= value < 1 << 31):
            resolved[name] = default
            issues.append(dict(field=name, expected='boolean' if expected is bool else 'int32',
                               actual=type(value).__name__, default_used=default))
        else:
            resolved[name] = int(value)
    return resolved, issues


def bits_from_declarations(fields, initial=0):
    values, issues = resolve_declaration_fields(fields)
    return accumulate_model_bits(values, initial), issues


def accumulate_model_bits(fields, initial=0):
    """Apply OR-only observed setters to already-resolved numeric fields."""
    if type(initial) is not int or not 0 <= initial < 1 << 64:
        raise ValueError('initial must be a uint64')
    spec = json.loads(SPEC.read_text(encoding='utf-8'))
    result = initial
    for rule in spec['fields'] + spec['conditional_fields']:
        if rule.get('requires_field') and not numeric(fields.get(rule['requires_field'], 0)):
            continue
        value = numeric(fields.get(rule['field'], rule['default']))
        enabled = value == 0 if rule['enabled_when'] == 'zero' else value != 0
        if enabled:
            result |= 1 << rule['bit']
    return result


def numeric(value):
    if isinstance(value, bool):
        return int(value)
    if type(value) is not int or not -(1 << 31) <= value < 1 << 31:
        raise ValueError('Only resolved int32 Bute/boolean values supported')
    return value


def hitmarker_enabled(*, settings_present, client_present, option_byte, model_index,
                      model_count, base_bits, is_reskill=False, matched_bits=None):
    """Evaluate the observed bit-18 gate using explicit caller-provided context.

    For reskill models, supply the matched server/model skillset. None means no
    match (zero bits); do not substitute base bits. Context getter and map lookup
    implementations remain external until their full state has been recovered.
    """
    for value in (model_index, model_count, option_byte, base_bits):
        if type(value) is not int:
            raise ValueError('Integer context fields required')
    if not 0 <= option_byte <= 255 or not 0 <= base_bits < 1 << 64:
        raise ValueError('Context outside observed byte/uint64 profile')
    if matched_bits is not None and (type(matched_bits) is not int or not 0 <= matched_bits < 1 << 64):
        raise ValueError('matched_bits must be uint64 or None')
    if not settings_present or not client_present or not option_byte:
        return False
    if model_index < 0 or model_index >= model_count:
        return False
    bits = (0 if matched_bits is None else matched_bits) if is_reskill else base_bits
    return bool(bits & (1 << 18))
