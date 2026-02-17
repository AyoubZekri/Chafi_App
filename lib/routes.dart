import 'package:chafi/core/constant/routes.dart';
import 'package:chafi/view/screen/Calculators/ArbitrarySystem.dart/G12/TypeActevite.dart';
import 'package:chafi/view/screen/Calculators/Simplified%20system/CalPersonType.dart';
import 'package:chafi/view/screen/Setting/ContactUs.dart';
import 'package:chafi/view/screen/Setting/Externallinks.dart';
import 'package:chafi/view/screen/Setting/InformationAPP.dart';
import 'package:get/get.dart';

import 'view/screen/ApplicationSystems/CategoriesApp.dart';
import 'view/screen/Articles/ditailsArticles.dart';
import 'view/screen/Auth/GoogleSignIn.dart';
import 'view/screen/Calculators/ArbitrarySystem.dart/CalculatorsArbitrarySystem.dart';
import 'view/screen/Calculators/ArbitrarySystem.dart/G12BES/TypeActeviteG12BES.dart';
import 'view/screen/Calculators/Calculators.dart';
import 'view/screen/Calculators/Realsystem/AnnualSummaryDisclosure/LossOrProfit.dart';
import 'view/screen/Calculators/Realsystem/CalculatorsRealSystem.dart';
import 'view/screen/Calculators/Realsystem/TaxStamp/TaxStamp.dart';
import 'view/screen/Calculators/Simplified system/CalculatorsofSystemSimpli.dart';
import 'view/screen/NavigationBar.dart';
import 'view/screen/Obligations/Obligations.dart';
import 'view/screen/Obligations/Specialappointments.dart';
import 'view/screen/OnBarding.dart';
import 'view/screen/Record/EditRecord.dart';
import 'view/screen/Setting/Notification.dart';
import 'view/screen/Setting/Privacypolicy.dart';
import 'view/screen/StartPage.dart';
import 'view/screen/ApplicationSystems/AppSystemsType.dart';
import 'view/screen/Articles/Articles.dart';
import 'view/screen/Auth/InfoUser.dart';
import 'view/screen/Institutions/InstitutionField.dart';
import 'view/screen/Institutions/InstitutionsInfo.dart';
import 'view/screen/Institutions/institutionType.dart';
import 'view/screen/Institutions/regulatedInstitutionTypes.dart';
import 'view/screen/MyPath/PersonType.dart';
import 'view/screen/Record/InfoRecord.dart';
import 'view/screen/Setting/EditProfaile.dart';
import 'view/screen/TaxSystems/CategoriesTax.dart';
import 'view/screen/TaxSystems/TaxSystemsType.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: "/", page: () => const Startpage()),

  //  name: "/",page: () => const Checkout()),
  GetPage(name: Approutes.onBarding, page: () => const OnBarding()),
  GetPage(
    name: Approutes.googleSignIn,
    page: () => const Googlesignin(),
    // binding: GoogleSigninBinding(),
  ),
  GetPage(name: Approutes.infouser, page: () => const Infouser()),
  GetPage(name: Approutes.navigationBar, page: () => const NavigationBar()),
  GetPage(name: Approutes.articles, page: () => const Articles()),
  GetPage(
    name: Approutes.institutionfield,
    page: () => const Institutionfield(),
  ),
  GetPage(name: Approutes.institutiontype, page: () => const Institutiontype()),
  GetPage(
    name: Approutes.regulatedinstitutiontypes,
    page: () => const Regulatedinstitutiontypes(),
  ),
  GetPage(
    name: Approutes.institutionsinfo,
    page: () => const Institutionsinfo(),
  ),
  GetPage(name: Approutes.taxsystemstype, page: () => const Taxsystemstype()),
  GetPage(name: Approutes.appsystemstype, page: () => const Appsystemstype()),
  GetPage(name: Approutes.persontype, page: () => const Persontype()),

  GetPage(name: Approutes.inforecord, page: () => const Inforecord()),
  // GetPage(name: Approutes.questions, page: () => const Questions()),
  GetPage(name: Approutes.editprofaile, page: () => const Editprofaile()),
  GetPage(name: Approutes.notification, page: () => const Notification()),
  GetPage(name: Approutes.contactus, page: () => const Contactus()),
  GetPage(name: Approutes.informationapp, page: () => const Informationapp()),
  GetPage(name: Approutes.categoriesapp, page: () => const Categoriesapp()),
  GetPage(name: Approutes.categoriesTax, page: () => const Categoriestax()),

  GetPage(name: Approutes.privacypolicy, page: () => const Privacypolicy()),
  GetPage(name: Approutes.ditailsarticles, page: () => const Ditailsarticles()),
  GetPage(name: Approutes.externallinks, page: () => const Externallinks()),
  GetPage(
    name: Approutes.specialappointments,
    page: () => const Specialappointments(),
  ),

  GetPage(name: Approutes.editrecord, page: () => const Editrecord()),

  GetPage(name: Approutes.obligations, page: () => const Obligations()),

  GetPage(name: Approutes.calculators, page: () => const Calculators()),
  GetPage(
    name: Approutes.calculatorsofSystemSimpli,
    page: () => const CalculatorsofSystemSimpli(),
  ),
  GetPage(name: Approutes.calPersontype, page: () => const CalPersontype()),
  GetPage(name: Approutes.calactivityType, page: () => const CalTypeActivite()),
  GetPage(
    name: Approutes.calculatorsarbitrarysystem,
    page: () => const Calculatorsarbitrarysystem(),
  ),
  GetPage(
    name: Approutes.typeacteviteg12bes,
    page: () => const Typeacteviteg12bes(),
  ),
  GetPage(name: Approutes.lossORprofit, page: () => const Lossorprofit()),
  GetPage(name: Approutes.calculatorsrealsystem, page: () => const Calculatorsrealsystem()),
  GetPage(name: Approutes.taxstamp, page: () => const Taxstamp()),

];
