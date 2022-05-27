import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final double x;
  final double y;
  final String? error;

  ErrorMessage({required this.x, required this.y, required this.error});

  @override
  Widget build(BuildContext context) {
    return
      error == null ? Container() : Container(
      alignment: Alignment(x, y),
      child: Text(
        error!,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
