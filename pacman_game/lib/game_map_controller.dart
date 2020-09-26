import 'dart:math';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:pacman_game/components/ground_component.dart';
import 'package:pacman_game/components/wall_component.dart';
import 'package:pacman_game/constants/constants.dart';
import 'package:pacman_game/pacman.dart';

class GameMapController extends Component {
  List<List<int>> _mapDefinition = [
    [9, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 0, 0, 6, 4, 10],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 6, 4, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1],
    [1, 0, 0, 0, 7, 4, 4, 5, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1],
    [3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 4, 5, 0, 3],
    [11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11],
    [11, 0, 0, 0, 0, 0, 9, 4, 4, 5, 0, 0, 0, 0, 0, 0, 0, 0, 11],
    [2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 2],
    [1, 0, 0, 0, 0, 0, 1, 0, 6, 4, 5, 0, 1, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 6, 4, 4, 8, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 6, 4, 4, 10, 0, 0, 0, 1],
    [1, 0, 6, 4, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 4, 5, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 0, 0, 0, 6, 8]
  ];

  final PacMan game;
  Map<Point, Component> _map;

  Map<Point, Component> get map => _map;

  GameMapController(this.game) {
    _initGameMap();
  }

  void _initGameMap() {
    Map<Point, Component> gameMap;
    for (int y = 0; y < _mapDefinition.length; ++y) {
      for (int x = 0; x < _mapDefinition.length; ++x) {
        double posX = game.tileWidth * x;
        double posY = game.tileWidth * y;

        switch (_mapDefinition[y][x]) {
          case MapTiles.GROUND:
            gameMap[Point(x, y)] = GroundComponent(game, posX, posY);
            break;

          case MapTiles.WALL_UP:
            gameMap[Point(x, y)] = WallComponent(WallConstants.wallsMap[MapTiles.WALL_UP], game, posX, posY);
            break;

          case MapTiles.WALL_DOWN:
            gameMap[Point(x, y)] = WallComponent(WallConstants.wallsMap[MapTiles.WALL_DOWN], game, posX, posY);
            break;

          case MapTiles.WALL_DOWN_CLOSE_RIGHT:
            gameMap[Point(x, y)] = WallComponent(WallConstants.wallsMap[MapTiles.WALL_DOWN_CLOSE_RIGHT], game, posX, posY);
            break;

          case MapTiles.WALL_DOWN_CLOSE_LEFT:
            gameMap[Point(x, y)] = WallComponent(WallConstants.wallsMap[MapTiles.WALL_DOWN_CLOSE_LEFT], game, posX, posY);
            break;

          case MapTiles.WALL_UP_CLOSE_UP:
            gameMap[Point(x, y)] = WallComponent(WallConstants.wallsMap[MapTiles.WALL_UP_CLOSE_UP], game, posX, posY);
            break;

          case MapTiles.WALL_UP_CLOSE_DOWN:
            gameMap[Point(x, y)] = WallComponent(WallConstants.wallsMap[MapTiles.WALL_UP_CLOSE_DOWN], game, posX, posY);
            break;

          case MapTiles.WALL_SIDE_TOP_LEFT:
            gameMap[Point(x, y)] = WallComponent(WallConstants.wallsMap[MapTiles.WALL_SIDE_TOP_LEFT], game, posX, posY);
            break;

          case MapTiles.WALL_SIDE_TOP_RIGHT:
            gameMap[Point(x, y)] = WallComponent(WallConstants.wallsMap[MapTiles.WALL_SIDE_TOP_RIGHT], game, posX, posY);
            break;

          case MapTiles.WALL_SIDE_BOTTOM_LEFT:
            gameMap[Point(x, y)] = WallComponent(WallConstants.wallsMap[MapTiles.WALL_SIDE_BOTTOM_LEFT], game, posX, posY);
            break;

          case MapTiles.WALL_SIDE_BOTTOM_RIGHT:
            gameMap[Point(x, y)] = WallComponent(WallConstants.wallsMap[MapTiles.WALL_SIDE_BOTTOM_RIGHT], game, posX, posY);
            break;
        }
      }
    }
  }

  @override
  void render(Canvas c) {
    // TODO: implement render
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}

class MapTiles {
  // map of images
  static const WALL_UP = 1;
  static const WALL_DOWN = 4;
  static const WALL_DOWN_CLOSE_RIGHT = 5;
  static const WALL_DOWN_CLOSE_LEFT = 6;
  static const WALL_UP_CLOSE_UP = 2;
  static const WALL_UP_CLOSE_DOWN = 3;
  static const WALL_SIDE_TOP_LEFT = 9;
  static const WALL_SIDE_TOP_RIGHT = 10;
  static const WALL_SIDE_BOTTOM_LEFT = 7;
  static const WALL_SIDE_BOTTOM_RIGHT = 8;
  static const GROUND = 0;
}
