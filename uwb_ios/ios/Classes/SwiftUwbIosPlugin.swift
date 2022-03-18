import Flutter
import UIKit

public class SwiftUwbIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let _: SwiftUwbIosPlugin = SwiftUwbIosPlugin()
      .setUpAdvertiser(messenger: registrar.messenger())
      .setUpNearbyInteraction(messenger: registrar.messenger())
      
  }
  
  private func setUpAdvertiser(messenger: FlutterBinaryMessenger) -> SwiftUwbIosPlugin {
    let nearbyServiceAdvertiserApi: BFMCNearbyServiceAdvertiserHostApiImpl = BFMCNearbyServiceAdvertiserHostApiImpl(flutterMessenger: messenger)
    BFMCNearbyServiceAdvertiserHostApiSetup(messenger, nearbyServiceAdvertiserApi)
    
    return self
  }
  
  private func setUpNearbyInteraction(messenger: FlutterBinaryMessenger) -> SwiftUwbIosPlugin {
    // TODO: Configure...
    
    return self
  }
}
