import 'package:flutter/material.dart';
import './Project1_SimpleCalculatorAppusingFlutter/caculator.dart';
import './Project12_BMIApp/bmi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: CalculaterPage(),
      home: BMICalculaterPage(),
    );
  }
}
