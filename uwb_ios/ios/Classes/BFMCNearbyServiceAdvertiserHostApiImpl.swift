//
//  MCNearbyServiceAdvertiserApi.swift
//  uwb_ios
//
//  Created by Maurits van Beusekom on 17/03/2022.
//

import Foundation
import MultipeerConnectivity

internal class BFMCNearbyServiceAdvertiserHostApiImpl : NSObject, BFMCNearbyServiceAdvertiserHostApi {
  let flutterMessenger: FlutterBinaryMessenger
    
  init(flutterMessenger: FlutterBinaryMessenger) {
    self.flutterMessenger = flutterMessenger
  }
  
  public func checkPlatformCompatibilityWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> NSNumber? {
    return true;
  }
}
