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
          /*

      if(gameOver()){
      timer.cancel();
      _showGameOverScreen();

      }

       */
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

  void updateSnake() {
    setState(() {
      int addValue = 0;

      switch (direction) {
        case Direction.down:
          addValue = snakePosition.last +
              widthOfSquare +
              (snakePosition.last > numberOfSquares - widthOfSquare ? -numberOfSquares : 0);
          break;
        case Direction.up:
          addValue = snakePosition.last - widthOfSquare + (snakePosition.last < widthOfSquare ? widthOfSquare : 0);
          break;
        case Direction.left:
          addValue = snakePosition.last - 1 + (snakePosition.last % widthOfSquare == 0 ? widthOfSquare : 0);
          break;
        case Direction.right:
          addValue = snakePosition.last + 1 + ((snakePosition.last + 1) % widthOfSquare == 0 ? -widthOfSquare : 0);
          break;
      }

      snakePosition.add(addValue);

      if (snakePosition.last == food) {
        generateNewFood();
      } else {
        snakePosition.removeAt(0);
      }
    });
  }
}
