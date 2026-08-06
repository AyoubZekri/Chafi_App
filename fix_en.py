import re

fixes = {
    "important_alert_content": "The information contained in the Chafi application is of a guiding and simplifying nature, and does not replace returning to the official legal texts.",
    "Arabic": "Arabic",
    "Can't be Empty": "Cannot be empty",
    "Can't be larger than": "Cannot be longer than",
    "Can't be less than": "Cannot be shorter than",
    "info_title4": "Concept of the Slogan: \\\"Chafi... Taxation simply\\\"",
    "info_content4": "The slogan \\\"Chafi... Taxation simply\\\" expresses the spirit of the \\\"CHAFI\\\" app and the nature of the relationship it seeks to build with the user, especially startups and micro-enterprises to simplify their understanding of tax compliance.",
}

with open('lib/core/localizations/Translation.dart', 'r', encoding='utf-8') as f:
    content = f.read()

en_match = re.search(r'(\"en\":\s*{)([\s\S]*?)(\n\s*})', content)
if en_match:
    en_prefix = en_match.group(1)
    en_block = en_match.group(2)
    en_suffix = en_match.group(3)
    
    for key, val in fixes.items():
        # replace the value for this key
        # Handle multiline string replacements properly
        # The regex looks for "key": "old_val" or 'key': 'old_val' etc
        pattern = r'(\"|\')' + re.escape(key) + r'\1\s*:\s*(?:\r?\n\s*)?(\"|\')[\s\S]*?\2'
        replacement = f'"{key}": "{val}"'
        en_block = re.sub(pattern, replacement, en_block)
        
    new_content = content[:en_match.start()] + en_prefix + en_block + en_suffix + content[en_match.end():]
    
    with open('lib/core/localizations/Translation.dart', 'w', encoding='utf-8') as f:
        f.write(new_content)
    print("Fixed keys")
else:
    print("Could not find en block")
