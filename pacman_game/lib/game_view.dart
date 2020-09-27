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
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: StreamBuilder(
                      stream: gamesStarted.stream,
                      builder: (context, _) {
                        String txtt = '0';
                        if (game != null && game.gameMapController != null && game.gameMapController.player != null) {
                          txtt = game.gameMapController.player.points.toString();
                        }

                        return Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0, right: 10.0, top: 16.0, bottom: 4.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 25.0),
                                  child: Text('Score', style: titleStyle),
                                ),
                                Text(txtt, style: titleStyle),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: resetGame.stream,
                      builder: (context, sss) {
                        if (sss.hasData != null) {
                          var newGame = PacMan(onStateChanged: () {
                            gamesStarted.add(const Object());
                          }, onPlayerDead: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("GameOver"),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          resetGame.add(const Object());
                                        },
                                        child: Text("Restart"),
                                      ),
                                    ],
                                  );
                                });
                          });

                          if (game != null) {
                            newGame.resize(game.screenSize);
                          }

                          game = newGame;
                          return game.widget;
                        }

                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 70,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Drag the screen in the direction you want to move',
                        style: titleStyle.copyWith(fontSize: 10),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white.withAlpha(100),
                            size: 24,
                          ),
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white.withAlpha(180),
                            size: 24,
                          ),
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white.withAlpha(255),
                            size: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future delay() async {
    await Future.delayed(Duration(milliseconds: 2000));
  }

  @override
  void dispose() {
    gamesStarted.close();
    resetGame.close();
    super.dispose();
  }
}
