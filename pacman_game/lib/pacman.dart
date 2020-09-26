import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:pacman_game/game_map_controller.dart';

class PacMan extends BaseGame with VerticalDragDetector, HorizontalDragDetector {
  Size screenSize;
  final gameColumns = 19;
  final gameRows = 18;
  double tileWidth, tileHeight;

  final VoidCallback onStateChanged;
  final VoidCallback onPlayedDead;

  GameMapController _gameMapController;
  GameMapController get gameMapController => _gameMapController;

  PacMan({this.onStateChanged, this.onPlayedDead}) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    _gameMapController = GameMapController(this);
  }

  @override
  void render(Canvas canvas) {
    if (this.screenSize == null) return;

    if (_gameMapController != null) _gameMapController.render(canvas);

    super.render(canvas);
  }

  @override
  void update(double t) {
    if (_gameMapController != null) _gameMapController.update(t);
    super.update(t);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileHeight = screenSize.height / gameRows;
    tileWidth = screenSize.width / gameColumns;
    super.resize(size);
  }

  @override
  void onVerticalDragEnd(DragEndDetails details) {
    double velocity = details.primaryVelocity;
    if (velocity < 0) {
      //up
    } else {
      //down
    }
  }

  @override
  void onHorizontalDragEnd(DragEndDetails details) {
    double velocity = details.primaryVelocity;
    if (velocity < 0) {
      //left
    } else {
      //right
    }
  }

  void die() {
    onPlayedDead();
    onStateChanged();
  }

  void addPoints() {
    onStateChanged();
  }
}
