import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut:
      'lib/src/multipeer_connectivity/multipeer_connectivity_wrapper_api.pigeon.dart',
  dartTestOut: 'test/multipeer_connectivity_wrapper_api.pigeon.dart',
  objcHeaderOut: 'ios/Classes/multipeer_connectivity_wrapper_api.pigeon.h',
  objcSourceOut: 'ios/Classes/multipeer_connectivity_wrapper_api.pigeon.m',
  objcOptions: ObjcOptions(
    prefix: 'BF',
  ),
))

/// An [MCPeerIDWrapper] object represents a peer in a multipeer session.
///
/// See Apple's documentation at [MCPeerID](https://developer.apple.com/documentation/multipeerconnectivity/mcpeerid).
class MCPeerIDWrapper {
  /// The display name for this peer.
  String? displayName;
}

/// Indicates whether a session should use encryption when communicating with
/// nearby peers.
///
/// See Apple's documentation at [MCEncryptionPreference](https://developer.apple.com/documentation/multipeerconnectivity/mcencryptionpreference).
enum MCEncryptionPreferenceWrapper {
  /// The session prefers to use encryption, but accepts unencrypted
  /// connections. A connection uses encryption when all the peers choose either
  /// MCEncryptionOptional or MCEncryptionRequired. If some peers choose
  /// MCEncryptionNone, then the session will not be encrypted. For this reason,
  /// if some peers running in the app can be configured without encryption, the
  /// app should always assume that the session is unencrypted.
  optional,

  /// The session requires encryption.
  required,

  /// The session should not be encrypted.
  none,
}

/// An [MCSessionWrapper] object enables and manages communication among all
/// peers in a Multipeer Connectivity session.
///
/// See Apple's documentation at [MCSession](https://developer.apple.com/documentation/multipeerconnectivity/mcsession).
class MCSessionWrapper {
  MCPeerIDWrapper? peerId;
  MCEncryptionPreferenceWrapper? encryptionPreference;
}

/// The [MCNearbyServiceAdvertiserDelegateFlutterApi] describes the methods that
/// represents events that may occur when starting to advertise nearby services.
///
/// See Apple's documentation at [MCNearbyServiceAdvertiserDelegate](https://developer.apple.com/documentation/multipeerconnectivity/mcnearbyserviceadvertiserdelegate).
@FlutterApi()
abstract class MCNearbyServiceAdvertiserDelegateFlutterApi {
  /// Called when advertisement fails.
  void didNotStartAdvertisingPeer();

  /// Called when an invitation to join a session is received from a nearby
  /// peer.
  ///
  /// The [peerID] identifies the nearby peer that invited the app to join the
  /// session.
  ///
  /// The [context] contains an arbitrary piece of data received from the nearby
  /// peer. This can be used to provide further information to the user about
  /// the nature of the invitation. Converted to String from NSData from iOS
  /// platform using UTF8Encoding.
  ///
  /// Return an instance of the [MCSessionWrapper] class to accept the
  /// connection invitation or return `null` to reject the connection invite.
  MCSessionWrapper? didReceiveInvitationFromPeer(
    MCPeerIDWrapper peerID,
    String? context,
  );
}

@HostApi(dartHostTestHandler: 'TestMCNearbyServiceAdvertiserHostApi')
abstract class MCNearbyServiceAdvertiserHostApi {
  void create(
    int instanceId,
    MCPeerIDWrapper peerId,
    Map<String, String>? info,
    String serviceType,
  );

  void dispose(int instanceId);

  void registerDelegate(int instanceId);

  void removeDelegate(int instanceId);

  /// Begins advertising the service provided by the local peer.
  void startAdvertisingPeer(int instanceId);

  void stopAdvertisingPeer(int instanceId);
}
