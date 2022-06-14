import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Contains all the calls that needs to be implemented in the platform specific plugins.
abstract class UwbPlatform extends PlatformInterface {
  /// Constructs a [UwbPlatform].
  UwbPlatform() : super(token: _token);

  static final Object _token = Object();

  /// The instance of [UwbPlatform] to use.
  ///
  /// Must be set before accessing.
  static UwbPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific.
  /// class that extends [UwbPlatform] when they register themselves.
  /// https://github.com/flutter/flutter/issues/43368.
  static set instance(UwbPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Should only be accessed after setter is called.
  static late UwbPlatform _instance;

  /// Checks platform compatibility.
  ///
  /// Returns [True] of compatible.
  /// Returns [False] if it is not compatible.
  Future<bool> checkPlatformCompatibility() =>
      throw UnimplementedError('setUp() has not been implemented.');

  /// Start advertising as a ultra wide band host allowing clients to connect.
  ///
  /// The [peerID] identifies a peer (the host in this case) in a multi peer session.
  /// The [serviceType] describes the service to advertise. This should be a short text string that describes the app's networking protocol.
  Future<void> startHost(String peerID, String serviceType) =>
      throw UnimplementedError('startHost() has not been implemented.');

  /// Sends an invite to the advertiser to start a multi peer session.
  ///
  /// The [peerID] identifies a peer (the client in this case) in a multi peer session.
  /// The [serviceType] describes the service to advertise. This should be a short text string that describes the app's networking protocol.
  Future<void> joinHost(String peerID, String serviceType) =>
      throw UnimplementedError('joinHost() has not been implemented.');

  /// Callback method to get the location updates.
  Future<void> getLocation(
          {required Function(Map<dynamic, dynamic>) onLocation}) =>
      throw UnimplementedError('getLocation() has not been implemented.');
}
