import json
with open(r'd:\flutter\chafi\lib\core\localizations\Translation.dart', encoding='utf-8') as f:
    lines = f.readlines()
matches = [(i+1, l.strip()) for i, l in enumerate(lines) if 'التطبيق' in l]
with open('matches.json', 'w', encoding='utf-8') as f:
    json.dump(matches, f, ensure_ascii=False, indent=2)
