import 'package:flutter/material.dart';

class BMICalculaterPage extends StatefulWidget {
  const BMICalculaterPage({super.key});
  @override
  State<BMICalculaterPage> createState() => BMICalculaterPageState();
}

class BMICalculaterPageState extends State<BMICalculaterPage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController resultBMIController = TextEditingController();
  Color myColor = Colors.transparent;

  void calculatorBMI(String weight, String height) {
    var calWeight = double.parse(weight);
    var calHeight = double.parse(height);
    var resultBMI = (calWeight / (calHeight * calHeight));
    setState(() {
      resultBMIController.text = resultBMI.toStringAsFixed(2);
      if (resultBMI < 18.5) {
        myColor = Color(0xFF87B1D9);
      }
      // Normal
      else if (resultBMI >= 18.5 && resultBMI <= 24.9) {
        myColor = Color(0xFF3DD365);
      }
      // Overweight
      else if (resultBMI >= 25 && resultBMI <= 29.9) {
        myColor = Color(0xFFEEE133);
      }
      // Obese
      else if (resultBMI >= 30 && resultBMI <= 34.9) {
        myColor = Color(0xFFFD802E);
      }
      // Extreme
      else if (resultBMI >= 35) {
        myColor = Color(0xFFF95353);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.pink, Colors.blue]),
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Text(
                    "BMI Calculator",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: weightController,
                      autofocus: true,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter your weight (kg)",
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: heightController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter your height (m)",
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      calculatorBMI(
                        weightController.text,
                        heightController.text,
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.amber),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(15),
                        ),
                      ),
                    ),
                    child: Text(
                      'Calculator',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  Center(
                    child: Container(
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "BMI  " + resultBMIController.text,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCategory(
                        color: Color(0xFF87B1D9),
                        text: "Underweight",
                      ),
                      _buildCategory(color: Color(0xFF3DD365), text: "Normal"),
                      _buildCategory(
                        color: Color(0xFFEEE133),
                        text: "Overweight",
                      ),
                      _buildCategory(color: Color(0xFFFD802E), text: "Obese"),
                      _buildCategory(color: Color(0xFFF95353), text: "Extreme"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _buildCategory extends StatelessWidget {
  final Color color;
  final String text;
  const _buildCategory({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
          ),
        ),
        Text(text),
      ],
    );
  }
}
