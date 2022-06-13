import 'package:flutter/material.dart';
import 'package:uwb_example/screens/game_screen.dart';
import 'package:uwb_example/screens/host_screen.dart';

///Home screen class. Shows this screen on initial run. Contains a host and play button.
class HomeScreen extends StatelessWidget {
  ///Home screen constructor
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const BreakoutGame()));
              },
              child: const Text(
                'P L A Y',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const HostScreen()));
              },
              child: const Text(
                'H O S T',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
