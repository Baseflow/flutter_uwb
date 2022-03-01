import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
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
  var _distance = "";
  var _angle = 0.0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onLocation(Map location) {
    var _direction = location["direction"];
    var _directionArray = _direction.split(",");
    var _x = double.parse(_directionArray[0]);
    var _y = double.parse(_directionArray[1]);
    var _z = double.parse(_directionArray[2]);

    setState(() {
      _distance = location["distance"];
      _angle = math.atan2(_x, _y);
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
        backgroundColor: Colors.black,
        body: Center(
            child: Column (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  TextButton(onPressed: startHosting, child: Text('Host')),
                  TextButton(onPressed: joinHost, child: Text('Join')),
                ],),
                Transform.rotate(
                    angle: _angle,
                    child: const Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 100),
                ),
                Text(_distance, style: const TextStyle(fontSize: 40, color: Colors.white),),
                // Text(_direction, style: const TextStyle(fontSize: 20, color: Colors.white),),
              ],
            )
        ),
      ),
    );
  }
}
