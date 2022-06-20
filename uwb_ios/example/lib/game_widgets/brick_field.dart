import 'package:flutter/material.dart';

import 'brick.dart';

///The [BrickField] class. Generates a field of bricks
class BrickField extends StatelessWidget {
  ///The [BrickField] constructor
  const BrickField({Key? key, required this.brickFieldList}) : super(key: key);

  ///List of bricks needed for generating the field
  final List<Brick> brickFieldList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        for (Brick brick in brickFieldList)
          Brick(
              x: brick.x,
              y: brick.y,
              brickColor: brick.brickColor,
              brickKey: brick.brickKey)
      ],
    );
  }
}
