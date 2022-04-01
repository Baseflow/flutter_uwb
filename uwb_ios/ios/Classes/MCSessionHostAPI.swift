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
    var peerID: MCPeerID?
    var mcHostSession: MCSession?
    var mcJoinSession: MCSession?
    var niSession: NISessionHostApi?
    var mcAdvertiserAssistant: MCNearbyServiceAdvertiser?
    
    override init(){
        print("mpcManager started")
        super.init()
        niSession = NISessionHostApi.shared
    }
    
    //MARK: - Set up

    public static func setUp (binaryMessenger: FlutterBinaryMessenger) {
        let session = MCSessionHostApi()
        let channel = FlutterMethodChannel(name: "com.baseflow.uwb/mc_session", binaryMessenger: binaryMessenger)
        
        channel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "MCSession.startHost":
                guard let args = call.arguments as? [String : Any] else {return}
                let displayName = args["peerID"] as? String
                let serviceType = args["serviceType"] as? String
                session.startAdvertising(displayName: displayName!, serviceType: serviceType!)
                result(true)
            case "MCSession.joinHost":
                guard let args = call.arguments as? [String : Any] else {return}
                let displayName = args["peerID"] as? String
                let serviceType = args["serviceType"] as? String
                session.sendInvite(displayName: displayName!, serviceType: serviceType!)
                result(true)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    //MARK: - Functions
    
    func startAdvertising(displayName: String, serviceType: String) {
        print("Started advertising")
        peerID = MCPeerID(displayName: displayName)
        mcHostSession = MCSession(peer: peerID!, securityIdentity: nil, encryptionPreference: .required)
        mcHostSession!.delegate = self

        mcAdvertiserAssistant = MCNearbyServiceAdvertiser(peer: peerID!, discoveryInfo: nil, serviceType: serviceType)
        mcAdvertiserAssistant?.delegate = self
        mcAdvertiserAssistant?.startAdvertisingPeer()
    }
    
    func sendInvite(displayName: String, serviceType: String) {
        print("Sending joinrequest")
        peerID = MCPeerID(displayName: displayName)
        mcJoinSession = MCSession(peer: peerID!, securityIdentity: nil, encryptionPreference: .required)
        mcJoinSession!.delegate = self
        
        let browser = MCBrowserViewController(serviceType: serviceType, session: mcJoinSession!)
        browser.delegate = self
        //present the browser to the viewcontroller
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first

        window?.rootViewController?.present(browser, animated: true, completion: nil)
    }
    
    //MARK: - Nearby Interaction Functions
    
    func sendDiscoveryToken(session: MCSession) {
        guard let dataToken = niSession?.discoveryToken,
              let data = try? NSKeyedArchiver.archivedData(withRootObject: dataToken, requiringSecureCoding: true) else {
                  fatalError("can't convert token to data")
              }
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
            print("Token send")
        } catch {
            fatalError("Could not send discovery token")
        }
    }
    
    func checkSession(){
        if (mcHostSession != nil) {
            if mcHostSession!.connectedPeers.count > 0 {
                sendDiscoveryToken(session: mcHostSession!)
            }
        } else if (mcJoinSession != nil) {
            if mcJoinSession!.connectedPeers.count > 0{
                sendDiscoveryToken(session: mcJoinSession!)
            }
        } else {
            print("Not connected to any peers.")
        }
    }
    
    // MARK: - MPC Functions
    
    public func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
    }
    
    public func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    }
    
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, mcHostSession)
    }
    
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case.connecting:
            print("\(peerID) state: connecting")
        case.connected:
            print("\(peerID) state: connected")

            if niSession?.session == nil {
                niSession?.setVariables()
                checkSession()
            }
            
        case.notConnected:
            print("\(peerID) state: not connected")
        @unknown default:
            print("\(peerID) state: unkown")
        }
    }
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        niSession?.startSession(data: data)
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
