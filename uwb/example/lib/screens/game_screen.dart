import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:uwb/uwb.dart';

import '../game_widgets/ball.dart';
import '../game_widgets/brick.dart';
import '../game_widgets/brick_field.dart';
import '../game_widgets/paddle.dart';
import '../game_widgets/score.dart';
import '../game_widgets/screen_overlay.dart';

class BreakoutGame extends StatefulWidget {
  const BreakoutGame({Key? key}) : super(key: key);

  @override
  _BreakoutGameState createState() => _BreakoutGameState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _BreakoutGameState extends State<BreakoutGame> {
  final Uwb _plugin = Uwb();
  bool gameHasStarted = false;
  bool playerIsDead = false;
  double ballX = 0;
  double ballY = 0;
  double paddleX = 0;
  double paddleY = 0.9;
  double paddleHitBox = 0;
  int score = 0;
  direction ballYDirection = direction.DOWN;
  direction ballXDirection = direction.LEFT;
  late List<Brick> brickFieldList;
  final GlobalKey<State<StatefulWidget>> ballKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> brickKey = GlobalKey();
  Color brickColor = Colors.blueAccent;

  double? _xPosition;
  double? _distance;
  double? _angle;
  String? _error;

  @override
  void initState() {
    initPlatformState();
    joinHost();
    brickFieldList = generateBrickFieldList();
    super.initState();
  }

  void onSetup(bool? status) {
    if (status != null && !status) {
      setState(() {
        _error = """Device is incompatible with this app.
        Please check device OS version and UWB compatibility. 
        For Apple users iOS version should be 14.0 or higher.""";
      });
    }
  }

  void startGame() {
    if (gameHasStarted == false) {
      gameHasStarted = true;
      Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
        checkWallCollision();
        if (ballY < -0.4) {
          checkBrickCollision();
        }
        if (ballY > -0.8) {
          // checkPlatformCollision();
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
      ///Vertical
      if (ballY >= 0.9 && paddleX + 0.4 >= ballX && paddleX <= ballX) {
        ballYDirection = direction.UP;
      } else if (ballY <= -0.9) {
        ballYDirection = direction.DOWN;
      }

      ///horizontal
      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  void checkBrickCollision() {
    RenderBox? ballBox =
        ballKey.currentContext?.findRenderObject() as RenderBox?;
    final Size? ballSize = ballBox?.size;
    final Offset? ballPosition = ballBox?.localToGlobal(Offset.zero);
    bool collide = false;

    double? ballPositionY = ballPosition?.dy;
    double? ballPositionX = ballPosition?.dx;
    double? ballSizeHeight = ballSize?.height;
    double? ballSizeWidth = ballSize?.width;

    for (Brick brick in brickFieldList) {
      RenderBox? brickBox =
          brick.brickKey.currentContext?.findRenderObject() as RenderBox?;
      final Size? brickSize = brickBox?.size;
      final Offset? brickPosition = brickBox?.localToGlobal(Offset.zero);

      double? brickPositionY = brickPosition?.dy;
      double? brickPositionX = brickPosition?.dx;
      double? brickSizeHeight = brickSize?.height;
      double? brickSizeWidth = brickSize?.width;

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
        } else {
          setState(() {
            brick.color = Colors.blueAccent;
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
      ///vertical movement
      if (ballYDirection == direction.DOWN) {
        ballY += 0.001;
      } else if (ballYDirection == direction.UP) {
        ballY -= 0.001;
      }

      ///horizontal movement
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
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ), // To display the title it is optional
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '\nYour score: $score',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
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

  void onLocation(Map location) {
    var _direction = location["direction"];
    var _directionArray = _direction.split(",");
    double _x = double.parse(_directionArray[0]);
    double _y = double.parse(_directionArray[1]);

    setState(() {
      _distance = double.parse(location["distance"]);
      if (_x == 0.0 && _y == 0.0) {
        _angle = null;
      } else {
        _angle = math.atan2(_x, _y);
        _xPosition = _x;
      }
    });
  }

  Future<void> initPlatformState() async {
    ///Needed for initial set-up and checks device compatibility
    onSetup(await _plugin.setUp());

    if (!mounted) return;
  }

  Future<void> joinHost() async {
    await _plugin.joinHost("test-device", "uwb-test");
    _plugin.getLocation(onLocation: onLocation);
  }

  List<Brick> generateBrickFieldList() {
    List<Brick> brickFieldList = [];

    for (double y = -0.5; y >= -0.8; y -= 0.1) {
      for (double x = -0.9; x <= 1; x += 0.45) {
        brickFieldList
            .add(Brick(x: x, y: y, color: brickColor, brickKey: GlobalKey()));
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
            children: [
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
