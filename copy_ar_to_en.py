import re

with open('lib/core/localizations/Translation.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Extract the 'ar' block
ar_match = re.search(r'(\"ar\":\s*{)([\s\S]*?)(},\s*(?://.*?\s*)*\"en\":)', content)
if not ar_match:
    print('Failed to find ar block')
    exit(1)

ar_dict_content = ar_match.group(2)

# Find the 'en' block
en_match = re.search(r'(\"en\":\s*{)([\s\S]*?)(\n\s*})', content)
if not en_match:
    print('Failed to find en block')
    exit(1)

# Replace the 'en' content with 'ar' content
new_content = content[:en_match.start(2)] + ar_dict_content + content[en_match.end(2):]

with open('lib/core/localizations/Translation.dart', 'w', encoding='utf-8') as f:
    f.write(new_content)
    
print("Successfully copied AR block to EN block")
