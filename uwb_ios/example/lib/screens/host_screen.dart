import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:uwb_ios/uwb_ios.dart';

import '../host_widgets/arrow.dart';
import '../host_widgets/distance.dart';
import '../host_widgets/error_message.dart';
import '../host_widgets/loading_indicator.dart';

/// The [HostScreen] class.
///
/// Shows the direction and distance to connected phone.
class HostScreen extends StatefulWidget {
  /// The [HostScreen] constructor.
  const HostScreen({Key? key}) : super(key: key);

  @override
  HostScreenState createState() => HostScreenState();
}

/// The [HostScreenState] class.
class HostScreenState extends State<HostScreen> {
  final UwbIos _plugin = UwbIos();

  double? _distance;
  double? _angle;
  String? _error;
  bool _waitingForPeer = true;

  /// The [deviceName] that is shown to peers when advertising.
  String deviceName = 'test-device';

  /// The [serviceType] describes the service to advertise. This should be a short text string that describes the app's networking protocol.
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
    onSetup(await _plugin.checkPlatformCompatibility());
  }

  /// Sets the error message when the device isn't compatible.
  void onSetup(bool? status) {
    print("Bool for device compatibility: $status");

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
    final String direction = location['direction'] as String;
    final List<String> directionArray = direction.split(',');
    final double x = double.parse(directionArray[0]);
    final double y = double.parse(directionArray[1]);

    setState(() {
      _distance = double.parse(location['distance'] as String);
      if (x == 0.0 && y == 0.0) {
        _angle = null;
      } else {
        _angle = math.atan2(x, y);
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
