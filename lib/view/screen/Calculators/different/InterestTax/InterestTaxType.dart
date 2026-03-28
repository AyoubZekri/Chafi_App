import 'package:chafi/controller/Calculators/InterestTaxController.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Interesttaxtype extends StatefulWidget {
  const Interesttaxtype({super.key});

  @override
  State<Interesttaxtype> createState() => _InteresttaxtypeState();
}

class _InteresttaxtypeState extends State<Interesttaxtype> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Interesttaxcontroller>().BackFromInteresttaxtype();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Impôt sur les intérêts".tr),
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
        body: GetBuilder<Interesttaxcontroller>(
          builder: (controller) {
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
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),

                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          CustemtextbodyMedium18(
                            color: AppColor.grey,
                            content:
                                "Entrez les données avec précision pour obtenir un résultat correct"
                                    .tr,
                          ),
                          SizedBox(height: 40),
                          CustemtextbodyMedium18(
                            content: controller.interesttaxtype == 1
                                ? "Choisissez le type de remise".tr
                                : controller.interesttaxtype == 2
                                ? "Choisissez le type de revenu".tr
                                : "Choisissez le type de bénéfice".tr,
                            color: AppColor.black,
                          ),
                          SizedBox(height: 60),
                          if (controller.typeTax == 1) ...[
                            Cardpersontype(
                              padding: 30,
                              marginb: 25,
                              index: 1,
                              title: "Biens immobiliers bâtis et non bâtis".tr,
                              selectedPerson: controller.interesttaxtype,
                              onTap: () =>
                                  controller.selectedInteresttaxtype(1),
                            ),
                            Cardpersontype(
                              padding: 30,
                              index: 2,
                              marginb: 25,
                              title:
                                  "Titres financiers pour personne physique hors activité"
                                      .tr,
                              selectedPerson: controller.interesttaxtype,
                              onTap: () =>
                                  controller.selectedInteresttaxtype(2),
                            ),
                            Cardpersontype(
                              padding: 30,
                              marginb: 25,
                              index: 3,
                              title: "Réinvestissement de l'excédent".tr,
                              selectedPerson: controller.interesttaxtype,
                              onTap: () =>
                                  controller.selectedInteresttaxtype(3),
                            ),
                          ],
                          if (controller.typeTax == 2) ...[
                            Cardpersontype(
                              padding: 30,
                              marginb: 25,
                              index: 1,
                              title:
                                  "Actions et parts de la société et revenus similaires"
                                      .tr,
                              selectedPerson: controller.interesttaxtype,
                              onTap: () =>
                                  controller.selectedInteresttaxtype(1),
                            ),
                            Cardpersontype(
                              padding: 30,
                              index: 2,
                              marginb: 25,
                              title:
                                  "Obligations non nominatives - personnes physiques"
                                      .tr,
                              selectedPerson: controller.interesttaxtype,
                              onTap: () =>
                                  controller.selectedInteresttaxtype(2),
                            ),
                            Cardpersontype(
                              padding: 30,
                              marginb: 25,
                              index: 3,
                              title:
                                  "Obligations non nominatives - personnes morales"
                                      .tr,
                              selectedPerson: controller.interesttaxtype,
                              onTap: () =>
                                  controller.selectedInteresttaxtype(3),
                            ),
                          ],
                          if (controller.typeTax == 3) ...[
                            Cardpersontype(
                              padding: 30,
                              marginb: 25,
                              index: 1,
                              title: "Intérêts des livrets d'épargne".tr,
                              selectedPerson: controller.interesttaxtype,
                              onTap: () =>
                                  controller.selectedInteresttaxtype(1),
                            ),
                            Cardpersontype(
                              padding: 30,
                              index: 2,
                              marginb: 25,
                              title: "Intérêts excédentaires".tr,
                              selectedPerson: controller.interesttaxtype,
                              onTap: () =>
                                  controller.selectedInteresttaxtype(2),
                            ),
                          ],
                          SizedBox(height: 30),
                          Custemsuberbutton(
                            content: "60".tr,
                            color: AppColor.typography,
                            onPressed: () => controller.gotoValuotax(),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
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
