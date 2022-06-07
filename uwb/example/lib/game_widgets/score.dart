import 'package:flutter/material.dart';

///Score class. Generates the score
//ignore: must_be_immutable
class Score extends StatelessWidget {
  ///Score constructor
  Score({required this.score, required this.gameHasStarted});

  ///Int variable to keep track of the current score
  int score;

  ///Boolean to know if the game is started so the score can be showed
  bool gameHasStarted;

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
