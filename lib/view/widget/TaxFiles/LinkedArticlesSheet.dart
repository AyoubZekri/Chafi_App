import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/Statusrequest.dart';
import '../../../core/constant/Colorapp.dart';
import '../../../core/functions/handlingdatacontroller.dart';
import '../../../data/datasource/Remote/TaxFilesData.dart';
import '../../../data/model/TaxFileModel.dart';
import 'TaxArticleCard.dart';

/// أرقام المواد المرتبطة بقوانين بطاقة (القوانين غير المرتبطة بمادة تُتجاهل)
List<int> linkedArticleIds(List<dynamic>? laws) {
  if (laws == null) return [];
  final ids = <int>{};
  for (final law in laws) {
    if (law is Map) {
      final id = int.tryParse(law['article_id']?.toString() ?? '');
      if (id != null) ids.add(id);
    }
  }
  return ids.toList();
}

/// زر "المواد" بنفس شكل زر القوانين في البطاقات؛ لا يظهر إذا لم يرتبط أي قانون بمادة
class LinkedArticlesButton extends StatelessWidget {
  final List<dynamic>? laws;

  const LinkedArticlesButton({super.key, required this.laws});

  @override
  Widget build(BuildContext context) {
    final ids = linkedArticleIds(laws);
    if (ids.isEmpty) return const SizedBox.shrink();

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => showLinkedArticles(context, ids),
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
            const Icon(Icons.article_outlined,
                size: 20, color: AppColor.typography),
            const SizedBox(width: 8),
            Text(
              "${"المواد".tr} (${ids.length})",
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
}

/// نافذة سفلية تعرض المواد المرتبطة ببطاقات المادة (النص، الجداول، زر الملف)
void showLinkedArticles(BuildContext context, List<int> ids) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: AppColor.card1,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
              child: Row(
                children: [
                  const Icon(Icons.article_outlined,
                      color: AppColor.typography),
                  const SizedBox(width: 8),
                  Text(
                    "المواد المرتبطة".tr,
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColor.typography,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _LinkedArticlesList(
                ids: ids,
                scrollController: scrollController,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _LinkedArticlesList extends StatefulWidget {
  final List<int> ids;
  final ScrollController scrollController;

  const _LinkedArticlesList({
    required this.ids,
    required this.scrollController,
  });

  @override
  State<_LinkedArticlesList> createState() => _LinkedArticlesListState();
}

class _LinkedArticlesListState extends State<_LinkedArticlesList> {
  late Future<List<TaxArticleModel>> future;

  @override
  void initState() {
    super.initState();
    future = _load();
  }

  Future<List<TaxArticleModel>> _load() async {
    final response = await TaxFilesData(Get.find()).viewArticlesByIds(widget.ids);
    if (handlingData(response) != Statusrequest.success ||
        !(response["status"] == 1 || response["status"] == true)) {
      throw Exception('failed');
    }
    final list = (response['data'] as List)
        .map((e) => TaxArticleModel.fromJson(Map<String, dynamic>.from(e)))
        // احتياط: نسخة سيرفر قديمة تتجاهل ids وترجع كل المواد
        .where((a) => widget.ids.contains(a.id))
        .toList();
    // نفس ترتيب القوانين في البطاقة
    list.sort((a, b) =>
        widget.ids.indexOf(a.id).compareTo(widget.ids.indexOf(b.id)));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TaxArticleModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.typography),
          );
        }
        if (snapshot.hasError || (snapshot.data ?? []).isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.cloud_off, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 10),
                Text(
                  "تعذر تحميل المواد".tr,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                TextButton(
                  onPressed: () => setState(() => future = _load()),
                  child: Text("إعادة المحاولة".tr),
                ),
              ],
            ),
          );
        }
        final articles = snapshot.data!;
        return ListView.builder(
          controller: widget.scrollController,
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: articles.length,
          itemBuilder: (context, i) => TaxArticleCard(
            key: ValueKey(articles[i].id),
            article: articles[i],
            showDocument: true,
          ),
        );
      },
    );
  }
}
