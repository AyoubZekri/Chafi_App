import 'package:chafi/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../../view/widget/Text/CustemheadlineMedium.dart';
import '../constant/Colorapp.dart';
import 'Statusrequest.dart';

class Handlingview extends StatelessWidget {
  final Statusrequest statusrequest;
  final IconData? iconData;
  final String? title;
  final Widget widget;

  const Handlingview({
    super.key,
    required this.statusrequest,
    required this.widget,
    this.iconData,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    switch (statusrequest) {
      case Statusrequest.loadeng:
      case Statusrequest.none:
        return const Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              backgroundColor: Color(0xFFF0F5FF),
              valueColor: AlwaysStoppedAnimation(Color(0xFF034D82)),
            ),
          ),
        );

      case Statusrequest.failure:
        return _errorView(
          icon: Icons.report_problem_outlined,
          message: "حدث خطأ".tr,
        );
      case Statusrequest.login:
        return _errorView(
          icon: Icons.login,
          message: "يجب عليك تسجيل الدخول أولاً".tr,
          button: true,
        );
      case Statusrequest.serverfailure:
        return _errorView(
          icon: Icons.wifi_off,
          message: "No Internet Connection".tr,
        );

      case Statusrequest.offlinefailure:
        return _errorView(icon: Icons.cloud_off, message: "Server Error");

      case Statusrequest.nodata:
        return _errorView(
          icon: Icons.folder_open_rounded,
          message: title ?? 'لا توجد بيانات لعرضها'.tr,
        );
      default:
        return widget;
    }
  }

  // Widget _errorView({required IconData icon, required String message}) {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       return SingleChildScrollView(
  //         physics: const AlwaysScrollableScrollPhysics(),
  //         child: ConstrainedBox(
  //           constraints: BoxConstraints(minHeight: constraints.maxHeight),
  //           child: Center(
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Icon(icon, color: AppColor.typography, size: 50),
  //                 const SizedBox(height: 12),
  //                 Text(
  //                   message,
  //                   style: TextStyle(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                     color: AppColor.grey,
  //                   ),
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _errorView({
    required IconData icon,
    required String message,
    bool button = false,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(), // 🔹 مهم للـ RefreshIndicator
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight, // يشغل كل مساحة الشاشة
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Folder card with pulse animation
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0x0D034d81),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: const Color(0xFF034d81).withOpacity(0.1),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x33034d81),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          icon,
                          size: 80,
                          color: const Color(0xFF034d81),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Text
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  if (button) ...[
                    SizedBox(height: 20),
                    Container(
                      height: 55,
                      width: 180,
                      decoration: BoxDecoration(
                        color: AppColor.typography,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        onPressed: () {
                          Get.toNamed(Approutes.googleSignIn,arguments: {"type":1});
                        },
                        child: Custemheadlinemedium(content: "تسجيل الدخول".tr),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
