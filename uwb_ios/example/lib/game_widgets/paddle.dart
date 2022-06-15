import 'package:flutter/material.dart';

///Paddle class. Generates a paddle
class Paddle extends StatelessWidget {
  ///Paddle constructor
  const Paddle({
    Key? key,
    required this.x,
    required this.y,
  }) : super(key: key);

  ///Variable for x-axis of the paddle
  final double x;

  ///Variable for y-axis of the paddle
  final double y;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * x + 0.4) / (2 - 0.4), y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          height: 20,
          width: MediaQuery.of(context).size.width / 5,
        ),
      ),
    );
  }
}
