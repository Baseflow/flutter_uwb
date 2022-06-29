import 'package:flutter/foundation.dart';
import 'package:uwb_ios/mc_peer_id_wrapper.dart';

import 'uwb_api.pigeon.dart';
import 'mc_nearby_service_advertiser_wrapper_api_impl.dart';

export 'uwb_api.pigeon.dart' show MCEncryptionPreferenceWrapper;

/// The [MCNearbyServiceAdvertiserDelegateWrapper] interface specifies events
/// that can be triggered by the [MCNearbyServiceAdvertiserWrapper] instance.
abstract class MCNearbyServiceAdvertiserDelegateWrapper
    extends MCNearbyServiceAdvertiserDelegateFlutterApi {
  /// Creates a new [MCNearbyServiceAdvertiserDelegateWrapper].
  MCNearbyServiceAdvertiserDelegateWrapper() {
    MCNearbyServiceAdvertiserDelegateFlutterApi.setup(this);
  }
}

/// Publishes an advertisement for a specific service that your app provides
/// through the Multipeer Connectivity framework.
///
/// Invitations from nearby peers are delivered to the delegate registered with
/// this instance.
class MCNearbyServiceAdvertiserWrapper {
  /// Creates a new [MCNearbyServiceAdvertiserWrapper].
  MCNearbyServiceAdvertiserWrapper({
    required MCPeerIDWrapper mcPeerIDInstance,
    Map<String, String>? info,
    required String serviceType,
  })  : _mcPeerIDInstance = mcPeerIDInstance,
        _info = info,
        _serviceType = serviceType {
    api.createFromInstance(this, _mcPeerIDInstance, _info, _serviceType);
  }

  /// Pigeon Host Api implementation for [MCNearbyServiceAdvertiserWrapper].
  @visibleForTesting
  static MCNearbyServiceAdvertiserHostApiImpl api =
      MCNearbyServiceAdvertiserHostApiImpl();

  final MCPeerIDWrapper _mcPeerIDInstance;
  final Map<String, String>? _info;
  final String _serviceType;

  /// The delegate object that handles advertising-related events.
  Future<void> setDelegate(MCNearbyServiceAdvertiserDelegateWrapper? delegate) {
    if (delegate == null) {
      return api.removeDelegateFromInstance(this);
    } else {
      return api.registerDelegateFromInstance(this);
    }
  }

  /// Starts advertising the service provided by the local peer.
  Future<void> startAdvertisingPeer() {
    return api.startAdvertisingPeerFromInstance(this);
  }

  /// Stops advertising the service provided by the local peer.
  Future<void> stopAdvertisingPeer() {
    return api.stopAdvertisingPeerFromInstance(this);
  }
}
