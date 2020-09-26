import 'dart:math';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:pacman_game/components/coin_component.dart';
import 'package:pacman_game/components/ghost_component.dart';
import 'package:pacman_game/components/ground_component.dart';
import 'package:pacman_game/components/player_component.dart';
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
  PlayerComponent _player;
  List<GhostComponent> _ghosts = List();
  List<CoinComponent> _coins = List();
  List<CoinComponent> _coinsToRemove = List();

  set addCoinToRemove(CoinComponent coin) {
    _coinsToRemove.add(coin);
  }

  Map<Point, Component> get map => _map;
  PlayerComponent get player => _player;
  List<CoinComponent> get coins => _coins;

  GameMapController(this.game) {
    _initGameMap();
    _addPlayer();
    _addGhosts();
  }

  void _initGameMap() {
    var gameMap = Map<Point, Component>();

    for (int y = 0; y < _mapDefinition.length; ++y) {
      for (int x = 0; x < _mapDefinition.length; ++x) {
        double posX = game.tileWidth * x;
        double posY = game.tileWidth * y;

        MapTiles casee = MapTilesExtension.fromInt(_mapDefinition[y][x]);
        print('$casee');
        print('${casee.asPath()}');
        switch (casee) {
          case MapTiles.GROUND:
            gameMap[Point(x, y)] = GroundComponent(game, posX, posY);
            break;

          case MapTiles.WALL_UP:
            gameMap[Point(x, y)] = WallComponent(MapTiles.WALL_UP.asPath(), game, posX, posY);
            break;

          case MapTiles.WALL_DOWN:
            gameMap[Point(x, y)] = WallComponent(MapTiles.WALL_DOWN.asPath(), game, posX, posY);
            break;

          case MapTiles.WALL_DOWN_CLOSE_RIGHT:
            gameMap[Point(x, y)] = WallComponent(MapTiles.WALL_DOWN_CLOSE_RIGHT.asPath(), game, posX, posY);
            break;

          case MapTiles.WALL_DOWN_CLOSE_LEFT:
            gameMap[Point(x, y)] = WallComponent(MapTiles.WALL_DOWN_CLOSE_LEFT.asPath(), game, posX, posY);
            break;

          case MapTiles.WALL_UP_CLOSE_UP:
            gameMap[Point(x, y)] = WallComponent(MapTiles.WALL_UP_CLOSE_UP.asPath(), game, posX, posY);
            break;

          case MapTiles.WALL_UP_CLOSE_DOWN:
            gameMap[Point(x, y)] = WallComponent(MapTiles.WALL_UP_CLOSE_DOWN.asPath(), game, posX, posY);
            break;

          case MapTiles.WALL_SIDE_TOP_LEFT:
            gameMap[Point(x, y)] = WallComponent(MapTiles.WALL_SIDE_TOP_LEFT.asPath(), game, posX, posY);
            break;

          case MapTiles.WALL_SIDE_TOP_RIGHT:
            gameMap[Point(x, y)] = WallComponent(MapTiles.WALL_SIDE_TOP_RIGHT.asPath(), game, posX, posY);
            break;

          case MapTiles.WALL_SIDE_BOTTOM_LEFT:
            gameMap[Point(x, y)] = WallComponent(MapTiles.WALL_SIDE_BOTTOM_LEFT.asPath(), game, posX, posY);
            break;

          case MapTiles.WALL_SIDE_BOTTOM_RIGHT:
            gameMap[Point(x, y)] = WallComponent(MapTiles.WALL_SIDE_BOTTOM_RIGHT.asPath(), game, posX, posY);
            break;
        }
      }
    }

    this._map = gameMap;
  }

  void _addPlayer() {
    if (_map.isNotEmpty) {
      _player = PlayerComponent(game);
    }
  }

  void _addGhosts() {
    if (_map.isNotEmpty) {
      _ghosts.add(GhostComponent(GhostConstants.ghostsMap[GhostTypes.BLUE], game, 5, 3));
      _ghosts.add(GhostComponent(GhostConstants.ghostsMap[GhostTypes.GREEN], game, 6, 3));
      _ghosts.add(GhostComponent(GhostConstants.ghostsMap[GhostTypes.PINK], game, 7, 3));

      _ghosts.add(GhostComponent(GhostConstants.ghostsMap[GhostTypes.LIGHT_BLUE], game, 11, 15));
      _ghosts.add(GhostComponent(GhostConstants.ghostsMap[GhostTypes.LIGHT_GREEN], game, 12, 15));
      _ghosts.add(GhostComponent(GhostConstants.ghostsMap[GhostTypes.RED], game, 13, 15));
    }
  }

  @override
  void render(Canvas c) {
    _map.forEach((position, component) {
      component.render(c);
    });
    _player.render(c);

    if (_coins.length > 0) {
      _coins.forEach((coin) {
        coin.render(c);
      });
    }

    if (_ghosts.length > 0) {
      _ghosts.forEach((ghost) {
        ghost.render(c);
      });
    }
  }

  @override
  void update(double t) {
    _player.update(t);

    _ghosts.forEach((ghost) {
      ghost.update(t);
    });

    _coins.forEach((coin) {
      coin.update(t);
    });

    // Remove coins consumed
    if (_coinsToRemove.isNotEmpty) {
      _coins.removeWhere((coin) => _coinsToRemove.contains(coin));
      _coinsToRemove.clear();
    }
  }

  void managePlayerMovement(String direction) {
    switch (direction) {
      case "LEFT":
        _movePlayer(-1.0, 0.0);
        break;
      case "RIGHT":
        _movePlayer(1.0, 0.0);
        break;
      case "UP":
        _movePlayer(0.0, 1.0);
        break;
      case "DOWN":
        _movePlayer(0.0, -1.0);
        break;
    }
  }

  void _movePlayer(double offsetX, double offsetY) {
    if (_player.position == null) {
      return;
    }

    Point targetPoint = Point((_player.position.x + offsetX), (_player.position.y + offsetY));

    if (_map[targetPoint] is WallComponent) {
      return;
    }

    if (targetPoint.x < 0) {
      targetPoint = Point(_player.position.x + game.gameColumns - 1, _player.position.y);
    }

    if (targetPoint.x > game.gameColumns - 1) {
      targetPoint = Point(0, _player.position.y);
    }

    if (targetPoint.y < 0) {
      targetPoint = Point(_player.position.x, _player.position.y + game.gameRows - 1);
    }

    if (targetPoint.y > game.gameRows - 1) {
      targetPoint = Point(_player.position.x, _player.position.y - game.gameColumns + 2);
    }

    _player.targetLocation = targetPoint;
  }
}

// map of images
enum MapTiles {
  WALL_UP,
  WALL_DOWN,
  WALL_DOWN_CLOSE_RIGHT,
  WALL_DOWN_CLOSE_LEFT,
  WALL_UP_CLOSE_UP,
  WALL_UP_CLOSE_DOWN,
  WALL_SIDE_TOP_LEFT,
  WALL_SIDE_TOP_RIGHT,
  WALL_SIDE_BOTTOM_LEFT,
  WALL_SIDE_BOTTOM_RIGHT,
  GROUND,
}

extension MapTilesExtension on MapTiles {
  static MapTiles fromInt(int value) => {
        1: MapTiles.WALL_UP,
        4: MapTiles.WALL_DOWN,
        5: MapTiles.WALL_DOWN_CLOSE_RIGHT,
        6: MapTiles.WALL_DOWN_CLOSE_LEFT,
        2: MapTiles.WALL_UP_CLOSE_UP,
        3: MapTiles.WALL_UP_CLOSE_DOWN,
        9: MapTiles.WALL_SIDE_TOP_LEFT,
        10: MapTiles.WALL_SIDE_TOP_RIGHT,
        7: MapTiles.WALL_SIDE_BOTTOM_LEFT,
        8: MapTiles.WALL_SIDE_BOTTOM_RIGHT,
        0: MapTiles.GROUND,
      }[value];

  int asInt() => {
        MapTiles.WALL_UP: 1,
        MapTiles.WALL_DOWN: 4,
        MapTiles.WALL_DOWN_CLOSE_RIGHT: 5,
        MapTiles.WALL_DOWN_CLOSE_LEFT: 6,
        MapTiles.WALL_UP_CLOSE_UP: 2,
        MapTiles.WALL_UP_CLOSE_DOWN: 3,
        MapTiles.WALL_SIDE_TOP_LEFT: 9,
        MapTiles.WALL_SIDE_TOP_RIGHT: 10,
        MapTiles.WALL_SIDE_BOTTOM_LEFT: 7,
        MapTiles.WALL_SIDE_BOTTOM_RIGHT: 8,
        MapTiles.GROUND: 0,
      }[this];

  String asPath() => {
        MapTiles.WALL_UP: 'wall/wall_up.png',
        MapTiles.WALL_DOWN: 'wall/wall_up_close_top.png',
        MapTiles.WALL_DOWN_CLOSE_RIGHT: 'wall/wall_up_close_bottom.png',
        MapTiles.WALL_DOWN_CLOSE_LEFT: 'wall/wall_down.png',
        MapTiles.WALL_UP_CLOSE_UP: 'wall/wall_down_close_right.png',
        MapTiles.WALL_UP_CLOSE_DOWN: 'wall/wall_down_close_left.png',
        MapTiles.WALL_SIDE_TOP_LEFT: 'wall/wall_side_bottom_left.png',
        MapTiles.WALL_SIDE_TOP_RIGHT: 'wall/wall_side_bottom_right.png',
        MapTiles.WALL_SIDE_BOTTOM_LEFT: 'wall/wall_side_top_left.png',
        MapTiles.WALL_SIDE_BOTTOM_RIGHT: 'wall/wall_side_top_right.png',
      }[this];
}
