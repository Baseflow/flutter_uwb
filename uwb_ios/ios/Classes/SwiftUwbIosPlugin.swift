import Foundation
import Flutter
import UIKit

public class SwiftUwbIosPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let _: SwiftUwbIosPlugin = SwiftUwbIosPlugin()
      .setUpAdvertiser(messenger: registrar.messenger())
  }
  
  private func setUpAdvertiser(messenger: FlutterBinaryMessenger) -> SwiftUwbIosPlugin {
    let advertiser: BFMCNearbyServiceAdvertiserHostApiImpl = BFMCNearbyServiceAdvertiserHostApiImpl(flutterMessenger: messenger)
    BFMCNearbyServiceAdvertiserHostApiSetup(messenger, advertiser)
    
    return self
  }
}
