import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/bonusesandcompensationcontroller.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/Taxinpout.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Inboutvalou extends StatefulWidget {
  const Inboutvalou({super.key});

  @override
  State<Inboutvalou> createState() => _InboutvalouState();
}

class _InboutvalouState extends State<Inboutvalou> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<bonusesandcompensationcontroller>().BackFromInboutvalou();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.typography,
        appBar: AppBar(
          title: Text("العلوات وتعويضات".tr),
          titleTextStyle: TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Almiri",
            fontSize: 24,
          ),
          iconTheme: IconThemeData(color: AppColor.white),
          backgroundColor: AppColor.typography,
          elevation: 0,
        ),

        body: GetBuilder<bonusesandcompensationcontroller>(
          builder: (controller) {
            final controllers = controller.valueControllersGroups[1] ?? {};
            final keys = controllers.keys.toList();
            final controllers2 = controller.valueControllersGroups[2] ?? {};
            final keys2 = controllers2.keys.toList();
            final controllers3 = controller.valueControllersGroups[3] ?? {};
            final keys3 = controllers3.keys.toList();
            return Container(
              color: AppColor.typography,
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                  child: Container(
                    color: AppColor.white,
                    child: ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              CustemtextbodyMedium18(
                                color: AppColor.grey,
                                content:
                                    "أدخل البيانات بدقة للحصول على نتيجة صحيحة"
                                        .tr,
                              ),
                              SizedBox(height: 40),
                              CustemtextbodyMedium18(
                                content:
                                    "أدخل قيم العلوات وتعويضات ليتم حساب الضريبة"
                                        .tr,
                                color: AppColor.black,
                              ),
                              SizedBox(height: 40),
                              SectionHeader(
                                icon: Icons.receipt_long_outlined,
                                title: "الخاضعة لي الضريبة والإشتراكات".tr,
                              ),
                              const SizedBox(height: 16),
                              CustomInputField(
                                label: "أدخل الأجر القاعدي",
                                icon: FontAwesomeIcons.wallet,
                                isCurrency: true,
                                controller: controller.fixedValueController,
                                errorText: controller.fixedValueControllerError,
                              ),

                              const SizedBox(height: 16),
                              CustomInputField(
                                label: controller.hasspeciallogictype == 1
                                    ? "نسبة العلاوة"
                                    : "عدد ايام العمل",
                                icon: controller.hasspeciallogictype == 1
                                    ? Icons.percent
                                    : Icons.calendar_today,
                                controller: controller.numday,
                                errorText: controller.numdayError,
                              ),
                              const SizedBox(height: 16),
                              if (controller.hasspeciallogictype == 2) ...[
                                CustomInputField(
                                  label: "سعر اليوم",
                                  icon: FontAwesomeIcons.moneyBillWave,
                                  isCurrency: true,
                                  controller: controller.hasspeciallogic,
                                  errorText: controller.hasspeciallogicError,
                                ),
                                const SizedBox(height: 16),
                              ],
                              if (keys.isNotEmpty)
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: keys.length,
                                  itemBuilder: (context, i) {
                                    final id = keys[i];
                                    final textController = controllers[id]!;

                                    final bonus = controller.data
                                        .firstWhereOrNull((e) => e.id == id);
                                    final label = bonus != null
                                        ? bonus.localizedName
                                        : "أدخل القيمة".tr;

                                    return Column(
                                      children: [
                                        CustomInputField(
                                          label: label,
                                          icon: FontAwesomeIcons.moneyBillWave,
                                          isCurrency: true,
                                          controller: textController,
                                          errorText: controller
                                              .bonusErrorsGroups[1]?[id],
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    );
                                  },
                                ),
                              const SizedBox(height: 24),
                              if (keys2.isNotEmpty) ...[
                                SectionHeader(
                                  icon: Icons.receipt_long_outlined,
                                  title: "الخاضعة لي الضريبة".tr,
                                ),
                                const SizedBox(height: 16),

                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: keys2.length,
                                  itemBuilder: (context, i) {
                                    final id = keys2[i];
                                    final textController = controllers2[id]!;

                                    final bonus = controller.data
                                        .firstWhereOrNull((e) => e.id == id);
                                    final label = bonus != null
                                        ? bonus.localizedName
                                        : "أدخل القيمة".tr;

                                    return Column(
                                      children: [
                                        CustomInputField(
                                          label: label,
                                          icon: FontAwesomeIcons.moneyBillWave,
                                          isCurrency: true,
                                          controller: textController,
                                          errorText: controller
                                              .bonusErrorsGroups[2]?[id],
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(height: 24),
                              ],
                              if (keys3.isNotEmpty) ...[
                                SectionHeader(
                                  icon: Icons.receipt_long_outlined,
                                  title: "غير خاضعة".tr,
                                ),
                                const SizedBox(height: 16),

                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: keys3.length,
                                  itemBuilder: (context, i) {
                                    final id = keys3[i];
                                    final textController = controllers3[id]!;

                                    final bonus = controller.data
                                        .firstWhereOrNull((e) => e.id == id);
                                    final label = bonus != null
                                        ? bonus.localizedName
                                        : "أدخل القيمة".tr;

                                    return Column(
                                      children: [
                                        CustomInputField(
                                          label: label,
                                          icon: FontAwesomeIcons.moneyBillWave,
                                          isCurrency: true,
                                          controller: textController,
                                          errorText: controller
                                              .bonusErrorsGroups[3]?[id],
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    );
                                  },
                                ),
                              ],
                              const SizedBox(height: 30),

                              Custemsuberbutton(
                                content: "60".tr,
                                color: AppColor.typography,
                                onPressed: () {
                                  controller.calcul();
                                },
                              ),

                              // const SizedBox(height: 20),

                              // Custemsuberbutton(
                              //   content: "62".tr,
                              //   color: Color(0xffE8F1FF),
                              //   color2: AppColor.brand,
                              //   onPressed: () {
                              //     controller.backtoPersonType();
                              //   },
                              // ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
