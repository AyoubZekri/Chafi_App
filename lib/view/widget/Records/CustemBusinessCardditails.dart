import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Custembusinesscardditails extends StatelessWidget {
  final String acteve;
  final int condition;
  final String persontype;
  final String name;
  final String address;
  final String numperTax;
  final String codeActeve;

  const Custembusinesscardditails({
    super.key,
    required this.acteve,
    required this.condition,
    required this.persontype,
    required this.name,
    required this.address,
    required this.numperTax,
    required this.codeActeve,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 201, 201, 201),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        " ${"67".tr} : $acteve ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF1A406D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  //   decoration: BoxDecoration(
                  //     color: condition == 1 ? AppColor.brand : AppColor.red,
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         condition == 1 ? Icons.check : Icons.close,
                  //         color: Colors.white,
                  //         size: 16,
                  //       ),
                  //       SizedBox(width: 4),
                  //       Text(
                  //         condition == 1 ? "68".tr : "69".tr,
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 14,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Column(
                  //   children: [
                  //     Icon(
                  //       Icons.business_center,
                  //       size: 50,
                  //       color: Color(0xFF1A406D),
                  //     ),
                  //     Text(
                  //       "CHAFI",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         color: Color(0xFF1A406D),
                  //       ),
                  //     ),
                  //     Text(
                  //       "رفيقك في الحياة",
                  //       style: TextStyle(fontSize: 10, color: Colors.green),
                  //     ),
                  //   ],
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "70".tr,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A406D),
                        ),
                      ),
                      // Text(
                      //   "تاريخ الإصدار: 12/03/2024",
                      //   style: TextStyle(
                      //     color: Color(0xFF1A406D),
                      //     fontSize: 16,
                      //   ),
                      // ),
                      // Text(
                      //   "تاريخ الانتهاء: 12/03/2025",
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     color: Colors.red,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),

              _buildDetailRow("71".tr, " $persontype"),
              _buildDetailRow("72".tr, "  $name "),
              _buildDetailRow("73".tr, " $address"),
              // _buildDetailRow(
              //   "النشاط الرئيسي:",
              //   "",
              // ),
              _buildDetailRow("74".tr, " $numperTax"),
              _buildDetailRow("75".tr, " $codeActeve"),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF1A406D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "76".tr,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.calculate_outlined, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$label ",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              height: 1.5,
            ),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.grey, fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}
