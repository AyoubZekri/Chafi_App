import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../data/datasource/Remote/TaxFilesData.dart';
import '../../data/model/TaxFileModel.dart';

/// مواد ملف واحد مع البحث بالمادة، الرقم، العنوان ونص المادة
class TaxFileArticlesController extends GetxController {
  final TaxDocumentModel document;
  TaxFileArticlesController(this.document);

  TaxFilesData taxFilesData = TaxFilesData(Get.find());
  Statusrequest statusrequest = Statusrequest.none;
  final searchController = TextEditingController();

  List<TaxArticleModel> data = [];
  List<TaxArticleModel> filteredData = [];

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
        data = listdata.map((e) => TaxArticleModel.fromJson(e)).toList();
        _searchIndex
          ..clear()
          ..addEntries(data.map((a) => MapEntry(
                a.id,
                normalize([a.label, a.labelEn, a.number, a.nodeTitle, a.text, a.textEn]
                    .whereType<String>()
                    .join(' ')),
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
  }

  bool get isSearching => searchController.text.trim().isNotEmpty;

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
