import Foundation
import Flutter
import UIKit

@available(iOS 14.0, *)
public class SwiftUwbIosPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let _: SwiftUwbIosPlugin = SwiftUwbIosPlugin()
            .setUpAdvertiser(messenger: registrar.messenger())
            .setUpPeerIDInstance(messenger: registrar.messenger())
    }
    
    private func setUpAdvertiser(messenger: FlutterBinaryMessenger) -> SwiftUwbIosPlugin {
        let advertiserApi: BFMCNearbyServiceAdvertiserHostApiImpl = BFMCNearbyServiceAdvertiserHostApiImpl(flutterMessenger: messenger)
        BFMCNearbyServiceAdvertiserHostApiSetup(messenger, advertiserApi)
        
        return self
    }
    
    private func setUpPeerIDInstance(messenger: FlutterBinaryMessenger) -> SwiftUwbIosPlugin {
        let peerIDApi: BFMCPeerIDHostApiImpl = BFMCPeerIDHostApiImpl(flutterMessenger: messenger)
        BFMCPeerIDHostApiSetup(messenger, peerIDApi)
        
        return self
    }
}
