import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:uwb/uwb.dart';

void OldMain() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Uwb _plugin = Uwb();
  double? _distance;
  double? _angle;
  String? _error;

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

    setState(() {
      _distance = double.parse(location["distance"]);
      if (_x == 0.0 && _y == 0.0) {
        _angle = null;
      } else {
        _angle = math.atan2(_x, _y);
      }
    });
  }

  void onSetup(bool? status) {
    if (status != null && !status) {
      setState(() {
        _error = """Device is incompatible with this app.
        Please check device OS version and UWB compatibility. 
        For Apple users iOS version should be 14.0 or higher.""";
      });
    }
  }

  Future<void> startHosting() async {
    await _plugin.startHost("Leroy", "uwb-test");
    _plugin.getLocation(onLocation: onLocation);
  }

  Future<void> joinHost() async {
    await _plugin.joinHost("Kathy", "uwb-test");
    _plugin.getLocation(onLocation: onLocation);
  }

  Future<void> initPlatformState() async {
    ///Needed for initial set-up and checks device compatibility
    onSetup(await _plugin.setUp());

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
                TextButton(onPressed: joinHost, child: const Text('Join')),
              ],
            ),
            if (_error != null) ...[
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              )
            ],
            if (_angle != null) ...[
              Transform(
                transform: Matrix4.identity()..rotateX(1.8 * math.pi * 2),
                child: Transform.rotate(
                  angle: _angle!,
                  child: const Icon(Icons.arrow_upward_rounded,
                      color: Colors.white, size: 100),
                ),
              ),
            ] else ...[
              const Text("", style: TextStyle(fontSize: 82))
            ],
            if (_distance != null) ...[
              Text(
                "${_distance}m",
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
            ] else ...[
              const Text("", style: TextStyle(fontSize: 40)),
            ]
          ],
        )),
      ),
    );
  }
}
