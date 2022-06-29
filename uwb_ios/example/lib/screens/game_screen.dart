import 'package:flutter/material.dart';
import 'package:uwb_ios/uwb_ios.dart';

/// The [BreakoutGame] class.
///
/// Contains the code for the breakout game.
class BreakoutGame extends StatefulWidget {
  /// The [BreakoutGame] constructor.
  const BreakoutGame({Key? key}) : super(key: key);

  @override
  State<BreakoutGame> createState() => BreakoutGameState();
}

/// The [BreakoutGameState] class.
class BreakoutGameState extends State<BreakoutGame> {
  final UwbIos _plugin = UwbIos();

  /// The [deviceName] that is shown to peers when advertising.
  String deviceName = 'test-device';

  /// The [serviceType] describes the service to advertise. This should be a short text string that describes the app's networking protocol.
  String serviceType = 'uwb-test';

  @override
  void initState() {
    joinHost();
    super.initState();
  }

  /// Join host call from the uwb plugin to join a host phone and setup a connection.
  Future<void> joinHost() async {
    await _plugin.joinHost(deviceName, serviceType);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
