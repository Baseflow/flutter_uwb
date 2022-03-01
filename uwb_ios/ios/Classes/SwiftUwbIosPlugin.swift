import Flutter
import UIKit

@available(iOS 14.0, *)
public class SwiftUwbIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      NISessionHostApi.setUp(binaryMessenger: registrar.messenger())
      MCSessionHostApi.setUp(binaryMessenger: registrar.messenger())
  }
}
