import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uwb_ios/uwb_ios.dart';

import '../game_widgets/ball.dart';
import '../game_widgets/brick.dart';
import '../game_widgets/brick_field.dart';
import '../game_widgets/paddle.dart';
import '../game_widgets/score.dart';
import '../game_widgets/screen_overlay.dart';

/// The [BreakoutGame] class.
///
/// Contains the code for the breakout game.
class BreakoutGame extends StatefulWidget {
  /// The [BreakoutGame] constructor.
  const BreakoutGame({Key? key}) : super(key: key);

  @override
  BreakoutGameState createState() => BreakoutGameState();
}

/// Contains the direction enums of the ball.
enum Direction {
  /// Ball goes up.
  up,

  /// Ball goes down.
  down,

  /// Ball goes left.
  left,

  /// Ball goes right.
  right
}

/// The [BreakoutGameState] class.
class BreakoutGameState extends State<BreakoutGame> {
  final UwbIos _plugin = UwbIos();

  /// Boolean that checks if the game has started.
  bool gameHasStarted = false;

  /// Boolean that checks if the player has lost the game.
  bool playerIsDead = false;

  /// X position of the ball.
  double ballX = 0;

  /// Y position of the ball.
  double ballY = 0;

  /// X position of the paddle.
  double paddleX = 0;

  /// Y position of the paddle.
  double paddleY = 0.9;

  /// Width of the paddle.
  double paddleWidth = 0.4;

  /// Height of the paddle.
  double paddeHeight = 0.03;

  /// Int that keeps track of the score.
  int score = 0;

  /// Direction that keeps track of the vertical direction of the ball.
  Direction ballYDirection = Direction.down;

  /// Direction that keeps track of the horizontal direction of the ball.
  Direction ballXDirection = Direction.left;

  /// List of bricks on the screen.
  late List<Brick> brickFieldList;

  /// Globalkey of the ball.
  final GlobalKey<State<StatefulWidget>> ballKey = GlobalKey();

  /// Color of the bricks in the game.
  Color brickColor = Colors.blueAccent;

  double? _xPosition;

  @override
  void initState() {
    initPlatformState();
    joinHost();
    brickFieldList = generateBrickFieldList();
    super.initState();
  }

  /// Starts the breakout game.
  void startGame() {
    if (gameHasStarted == false) {
      gameHasStarted = true;
      Timer.periodic(const Duration(milliseconds: 8), (Timer timer) {
        if (ballY < -0.4) {
          checkBrickCollision();
        }
        moveBall();
        checkWallCollision();
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

  /// Functions that resets game modifiers.
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

  /// Function that checks wall collision.
  void checkWallCollision() {
    setState(() {
      if (ballY >= (paddleY - paddeHeight)) {
        if (ballY <= 0.9 &&
            paddleX + paddleWidth >= ballX &&
            paddleX <= ballX) {
          ballYDirection = Direction.up;
        }
      } else if (ballY <= -0.9) {
        ballYDirection = Direction.down;
      }

      if (ballX >= 1) {
        ballXDirection = Direction.left;
      } else if (ballX <= -1) {
        ballXDirection = Direction.right;
      }
    });
  }

  /// Fucntions that checks brick collision.
  ///
  /// Uses [finderRenderObject] to determine the position of the bricks and paddle, and checks if the containers overlap.
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
            if (ballPositionY! - (brickPositionY! + brickSizeHeight!) < 1 &&
                    ballPositionY - (brickPositionY + brickSizeHeight) > -8 ||
                ballPositionY + ballSizeHeight! - brickPositionY < 8 &&
                    ballPositionY + ballSizeHeight - brickPositionY > -1) {
              toggleVerticalMovement();
            }

            if (ballPositionX! - (brickPositionX! + brickSizeWidth!) < 1 &&
                    ballPositionX - (brickPositionX + brickSizeWidth) > -15 ||
                ballPositionX + ballSizeWidth! - brickPositionX < 15 &&
                    ballPositionX + ballSizeWidth - brickPositionX > -1) {
              toggleHorizontalMovement();
            }
          });
        }
      }
      if (collide) {
        break;
      }
    }
  }

  /// Toggles vertical ball movement.
  void toggleVerticalMovement() {
    setState(() {
      if (ballYDirection == Direction.down) {
        ballYDirection = Direction.up;
      } else {
        ballYDirection = Direction.down;
      }
    });
  }

  /// Toggles horizontal ball movement.
  void toggleHorizontalMovement() {
    setState(() {
      if (ballXDirection == Direction.right) {
        ballXDirection = Direction.left;
      } else {
        ballXDirection = Direction.right;
      }
    });
  }

  /// Function that moves the ball by changeing the x and y-axis.
  void moveBall() {
    setState(() {
      if (ballYDirection == Direction.down) {
        ballY += 0.005;
      } else if (ballYDirection == Direction.up) {
        ballY -= 0.005;
      }

      if (ballXDirection == Direction.right) {
        ballX += 0.010;
      } else if (ballXDirection == Direction.left) {
        ballX -= 0.010;
      }
    });
  }

  /// Function that moves the ball by changing the x-axis of the paddle corresponding to the x position of the phone.
  void movePlatform() {
    if (_xPosition != null) {
      setState(() {
        paddleX = 2 * -_xPosition!;
      });
    }
  }

  /// Function that shows a Popup dialog after winning or loosing.
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
          ),
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
              style: TextButton.styleFrom(primary: Colors.white),
              child: const Text('EXIT'),
            ),
            TextButton(
              onPressed: () {
                resetGame();
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: const Text('REPLAY'),
            ),
          ],
        );
      },
    );
  }

  /// Function that gets the x position of the phone from the location data.
  void onLocation(Map<dynamic, dynamic> location) {
    final String direction = location['direction'] as String;
    final List<String> directionArray = direction.split(',');
    final double x = double.parse(directionArray[0]);
    final double y = double.parse(directionArray[1]);

    setState(() {
      if (x != 0.0 && y != 0.0) {
        _xPosition = x;
      }
    });
  }

  /// Setup call form the uwb plugin.
  Future<void> initPlatformState() async {
    await _plugin.checkPlatformCompatibility();
  }

  /// Join host call from the uwb plugin to join a host phone and setup a connection.
  Future<void> joinHost() async {
    await _plugin.joinHost('test-device', 'uwb-test');

    /// When there is a connection with the host phone we can use the getLocation method form the plugin to get the location data.
    _plugin.getLocation(onLocation: onLocation);
  }

  /// Generates a list of bricks.
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

  /// Function that checks the loose condition.
  ///
  /// When the ball hits the bottum of the screen it returns a true, otherwise it returns a false.
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
              Score(score: score, gameHasStarted: gameHasStarted),
            ],
          ),
        ),
      ),
    );
  }
}