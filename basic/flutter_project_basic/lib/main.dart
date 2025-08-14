import 'package:flutter/material.dart';
import './Project1_SimpleCalculatorAppusingFlutter/caculator.dart';
import 'Project2_BMIApp/bmi.dart';
import 'Project3_BuildingTicTacToeGame/BuildTicTacToeGame.dart';
import 'Project4_StoreApp/storyApp.dart';
import 'Project5_BuildTodoApp/todoApp.dart';
import 'Project6_BuildBirthDayReminder/birthdayReminderApp.dart';
import 'Project7_FortuneWheelSpin/fortuneWheelSpin.dart';

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
      // home: BMICalculaterPage(),
      // home: BuildTicTacToeGame(),
      // home: storyApp(),
      // home: todoApp(),
      // home: BirthdayReminderApp(),
      home: FortuneWheelSpin(),
    );
  }
}
