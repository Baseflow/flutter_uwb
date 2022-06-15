import 'package:flutter/material.dart';

///Loading indicator class. Shows a loading icon when waiting for peer to connect
class LoadingIndicator extends StatelessWidget {
  ///Loading indicator constructor
  const LoadingIndicator(
      {Key? key,
      required this.x,
      required this.y,
      required this.waitingForPeer})
      : super(key: key);

  ///Variable for x-axis of the loading indicator
  final double x;

  ///Variable for x-axis of the loading indicator
  final double y;

  ///Boolean to know when to show/not show loading indicator
  final bool waitingForPeer;

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
