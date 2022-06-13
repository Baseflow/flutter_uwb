import 'package:flutter/material.dart';

///Brick class. Generates a brick
class Brick extends StatelessWidget {
  ///Brick constructor
  const Brick(
      {required this.x,
      required this.y,
      required this.brickColor,
      required this.brickKey});

  ///Variable for x-axis of the brick
  final double x;

  ///Variable for y-axis of the brick
  final double y;

  ///Color variable of the brick
  final Color brickColor;

  ///Global key used for collision checker
  final GlobalKey brickKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          key: brickKey,
          color: brickColor,
          height: MediaQuery.of(context).size.height / 30,
          width: MediaQuery.of(context).size.width / 6,
        ),
      ),
    );
  }
}
