import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../controller/Calculators/different/FiscalCalculator/FiscalCalculatorController.dart';
import '../../../../../core/constant/Colorapp.dart';

class FiscalCalculator extends StatelessWidget {
  const FiscalCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FiscalCalculatorController controller = Get.put(
      FiscalCalculatorController(),
    );

    Widget _buildButton(String text, {Color? bgColor, Color? textColor}) {
      bgColor ??= Colors.white;
      textColor ??= AppColor.typography;

      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: Material(
              color: bgColor,
              shape: const CircleBorder(),
              elevation: 0,
              child: InkWell(
                onTap: () {
                  String mappedText = text;
                  if (text == '÷') mappedText = '/';
                  if (text == '×') mappedText = 'x';

                  // For parenthesis and +/- we can try to pass them or ignore if not supported by controller
                  // We'll just pass them to controller, it will ignore or you can update controller later
                  controller.onButtonPressed(mappedText);
                },
                customBorder: const CircleBorder(),
                splashColor: AppColor.brand.withOpacity(0.5),
                highlightColor: AppColor.brand.withOpacity(0.2),
                child: Center(
                  child: Transform.translate(
                    offset: Offset(
                      0,
                      (text == '÷' ||
                              text == '×' ||
                              text == '-' ||
                              text == '+' ||
                              text == '=')
                          ? -6.0
                          : 0.0,
                    ),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                      ),
                      style: TextStyle(
                        fontSize:
                            (text == '÷' ||
                                text == '×' ||
                                text == '-' ||
                                text == '+' ||
                                text == '=')
                            ? 65
                            : 36,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("الحاسبة".tr), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            // Display Section
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 60,
                      alignment: Alignment.bottomRight,
                      child: Obx(
                        () => FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            controller.userInput.value,
                            style: TextStyle(
                              fontSize: controller.isResultFinal.value
                                  ? 40
                                  : 54,
                              color: controller.isResultFinal.value
                                  ? Colors.grey
                                  : AppColor.typography,
                              fontWeight: controller.isResultFinal.value
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 60,
                      alignment: Alignment.bottomRight,
                      child: Obx(
                        () => FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            controller.result.value,
                            style: TextStyle(
                              fontSize: controller.isResultFinal.value
                                  ? 54
                                  : 40,
                              color: controller.isResultFinal.value
                                  ? AppColor.typography
                                  : Colors.grey,
                              fontWeight: controller.isResultFinal.value
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Actions Row (Backspace only, green color)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => controller.onButtonPressed('DEL'),
                    icon: const Icon(
                      Icons.backspace_outlined,
                      color: AppColor.brand, // Green color
                      size: 28,
                    ),
                    splashColor: AppColor.brand.withOpacity(0.2),
                    highlightColor: AppColor.brand.withOpacity(0.1),
                  ),
                ],
              ),
            ),

            // Divider
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(height: 1, color: Colors.black12),
            ),

            // Keypad Section
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: 24.0,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton("(", bgColor: Colors.grey[200]),
                      _buildButton(")", bgColor: Colors.grey[200]),
                      _buildButton("%", bgColor: Colors.grey[200]),
                      _buildButton(
                        "÷",
                        bgColor: Colors.grey[600],
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                      _buildButton(
                        "×",
                        bgColor: Colors.grey[600],
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                      _buildButton(
                        "-",
                        bgColor: Colors.grey[600],
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                      _buildButton(
                        "+",
                        bgColor: Colors.grey[600],
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("C"),
                      _buildButton("0"),
                      _buildButton("."),
                      _buildButton(
                        "=",
                        bgColor: AppColor.brand,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
