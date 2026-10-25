import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/TaxFiles/TaxFileArticlesController.dart';
import '../../../core/constant/Colorapp.dart';
import 'TaxArticleCard.dart';

/// نتيجة البحث بكلمة أو جملة: الجملة مع تلوين كلمات البحث، وبجانبها مادتها.
/// الضغط يفتح المادة كاملة
class TaxSentenceCard extends StatelessWidget {
  final TaxSentenceHit hit;
  final String? pdfFile;
  final String highlight;

  const TaxSentenceCard({
    super.key,
    required this.hit,
    this.pdfFile,
    this.highlight = '',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _openArticle(context),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text.rich(
                _highlighted(hit.sentence, context),
                textDirection: hit.article.textDirection,
              ),
            ),
            const SizedBox(width: 10),
            _articleChip(),
          ],
        ),
      ),
    );
  }

  // نفس لون تمييز المادة غير المقننة في [TaxArticleCard]
  static const Color _nonCodifiedColor = Color(0xFFE07B00);

  /// المادة التي تنتمي إليها الجملة (بالبرتقالي إذا كانت غير مقننة)
  Widget _articleChip() {
    final nonCodified = !hit.article.isCodified;
    final color = nonCodified ? _nonCodifiedColor : AppColor.typography;
    return Container(
      width: 78,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            hit.article.localizedLabel,
            textAlign: TextAlign.center,
            textDirection: hit.article.labelDirection,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.3,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          if (nonCodified) ...[
            const SizedBox(height: 4),
            Text(
              "غير مقننة".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: _nonCodifiedColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _openArticle(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        maxChildSize: 0.95,
        builder: (_, scrollController) => Container(
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            children: [
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
              TaxArticleCard(
                article: hit.article,
                pdfFile: pdfFile,
                highlight: highlight,
                initiallyOpen: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// تلوين كلمات البحث داخل الجملة (يتجاهل الهمزات والتشكيل كما في البحث)
  TextSpan _highlighted(String text, BuildContext context) {
    final base = context.textTheme.bodyLarge?.copyWith(
          fontSize: 15,
          color: Colors.grey[800],
          height: 1.6,
        ) ??
        TextStyle(fontSize: 15, color: Colors.grey[800], height: 1.6);
    final words = TaxFileArticlesController.normalize(highlight.trim())
        .split(' ')
        .where((w) => w.isNotEmpty)
        .toList();
    if (words.isEmpty) return TextSpan(text: text, style: base);

    // نبحث في النص الموحد مع الاحتفاظ بموضع كل حرف في النص الأصلي
    final normalizedChars = StringBuffer();
    final positions = <int>[];
    for (int i = 0; i < text.length; i++) {
      final n = TaxFileArticlesController.normalize(text[i]);
      for (int k = 0; k < n.length; k++) {
        normalizedChars.write(n[k]);
        positions.add(i);
      }
    }
    final normalized = normalizedChars.toString();

    final marked = List<bool>.filled(text.length, false);
    for (final w in words) {
      int from = 0;
      while (true) {
        final idx = normalized.indexOf(w, from);
        if (idx < 0) break;
        final start = positions[idx];
        final end = positions[idx + w.length - 1];
        for (int i = start; i <= end; i++) {
          marked[i] = true;
        }
        from = idx + w.length;
      }
    }

    final highlightStyle = base.copyWith(
      backgroundColor: AppColor.typography.withOpacity(0.15),
      fontWeight: FontWeight.bold,
      color: AppColor.typography,
    );
    final spans = <TextSpan>[];
    int last = 0;
    for (int i = 1; i <= text.length; i++) {
      if (i == text.length || marked[i] != marked[last]) {
        spans.add(TextSpan(
          text: text.substring(last, i),
          style: marked[last] ? highlightStyle : base,
        ));
        last = i;
      }
    }
    return TextSpan(children: spans);
  }
}
