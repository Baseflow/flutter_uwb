//
//  MCSessionHostApi.swift
//  uwb_ios
//
//  Created by Leroy on 21/02/2022.
//

import Foundation
import MultipeerConnectivity
import NearbyInteraction

@available(iOS 14.0, *)
public class MCSessionHostApi: NSObject, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate {
    
    static var tokenChannel: FlutterMethodChannel?
    
    var token: String?
    var peerID: MCPeerID
    var mcSession: MCSession
    var niManager: NISessionHostApi
    var mcAdvertiserAssistant: MCNearbyServiceAdvertiser?
    
    override init(){
        print("mpcManager started")
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        niManager = NISessionHostApi()
        
        super.init()
        mcSession.delegate = self
    }
    
    //MARK: - Set up

    public static func setUp (binaryMessenger: FlutterBinaryMessenger) {
        let session = MCSessionHostApi()
        
        let channel = FlutterMethodChannel(name: "com.baseflow.uwb/mc_session", binaryMessenger: binaryMessenger)
        
        tokenChannel = FlutterMethodChannel(name: "com.baseflow.uwb/ni_session_location", binaryMessenger: binaryMessenger)
        
        channel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "MCSession.start":
                result(session.start())
            case "MCSession.startHost":
                session.startAdvertising()
                result(true)
            case "MCSession.joinHost":
                session.sendInvite()
                result(true)
            default:
                result(FlutterMethodNotImplemented)
            }
         }
    }
    
    //MARK: - Functions
    
    func start() -> String {
        return "MCSession started"
    }
    
    func startAdvertising() {
        print("Started advertising")
        mcAdvertiserAssistant = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "mpc-connect")
        mcAdvertiserAssistant?.delegate = self
        mcAdvertiserAssistant?.startAdvertisingPeer()
    }
    
    func sendInvite() {
        print("invite send")
        let browser = MCBrowserViewController(serviceType: "mpc-connect", session: mcSession)
        browser.delegate = self
        
        //present the browser to the viewcontroller
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first

        window?.rootViewController?.present(browser, animated: true, completion: nil)
    }
    
    func sendToken(token: String){
        print("Trying to send test token")
        if mcSession.connectedPeers.count > 0 {
            let dataToken = Data(token.utf8)
            do {
                try mcSession.send(dataToken, toPeers: mcSession.connectedPeers, with: .reliable)
                print("Test token send")
            } catch {
                fatalError("Could not send test token")
            }
        } else {
            print("You are not connected to other devices")
        }
    }
    
    //MARK: - Nearby Interaction Functions
    
    func sendDiscoveryToken(){
        print("Trying to send discoverytoken")
        if mcSession.connectedPeers.count > 0 {
            
            guard let dataToken = niManager.discoveryToken,
                  let data = try? NSKeyedArchiver.archivedData(withRootObject: dataToken, requiringSecureCoding: true) else {
                      fatalError("can't convert token to data")
                  }
            do {
                try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
                print("Token send")
            } catch {
                fatalError("Could not send discovery token")
            }
        } else {
            print("You are not connected to other devices")
        }
    }
    
    // MARK: - MPC Functions
    
    public func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
    }
    
    public func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    }
    
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, mcSession)
    }
    
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case.connecting:
            print("\(peerID) state: connecting")
        case.connected:
            print("\(peerID) state: connected")
            
            //TODO: //stopadvertising/stopbrowsing (ff checken waar dit moet)
            if niManager.session == nil {
                niManager.setVariables()
                sendDiscoveryToken()
            }
            
        case.notConnected:
            print("\(peerID) state: not connected")
        @unknown default:
            print("\(peerID) state: unkown")
        }
    }
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
//        niManager.startSession(data: data)
    //TODO: send dataString back to dart
        let token = data.map(String.init)
        MCSessionHostApi.tokenChannel?.invokeMethod("token", arguments: token)
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
    
    public func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        //dismiss browser when done
        browserViewController.dismiss(animated: true, completion: nil)
    }
    
    public func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        //dismiss browser when cancelled
        browserViewController.dismiss(animated: true, completion: nil)
    }
}
