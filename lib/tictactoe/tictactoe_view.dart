import 'package:flutter/material.dart';
import 'package:flutter_games/constants/constants.dart';

class TicTacToeView extends StatefulWidget {
  @override
  _TicTacToeViewState createState() => _TicTacToeViewState();
}

class _TicTacToeViewState extends State<TicTacToeView> {
  List<String> displayExOh = ['', '', '', '', '', '', '', '', ''];
  bool ohTurn = true;
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          SizedBox(height: 15),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player O', style: myNewFontWhite),
                        SizedBox(height: 20),
                        Text(ohScore.toString(), style: myNewFontWhite),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player X', style: myNewFontWhite),
                        SizedBox(height: 20),
                        Text(exScore.toString(), style: myNewFontWhite),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  'TURN: ${ohTurn ? 'O' : 'X'}',
                  style: myNewFontWhite.copyWith(color: Colors.green[600]),
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: 9,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => _onTapped(index),
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey[700])),
                            child: Center(
                              child: Text(
                                displayExOh[index],
                                style: TextStyle(color: Colors.white, fontSize: 40),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text('TIC TAC TOE', style: myNewFontWhite),
                SizedBox(height: 60),
                Text('@KODEVINCERE', style: myNewFontWhite),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTapped(int index) {
    setState(() {
      if (ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'O';
        filledBoxes += 1;
      } else if (!ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'X';
        filledBoxes += 1;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // checks 1st row
    if (displayExOh[0] == displayExOh[1] && displayExOh[0] == displayExOh[2] && displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }

    // checks 2nd row
    if (displayExOh[3] == displayExOh[4] && displayExOh[3] == displayExOh[5] && displayExOh[3] != '') {
      _showWinDialog(displayExOh[3]);
    }

    // checks 3rd row
    if (displayExOh[6] == displayExOh[7] && displayExOh[6] == displayExOh[8] && displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    }

    // checks 1st column
    if (displayExOh[0] == displayExOh[3] && displayExOh[0] == displayExOh[6] && displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }

    // checks 2nd column
    if (displayExOh[1] == displayExOh[4] && displayExOh[1] == displayExOh[7] && displayExOh[1] != '') {
      _showWinDialog(displayExOh[1]);
    }

    // checks 3rd column
    if (displayExOh[2] == displayExOh[5] && displayExOh[2] == displayExOh[8] && displayExOh[2] != '') {
      _showWinDialog(displayExOh[2]);
    }

    // checks diagonal
    if (displayExOh[6] == displayExOh[4] && displayExOh[6] == displayExOh[2] && displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    }

    // checks diagonal
    if (displayExOh[0] == displayExOh[4] && displayExOh[0] == displayExOh[8] && displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('DRAW'),
            actions: <Widget>[
              FlatButton(
                child: Text('Play Again!'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('WINNER IS: ' + winner),
            actions: <Widget>[
              FlatButton(
                child: Text('Play Again!'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'o') {
      ohScore += 1;
    } else if (winner == 'x') {
      exScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExOh[i] = '';
      }
    });

    filledBoxes = 0;
  }
}
