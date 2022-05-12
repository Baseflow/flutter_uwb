import 'package:flutter/material.dart';

class Paddle extends StatelessWidget {
  final double x;
  final double y;

  Paddle({required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          height: 20,
          width: MediaQuery.of(context).size.width / 5.5,
        ),
      ),
    );
  }
}
