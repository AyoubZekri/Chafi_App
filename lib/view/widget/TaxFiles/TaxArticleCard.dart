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
        SizedBox(
          width: double.infinity,
          child: SelectableText.rich(
            _highlighted(article.localizedText, context),
            textDirection: article.textDirection,
          ),
        ),
        for (final table in article.tables) ...[
          const SizedBox(height: 16),
          TaxTableView(table: table),
        ],
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
        if (canOpenPdf) ...[
          const SizedBox(height: 15),
          Divider(color: Colors.grey.shade300, thickness: 1),
          const SizedBox(height: 10),
          _fileButton(context),
        ],
      ],
    );
  }

  /// زر "الملف" بنفس شكل أزرار البطاقات الأخرى، يفتح PDF الملف مباشرة في صفحة المادة
  Widget _fileButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: _openPdf,
      child: Container(
        height: 48,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.typography, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.description_outlined,
              size: 20,
              color: AppColor.typography,
            ),
            const SizedBox(width: 8),
            Text(
              "الملف".tr,
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColor.typography,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
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
