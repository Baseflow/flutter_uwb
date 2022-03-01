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
  bool? _setup = false;
  Map _location = {};
  String _distance = "";
  String _direction = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onLocation(Map location) {
    setState(() {
      _distance = location["distance"];
      _direction = location["direction"];
    });
  }

  void onSetup(bool? status) {
    setState(() {
      _setup = status;
    });
  }

  Future<void> startHosting() async {
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

    ///Needed for initial set-up
    try {
      onSetup(await _plugin.setUp());
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
                Text('Distance: $_distance'),
                Text('Direction: $_direction'),
                TextButton(onPressed: startHosting, child: Text('startHosting')),
                TextButton(onPressed: joinHost, child: Text('joinHost')),
              ],
            )
        ),
      ),
    );
  }
}
