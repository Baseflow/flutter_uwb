import 'package:uwb_ios/mc_peer_id_wrapper_api_impl.dart';

/// Implementation of the [MCPeerIDWrapper] interface.
class MCPeerIDWrapper {
  /// Constructor of the [MCPeerIDWrapper] interface.
  MCPeerIDWrapper({
    required String displayName,
  }) {
    api.createFromInstance(this, displayName);
  }

  /// Pigeon Host Api implementation for [MCPeerIDWrapper].
  static MCPeerIDHostApiImpl api = MCPeerIDHostApiImpl();

  /// Discards the instance of the MCPeerID.
  Future<void> dispose() {
    return api.disposeFromIntstance(this);
  }
}
