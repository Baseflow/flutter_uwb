import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uwb_ios/uwb_ios.dart';

void main() {
  runApp(const MyApp());
}

/// The [MyApp] class that contains an example application for the uwb plugin.
class MyApp extends StatefulWidget {
  /// The constructor of the [MyApp] class.
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UwbIos _plugin = UwbIos();
  String? _error;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onSetup(bool? status) {
    if (status != null && !status) {
      setState(() {
        _error = '''
        Device is incompatible with this app.
        Please check device OS version and UWB compatibility. 
        For Apple users iOS version should be 14.0 or higher.''';
      });
    }
  }

  Future<void> startHosting() async {
    await _plugin.startHost('UWB Example', 'mc-connect');
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                TextButton(onPressed: startHosting, child: const Text('Host')),
              ],
            ),
            if (_error != null) ...[
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              )
            ],
          ],
        )),
      ),
    );
  }
}
