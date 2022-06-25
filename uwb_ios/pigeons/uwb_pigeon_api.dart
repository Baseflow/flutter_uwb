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
  String? displayname;
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
  bool checkPlatformCompatibility();

  void create(
    int instanceId,
    MCPeerIDWrapper peerId,
    Map<String, String>? info,
    String serviceType,
  );

  void dispose(int instanceId);

  void registerDelegate(int instanceId);

  void removeDelegate(int instanceId);

  void startAdvertisingPeer(int instanceId);

  void stopAdvertisingPeer(int instanceId);
}

@HostApi()
abstract class MCSessionHostApi {}
