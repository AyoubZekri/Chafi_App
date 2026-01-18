import 'package:get/get.dart';

import '../../view/screen/MyPath/ActivityType.dart';
import '../../view/screen/MyPath/MoralActivities.dart';
import '../../view/screen/MyPath/NatureOfActivity.dart';
import '../../view/screen/MyPath/TaxSystemsTypeInMypath.dart';

class Mypathcontroller extends GetxController {
  //
  void selectedPerson(int i) {}
  void gotoNatureofactivity() {}
  //
  void selectNatureofactivity(int i) {}
  void backtoPersonType() {}
  void gotoActivitytype() {}
  //
  void backtonatureofactivity() {}
  void selectativitytype(int i) {}
  void gotoTaxsystemstype() {}
  //
  void backtoativitytype() {}
  void selectTaxsystemstype(int i) {}
  // void gotoTaxsystemstype() {}
  //
  void selectMoralactivities(int i) {}
  void backtoPersonType2() {}
}

class MypathcontrollerImp extends Mypathcontroller {
  // personType
  int personType = -1;
  @override
  selectedPerson(int i) {
    personType = i;
    update();
  }

  @override
  gotoNatureofactivity() {
    if (personType == 0) {
      Get.to(Natureofactivity());
    } else {
      Get.to(Moralactivities());
    }
  }

  //Natureofactivity
  int natureofactivity = -1;
  @override
  selectNatureofactivity(int i) {
    natureofactivity = i;
    update();
  }

  @override
  backtoPersonType() {
    natureofactivity = -1;
    Get.back();
  }

  @override
  gotoActivitytype() {
    Get.to(Activitytype());
  }

  //Activitytype
  int ativitytype = -1;

  @override
  selectativitytype(int i) {
    ativitytype = i;
    update();
  }

  @override
  backtonatureofactivity() {
    ativitytype = -1;
    Get.back();
  }

  @override
  gotoTaxsystemstype() {
    Get.to(Taxsystemstypeinmypath());
  }

  //taxsystemstype
  int taxsystemstype = -1;

  @override
  selectTaxsystemstype(int i) {
    taxsystemstype = i;
    update();
  }

  @override
  backtoativitytype() {
    taxsystemstype = -1;
    Get.back();
  }

  //Moralactivities
  int moralactivities = -1;
  @override
  selectMoralactivities(int i) {
    moralactivities = i;
    update();
  }

  @override
  backtoPersonType2() {
    moralactivities = -1;
    Get.back();
  }
}
