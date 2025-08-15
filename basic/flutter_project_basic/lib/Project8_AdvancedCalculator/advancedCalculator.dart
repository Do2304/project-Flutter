import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  var input = '';
  var output = '';

  void _onButtonClicked(value) {
    setState(() {
      if (value == "AC") {
        input = '';
        output = '';
      } else if (value == "A") {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (value == '=') {
        if (input.isNotEmpty) {
          var userInput = input;
          userInput = input.replaceAll("", "");
          ExpressionParser p = GrammarParser();
          Expression exp = p.parse(userInput);
          ContextModel context = ContextModel();
          var finalValue = exp.evaluate(EvaluationType.REAL, context);
          output = finalValue.toString();
        }
      } else {
        input = input + value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  Text(
                    output,
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              button("AC", Colors.black, Colors.orangeAccent),
              button("A", Colors.black, Colors.orangeAccent),
              button("", Colors.transparent, Colors.white),
              button("/", Colors.black, Colors.orangeAccent),
            ],
          ),
          Row(
            children: [
              button("7", Colors.black, Colors.white),
              button("8", Colors.black, Colors.white),
              button("9", Colors.black, Colors.white),
              button("*", Colors.black, Colors.orangeAccent),
            ],
          ),
          Row(
            children: [
              button("4", Colors.black, Colors.white),
              button("5", Colors.black, Colors.white),
              button("6", Colors.black, Colors.white),
              button("-", Colors.black, Colors.orangeAccent),
            ],
          ),
          Row(
            children: [
              button("1", Colors.black, Colors.white),
              button("2", Colors.black, Colors.white),
              button("3", Colors.black, Colors.white),
              button("+", Colors.black, Colors.orangeAccent),
            ],
          ),
          Row(
            children: [
              button("%", Colors.black, Colors.white),
              button("0", Colors.black, Colors.white),
              button(".", Colors.black, Colors.white),
              button("=", Colors.black, Colors.orangeAccent),
            ],
          ),
        ],
      ),
    );
  }

  Expanded button(text, color, tColor) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              _onButtonClicked(text);
            },
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: tColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
