import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../LinkApi.dart';
import '../../../controller/FavoritesController.dart';
import '../../../core/constant/Colorapp.dart';
import '../../../data/model/TaxFileModel.dart';
import '../../screen/pdf.dart';
import 'TaxTableView.dart';

/// نوع المفضلة الخاص بمواد "جبايتك" (8 مؤسسات، 9 أنظمة جبائية، 10 جزاءات)
const int taxArticleFavoriteType = 12;

/// بطاقة مادة بنفس تصميم [Custemcardinfo]: عنوان المادة،
/// وعند الضغط يظهر النص والجداول وزر فتح الـ PDF في صفحة المادة
class TaxArticleCard extends StatefulWidget {
  final TaxArticleModel article;

  /// مسار PDF الملف (إن لم يُمرر يُؤخذ من المادة نفسها)
  final String? pdfFile;

  /// كلمات البحث لتلوينها داخل النص
  final String highlight;

  /// اسم الملف (يظهر في صفحة المفضلة)
  final bool showDocument;


  const TaxArticleCard({
    super.key,
    required this.article,
    this.pdfFile,
    this.highlight = '',
    this.showDocument = false,
  });

  @override
  State<TaxArticleCard> createState() => _TaxArticleCardState();
}

class _TaxArticleCardState extends State<TaxArticleCard> {
  bool isOpen = false;

  TaxArticleModel get article => widget.article;

  /// اسم الملف الذي تنتمي إليه المادة، حسب لغة التطبيق
  /// (اسم القانون المرتبط قد يحتوي اسم المادة نفسها، لذلك لا نعتمد عليه)
  String? get _sourceName => article.localizedDocumentTitle;
  String? get pdfFile => widget.pdfFile ?? article.documentFile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isOpen = !isOpen),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== TITLE =====
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _title(context)),
                _favoriteButton(),
              ],
            ),

            /// ===== BODY + ACTIONS =====
            AnimatedSize(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: isOpen ? _body(context) : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.localizedLabel,
          textDirection: article.labelDirection,
          style: context.textTheme.headlineMedium?.copyWith(
            fontSize: 17,
            height: 1.4,
            fontWeight: FontWeight.w800,
            color: AppColor.typography,
          ),
        ),
        if (article.isRepealed) ...[
          const SizedBox(height: 4),
          Text(
            "ملغاة".tr,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        if (widget.showDocument && (_sourceName ?? '').isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            _sourceName!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
        ],
      ],
    );
  }

  Widget _favoriteButton() {
    return GetBuilder<FavoritesController>(
      init: FavoritesController(),
      builder: (favCtrl) {
        final type = taxArticleFavoriteType.toString();
        final isFav = favCtrl.isFavorite(article.id, type);
        return IconButton(
          onPressed: () => isFav
              ? favCtrl.removeFavorite(article.id, type)
              : favCtrl.addFavorite(article.id, type),
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.redAccent : Colors.grey,
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    final canOpenPdf = pdfFile != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        ..._textWithTables(context),
        if (article.notes.isNotEmpty) ...[
          const SizedBox(height: 12),
          for (final note in article.notes)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                "• $note",
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
            ),
        ],
        if (canOpenPdf || article.tables.isNotEmpty) ...[
          const SizedBox(height: 15),
          Divider(color: Colors.grey.shade300, thickness: 1),
          const SizedBox(height: 10),
          Row(
            children: [
              if (canOpenPdf) Expanded(child: _fileButton(context)),
              if (canOpenPdf && article.tables.isNotEmpty)
                const SizedBox(width: 10),
              if (article.tables.isNotEmpty)
                Expanded(child: _tablesButton(context)),
            ],
          ),
        ],
      ],
    );
  }

  /// زر بنفس شكل أزرار البطاقات الأخرى (إطار بلون التطبيق)
  Widget _actionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.typography, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppColor.typography),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColor.typography,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// زر "الملف": يفتح PDF الملف مباشرة في صفحة المادة
  Widget _fileButton(BuildContext context) => _actionButton(
        context,
        icon: Icons.description_outlined,
        label: "الملف".tr,
        onTap: _openPdf,
      );

  /// زر "الجداول": قائمة جداول المادة لاختيار الجدول المراد عرضه
  Widget _tablesButton(BuildContext context) => _actionButton(
        context,
        icon: Icons.table_chart_outlined,
        label: "${"الجداول".tr} (${article.tables.length})",
        onTap: () => _showTablesList(context),
      );

  void _openTable(int number) {
    Get.to(() => TaxTableFullscreen(
          table: article.tables[number - 1],
          number: number,
          highlight: widget.highlight,
        ));
  }

  /// نافذة سفلية بجداول المادة: الرقم، العنوان، والحجم
  void _showTablesList(BuildContext context) {
    final tables = article.tables;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(sheetContext).size.height * 0.75,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                  child: Text(
                    "جداول المادة".tr,
                    style: sheetContext.textTheme.headlineMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColor.typography,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: Text(
                    article.localizedLabel,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: tables.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, i) => _tableTile(sheetContext, i + 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tableTile(BuildContext sheetContext, int number) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.of(sheetContext).pop();
        _openTable(number);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.card1,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.typography,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${"جدول".tr} $number',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColor.grey),
          ],
        ),
      ),
    );
  }

  /// علامة الجدول داخل النص تصبح زراً صغيراً يفتح الجدول
  Widget _tableChip(int number) {
    final table = article.tables[number - 1];
    final title = table.title.trim();
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _openTable(number),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: AppColor.typography.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.typography.withOpacity(0.25)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.table_chart_outlined,
                  size: 16, color: AppColor.typography),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  title.isEmpty
                      ? '${"عرض الجدول".tr} $number'
                      : '${"عرض الجدول".tr} $number: $title',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColor.typography,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // علامة الجدول داخل النص: [[جدول:2]] (أو [[Table:2]] في ترجمة قديمة)
  static final _tableMarker =
      RegExp(r'\[\[\s*(?:جدول|Table)\s*:\s*(\d+)\s*\]\]', caseSensitive: false);

  /// نص المادة، وعلامة كل جدول تصبح زراً يفتحه (كل الجداول في زر "الجداول")
  List<Widget> _textWithTables(BuildContext context) {
    final text = article.localizedText;
    final tables = article.tables;
    final widgets = <Widget>[];

    void addText(String part) {
      final trimmed = part.trim();
      if (trimmed.isEmpty) return;
      widgets.add(SizedBox(
        width: double.infinity,
        child: SelectableText.rich(
          _highlighted(trimmed, context),
          textDirection: article.textDirection,
        ),
      ));
    }

    int last = 0;
    for (final m in _tableMarker.allMatches(text)) {
      addText(text.substring(last, m.start));
      final n = int.parse(m.group(1)!);
      if (n >= 1 && n <= tables.length) {
        widgets.add(_tableChip(n));
      }
      last = m.end;
    }
    addText(text.substring(last));

    // مسافة بين الأجزاء
    return [
      for (int i = 0; i < widgets.length; i++) ...[
        if (i > 0) const SizedBox(height: 10),
        widgets[i],
      ],
    ];
  }

  /// فتح PDF الملف مباشرة في الصفحة التي تبدأ فيها المادة
  void _openPdf() {
    Get.to(
      () => PdfSearchPage(
        url: "${Applink.image}$pdfFile",
        initialPage: article.pageStart ?? 1,
      ),
    );
  }

  /// النص بنفس خط [Custemcardinfo] مع تلوين كلمات البحث
  TextSpan _highlighted(String text, BuildContext context) {
    final base = context.textTheme.bodyLarge?.copyWith(
          fontSize: 15,
          color: Colors.grey[700],
          height: 1.6,
        ) ??
        TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.6);
    final words = widget.highlight
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 1)
        .map(RegExp.escape)
        .toList();
    if (words.isEmpty) return TextSpan(text: text, style: base);

    final pattern = RegExp(words.join('|'), caseSensitive: false);
    final spans = <TextSpan>[];
    int last = 0;
    for (final m in pattern.allMatches(text)) {
      if (m.start > last) {
        spans.add(TextSpan(text: text.substring(last, m.start), style: base));
      }
      spans.add(TextSpan(
        text: m.group(0),
        style: base.copyWith(
          backgroundColor: Colors.amber.withOpacity(0.35),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ));
      last = m.end;
    }
    if (last < text.length) {
      spans.add(TextSpan(text: text.substring(last), style: base));
    }
    return TextSpan(children: spans);
  }
}
