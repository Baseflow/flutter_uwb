import Flutter
import UIKit

public class SwiftUwbIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      
      SetupHelperClass.setUp(binaryMessenger: registrar.messenger())
      
      if #available(iOS 14.0, *) {
          NISessionHostApi.setUp(binaryMessenger: registrar.messenger())
          MCSessionHostApi.setUp(binaryMessenger: registrar.messenger())
      }
  }
}
