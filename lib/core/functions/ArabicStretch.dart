import 'package:flutter/widgets.dart';

/// حرف التطويل (الكشيدة)
const String _tatweel = 'ـ';

/// حروف لا تتصل بما بعدها، فلا يوضع بعدها تطويل
const String _nonJoining = 'اأإآدذرزوؤةءى';

bool _isArabicLetter(String ch) {
  final c = ch.codeUnitAt(0);
  return c >= 0x0621 && c <= 0x064A;
}

/// المواضع التي يصح فيها التطويل: بين حرفين متصلين في نفس الكلمة
List<int> _stretchPoints(String text) {
  final points = <int>[];
  for (int i = 0; i < text.length - 1; i++) {
    final ch = text[i];
    final next = text[i + 1];
    if (_isArabicLetter(ch) &&
        _isArabicLetter(next) &&
        !_nonJoining.contains(ch)) {
      points.add(i + 1);
    }
  }
  return points;
}

double _width(String text, TextStyle style, TextDirection direction) {
  final painter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: direction,
    maxLines: 1,
  )..layout();
  final w = painter.width;
  painter.dispose();
  return w;
}

/// يطيل النص العربي بالتطويل "ـ" حتى يقترب عرضه من [targetWidth].
/// التطويل يوزَّع على المواضع الصحيحة (من آخر الكلمات أولاً).
String stretchArabic(
  String text,
  double targetWidth,
  TextStyle style, {
  TextDirection direction = TextDirection.rtl,
}) {
  final points = _stretchPoints(text);
  if (points.isEmpty) return text;

  // عدد التطويلات في كل موضع
  final counts = List<int>.filled(points.length, 0);
  String build() {
    final buffer = StringBuffer();
    int last = 0;
    for (int i = 0; i < points.length; i++) {
      buffer.write(text.substring(last, points[i]));
      buffer.write(_tatweel * counts[i]);
      last = points[i];
    }
    buffer.write(text.substring(last));
    return buffer.toString();
  }

  var result = text;
  // حد أقصى للأمان حتى لا يطول النص بلا نهاية
  for (int step = 0; step < 80; step++) {
    if (_width(result, style, direction) >= targetWidth) break;
    // نبدأ من آخر موضع ثم ننتقل للخلف بالتناوب
    final index = points.length - 1 - (step % points.length);
    counts[index]++;
    final candidate = build();
    if (_width(candidate, style, direction) > targetWidth + 2) break;
    result = candidate;
  }
  return result;
}

/// يطيل كل النصوص لتقترب من عرض أطولها
List<String> stretchToLongest(
  List<String> texts,
  TextStyle style, {
  TextDirection direction = TextDirection.rtl,
}) {
  if (texts.isEmpty) return texts;
  final target = texts
      .map((t) => _width(t, style, direction))
      .reduce((a, b) => a > b ? a : b);
  return texts
      .map((t) => stretchArabic(t, target, style, direction: direction))
      .toList();
}
