import 'uwb_api.pigeon.dart';
import 'mc_browser_view_controller_wrapper_api_impl.dart';

export 'uwb_api.pigeon.dart'
    show MCEncryptionPreferenceWrapper, MCPeerIDWrapper, MCSessionWrapper;

///
class MCBrowserViewControllerWrapper {
  ///
  MCBrowserViewControllerWrapper({
    required MCSessionWrapper mcSession,
    required String serviceType,
  })  : _mcSession = mcSession,
        _serviceType = serviceType {
    api.createFromInstance(this, _mcSession, _serviceType);
  }

  final MCSessionWrapper _mcSession;
  final String _serviceType;

  ///
  static MCBrowserViewControllerHostApiImpl api =
      MCBrowserViewControllerHostApiImpl();

  ///
  Future<void> presentTheBrowserToViewController() {
    return api.presentTheBrowserToViewControllerFromInstance(this);
  }
}
