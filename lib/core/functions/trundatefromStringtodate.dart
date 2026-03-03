import 'package:intl/intl.dart';

DateTime? parseDate(String text) {
  if (text.isEmpty) return null;
  try {
    return DateFormat('yyyy/MM/dd').parseStrict(text);
  } catch (_) {
    try {
      return DateFormat('yyyy-MM-dd').parseStrict(text);
    } catch (_) {
      return null;
    }
  }
}
