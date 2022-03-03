import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:uwb_ios/uwb_ios.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UwbIos _plugin = UwbIos();
  bool? _setup = false;
  var _distance;
  var _angle;

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
      if (_x == 0.0 && _y == 0.0) {
        _angle = null;
      } else {
        _angle = math.atan2(_x, _y);
      }
    });
  }

  void onSetup(bool? status) {
    setState(() {
      _setup = status;
    });
  }

  Future<void> startHosting() async {
    await _plugin.startHost();
    _plugin.getLocation(onLocation: onLocation);
  }

  Future<void> joinHost() async {
    await _plugin.joinHost();
    _plugin.getLocation(onLocation: onLocation);
  }

  Future<void> initPlatformState() async {

    ///Needed for initial set-up
    onSetup(await _plugin.setUp());

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
                  TextButton(onPressed: startHosting, child: const Text('Host')),
                  TextButton(onPressed: joinHost, child: const Text('Join')),
                ],),
                if (_angle != null)... [
                  Transform.rotate(
                    angle: _angle,
                    child: const Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 100),
                  ),
                ] else... [
                  const Text("", style: TextStyle(fontSize: 82))
                ],
                if (_distance != null)... [Text("${_distance}m", style: const TextStyle(fontSize: 40, color: Colors.white),),
                ] else... [const Text("", style: TextStyle(fontSize: 40)),
                ]
              ],
            )
        ),
      ),
    );
  }
}
