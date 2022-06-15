import 'package:flutter/material.dart';

///Error message class. Shows an error message when the decice isn't compatible with UWB
class ErrorMessage extends StatelessWidget {
  ///Error message constructor
  const ErrorMessage({Key? key, required this.x, required this.y, required this.error}): super(key: key);

  ///Variable for x-axis of the error message
  final double x;

  ///Variable for y-axis of the error message
  final double y;

  ///Variable that contains the error message
  final String? error;

  @override
  Widget build(BuildContext context) {
    return error == null
        ? Container()
        : Container(
            alignment: Alignment(x, y),
            child: Text(
              error!,
              style: const TextStyle(color: Colors.red),
            ),
          );
  }
}
