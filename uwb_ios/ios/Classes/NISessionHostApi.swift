//
//  NISessionHostApi.swift
//  uwb_ios
//
//  Created by Leroy on 21/02/2022.
//

import Foundation

public class NISessionHostApi {
    
    public static func setUp(binaryMessenger: FlutterBinaryMessenger) {
        let session = NISessionHostApi()
        
        let channel = FlutterMethodChannel(name: "com.baseflow.uwb/ni_session", binaryMessenger: binaryMessenger)
        
        channel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
              case "NISession.start":
                result(session.start())
            default:
                result(FlutterMethodNotImplemented)
            }
         }
    }
    
    func start() -> String {
        return "session started"
    }
}
