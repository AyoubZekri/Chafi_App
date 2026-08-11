import 'package:flutter/material.dart';
import '../../../core/constant/Colorapp.dart';

class StandardCalculator extends StatefulWidget {
  const StandardCalculator({super.key});

  @override
  State<StandardCalculator> createState() => _StandardCalculatorState();
}

class _StandardCalculatorState extends State<StandardCalculator> {
  String _display = "0";

  void _onButtonPressed(String value) {
    setState(() {
      // منطق بسيط للحاسبة (للتصميم فقط)، يمكنك استبداله بمنطقك الخاص
      if (value == "C") {
        _display = "0";
      } else if (value == "=") {
        // قم بتقييم العملية هنا
      } else if (value == "+/-") {
        if (_display.startsWith("-")) {
          _display = _display.substring(1);
        } else if (_display != "0") {
          _display = "-$_display";
        }
      } else {
        if (_display == "0") {
          _display = value;
        } else {
          _display += value;
        }
      }
    });
  }

  void _onDelete() {
    setState(() {
      if (_display.length > 1) {
        _display = _display.substring(0, _display.length - 1);
      } else {
        _display = "0";
      }
    });
  }

  Widget _buildButton(String text, {Color? bgColor, Color? textColor}) {
    // الألوان الافتراضية
    bgColor ??= Colors.white;
    textColor ??= AppColor.typography;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: AspectRatio(
          aspectRatio: 1, // يحافظ على شكل الدائرة تماماً
          child: Material(
            color: bgColor,
            shape: const CircleBorder(),
            elevation: 0,
            child: InkWell(
              onTap: () => _onButtonPressed(text),
              customBorder: const CircleBorder(),
              splashColor: AppColor.brand.withOpacity(
                0.5,
              ), // تغيير اللون عند الضغط
              highlightColor: AppColor.brand.withOpacity(
                0.2,
              ), // اللون الخفيف أثناء الضغط
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA), // لون الخلفية الرمادي الفاتح
      body: SafeArea(
        child: Column(
          children: [
            // شاشة العرض
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Text(
                    _display,
                    style: const TextStyle(
                      fontSize: 54,
                      fontWeight: FontWeight.bold,
                      color: AppColor.typography,
                    ),
                  ),
                ),
              ),
            ),

            // صف الإجراءات (أيقونة الحذف فقط باللون الأخضر)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: _onDelete,
                    icon: const Icon(
                      Icons.backspace_outlined,
                      color: AppColor.brand, // لون التطبيق الأخضر
                      size: 28,
                    ),
                    splashColor: AppColor.brand.withOpacity(0.2),
                    highlightColor: AppColor.brand.withOpacity(0.1),
                  ),
                ],
              ),
            ),

            // خط فاصل خفيف
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(height: 1, color: Colors.black12),
            ),

            // شبكة الأزرار
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
                      _buildButton("C", bgColor: Colors.grey[200]),
                      _buildButton("( )", bgColor: Colors.grey[200]),
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
                      _buildButton("+/-"),
                      _buildButton("0"),
                      _buildButton("."),
                      _buildButton(
                        "=",
                        bgColor: AppColor.brand,
                        textColor: Colors.white,
                      ), // الزر الأخضر
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
