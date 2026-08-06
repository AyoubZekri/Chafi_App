import re
import json

with open('lib/core/localizations/Translation.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Valid English keys that should NOT be modified
valid_english_keys = {
    'important_alert', 'important_alert_content', 'Langugs', 'English', 'Arabic', 
    'Home', 'Records', 'Articles', 'Profile', 'not valid username', 'not valid Email', 
    'not valid phone', 'Can\'t be Empty', 'Can\'t be larger than', 'Can\'t be less than', 
    'Contact us', 'informationApp', 'Privacy Policy', 'PDF Viewer', 'hello', 'slogan', 
    'Invité', 'DA', 'DZD', 'terms_title', 'term_1_title', 'term_1_desc', 'term_2_title', 
    'term_2_desc', 'term_3_title', 'term_3_desc', 'term_4_title', 'term_4_desc', 
    'advertising_sponsorship', 'enter_business_number', 'business_number', 'max_deduction', 
    'ads_sponsorship', 'deduction_value', 'finish', 'bonuses_compensations', 'special_zone', 
    'enter_data_correctly', 'choose_account_type', 'monthly', 'yearly', 'next', 
    'choose_taxable_bonuses', 'choose_taxable_bonuses_only', 'Enter base salary', 
    'Bonus percentage', 'Number of working days', 'Day price', 'Enter value', 
    'Non imposable', 'taxable_and_contributions', 'taxable_only', 'choose_non_taxable', 
    'are_you_in_these_people', 'physically_disabled', 'mentally_disabled', 'blind', 
    'deaf_mute', 'retired_workers', 'none_of_them', 'bonus_details', 'basic_wage', 
    'base_salary', 'zone_bonus', 'zone_bonus_desc', 'social_security', 'social_security_desc', 
    'taxable_income', 'taxable_income_desc', 'first_discount', 'first_discount_desc', 
    'second_discount', 'second_discount_desc_low_income', 'second_discount_desc_special', 
    'total_amount', 'show_salary_slip', 'salary_slip', 'net_to_pay', 'irg', 'code', 'label', 
    'number', 'rate', 'gain', 'deduction', 'total_gains', 'total_deductions', 
    'bonuses_compensation', 'enter_data_accurately', 'choose_region_bonus_type', 
    'zone_bonus_taxable', 'zone_bonus_exempt', 'geographical_area_bonus', 'isolated_area_bonus', 
    'budget_deposit', 'please_enter_budget_value', 'budget', 'budget_value', 
    'payment_and_deposit_dates', 'budget_date', 'deposit_date', 'payment_date', 
    'penalties_and_deposit', 'deposit_delay_tax', 'deposit_delay', 'payment_delay_tax', 
    'payment_delay', 'threat_tax', 'threat', 'total_tax', 'gifts', 'add_gift', 'calculate', 
    'add_gift_details', 'gift_name', 'gift_name_hint', 'gift_cost', 'gift_cost_hint', 
    'gift_quantity', 'gift_quantity_hint', 'add', 'cancel', 'add_gifts_description', 
    'deductible_amount', 'added_to_tax_result', 'gifts_details', 'per_gift', 'total_gifts', 
    'total_entered_value', 'non_deductible_part', 'amount_exceeding_limit', 'deductible_total', 
    'final_tax_1', 'temporary_tax_advance_10', 'Alert', 'select_category_hint', 
    'informationBody1', 'informationBody2', 'info_title1', 'info_content1', 'info_title2', 
    'info_content2', 'info_title3', 'info_content3', 'info_title4', 'info_content4', 
    'app_logo_title', 'app_slogan', 'other_services', 'training_courses', 'consultations', 
    'under_construction', 'under_construction_desc', 'feedback_title', 'feedback_easy', 
    'feedback_instructive', 'feedback_motivating', 'feedback_correcting', 'feedback_reassuring', 
    'feedback_cancel', 'feedback_send', 'feedback_thanks', 'feedback_success', 'feedback_error', 
    'feedback_error_msg', 'feedback_question', 'feedback_subtitle', 'feedback_send_button', 
    'feedback_share_thoughts', 'Contractor\'s Partner', 'base_working_days', '22_days', 
    '24_days', '26_days', '30_days', 'input_absent_days', 'absent_days_count', 
    'is_subject_to_cacobatph', 'yes_subject', 'cacobatph_fund', 'null', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99', '100', '101', '102', '103', '200'
}

ar_match = re.search(r'(\"ar\":\s*{)([\s\S]*?)(},\s*(?://.*?\s*)*\"en\":)', content)
en_match = re.search(r'(\"en\":\s*{)([\s\S]*?)(\n\s*})', content)

if not ar_match or not en_match:
    print('Failed to find ar or en blocks')
    exit(1)

ar_content = ar_match.group(2)
en_content = en_match.group(2)

def replace_french_keys(block_content, is_ar_block):
    new_block = block_content
    # Find all keys that have a-zA-Z but aren't in valid_english_keys
    for m in re.finditer(r'\"([^\"]*[a-zA-Z][^\"]*)\"\s*:\s*\"([^\"]*)\"', block_content):
        key = m.group(1)
        value = m.group(2)
        
        # Check if it has letters and is not in our allowlist
        if re.search(r'[a-zA-Z]', key) and key not in valid_english_keys:
            # Check if we can find the Arabic translation for this key from the AR block
            ar_val_match = re.search(f'\"{re.escape(key)}\"\\s*:\\s*\"([^\"]*)\"', ar_content)
            if ar_val_match:
                ar_val = ar_val_match.group(1)
                
                # We need to replace the KEY in this block with the Arabic value
                if is_ar_block:
                    # In AR block, replace "FrenchKey": "ArabicVal" with "ArabicVal": "ArabicVal"
                    old_line = f'"{key}": "{value}"'
                    new_line = f'"{ar_val}": "{ar_val}"'
                else:
                    # In EN block, replace "FrenchKey": "EnglishVal" with "ArabicVal": "EnglishVal"
                    old_line = f'"{key}": "{value}"'
                    new_line = f'"{ar_val}": "{value}"'
                
                new_block = new_block.replace(old_line, new_line)
    return new_block

new_ar = replace_french_keys(ar_content, True)
new_en = replace_french_keys(en_content, False)

# reconstruct the file
new_content = content[:ar_match.start(2)] + new_ar + content[ar_match.end(2):en_match.start(2)] + new_en + content[en_match.end(2):]

with open('lib/core/localizations/Translation.dart', 'w', encoding='utf-8') as f:
    f.write(new_content)

print("Keys fixed successfully")
