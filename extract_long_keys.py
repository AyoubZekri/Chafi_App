import json

with open('lib/core/localizations/Translation.dart', 'r', encoding='utf-8') as f:
    content = f.read()

keys = [
    'التسبيقات على الدخل_طويلة',
    'كشف التلخيص السنوي_طويلة',
    'الطابع الجبائي_طويلة',
    'budget_deposit_طويلة',
    'gifts_طويلة',
    'advertising_sponsorship_طويلة',
    'المركبات السياحية_طويلة',
    'البحث والتطوير_طويلة',
    'التنازل عن الإستثمار_طويلة',
    'bonuses_compensation_طويلة'
]

# extract ar and en maps string
ar_start = content.find('"ar": {')
en_start = content.find('"en": {')
ar_content = content[ar_start:en_start] if ar_start != -1 and en_start != -1 else ""
en_content = content[en_start:] if en_start != -1 else ""

with open('keys_out.txt', 'w', encoding='utf-8') as f:
    f.write('ARABIC:\n')
    for k in keys:
        if f'"{k}"' in ar_content:
            # find value
            idx = ar_content.find(f'"{k}"')
            colon_idx = ar_content.find(':', idx)
            newline_idx = ar_content.find('\n', colon_idx)
            val = ar_content[colon_idx+1:newline_idx].strip().strip('",')
            f.write(f'{k} -> {val}\n')
        else:
            f.write(f'MISSING: {k}\n')
    
    f.write('\nENGLISH:\n')
    for k in keys:
        if f'"{k}"' in en_content:
            idx = en_content.find(f'"{k}"')
            colon_idx = en_content.find(':', idx)
            newline_idx = en_content.find('\n', colon_idx)
            val = en_content[colon_idx+1:newline_idx].strip().strip('",')
            f.write(f'{k} -> {val}\n')
        else:
            f.write(f'MISSING: {k}\n')
