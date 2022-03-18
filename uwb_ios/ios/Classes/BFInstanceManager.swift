//
//  BFInstanceManager.swift
//  uwb_ios
//
//  Created by Maurits van Beusekom on 17/03/2022.
//

import Foundation

/// The BFInstanceManager is used to store class instances with an identifyer.
internal class BFInstanceManager : NSObject {
  /// Provides access to the current instance of the BFInstanceManager.
  ///
  /// If an instance of the BFInstanceManager doesn't exists one is created and returned.
  static let current: BFInstanceManager = BFInstanceManager();
  
  private var instanceIdsToInstances: Dictionary<NSNumber, NSObject> = [:]
  
  /// Hides the public constructor.
  ///
  /// Callers should use the BFInstanceManager.instance property instead.
  private override init() {
  }
  
  /// Adds the supplied instance with the specified instanceId.
  ///
  /// Overwrites existing instances with the same key.
  func addInstance(instanceId: NSNumber, instance: NSObject) {
    instanceIdsToInstances[instanceId] = instance
  }
  
  /// Removes an object based on its associated intance identifier.
  ///
  /// Returns the object that is removed or nil if no object was found.
  func removeInstanceId(instanceId: NSNumber) -> NSObject? {
    let instance: NSObject? = instanceIdsToInstances[instanceId]
    if (instance != nil) {
      instanceIdsToInstances.removeValue(forKey: instanceId)
    }
    
    return instance
  }
  
  /// Retrieve the object associated with the supplied instance identifier.
  ///
  /// Returns nil if no associated object was found.
  func getInstance(instanceId: NSNumber) -> NSObject? {
    return instanceIdsToInstances[instanceId]
  }
}
