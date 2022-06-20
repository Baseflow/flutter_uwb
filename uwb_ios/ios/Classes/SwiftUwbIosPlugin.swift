import Flutter
import UIKit

public class SwiftUwbIosPlugin: NSObject, FlutterPlugin, BFMCNearbyServiceAdvertiserHostApi {

    public static func register(with registrar: FlutterPluginRegistrar) {
//        let messenger : FlutterBinaryMessenger = registrar.messenger()
//        let api : MCNearbyServiceAdvertiserHostApi & NSObjectProtocol = SwiftUwbIosPlugin.init()
//        MCNearbyServiceAdvertiserHostApiSetup(messenger, api);
      
      SetupHelperClass.setUp(binaryMessenger: registrar.messenger())
      
      if #available(iOS 14.0, *) {
          NISessionHostApi.setUp(binaryMessenger: registrar.messenger())
          MCSessionHostApi.setUp(binaryMessenger: registrar.messenger())
      }
    }
    
    public func checkPlatformCompatibilityWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> NSNumber? {
        return true;
    }
}
