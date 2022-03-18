import 'package:uwb_ios/multipeer_connectivity_wrapper.dart';
import 'package:uwb_platform_interface/uwb_platform_interface.dart';

/// The iOS implementation of the UwbPlatform interface.
class UwbIOSPlatform extends UwbPlatform {
  /// Registers the [UwbIOSPlatform] with the [UwbPlatform] interface as the
  /// current implementation.
  static void registerWith() {
    UwbPlatform.instance = UwbIOSPlatform();
  }

  /// Callback that is called when starting the advertiser failed.
  void Function()? onAdvertisingFailure;

  /// Callback that is called when an invitation is received from a connecting
  /// peer.
  void Function(String peerName, String? context)? onReceiveInvitation;

  @override
  Future<void> startHost(String name, String serviceType) {
    final MCPeerIDWrapper peerId = MCPeerIDWrapper(displayName: name);
    final MCNearbyServiceAdvertiserWrapper advertiser =
        MCNearbyServiceAdvertiserWrapper(
      peer: peerId,
      serviceType: serviceType,
    );

    advertiser.setDelegate(_NearbyServiceAdvertiserDelegate(this));

    return advertiser.startAdvertisingPeer();
  }
}

class _NearbyServiceAdvertiserDelegate
    extends MCNearbyServiceAdvertiserDelegateWrapper {
  _NearbyServiceAdvertiserDelegate(this._platform);

  final UwbIOSPlatform _platform;

  @override
  void didNotStartAdvertisingPeer() {
    if (_platform.onAdvertisingFailure != null) {
      _platform.onAdvertisingFailure!();
    }
  }

  @override
  MCSessionWrapper? didReceiveInvitationFromPeer(
      MCPeerIDWrapper peerID, String? context) {
    if (_platform.onReceiveInvitation != null) {
      _platform.onReceiveInvitation!(peerID.displayName!, context);
    }
  }
}
