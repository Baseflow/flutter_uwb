//
//  MCNearbyServiceAdvertiserApi.swift
//  uwb_ios
//
//  Created by Maurits van Beusekom on 17/03/2022.
//

import Foundation
import MultipeerConnectivity
import NearbyInteraction

internal class BFMCNearbyServiceAdvertiserHostApiImpl : NSObject, BFMCNearbyServiceAdvertiserHostApi {
  let flutterMessenger: FlutterBinaryMessenger
    
  init(flutterMessenger: FlutterBinaryMessenger) {
    self.flutterMessenger = flutterMessenger
  }
  
  public func checkPlatformCompatibilityWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> NSNumber? {
      if #available(iOS 14.0, *) {
          if NISession.isSupported {
              return true
          }
      }
    return false
  }
}
