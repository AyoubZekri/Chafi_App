import re

with open('lib/core/localizations/Translation.dart', 'r', encoding='utf-8') as f:
    content = f.read()

ar_match = re.search(r'(\"ar\":\s*{)([\s\S]*?)(},\s*(?://.*?\s*)*\"en\":)', content)
en_match = re.search(r'(\"en\":\s*{)([\s\S]*?)(\n\s*})', content)

if not ar_match or not en_match:
    print('Failed to find ar or en blocks')
    exit(1)

def extract_keys(block):
    keys = []
    for m in re.finditer(r'(\"|\')([^\"\']+)\1\s*:', block):
        keys.append(m.group(2))
    return keys

ar_keys = extract_keys(ar_match.group(2))
en_keys = extract_keys(en_match.group(2))

ar_set = set(ar_keys)
en_set = set(en_keys)

missing_in_en = ar_set - en_set
missing_in_ar = en_set - ar_set

print(f'Keys in AR: {len(ar_keys)}, in EN: {len(en_keys)}')

if missing_in_en:
    print(f'Missing in EN ({len(missing_in_en)}):\n' + '\n'.join(missing_in_en))
if missing_in_ar:
    print(f'Missing in AR ({len(missing_in_ar)}):\n' + '\n'.join(missing_in_ar))
