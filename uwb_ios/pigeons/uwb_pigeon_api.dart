import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/uwb_api.pigeon.dart',
  dartTestOut: 'test/uwb_api.pigeon.dart',
  objcHeaderOut: 'ios/Classes/uwb_api.pigeon.h',
  objcSourceOut: 'ios/Classes/uwb_api.pigeon.m',
  objcOptions: ObjcOptions(
    prefix: 'BF',
  ),
))
class MCPeerIDWrapper {
  String? displayName;
}

enum MCEncryptionPreferenceWrapper {
  optional,
  required,
  none,
}

class MCSessionWrapper {
  MCPeerIDWrapper? peerId;
  MCEncryptionPreferenceWrapper? encryptionPreference;
}

@FlutterApi()
abstract class MCNearbyServiceAdvertiserDelegateFlutterApi {
  void didNotStartAdvertisingPeer();

  MCSessionWrapper? didReceiveInvitationFromPeer(
    MCPeerIDWrapper peerID,
    String? context,
  );
}

@HostApi()
abstract class MCNearbyServiceAdvertiserHostApi {
  /// Initializes an advertiser object.
  void create(
    int instanceId,
    MCPeerIDWrapper peerId,
    Map<String, String>? info,
    String serviceType,
  );

  /// Discards the instance of the browser view controller.
  void dispose(int instanceId);

  /// Registers the delegate object that handles advertising-assistant-related events.
  void registerDelegate(int instanceId);

  /// Removes the delegate object that handles advertising-assistant-related events.
  void removeDelegate(int instanceId);

  /// Begins advertising the service provided by a local peer and starts the assistant.
  void startAdvertisingPeer(int instanceId);

  /// Stops advertising the service provided by a local peer and stops the assistant.
  void stopAdvertisingPeer(int instanceId);
}

@HostApi()
abstract class MCBrowserViewControllerHostApi {
  /// Initializes a browser view controller using the provided service type and session.
  void create(
    int instanceId,
    MCSessionWrapper peerId,
    String serviceType,
  );

  /// Discards the instance of the browser view controller.
  void dispose(int instanceId);

  /// Registers the delegate object that handles browser-view-controller-related events.
  void registerDelegate(int instanceId);

  /// Removes the delegate object that handles browser-view-controller-related events.
  void removeDelegate(int instanceId);

  /// Presents the browser to the view controller.
  void presentTheBrowserToViewController(int instanceId);
}
