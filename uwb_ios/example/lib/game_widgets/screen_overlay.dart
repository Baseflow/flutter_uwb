import 'package:flutter/material.dart';

/// The [ScreenOverlay] class.
///
/// Shows a TAP TO PLAY on the screen when the game hasn't been started.
class ScreenOverlay extends StatelessWidget {
  /// The [ScreenOverlay] constructor.
  const ScreenOverlay({Key? key, required this.gameHasStarted})
      : super(key: key);

  /// Boolean to know if the game hasn't been started so the text can be shown.
  final bool gameHasStarted;

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
