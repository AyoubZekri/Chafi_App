with open(r'd:\flutter\chafi\lib\core\localizations\Translation.dart', encoding='utf-8') as f:
    lines = f.readlines()
for i, l in enumerate(lines):
    if '"40"' in l:
        print(f"Line {i+1}: {l.strip()}")
