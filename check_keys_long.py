import json
import re

with open('lib/core/localizations/Translation.dart', 'r', encoding='utf-8') as f:
    content = f.read()

ar_start = content.find('"ar": {')
en_start = content.find('"en": {')
ar_content = content[ar_start:en_start] if ar_start != -1 and en_start != -1 else ""
en_content = content[en_start:] if en_start != -1 else ""

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

print('ARABIC MAP:')
for k in keys:
    if f'"{k}"' in ar_content:
        print(f'FOUND in ar: {k}')
    else:
        print(f'MISSING in ar: {k}')

print('\nENGLISH MAP:')
for k in keys:
    if f'"{k}"' in en_content:
        print(f'FOUND in en: {k}')
    else:
        print(f'MISSING in en: {k}')
