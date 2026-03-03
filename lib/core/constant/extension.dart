extension CustomNumberFormat on int {
  String formatCustomint() {
    String digits = toString();

    if (digits.length <= 2) return digits;

    // آخر رقمين من اليمين
    String lastTwo = digits.substring(digits.length - 2);

    // الباقي
    String remaining = digits.substring(0, digits.length - 2);

    List<String> parts = [];

    while (remaining.length > 3) {
      parts.insert(0, remaining.substring(remaining.length - 3));
      remaining = remaining.substring(0, remaining.length - 3);
    }

    if (remaining.isNotEmpty) {
      parts.insert(0, remaining);
    }

    return parts.join(',') + ',' + lastTwo;
  }
}

extension CustomNumberFormatString on String {
  /// يرجع غير الأرقام
  String get onlyDigits => replaceAll(RegExp(r'[^0-9]'), '');

  /// فورمات: أول فاصلة قبل آخر رقمين
  String formatCustom() {
    String digits = onlyDigits;

    if (digits.isEmpty) return '';
    if (digits.length <= 2) return digits;

    String lastTwo = digits.substring(digits.length - 2);
    String remaining = digits.substring(0, digits.length - 2);

    List<String> parts = [];

    while (remaining.length > 3) {
      parts.insert(0, remaining.substring(remaining.length - 3));
      remaining = remaining.substring(0, remaining.length - 3);
    }

    if (remaining.isNotEmpty) {
      parts.insert(0, remaining);
    }

    return parts.join(',') + ',' + lastTwo;
  }
}
