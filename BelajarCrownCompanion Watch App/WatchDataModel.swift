//
//  WatchDataModel.swift
//  BelajarCrownCompanion Watch App
//
//  Created by Gregorius Yuristama Nugraha on 8/22/23.
//

import Foundation
import WatchConnectivity


class WatchDataModel : NSObject, WCSessionDelegate, ObservableObject {
    static let shared = WatchDataModel()
    let session = WCSession.default
    @Published var fidgetShape : Int = 0
    override init() {
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        } else {
            print("ERROR: Watch session not supported")
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("session activation failed with error: \(error.localizedDescription)")
            return
        }
    }
    
    
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any]) {
        guard let newShape = userInfo["FidgetShape"] as? Int else {
            print("ERROR: unknown data received from Watch")
            return
        }
        DispatchQueue.main.async {
            
            self.fidgetShape = newShape  // resets count to be last sent count from watch
            print(newShape)
        }
    }

}
