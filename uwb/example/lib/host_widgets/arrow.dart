import 'dart:math' as math;

import 'package:flutter/material.dart';

class Arrow extends StatelessWidget {
  final double x;
  final double y;
  final double? angle;

  Arrow({required this.x, required this.y, required this.angle});

  @override
  Widget build(BuildContext context) {
    return angle == null
        ? Container()
        : Container(
            alignment: Alignment(x, y),
            child: Transform(
              transform: Matrix4.identity()..rotateX(1.8 * math.pi * 2),
              child: Transform.rotate(
                angle: angle!,
                child: const Icon(Icons.arrow_upward_rounded,
                    color: Colors.white, size: 100),
              ),
            ),
          );
  }
}
