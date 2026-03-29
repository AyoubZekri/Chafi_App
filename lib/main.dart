import 'package:chafi/core/functions/Localizetion.dart';
import 'package:chafi/core/functions/fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'Bindings/Initialbindings.dart';
import 'core/localizations/ChengeLocal.dart';
import 'core/localizations/Translation.dart';
import 'core/services/Services.dart';
import 'routes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:responsive_framework/responsive_framework.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  await FcmHelper.initFCM();

  await getUserState();
  // print("=============userState $userState");
  // await analytics.logEvent(name: 'app_open', parameters: {'state': userState});
  // print("=============userState $userState");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    return GetMaterialApp(
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      navigatorObservers: [routeObserver],
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: controller.themeData,
      locale: controller.language,
      initialBinding: Initialbindings(),
      getPages: routes,
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final screenWidth = mediaQueryData.size.width;
        
        Widget scaledChild = screenWidth > 600 
            ? ResponsiveScaledBox(width: 450, child: child!) 
            : child!;
            
        return ResponsiveBreakpoints.builder(
          child: Container(
            color: const Color(0xFFF5F5F5),
            child: MaxWidthBox(
              maxWidth: 1200,
              child: MediaQuery(
                data: mediaQueryData.copyWith(textScaleFactor: 1.0, devicePixelRatio: 1.0),
                child: scaledChild,
              ),
            ),
          ),
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
      },
    );
  }
}
