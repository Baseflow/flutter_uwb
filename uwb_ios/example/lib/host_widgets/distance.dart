import 'package:flutter/material.dart';

///Distance class. Shows the distance of the connected phone
class Distance extends StatelessWidget {
  ///Distance constructor
  const Distance(
      {Key? key, required this.x, required this.y, required this.distance})
      : super(key: key);

  ///Variable for x-axis of the distance widget
  final double x;

  ///Variable for y-axis of the distance widget
  final double y;

  ///Variable that contains the distance to the other device
  final double? distance;

  @override
  Widget build(BuildContext context) {
    return distance == null
        ? Container()
        : Container(
            alignment: Alignment(x, y),
            child: Text(
              '${distance}m',
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          );
  }
}
