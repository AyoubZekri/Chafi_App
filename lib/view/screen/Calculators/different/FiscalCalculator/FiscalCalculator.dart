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

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("حاسبة جبائية".tr), centerTitle: true),
      body: Column(
        children: [
          // Display Section
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                color: AppColor.card1,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
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
                            fontSize: controller.isResultFinal.value ? 32 : 48,
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
                            fontSize: controller.isResultFinal.value ? 48 : 32,
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

          // Keypad Section
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  // Clear button
                  if (index == 0) {
                    return MyButton(
                      buttonText: buttons[index],
                      color: Colors.red,
                      textColor: Colors.white,
                      buttonTapped: () {
                        controller.onButtonPressed(buttons[index]);
                      },
                    );
                  }
                  // Delete button
                  else if (index == 1) {
                    return MyButton(
                      buttonText: buttons[index],
                      color: Colors.orange,
                      textColor: Colors.white,
                      buttonTapped: () {
                        controller.onButtonPressed(buttons[index]);
                      },
                    );
                  }
                  // Equals button
                  else if (index == buttons.length - 1) {
                    return MyButton(
                      buttonText: buttons[index],
                      color: AppColor.typography,
                      textColor: Colors.white,
                      buttonTapped: () {
                        controller.onButtonPressed(buttons[index]);
                      },
                    );
                  }
                  // Other buttons
                  else {
                    return MyButton(
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? AppColor.typography
                          : Colors.grey[200],
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : AppColor.typography,
                      buttonTapped: () {
                        controller.onButtonPressed(buttons[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
}

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  const MyButton({
    this.color,
    this.textColor,
    required this.buttonText,
    this.buttonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

const List<String> buttons = [
  'C',
  'DEL',
  '%',
  '/',
  '7',
  '8',
  '9',
  'x',
  '4',
  '5',
  '6',
  '-',
  '1',
  '2',
  '3',
  '+',
  '0',
  '00',
  '.',
  '=',
];
