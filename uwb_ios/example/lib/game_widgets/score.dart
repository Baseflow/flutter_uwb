import 'package:flutter/material.dart';

/// The [Score] class that generates the score.
class Score extends StatelessWidget {
  /// The [Score] constructor.
  const Score({Key? key, required this.score, required this.gameHasStarted})
      : super(key: key);

  /// Int variable to keep track of the current score.
  final int score;

  /// Boolean to know if the game is started so the score can be showed.
  final bool gameHasStarted;

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
