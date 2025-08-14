import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:confetti/confetti.dart';

class Lunch {
  final String meals;
  var img;

  Lunch({required this.meals, this.img});

  factory Lunch.fromJson(Map<String, dynamic> json) {
    return Lunch(meals: json['strMeal'], img: json['strMealThumb']);
  }
}

class FortuneWheelSpin extends StatefulWidget {
  @override
  State<FortuneWheelSpin> createState() => _FortuneWheelSpinState();
}

class _FortuneWheelSpinState extends State<FortuneWheelSpin> {
  StreamController<int> selected = StreamController<int>();

  late ConfettiController _centerController;

  String url = "https://www.themealdb.com/api/json/v1/1/filter.php?a=Indian";

  List<Lunch> _ideas = [];

  Future<void> _getLunchIdeas() async {
    http.Response response;

    Uri uri = Uri.parse(url);
    response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData['meals'] != null) {
        List<dynamic> meals = jsonData['meals'];
        print("Fetched meals: $meals");
        setState(() {
          _ideas = meals.map((json) => Lunch.fromJson(json)).toList();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getLunchIdeas();

    _centerController = ConfettiController(
      duration: const Duration(seconds: 10),
    );
  }

  @override
  void dispose() {
    selected.close();

    _centerController.dispose();
    super.dispose();
  }

  var selectedIdea = "";
  late var selectedImg;

  void setValue(value) {
    selectedIdea = _ideas[value].meals.toString();
    selectedImg = _ideas[value].img;
  }

  @override
  Widget build(BuildContext context) {
    var flag = false;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: const Text('Gfg Lunch Wheel'),

        backgroundColor: Colors.green,

        foregroundColor: Colors.white,
      ),
      body: _ideas.length > 2
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected.add(Fortune.randomInt(0, _ideas.length));
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 350,
                      child: FortuneWheel(
                        selected: selected.stream,

                        items: [
                          for (var it in _ideas)
                            FortuneItem(child: Text(it.meals)),
                        ],
                        onAnimationEnd: () {
                          _centerController.play();

                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    scrollable: true,

                                    title: Text("Hurray! today's meal is????"),
                                    content: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: SizedBox(
                                            width: 300,
                                            height: 300,
                                            child: Center(
                                              child: ConfettiWidget(
                                                confettiController:
                                                    _centerController,
                                                blastDirection: pi,
                                                maxBlastForce: 10,
                                                minBlastForce: 1,
                                                emissionFrequency: 0.03,
                                                numberOfParticles: 100,
                                                gravity: 0,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              selectedIdea,
                                              style: TextStyle(fontSize: 22),
                                            ),

                                            Image.network(selectedImg),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        onFocusItemChanged: (value) {
                          if (flag == true) {
                            setValue(value);
                          } else {
                            flag = true;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              // Show loading indicator
              child: CircularProgressIndicator(color: Colors.green),
            ),
    );
  }
}
