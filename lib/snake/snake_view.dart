import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_games/constants/constants.dart';

final defaultPosition = [45, 65, 85, 105, 125];
enum Direction { down, up, left, right }
enum TimerState { running, stop }

class SnakeView extends StatefulWidget {
  @override
  _SnakeViewState createState() => _SnakeViewState();
}

class _SnakeViewState extends State<SnakeView> {
  List<int> snakePosition = []..addAll(defaultPosition);
  int numberOfSquares = 0;
  final int widthOfSquare = 20;

  static Random randomNumber = Random();
  int food = randomNumber.nextInt(700);

  Direction direction = Direction.down;
  Timer _timer;

  String state = 'Start';
  TimerState timerState = TimerState.stop;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paddingTop = MediaQuery.of(context).padding.top;
    final squareSize = size.width / widthOfSquare;
    numberOfSquares = ((size.height - paddingTop - 60) / squareSize).round() * widthOfSquare;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (direction != Direction.up && details.delta.dy > 0) {
                    direction = Direction.down;
                  } else if (direction != Direction.down && details.delta.dy < 0) {
                    direction = Direction.up;
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (direction != Direction.left && details.delta.dx > 0) {
                    direction = Direction.right;
                  } else if (direction != Direction.right && details.delta.dx < 0) {
                    direction = Direction.left;
                  }
                },
                child: GridView.builder(
                  itemCount: numberOfSquares,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: widthOfSquare),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 5,
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: getColor(index),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      startGame();
                    },
                    child: Text(state, style: myNewFontWhite),
                  ),
                  Text('@kodevincere', style: myNewFontWhite),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Color getColor(int index) {
    if (snakePosition.contains(index))
      return Colors.white;
    else if (index == food) return Colors.green;

    return Colors.white.withOpacity(0.1);
  }

  void generateNewFood() {
    food = randomNumber.nextInt(700);
  }

  void startGame() {
    switch (timerState) {
      case TimerState.stop:
        _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
          updateSnake();

          if (gameOver()) {
            timer.cancel();
            initDefault();
            _showGameOverScreen();
          }
        });

        setState(() {
          state = 'Stop';
          timerState = TimerState.running;
        });
        break;
      case TimerState.running:
        _timer.cancel();
        setState(() {
          state = 'Start';
          timerState = TimerState.stop;
        });
        break;
    }
  }

  void initDefault() {
    snakePosition.clear();
    snakePosition.addAll(defaultPosition);
  }

  bool gameOver() {
    for (int i = 0; i < snakePosition.length; ++i) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; ++j) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void _showGameOverScreen() {
    showDialog(
      context: context,
      barrierDismissible: false, // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('GAME OVER!!!'),
          content: Text('SCORE: ${snakePosition.length}'),
          actions: [
            FlatButton(
              child: Text('Play Again'),
              onPressed: () {
                startGame();
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  void updateSnake() {
    setState(() {
      int addValue = 0;

      switch (direction) {
        case Direction.down:
          addValue = widthOfSquare + (snakePosition.last > numberOfSquares - widthOfSquare ? -numberOfSquares : 0);
          break;
        case Direction.up:
          addValue = -widthOfSquare + (snakePosition.last < widthOfSquare ? numberOfSquares : 0);
          break;
        case Direction.left:
          addValue = -1 + (snakePosition.last % widthOfSquare == 0 ? widthOfSquare : 0);
          break;
        case Direction.right:
          addValue = 1 + ((snakePosition.last + 1) % widthOfSquare == 0 ? -widthOfSquare : 0);
          break;
      }

      snakePosition.add(snakePosition.last + addValue);

      if (snakePosition.last == food) {
        generateNewFood();
      } else {
        snakePosition.removeAt(0);
      }
    });
  }
}
