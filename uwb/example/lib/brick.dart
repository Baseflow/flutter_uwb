import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  final double x;
  final double y;
  Color color;
  final GlobalKey brickKey;

  Brick(
      {required this.x,
      required this.y,
      required this.color,
      required this.brickKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          key: brickKey,
          color: color,
          height: MediaQuery.of(context).size.height / 30,
          width: MediaQuery.of(context).size.width / 6,
        ),
      ),
    );
  }
}
