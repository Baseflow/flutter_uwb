import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final double x;
  final double y;
  final GlobalKey ballKey;

  Ball({required this.x, required this.y, required this.ballKey});

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
