import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:uwb/uwb.dart';

class HostScreen extends StatefulWidget {
  const HostScreen({Key? key}) : super(key: key);

  @override
  _HostScreenState createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  final Uwb _plugin = Uwb();

  double? _distance;
  double? _angle;
  String? _error;
  bool _waitingForPeer = true;

  @override
  void initState() {
    initPlatformState();
    startHosting();
    super.initState();
  }

  Future<void> startHosting() async {
    await _plugin.startHost("Leroy", "uwb-test");
    _plugin.getLocation(onLocation: onLocation);
    _waitingForPeer = false;
  }

  Future<void> initPlatformState() async {
    ///Needed for initial set-up and checks device compatibility
    onSetup(await _plugin.setUp());
    if (!mounted) return;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Stack(
          children: [
            if (_waitingForPeer) ...[
              Container(
                alignment: const Alignment(0, 0),
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            ],
            if (_error != null) ...[
              Container(
                alignment: Alignment(0, -0.5),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
            if (_angle != null) ...[
              Container(
                alignment: const Alignment(0, 0),
                child: Transform(
                  transform: Matrix4.identity()..rotateX(1.8 * math.pi * 2),
                  child: Transform.rotate(
                    angle: _angle!,
                    child: const Icon(Icons.arrow_upward_rounded,
                        color: Colors.white, size: 100),
                  ),
                ),
              ),
            ],
            if (_distance != null) ...[
              Container(
                alignment: const Alignment(0, 0.5),
                child: Text(
                  "${_distance}m",
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
