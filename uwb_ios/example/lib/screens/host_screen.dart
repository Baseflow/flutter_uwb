import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:uwb_ios/uwb_ios.dart';

import '../host_widgets/arrow.dart';
import '../host_widgets/distance.dart';
import '../host_widgets/error_message.dart';
import '../host_widgets/loading_indicator.dart';

/// Host screen class. Shows the direction and distance to connected phone.
class HostScreen extends StatefulWidget {
  /// Host screen constructor.
  const HostScreen({Key? key}) : super(key: key);

  @override
  _HostScreenState createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  final UwbIos _plugin = UwbIos();

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

  /// Starts the host function from the uwb plugin to start the advertise function to let peers know they can connect to this phone. 
  Future<void> startHosting() async {
    await _plugin.startHost(deviceName, serviceType);
    /// When there is a connection with a peer we can use the getLocation method form the plugin to get the location data.
    _plugin.getLocation(onLocation: onLocation);
    _waitingForPeer = false;
  }

  /// SetUp call from the uwb plugin to check device compatibility. 
  Future<void> initPlatformState() async {
    onSetup(await _plugin.setUp());
  }

  /// Sets the error message when the device isn't compatible. 
  void onSetup(bool? status) {
    if (status != null && !status) {
      setState(() {
        _error = 'Device is incompatible with this app.'
            '\nPlease check device OS version and UWB compatibility. '
            '\nFor Apple users iOS version should be 14.0 or higher.';
      });
    }
  }

  /// Funcvtions that gets the angle and distance from the location data. 
  void onLocation(Map<dynamic, dynamic> location) {
    final String _direction = location['direction'] as String;
    final List<String> _directionArray = _direction.split(',');
    final double _x = double.parse(_directionArray[0]);
    final double _y = double.parse(_directionArray[1]);

    setState(() {
      _distance = double.parse(location['distance'] as String);
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
