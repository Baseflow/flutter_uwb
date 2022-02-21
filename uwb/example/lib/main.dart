import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:uwb/uwb.dart';
import 'package:uwb_platform_interface/uwb_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Uwb _plugin = Uwb();
  // String _platformVersion = "Unkown";
  int _counter = 0;
  String _mcSession = "";
  String _niSession = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onAdd(int counter) {
    setState(() {
      _counter = counter;
      print("main - onAdd called. Counter updated to " + _counter.toString());
    });
  }

  void onMCSession(String status) {
    print("Main - inMCSession() called: $status");
    setState(() {
      _mcSession = status;
      // print("main - onAdd called. Counter updated to " + _counter.toString());
    });
  }

  void onNISession(String status) {
    print("Main - onNISession() called");
    setState(() {
      _niSession = status;
    });
  }

  Future<void> startMCSession() async {
    print("Main - startMCSession() called");
    try {
      onMCSession(await _plugin.startMCSession());
    } on PlatformException {
      print("main - could not add one");
    }
  }

  Future<void> startNISession() async{
    print("Main - startNISession() called");
    try {
      onNISession(await _plugin.startNISession());
    } on PlatformException {
      print("main - could not add one");
    }
  }

  Future<void> addOne() async {
    print("main - addOne called");
    try {
      onAdd(await _plugin.addOne(_counter));
    } on PlatformException {
      print("main - could not add one");
    }
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    // try {
    //   // platformVersion =
    //   //     await _plugin.platformVersion ?? 'Unknown platform version';
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }

    //get location stream
    //listen aanroepen op locationstream

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
      // _testMessage = testMessage;
      // _secondTestMessage = secondTestMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('UWB example app'),
        ),
        body: Center(
            child: Column (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('MCSession status: $_mcSession'),
                FloatingActionButton(onPressed: startMCSession),
                Text('NISession status: $_niSession'),
                FloatingActionButton(onPressed: startNISession),
                Text('Button pushed: $_counter\n'),
                FloatingActionButton(onPressed: addOne)
              ],
            )
        ),
      ),
    );
  }
}
