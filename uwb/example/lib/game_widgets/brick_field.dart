import 'package:flutter/material.dart';

import 'brick.dart';

class BrickField extends StatelessWidget {
  final List<Brick> brickFieldList;

  BrickField({required this.brickFieldList});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var brick in brickFieldList)
          Brick(
              x: brick.x,
              y: brick.y,
              color: brick.color,
              brickKey: brick.brickKey)
      ],
    );
  }
}
