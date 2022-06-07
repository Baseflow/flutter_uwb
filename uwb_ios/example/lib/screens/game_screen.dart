import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uwb_ios/uwb_ios.dart';

import '../game_widgets/ball.dart';
import '../game_widgets/brick.dart';
import '../game_widgets/brick_field.dart';
import '../game_widgets/paddle.dart';
import '../game_widgets/score.dart';
import '../game_widgets/screen_overlay.dart';

///Breakout game class. Contains the code for the breakout game.
class BreakoutGame extends StatefulWidget {
  ///Breakout game constructor
  const BreakoutGame({Key? key}) : super(key: key);

  @override
  _BreakoutGameState createState() => _BreakoutGameState();
}

///Contains the direction enums of the ball
enum direction {
  ///Ball goes up
  UP,

  ///Ball goes down
  DOWN,

  ///Ball goes left
  LEFT,

  ///Ball goes right
  RIGHT
}

class _BreakoutGameState extends State<BreakoutGame> {
  final UwbIos _plugin = UwbIos();
  bool gameHasStarted = false;
  bool playerIsDead = false;
  double ballX = 0;
  double ballY = 0;
  double paddleX = 0;
  double paddleY = 0.9;
  double paddleWidth = 0.4;
  int score = 0;
  direction ballYDirection = direction.DOWN;
  direction ballXDirection = direction.LEFT;
  late List<Brick> brickFieldList;
  final GlobalKey<State<StatefulWidget>> ballKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> brickKey = GlobalKey();
  Color brickColor = Colors.blueAccent;

  double? _xPosition;

  @override
  void initState() {
    initPlatformState();
    joinHost();
    brickFieldList = generateBrickFieldList();
    super.initState();
  }

  void startGame() {
    if (gameHasStarted == false) {
      gameHasStarted = true;
      Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
        checkWallCollision();
        if (ballY < -0.4) {
          checkBrickCollision();
        }
        moveBall();
        movePlatform();
        if (isPLayerDead()) {
          playerIsDead = true;
          timer.cancel();
          _showDialog('G A M E  O V E R', Colors.redAccent);
        }
        if (score == 20) {
          timer.cancel();
          _showDialog('Y O U  W I N', Colors.green);
        }
      });
    }
  }

  void resetGame() {
    Navigator.pop(context);
    brickFieldList.clear();
    brickFieldList = generateBrickFieldList();
    setState(() {
      gameHasStarted = false;
      playerIsDead = false;
      paddleX = 0;
      ballX = 0;
      ballY = 0;
      score = 0;
    });
  }

  void checkWallCollision() {
    setState(() {
      if (ballY >= 0.9 && paddleX + paddleWidth >= ballX && paddleX <= ballX) {
        ballYDirection = direction.UP;
      } else if (ballY <= -0.9) {
        ballYDirection = direction.DOWN;
      }

      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  void checkBrickCollision() {
    final RenderBox? ballBox =
        ballKey.currentContext?.findRenderObject() as RenderBox?;
    final Size? ballSize = ballBox?.size;
    final Offset? ballPosition = ballBox?.localToGlobal(Offset.zero);
    bool collide = false;

    final double? ballPositionY = ballPosition?.dy;
    final double? ballPositionX = ballPosition?.dx;
    final double? ballSizeHeight = ballSize?.height;
    final double? ballSizeWidth = ballSize?.width;

    for (final Brick brick in brickFieldList) {
      final RenderBox? brickBox =
          brick.brickKey.currentContext?.findRenderObject() as RenderBox?;
      final Size? brickSize = brickBox?.size;
      final Offset? brickPosition = brickBox?.localToGlobal(Offset.zero);

      final double? brickPositionY = brickPosition?.dy;
      final double? brickPositionX = brickPosition?.dx;
      final double? brickSizeHeight = brickSize?.height;
      final double? brickSizeWidth = brickSize?.width;

      if (ballPosition != null && brickPosition != null) {
        collide = ballPosition.dx < brickPosition.dx + brickSize!.width &&
            ballPosition.dx + ballSize!.width > brickPosition.dx &&
            ballPosition.dy < brickPosition.dy + brickSize.height &&
            ballPosition.dy + ballSize.height > brickPosition.dy;

        if (collide) {
          setState(() {
            brickFieldList.remove(brick);
            score++;
            bool didToggle = false;

            if (ballPositionY! - (brickPositionY! + brickSizeHeight!) < 1 &&
                    ballPositionY - (brickPositionY + brickSizeHeight) > -8 ||
                ballPositionY + ballSizeHeight! - brickPositionY < 8 &&
                    ballPositionY + ballSizeHeight - brickPositionY > -1) {
              print('VERTICAL TOGGLE AT SCORE: $score');
              didToggle = true;
              toggleVerticalMovement();
            }

            if (ballPositionX! - (brickPositionX! + brickSizeWidth!) < 1 &&
                    ballPositionX - (brickPositionX + brickSizeWidth) > -15 ||
                ballPositionX + ballSizeWidth! - brickPositionX < 15 &&
                    ballPositionX + ballSizeWidth - brickPositionX > -1) {
              toggleHorizontalMovement();
              didToggle = true;
              print('HORIZONTAL TOGGLE AT SCORE: $score');
            }
            if (!didToggle) {
              print('NO TOGGLE');
            }
          });
        }
      }
      if (collide) {
        break;
      }
    }
  }

  void toggleVerticalMovement() {
    setState(() {
      if (ballYDirection == direction.DOWN) {
        ballYDirection = direction.UP;
      } else {
        ballYDirection = direction.DOWN;
      }
    });
  }

  void toggleHorizontalMovement() {
    setState(() {
      if (ballXDirection == direction.RIGHT) {
        ballXDirection = direction.LEFT;
      } else {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  void moveBall() {
    setState(() {
      if (ballYDirection == direction.DOWN) {
        ballY += 0.001;
      } else if (ballYDirection == direction.UP) {
        ballY -= 0.001;
      }

      if (ballXDirection == direction.RIGHT) {
        ballX += 0.002;
      } else if (ballXDirection == direction.LEFT) {
        ballX -= 0.002;
      }
    });
  }

  void movePlatform() {
    if (_xPosition != null) {
      setState(() {
        paddleX = 2 * -_xPosition!;
      });
    }
  }

  void _showDialog(String title, Color color) {
    showDialog<Dialog>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ), // To display the title it is optional
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '\nYour score: $score',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                resetGame();
              },
              child: const Text('EXIT'),
              style: TextButton.styleFrom(primary: Colors.white),
            ),
            TextButton(
              onPressed: () {
                resetGame();
              },
              child: const Text('REPLAY'),
              style: TextButton.styleFrom(primary: Colors.white),
            ),
          ],
        );
      },
    );
  }

  void onLocation(Map<dynamic, dynamic> location) {
    final String _direction = location['direction'] as String;
    final List<String> _directionArray = _direction.split(',');
    final double _x = double.parse(_directionArray[0]);
    final double _y = double.parse(_directionArray[1]);

    setState(() {
      if (_x != 0.0 && _y != 0.0) {
        _xPosition = _x;
      }
    });
  }

  Future<void> initPlatformState() async {
    ///Needed for initial set-up and checks device compatibility
    await _plugin.setUp();

    if (!mounted) {
      return;
    }
  }

  Future<void> joinHost() async {
    await _plugin.joinHost('test-device', 'uwb-test');
    _plugin.getLocation(onLocation: onLocation);
  }

  List<Brick> generateBrickFieldList() {
    final List<Brick> brickFieldList = <Brick>[];

    for (double y = -0.5; y >= -0.8; y -= 0.1) {
      for (double x = -0.9; x <= 1; x += 0.45) {
        brickFieldList.add(
            Brick(x: x, y: y, brickColor: brickColor, brickKey: GlobalKey()));
      }
    }
    return brickFieldList;
  }

  bool isPLayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: startGame,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Stack(
            children: <Widget>[
              BrickField(brickFieldList: brickFieldList),
              ScreenOverlay(gameHasStarted: gameHasStarted),
              Ball(x: ballX, y: ballY, ballKey: ballKey),
              Paddle(x: paddleX, y: paddleY),
              Score(score: score, gameHasStarted: gameHasStarted)
            ],
          ),
        ),
      ),
    );
  }
}
