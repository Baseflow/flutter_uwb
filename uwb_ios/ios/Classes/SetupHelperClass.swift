//
//  SetupHelperClass.swift
//  uwb_ios
//
//  Created by Leroy on 03/03/2022.
//

import Foundation
import NearbyInteraction

public class SetupHelperClass {
    public static func setUp (binaryMessenger: FlutterBinaryMessenger) {
        let session = SetupHelperClass()
        
        let channel = FlutterMethodChannel(name: "com.baseflow.uwb/setup_helper_class", binaryMessenger: binaryMessenger)
        
        channel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "SetupHelperClass.setUp":
                result(session.checkDevicecompatibility())
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    public func checkDevicecompatibility() -> Bool {
        if #available(iOS 14.0, *) {
            var shared: NISessionHostApi
            shared = NISessionHostApi.shared!
            return shared.checkDeviceCompatibility()
        } else {
          return false
        }
    }
}


