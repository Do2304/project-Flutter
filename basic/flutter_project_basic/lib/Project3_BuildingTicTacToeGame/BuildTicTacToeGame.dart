import 'package:flutter/material.dart';

class BuildTicTacToeGame extends StatefulWidget {
  const BuildTicTacToeGame({super.key});
  @override
  State<BuildTicTacToeGame> createState() => BuildTicTacToeGameState();
}

class BuildTicTacToeGameState extends State<BuildTicTacToeGame> {
  bool oTurn = true;
  int oScore = 0;
  int xScore = 0;
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int fillBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(height: 100),
                      Text(
                        "Player X",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        xScore.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(height: 100),
                      Text(
                        "Player O",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        oScore.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _onTapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        displayElement[index],
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _ClearBoardScore();
                    },
                    child: Text("Clear Score Board"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        fillBoxes++;
      } else {
        displayElement[index] = 'X';
        fillBoxes++;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      _showDialog(displayElement[0]);
    } else if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      _showDialog(displayElement[3]);
    } else if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      _showDialog(displayElement[6]);
    } else if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      _showDialog(displayElement[0]);
    } else if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      _showDialog(displayElement[1]);
    } else if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      _showDialog(displayElement[2]);
    } else if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      _showDialog(displayElement[0]);
    } else if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      _showDialog(displayElement[2]);
    } else if (fillBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDialog(String Winner) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(" $Winner is winner"),
          actions: [
            TextButton(
              onPressed: () {
                _clearBoard();
                Navigator.pop(context);
              },
              child: Text("Play again"),
            ),
          ],
        );
      },
    );
    if (Winner == 'O') {
      oScore++;
    } else {
      xScore++;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
      fillBoxes = 0;
    });
  }

  void _ClearBoardScore() {
    setState(() {
      oScore = 0;
      xScore = 0;
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
      fillBoxes = 0;
    });
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Draw"),
          actions: [
            TextButton(
              onPressed: () {
                _clearBoard();
                Navigator.pop(context);
              },
              child: Text("Play Again"),
            ),
          ],
        );
      },
    );
  }
}
