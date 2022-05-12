import 'package:flutter/material.dart';

class ScreenOverlay extends StatelessWidget {
  final bool gameHasStarted;

  ScreenOverlay({required this.gameHasStarted});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.2),
      child: Text(
        gameHasStarted ? '' : 'T A P  T O  P L A Y',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
