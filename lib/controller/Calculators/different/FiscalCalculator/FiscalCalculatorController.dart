import 'package:get/get.dart';

class FiscalCalculatorController extends GetxController {
  var userInput = ''.obs;
  var result = '0'.obs;
  var isResultFinal = false.obs;

  void onButtonPressed(String text) {
    if (text == 'C') {
      userInput.value = '';
      result.value = '0';
      isResultFinal.value = false;
    } else if (text == 'DEL') {
      isResultFinal.value = false;
      if (userInput.value.isNotEmpty) {
        userInput.value = userInput.value.substring(0, userInput.value.length - 1);
        _calculateResult();
      }
    } else if (text == '%') {
      isResultFinal.value = false;
      if (userInput.value.isNotEmpty) {
        _calculateResult();
        double current = double.tryParse(result.value) ?? 0.0;
        result.value = (current / 100).toString();
        userInput.value = result.value;
      }
    } else if (text == '=') {
      isResultFinal.value = true;
      _calculateResult(finalResult: true);
    } else {
      if (isResultFinal.value) {
        if (isOperator(text)) {
          userInput.value = result.value;
        } else {
          userInput.value = '';
        }
        isResultFinal.value = false;
      }

      // Prevent consecutive operators, except maybe negative sign
      if (isOperator(text) && userInput.value.isNotEmpty) {
        String lastChar = userInput.value[userInput.value.length - 1];
        if (isOperator(lastChar)) {
           if(text == '-' && lastChar != '-') {
               // allow negative sign after an operator
           } else {
               userInput.value = userInput.value.substring(0, userInput.value.length - 1) + text;
               return;
           }
        }
      }
      userInput.value += text;
      _calculateResult();
    }
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '%') {
      return true;
    }
    return false;
  }

  void _calculateResult({bool finalResult = false}) {
    if (userInput.value.isEmpty) {
      result.value = '0';
      return;
    }
    try {
      String expression = userInput.value.replaceAll('x', '*');
      double eval = evaluateSimpleExpression(expression);
      if (eval == eval.toInt()) {
         result.value = eval.toInt().toString();
      } else {
         result.value = eval.toStringAsFixed(2);
      }
      // Removed the logic that replaces userInput with result when finalResult is true
    } catch (e) {
      if (finalResult) {
          result.value = "Error";
      }
    }
  }

  double evaluateSimpleExpression(String expression) {
    if(expression.isEmpty) return 0.0;
    
    List<String> tokens = [];
    String currentNumber = '';
    
    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];
      if ('+-*/'.contains(char)) {
        if (char == '-' && (i == 0 || '+-*/'.contains(expression[i-1]))) {
           currentNumber += char;
        } else {
           if(currentNumber.isNotEmpty){
              tokens.add(currentNumber);
              currentNumber = '';
           }
           tokens.add(char);
        }
      } else {
        currentNumber += char;
      }
    }
    if (currentNumber.isNotEmpty) {
      tokens.add(currentNumber);
    }

    if(tokens.isEmpty) return 0.0;
    if('+-*/'.contains(tokens.last)) {
       tokens.removeLast(); // ignore trailing operator for intermediate results
    }
    if(tokens.length == 1) return double.parse(tokens[0]);

    // Process * and /
    for (int i = 1; i < tokens.length - 1; i += 2) {
      if (tokens[i] == '*' || tokens[i] == '/') {
        double left = double.parse(tokens[i - 1]);
        double right = double.parse(tokens[i + 1]);
        double res = tokens[i] == '*' ? left * right : left / right;
        tokens[i - 1] = res.toString();
        tokens.removeAt(i);
        tokens.removeAt(i);
        i -= 2;
      }
    }
    
    // Process + and -
    double res = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length - 1; i += 2) {
      double right = double.parse(tokens[i + 1]);
      if (tokens[i] == '+') {
        res += right;
      } else if (tokens[i] == '-') {
        res -= right;
      }
    }
    
    return res;
  }
}
