import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pacman_game/pacman.dart';

import 'constants/constants.dart';

class GameView extends StatefulWidget {
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  PacMan game;

  final StreamController gamesStarted = StreamController();
  final StreamController resetGame = StreamController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            margin: EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 10, top: 16, bottom: 4),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 25),
                        child: Text('Score', style: titleStyle),
                      ),
                      Text('0', style: titleStyle),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: resetGame.stream,
                    builder: (context, _) {
                      var newGame = PacMan(
                        onStateChanged: () {
                          gamesStarted.add(Object());
                        },
                        onPlayedDead: () {},
                      );

                      if (game != null) {
                        newGame.resize(game.screenSize);
                      }

                      game = newGame;
                      return game.widget;
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    gamesStarted.close();
    resetGame.close();
    super.dispose();
  }
}
