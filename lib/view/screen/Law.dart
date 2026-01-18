import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/Colorapp.dart';
import '../widget/Button/CustoumButtonCard.dart';
import 'pdf.dart';

class Law extends StatefulWidget {
  const Law({super.key});

  @override
  State<Law> createState() => _LawState();
}

class _LawState extends State<Law> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("78".tr)),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Custoumbuttoncard(
            title: 'القانون الأول',
            description: 'خرج في 2025',
            onTap: () {
              Get.to(
                () => const PdfSearchPage(
                  url: 'https://arxiv.org/pdf/1706.03762.pdf',
                  initialPage: 5,
                ),
              );
            },
          ),
          Custoumbuttoncard(
            title: 'القانون الثاني',
            description: 'خرج في 2025',
            onTap: () {
              Get.to(
                () => const PdfSearchPage(
                  url: 'https://arxiv.org/pdf/1706.03762.pdf',
                ),
              );
            },
          ),
          Custoumbuttoncard(
            title: 'القانون الثالث',
            description: 'خرج في 2025',
            onTap: () {
              Get.to(
                () => const PdfSearchPage(
                  url: 'https://arxiv.org/pdf/1706.03762.pdf',
                ),
              );
            },
          ),
          Custoumbuttoncard(
            title: 'القانون الرابع',
            description: 'خرج في 2025',
            onTap: () {
              Get.to(
                () => const PdfSearchPage(
                  url: 'https://arxiv.org/pdf/1706.03762.pdf',
                ),
              );
            },
          ),
          Custoumbuttoncard(
            title: 'القانون الخامس',
            description: 'خرج في 2025',
            onTap: () {
              Get.to(
                () => const PdfSearchPage(
                  url: 'https://arxiv.org/pdf/1706.03762.pdf',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
