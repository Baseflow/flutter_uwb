import 'package:flutter/material.dart';
import 'package:uwb_ios/uwb_ios.dart';

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

  /// The [deviceName] that is shown to peers when advertising.
  String deviceName = 'test-device';

  /// The [serviceType] describes the service to advertise. This should be a short text string that describes the app's networking protocol.
  String serviceType = 'uwb-test';

  @override
  void initState() {
    startHosting();
    super.initState();
  }

  /// Starts the host function from the uwb plugin to start the advertise function to let peers know they can connect to this phone.
  Future<void> startHosting() async {
    await _plugin.startHost(deviceName, serviceType);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
