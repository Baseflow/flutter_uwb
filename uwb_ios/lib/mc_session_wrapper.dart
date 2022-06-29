import 'package:uwb_ios/mc_peer_id_wrapper.dart';
import 'package:uwb_ios/mc_session_wrapper_api_impl.dart';
import 'package:uwb_ios/uwb_api.pigeon.dart';

export 'uwb_api.pigeon.dart' show MCEncryptionPreferenceWrapper;

/// Implementation of the [MCSessionWrapper] interface.
class MCSessionWrapper {
  /// Constructor of the [MCSessionWrapper] interface.
  MCSessionWrapper({
    required MCPeerIDWrapper mcPeerIDInstance,
    MCEncryptionPreferenceWrapper? encryptionPreference,
  }) {
    api.createFromInstance(this, mcPeerIDInstance, encryptionPreference!);
  }

  /// Pigeon Host Api implementation for [MCSessionWrapper].
  static MCSessionHostApiImpl api = MCSessionHostApiImpl();

  /// Discards the instance of the MCPeerID.
  Future<void> dispose() {
    return api.disposeFromIntstance(this);
  }
}
