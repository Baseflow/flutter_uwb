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
  String _mcSession = "";
  String _niSession = "";
  String _location = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onLocation(String location) {
    setState(() {
      _location = location;
    });
  }

  void onNISession(String status) {
    print("Main - onNISession() called");
    setState(() {
      _niSession = status;
    });
  }

  Future<void> startNISession() async{
    print("Main - startNISession() called");
    try {
      onNISession(await _plugin.startNISession());
    } on PlatformException {
      print("main - could not add one");
    }
  }

  Future<void> startHosting() async {
    print("main - startHosting()");
    try {
      await _plugin.startHost();
      _plugin.getLocation(onLocation: onLocation);
    } on PlatformException {
      //TODO: throw exception
    }
  }

  Future<void> joinHost() async {
    print("main - joinHost()");
    try {
      await _plugin.joinHost();
      _plugin.getLocation(onLocation: onLocation);
    } on PlatformException {
      //TODO: throw exception
    }
  }

  Future<void> initPlatformState() async {

    //needed for initial set-up
    try {
      onNISession(await _plugin.startNISession());
    } on PlatformException {
      print("Could not properly setup app");
    }

    if (!mounted) return;

    setState(() {
      //not used
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
                Text('Distance: $_location'),
                TextButton(onPressed: startHosting, child: Text('startHosting')),
                TextButton(onPressed: joinHost, child: Text('joinHost')),
              ],
            )
        ),
      ),
    );
  }
}
