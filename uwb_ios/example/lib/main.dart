import 'package:flutter/material.dart';
import 'package:uwb_ios_example/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

/// My app class.
class MyApp extends StatelessWidget {
  /// My app constructor.
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
