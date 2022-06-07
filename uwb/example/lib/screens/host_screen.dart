import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:uwb/uwb.dart';
import 'package:uwb_example/host_widgets/arrow.dart';
import 'package:uwb_example/host_widgets/distance.dart';
import 'package:uwb_example/host_widgets/error_message.dart';
import '../host_widgets/loading_indicator.dart';

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
  String deviceName = 'test-device';
  String serviceType = 'uwb-test';

  @override
  void initState() {
    initPlatformState();
    startHosting();
    super.initState();
  }

  Future<void> startHosting() async {
    await _plugin.startHost(deviceName, serviceType);
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
    var _direction = location['direction'];
    var _directionArray = _direction.split(",");
    var _x = double.parse(_directionArray[0]);
    var _y = double.parse(_directionArray[1]);

    setState(() {
      _distance = double.parse(location['distance']);
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
          children: <Widget>[
            LoadingIndicator(x: 0, y: 0, waitingForPeer: _waitingForPeer),
            ErrorMessage(x: 0, y: -0.5, error: _error),
            Arrow(x: 0, y: 0, angle: _angle),
            Distance(x: 0, y: 0.5, distance: _distance),
          ],
        ),
      ),
    );
  }
}
