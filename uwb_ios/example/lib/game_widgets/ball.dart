import 'package:flutter/material.dart';

///Ball class. Generates ball on the field
class Ball extends StatelessWidget {
  ///Ball constructor
  const Ball({Key? key, required this.x, required this.y, required this.ballKey}) : super(key: key);

  ///Variable for x-axis of the ball
  final double x;

  ///Variable for y-axis of the ball
  final double y;

  ///Global key used for collision checker
  final GlobalKey ballKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: Container(
        key: ballKey,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        width: 20,
        height: 20,
      ),
    );
  }
}
