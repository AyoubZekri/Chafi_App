import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../data/datasource/Remote/TaxFilesData.dart';
import '../../data/model/TaxFileModel.dart';

/// جملة من نص مادة تحتوي كلمات البحث
class TaxSentenceHit {
  final TaxArticleModel article;
  final String sentence;

  TaxSentenceHit(this.article, this.sentence);
}

/// مواد ملف واحد مع البحث بالمادة، الرقم، العنوان ونص المادة
class TaxFileArticlesController extends GetxController {
  final TaxDocumentModel document;

  /// صفحة "البحث في الجباية": المواد المقننة فقط
  final bool codifiedOnly;

  TaxFileArticlesController(this.document, {this.codifiedOnly = false});

  TaxFilesData taxFilesData = TaxFilesData(Get.find());
  Statusrequest statusrequest = Statusrequest.none;
  final searchController = TextEditingController();

  List<TaxArticleModel> data = [];
  List<TaxArticleModel> filteredData = [];

  /// البحث بكلمة أو جملة: الجمل المطابقة وبجانب كل جملة مادتها
  List<TaxSentenceHit> sentenceHits = [];

  // جمل نص كل مادة (الأصلية + الموحدة)، تُحسب عند أول حاجة
  final Map<int, List<(String, String)>> _sentences = {};

  // نص كل مادة بعد التوحيد، يُحسب مرة واحدة لتسريع البحث
  final Map<int, String> _searchIndex = {};

  Future<void> viewdata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await taxFilesData.viewArticles(document.id);
    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1 || response["status"] == true) {
        List listdata = response['data'];
        data = listdata
            .map((e) => TaxArticleModel.fromJson(e))
            .where((a) => !codifiedOnly || a.isCodified)
            .toList();
        _sentences.clear();
        _searchIndex
          ..clear()
          ..addEntries(data.map((a) => MapEntry(
                a.id,
                normalize([
                  a.label,
                  a.labelEn,
                  a.number,
                  a.nodeTitle,
                  a.text,
                  a.textEn,
                  // كلمات الجداول: العناوين ونصوص الخلايا
                  for (final t in a.tables) ...[
                    t.title,
                    for (final c in t.cells) c.text,
                  ],
                ].whereType<String>().join(' ')),
              )));
        _applySearch();
        if (data.isEmpty) statusrequest = Statusrequest.nodata;
      } else {
        statusrequest = Statusrequest.failure;
      }
    }
    update();
  }

  /// توحيد الحروف العربية حتى لا يفشل البحث بسبب الهمزات أو التشكيل
  static String normalize(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp('[ً-ْـ]'), '') // التشكيل والتطويل
        .replaceAll(RegExp('[أإآٱ]'), 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .replaceAll('ؤ', 'و')
        .replaceAll('ئ', 'ي')
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  void onSearch(String _) {
    _applySearch();
    update();
  }

  void clearSearch() {
    searchController.clear();
    _applySearch();
    update();
  }

  void _applySearch() {
    final words = normalize(searchController.text.trim())
        .split(' ')
        .where((w) => w.isNotEmpty)
        .toList();
    sentenceHits = [];
    if (words.isEmpty) {
      filteredData = List.from(data);
      return;
    }
    // كل كلمة من البحث يجب أن تظهر في المادة (مثال: "12 مكرر")
    final matches = data.where((a) {
      final text = _searchIndex[a.id] ?? '';
      return words.every(text.contains);
    }).toList();

    // الترتيب: رقم المادة المطابق أولاً، ثم المكرر منه، ثم التسمية/العنوان، ثم النص
    final query = words.join(' ');
    int rank(TaxArticleModel a) {
      final number = normalize(a.number ?? '').trim();
      if (number == query) return 0;
      if (number.startsWith('$query ')) return 1;
      final title =
          normalize('${a.label} ${a.labelEn ?? ''} ${a.nodeTitle ?? ''}');
      if (words.every(title.contains)) return 2;
      return 3;
    }

    final ranks = {for (final a in matches) a.id: rank(a)};
    final order = {for (int i = 0; i < data.length; i++) data[i].id: i};
    matches.sort((x, y) {
      final byRank = ranks[x.id]!.compareTo(ranks[y.id]!);
      return byRank != 0 ? byRank : order[x.id]!.compareTo(order[y.id]!);
    });
    filteredData = matches;

    if (!_isArticleNumberQuery(words)) {
      sentenceHits = [
        for (final a in matches)
          for (final (original, normalized) in _sentencesOf(a))
            if (words.every(normalized.contains)) TaxSentenceHit(a, original),
      ];
    }
  }

  /// "12" أو "12 مكرر" أو "المادة 12": بحث برقم المادة فنعرض المواد نفسها
  static bool _isArticleNumberQuery(List<String> words) {
    const ignored = {'ماده', 'الماده', 'م', 'art', 'article'};
    final rest = words.where((w) => !ignored.contains(w)).toList();
    return rest.isNotEmpty &&
        rest.any((w) => RegExp(r'^\d+$').hasMatch(w)) &&
        rest.every((w) => RegExp(r'^(\d+|مكرر)$').hasMatch(w));
  }

  // علامة الجدول داخل النص: [[جدول:2]]
  static final _tableMarker =
      RegExp(r'\[\[\s*(?:جدول|Table)\s*:\s*\d+\s*\]\]', caseSensitive: false);

  // نهاية الجملة: نقطة/علامة استفهام/فاصلة منقوطة متبوعة بمسافة، أو سطر جديد
  static final _sentenceEnd = RegExp(r'(?<=[.!?؟؛;])\s+|\n+');

  List<(String, String)> _sentencesOf(TaxArticleModel a) {
    return _sentences.putIfAbsent(a.id, () {
      return a.localizedText
          .replaceAll(_tableMarker, '\n')
          .split(_sentenceEnd)
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .map((s) => (s, normalize(s)))
          .toList();
    });
  }

  bool get isSearching => searchController.text.trim().isNotEmpty;

  /// عرض الجمل بدل المواد عند البحث بكلمة أو جملة
  bool get showSentences => sentenceHits.isNotEmpty;

  @override
  void onInit() {
    viewdata();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
