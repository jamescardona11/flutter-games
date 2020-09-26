import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:pacman_game/pacman.dart';

class GroundComponent extends Component {
  final PacMan game;
  Sprite sprite = Sprite('ground.png');
  Rect groundRect;

  GroundComponent(this.game, double x, double y) {
    groundRect = Rect.fromLTWH(x, y, game.tileWidth, game.tileHeight);
  }

  @override
  void render(Canvas c) {
    sprite.renderRect(c, groundRect.inflate(2));
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
