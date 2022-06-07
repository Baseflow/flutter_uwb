import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double x;
  final double y;
  final bool waitingForPeer;

  LoadingIndicator(
      {required this.x, required this.y, required this.waitingForPeer});

  @override
  Widget build(BuildContext context) {
    return !waitingForPeer
        ? Container()
        : Container(
            alignment: Alignment(x, y),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
  }
}
