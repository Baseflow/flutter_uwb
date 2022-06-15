import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The [Arrow] class that generates an arrow to point at the location of the connected device.
class Arrow extends StatelessWidget {
  /// The [Arrow] constructor.
  const Arrow({Key? key, required this.x, required this.y, required this.angle})
      : super(key: key);

  /// Variable for x-axis of the arrow.
  final double x;

  /// Variable for y-axis of the arrow.
  final double y;

  /// Variable for arrow direction.
  final double? angle;

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
