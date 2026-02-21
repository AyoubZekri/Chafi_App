import 'package:chafi/core/constant/Colorapp.dart';
import 'package:chafi/view/widget/Card/CustemCardConferm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Auth/InfoUserController.dart';
import '../../../core/class/Statusrequest.dart';
import '../../widget/Button/CustemSuberButton.dart';
import '../../widget/TextFild/CustemTextFromFildInfoUser.dart';

class Infouser extends StatefulWidget {
  const Infouser({super.key});

  @override
  State<Infouser> createState() => _InfouserState();
}

class _InfouserState extends State<Infouser> {
  @override
  Widget build(BuildContext context) {
    Get.put(InfousercontrollerImp());
    return GetBuilder<InfousercontrollerImp>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.white,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: controller.statusrequest == Statusrequest.loadeng
                ? Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.brand,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Custemsuberbutton(
                    content: "19".tr,
                    color: AppColor.brand,
                    onPressed: () {
                      controller.gotoNavigationBar();
                    },
                  ),
          ),

          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 70),
                Text(
                  "14".tr,
                  style: context.textTheme.headlineSmall?.copyWith(
                    height: 1.5,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                CustemtextfromfildInfoUser(
                  myController: controller.username,
                  hintText: "15".tr,
                  enabled: true,
                  iconData: Icons.person,
                ),
                CustemtextfromfildInfoUser(
                  myController: controller.wilaya,
                  hintText: "16".tr,
                  enabled: true,
                  iconData: Icons.location_on,
                ),
                CustemtextfromfildInfoUser(
                  myController: controller.numperPhone,
                  hintText: "17".tr,
                  enabled: true,
                  iconData: Icons.phone,
                ),
                Custemcardconferm(
                  onTapTerms: () {
                    showTaxAppTermsDialog(context);
                  },
                  value: controller.isSwitched,
                  onChanged: (value) {
                    setState(() {
                      controller.isSwitched = value;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void showTaxAppTermsDialog(BuildContext context) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        height: 400, // ارتفاع مناسب بعد حذف قسم الدفع
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "terms_title".tr, // => "شروط استخدام تطبيق الجباية"
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 15),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "term_1_title".tr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColor.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "term_1_desc".tr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        height: 1.4,
                        color: AppColor.grey,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      "term_2_title".tr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColor.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "term_2_desc".tr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        height: 1.4,
                        color: AppColor.grey,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      "term_3_title".tr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColor.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "term_3_desc".tr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        height: 1.4,
                        color: AppColor.grey,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      "term_4_title".tr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColor.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "term_4_desc".tr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        height: 1.4,
                        color: AppColor.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}
