import 'package:flutter/material.dart';

class Distance extends StatelessWidget {
  final double x;
  final double y;
  final double? distance;

  Distance({required this.x, required this.y, required this.distance});

  @override
  Widget build(BuildContext context) {
    return
      distance == null ? Container() : Container(
      alignment: Alignment(x, y),
      child: Text(
        '${distance}m',
        style: const TextStyle(fontSize: 40, color: Colors.white),
      ),
    );
  }
}
