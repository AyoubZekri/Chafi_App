import 'package:flutter/widgets.dart' show TextDirection;
import 'package:get/get.dart';

int? _toInt(dynamic v) => v == null ? null : int.tryParse(v.toString());

bool _toBool(dynamic v) => v == true || v.toString() == '1';

/// ملف (وثيقة) من "جبايتك"
class TaxDocumentModel {
  final int id;
  final String code;
  final String titleAr;
  final String? titleFr;
  final int? year;
  final String? file; // مسار PDF الملف في التخزين

  TaxDocumentModel({
    required this.id,
    required this.code,
    required this.titleAr,
    this.titleFr,
    this.year,
    this.file,
  });

  factory TaxDocumentModel.fromJson(Map<String, dynamic> json) {
    return TaxDocumentModel(
      id: _toInt(json['id'])!,
      code: json['code']?.toString() ?? '',
      titleAr: json['title_ar']?.toString() ?? '',
      titleFr: json['title_fr']?.toString(),
      year: _toInt(json['year']),
      file: (json['file']?.toString() ?? '').isEmpty ? null : json['file'].toString(),
    );
  }

  String get localizedTitle {
    final lang = Get.locale?.languageCode ?? 'ar';
    return lang == 'ar' || (titleFr ?? '').isEmpty ? titleAr : titleFr!;
  }
}

/// مادة من ملف، مع ملاحظاتها وجداولها
class TaxArticleModel {
  final int id;
  final int documentId;
  final String label;
  final String? labelEn;
  final String? number;
  final String text;
  final String? textEn;
  final bool isRepealed;
  final int? pageStart;
  final String? nodeTitle;
  final String? documentTitle;
  final String? documentTitleFr;
  final String? documentFile;
  final List<String> notes;
  final List<TaxArticleTable> tables;

  TaxArticleModel({
    required this.id,
    required this.documentId,
    required this.label,
    this.labelEn,
    this.number,
    required this.text,
    this.textEn,
    required this.isRepealed,
    this.pageStart,
    this.nodeTitle,
    this.documentTitle,
    this.documentTitleFr,
    this.documentFile,
    required this.notes,
    required this.tables,
  });

  bool get _isEnglish => (Get.locale?.languageCode ?? 'ar') == 'en';

  /// التسمية والنص حسب لغة التطبيق (العربية إذا لم تتوفر ترجمة)
  String get localizedLabel => _isEnglish && labelEn != null ? labelEn! : label;
  String get localizedText => _isEnglish && textEn != null ? textEn! : text;

  /// اتجاه النص المعروض فعلاً (العربية تبقى من اليمين حتى في واجهة إنجليزية)
  TextDirection get labelDirection =>
      _isEnglish && labelEn != null ? TextDirection.ltr : TextDirection.rtl;
  TextDirection get textDirection =>
      _isEnglish && textEn != null ? TextDirection.ltr : TextDirection.rtl;

  /// اسم الملف حسب لغة التطبيق
  String? get localizedDocumentTitle =>
      !_isArabic && documentTitleFr != null ? documentTitleFr : documentTitle;

  bool get _isArabic => (Get.locale?.languageCode ?? 'ar') == 'ar';

  static String? _nonEmpty(dynamic v) {
    final s = v?.toString().trim() ?? '';
    return s.isEmpty ? null : s;
  }

  factory TaxArticleModel.fromJson(Map<String, dynamic> json) {
    final node = json['node'];
    final document = json['document'];
    final notes = json['notes'];
    final tables = json['tables'];
    return TaxArticleModel(
      id: _toInt(json['id'])!,
      documentId: _toInt(json['document_id']) ?? 0,
      label: json['label']?.toString() ?? '',
      labelEn: _nonEmpty(json['label_en']),
      number: json['number']?.toString(),
      text: json['text']?.toString() ?? '',
      textEn: _nonEmpty(json['text_en']),
      isRepealed: _toBool(json['is_repealed']),
      pageStart: _toInt(json['page_start']),
      nodeTitle: node is Map
          ? [node['label'], node['title']]
              .where((e) => e != null && e.toString().trim().isNotEmpty)
              .join(' - ')
          : null,
      documentTitle: document is Map ? document['title_ar']?.toString() : null,
      documentTitleFr: document is Map ? _nonEmpty(document['title_fr']) : null,
      documentFile: document is Map &&
              (document['file']?.toString() ?? '').isNotEmpty
          ? document['file'].toString()
          : null,
      notes: notes is List
          ? notes.map((e) => (e is Map ? e['text'] : e).toString()).toList()
          : [],
      tables: tables is List
          ? (tables
              .whereType<Map>()
              .map((e) => TaxArticleTable.fromJson(Map<String, dynamic>.from(e)))
              .toList()
            ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder)))
          : [],
    );
  }
}

class TaxTableCell {
  final int row;
  final int col;
  final int rowSpan;
  final int colSpan;
  final bool isHeader;
  final String text;

  TaxTableCell({
    required this.row,
    required this.col,
    required this.rowSpan,
    required this.colSpan,
    required this.isHeader,
    required this.text,
  });

  factory TaxTableCell.fromJson(Map<String, dynamic> json) => TaxTableCell(
        row: _toInt(json['row_idx']) ?? 0,
        col: _toInt(json['col_idx']) ?? 0,
        rowSpan: _toInt(json['row_span']) ?? 1,
        colSpan: _toInt(json['col_span']) ?? 1,
        isHeader: _toBool(json['is_header']),
        text: json['text']?.toString() ?? '',
      );

  bool covers(int r, int c) =>
      r >= row && r < row + rowSpan && c >= col && c < col + colSpan;
}

class TaxArticleTable {
  final int sortOrder;
  final String title;
  final int nRows;
  final int nCols;
  final List<TaxTableCell> cells;

  TaxArticleTable({
    required this.sortOrder,
    required this.title,
    required this.nRows,
    required this.nCols,
    required this.cells,
  });

  factory TaxArticleTable.fromJson(Map<String, dynamic> json) {
    final cellsJson = json['cells'];
    final cells = cellsJson is List
        ? cellsJson
            .whereType<Map>()
            .map((e) => TaxTableCell.fromJson(Map<String, dynamic>.from(e)))
            .toList()
        : <TaxTableCell>[];
    int rows = _toInt(json['n_rows']) ?? 0;
    int cols = _toInt(json['n_cols']) ?? 0;
    for (final c in cells) {
      if (c.row + c.rowSpan > rows) rows = c.row + c.rowSpan;
      if (c.col + c.colSpan > cols) cols = c.col + c.colSpan;
    }
    return TaxArticleTable(
      sortOrder: _toInt(json['sort_order']) ?? 0,
      title: json['title']?.toString() ?? '',
      nRows: rows,
      nCols: cols,
      cells: cells,
    );
  }

  TaxTableCell? cellCovering(int r, int c) {
    for (final cell in cells) {
      if (cell.covers(r, c)) return cell;
    }
    return null;
  }
}
