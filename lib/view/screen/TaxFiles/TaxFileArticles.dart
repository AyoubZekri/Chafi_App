import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/TaxFiles/TaxFileArticlesController.dart';
import '../../../core/class/handlingview.dart';
import '../../../core/constant/Colorapp.dart';
import '../../../data/model/TaxFileModel.dart';
import '../../widget/TaxFiles/TaxArticleCard.dart';

/// كل مواد ملف مع البحث بالمادة، الرقم، العنوان وتفاصيل المادة
class TaxFileArticles extends StatelessWidget {
  final TaxDocumentModel document;

  /// صفحة "البحث في الجباية": المواد المقننة فقط
  final bool codifiedOnly;

  const TaxFileArticles({
    super.key,
    required this.document,
    this.codifiedOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    // tag حتى يكون لكل ملف متحكم خاص به
    final tag = 'tax-file-${document.id}-${codifiedOnly ? 'code' : 'all'}';
    Get.put(
      TaxFileArticlesController(document, codifiedOnly: codifiedOnly),
      tag: tag,
    );

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text(codifiedOnly ? "البحث في الجباية".tr : "78".tr),
      ),
      body: GetBuilder<TaxFileArticlesController>(
        tag: tag,
        builder: (controller) {
          return Column(
            children: [
              _searchBar(controller),
              Expanded(
                child: RefreshIndicator(
                  color: AppColor.typography,
                  onRefresh: controller.viewdata,
                  child: Handlingview(
                    statusrequest: controller.statusrequest,
                    widget: controller.filteredData.isEmpty
                        ? _noResults()
                        : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 20),
                            itemCount: controller.filteredData.length,
                            itemBuilder: (context, i) {
                              final article = controller.filteredData[i];
                              return TaxArticleCard(
                                key: ValueKey(article.id),
                                article: article,
                                pdfFile: document.file,
                                highlight: controller.searchController.text,
                              );
                            },
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _searchBar(TaxFileArticlesController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: AppColor.typography,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.search, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller.searchController,
              onChanged: controller.onSearch,
              textInputAction: TextInputAction.search,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: codifiedOnly
                    ? "إبحث : بالمادة المقننة , الكلمة , الجملة".tr
                    : "إبحث : بالمادة المقننة والغير مقننة , الكلمة , الجملة".tr,
                // نص إرشادي رمادي باهت
                hintStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade400,
                ),
                hintMaxLines: 2,
                border: InputBorder.none,
              ),
            ),
          ),
          if (controller.isSearching)
            IconButton(
              onPressed: controller.clearSearch,
              icon: const Icon(Icons.close, color: Colors.grey),
            ),
        ],
      ),
    );
  }

  Widget _noResults() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 80),
        Icon(Icons.search_off, size: 60, color: Colors.grey[400]),
        const SizedBox(height: 12),
        Text(
          "لا توجد مادة مطابقة للبحث".tr,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
