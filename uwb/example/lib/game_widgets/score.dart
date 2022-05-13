import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  int score;
  bool gameHasStarted;

  Score({required this.score, required this.gameHasStarted});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, 0),
      child: Text(
        gameHasStarted ? '$score' : '',
        style: const TextStyle(fontSize: 80, color: Colors.white),
      ),
    );
  }
}
