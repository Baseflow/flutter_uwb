import 'package:uwb_ios/mc_session_wrapper.dart';
import 'mc_browser_view_controller_wrapper_api_impl.dart';

export 'uwb_api.pigeon.dart' show MCEncryptionPreferenceWrapper;

///
class MCBrowserViewControllerWrapper {
  ///
  MCBrowserViewControllerWrapper({
    required MCSessionWrapper mcSessionInstance,
    required String serviceType,
  })  : _mcSession = mcSessionInstance,
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
