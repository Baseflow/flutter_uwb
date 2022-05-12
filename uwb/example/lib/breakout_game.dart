import 'dart:async';

import 'package:flutter/material.dart';

import 'ball.dart';
import 'brick.dart';
import 'brick_field.dart';
import 'paddle.dart';
import 'screen_overlay.dart';

class BreakoutGame extends StatefulWidget {
  const BreakoutGame({Key? key}) : super(key: key);

  @override
  _BreakoutGameState createState() => _BreakoutGameState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _BreakoutGameState extends State<BreakoutGame> {
  bool gameHasStarted = false;
  double ballX = 0;
  double ballY = 0;
  double paddleX = 0;
  double paddleY = 0.9;
  int score = 0;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;
  late List<Brick> brickFieldList;
  final ballKey = GlobalKey();
  final brickKey = GlobalKey();
  Color brickColor = Colors.blueAccent;

  @override
  void initState() {
    brickFieldList = generateBrickFieldList();
    super.initState();
  }

  void startGame() {
    if (gameHasStarted == false) {
      gameHasStarted = true;
      Timer.periodic(const Duration(milliseconds: 1), (timer) {
        checkWallCollision();
        checkBrickCollision();
        moveBall();

        if (isPLayerDead()) {
          timer.cancel();
          resetGame();
        }
      });
    }
  }

  bool isPLayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void resetGame() {
    setState(() {
      gameHasStarted = false;
      ballX = 0;
      ballY = 0;
      score = 0;
    });
  }

  void checkWallCollision() {
    setState(() {
      ///Vertical
      if (ballY >= 0.9) {
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

  void toggleVerticalMovement() {
    // print('checking movement');
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

  void checkBrickCollision() {
    RenderBox? ballBox =
        ballKey.currentContext?.findRenderObject() as RenderBox?;
    final ballSize = ballBox?.size;
    final ballPosition = ballBox?.localToGlobal(Offset.zero);
    bool collide = false;

    double? ballPositionY = ballPosition?.dy;
    double? ballPositionX = ballPosition?.dx;
    double? ballSizeHeight = ballSize?.height;
    double? ballSizeWidth = ballSize?.width;

    for (var brick in brickFieldList) {
      RenderBox? brickBox =
          brick.brickKey.currentContext?.findRenderObject() as RenderBox?;
      final brickSize = brickBox?.size;
      final brickPosition = brickBox?.localToGlobal(Offset.zero);

      double? brickPositionY = brickPosition?.dy;
      double? brickPositionX = brickPosition?.dx;
      double? brickSizeHeight = brickSize?.height;
      double? brickSizeWidth = brickSize?.width;

      if (ballPosition != null && brickPosition != null) {
        collide = (ballPosition.dx < brickPosition.dx + brickSize!.width &&
            ballPosition.dx + ballSize!.width > brickPosition.dx &&
            ballPosition.dy < brickPosition.dy + brickSize.height &&
            ballPosition.dy + ballSize.height > brickPosition.dy);

        if (collide) {
          setState(() {
            // brick.color = Colors.green;
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

            print(ballPositionY - (brickPositionY + brickSizeHeight));
            print(ballPositionY + ballSizeHeight! - brickPositionY);
            print(ballPositionX - (brickPositionX + brickSizeWidth));
            print(ballPositionX + ballSizeWidth! - brickPositionX);

            // print('---------------------------------------------------');
            // //righthit
            // print('$ballPositionX < $brickPositionX + $brickSizeWidth');
            // //lefthit
            // print('$ballPositionX + $ballSizeWidth > $brickPositionX');
            // //bothit
            // print('$ballPositionY < $brickPositionY + $brickSizeHeight');
            // //tophit
            // print('$ballPositionY + $ballSizeHeight > $brickPositionY');
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
              Container(
                alignment: const Alignment(0, 0),
                child: Text(
                  gameHasStarted ? '$score' : '',
                  style: const TextStyle(fontSize: 80, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
