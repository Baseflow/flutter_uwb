//
//  MCSessionHostApi.swift
//  uwb_ios
//
//  Created by Leroy on 21/02/2022.
//

import Foundation

public class MCSessionHostApi{
    
    //MARK: - Set up
    
    public static func setUp (binaryMessenger: FlutterBinaryMessenger) {
        let session = MCSessionHostApi()
        
        let channel = FlutterMethodChannel(name: "com.baseflow.uwb/mc_session", binaryMessenger: binaryMessenger)
        
        channel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
              case "MCSession.start":
                result(session.start())
            default:
                result(FlutterMethodNotImplemented)
            }
         }
    }
    
    //MARK: - Functions
    
    func start() -> String {
        return "session started"
    }
}
