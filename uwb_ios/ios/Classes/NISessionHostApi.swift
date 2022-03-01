//
//  NISessionHostApi.swift
//  uwb_ios
//
//  Created by Leroy on 21/02/2022.
//

import Foundation
import NearbyInteraction

@available(iOS 14.0, *)
public class NISessionHostApi: NSObject, NISessionDelegate, ObservableObject {
    
    static var locationChannel: FlutterMethodChannel?
    static var shared: NISessionHostApi?
    
    var nearbyObjects: NINearbyObject?
    var session: NISession?
    var discoveryToken: NIDiscoveryToken?
    var distance: String?
    
    public static func setUp(binaryMessenger: FlutterBinaryMessenger) {
        shared = NISessionHostApi()
        
        let channel = FlutterMethodChannel(name: "com.baseflow.uwb/ni_session", binaryMessenger: binaryMessenger)
        locationChannel = FlutterMethodChannel(name: "com.baseflow.uwb/ni_session_location", binaryMessenger: binaryMessenger)
        
        channel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
              case "NISession.setUp":
                result(true)
            default:
                result(FlutterMethodNotImplemented)
            }
         }
    }
    
    func setVariables() {
        session = NISession()
        session?.delegate = self
        discoveryToken = session?.discoveryToken
    }
    
    // MARK: - Nearby Interaction Functions
      
    func startSession(data: Data){
        guard let token = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NIDiscoveryToken.self, from: data) else {
            fatalError("Unexpectedly failed to encode discovery token.")
        }
        let configuration = NINearbyPeerConfiguration(peerToken: token)
        session?.run(configuration)
    }
    
    // MARK: - NISessionDelegate functions
    
    public func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
        print(nearbyObjects)
        
        let direction = nearbyObjects.first?.direction ?? simd_float3(0.0,0.0,0.0)

        let objectmap = [
            "distance": String(nearbyObjects.first?.distance ?? 0),
            "direction": String("\(direction.x),\(direction.y),\(direction.z)")
        ]
        NISessionHostApi.locationChannel?.invokeMethod("updateLocation", arguments: objectmap)
    }
    
    public func session(_ session: NISession, didRemove nearbyObjects: [NINearbyObject], reason: NINearbyObject.RemovalReason) {
    }
    
    public func sessionWasSuspended(_ session: NISession) {
    }
    
    public func sessionSuspensionEnded(_ session: NISession) {
    }
    
    public func session(_ session: NISession, didInvalidateWith error: Error) {
        
    }
}
