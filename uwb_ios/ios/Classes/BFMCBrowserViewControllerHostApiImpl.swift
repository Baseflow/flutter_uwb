//
//  BFMCBrowserViewControllerHostApiImpl.swift
//  uwb_ios
//
//  Created by Leroy on 27/06/2022.
//

import Foundation
import MultipeerConnectivity

@available(iOS 14.0, *)
internal class BFMCBrowserViewControllerHostApiImpl : NSObject, BFMCBrowserViewControllerHostApi {
    
    let flutterMessenger: FlutterBinaryMessenger
      
    init(flutterMessenger: FlutterBinaryMessenger) {
      self.flutterMessenger = flutterMessenger
    }
    
    func createInstanceId(_ instanceId: NSNumber, mCSessionInstanceID: NSNumber, serviceType: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
        let browser: MCBrowserViewController = MCBrowserViewController(serviceType: serviceType, session: BFInstanceManager.current.getInstance(instanceId: mCSessionInstanceID) as! MCSession
        )

        BFInstanceManager.current.addInstance(instanceId: instanceId, instance: browser)
    }
    
    func disposeInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func registerDelegateInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func removeDelegateInstanceId(_ instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
    }
    
    func presentTheBrowser(toViewControllerInstanceId instanceId: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let browser: MCBrowserViewController = BFInstanceManager.current.getInstance(instanceId: instanceId) as! MCBrowserViewController

        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first

        window?.rootViewController?.present(browser, animated: true, completion: nil)
    }
}
