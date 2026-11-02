//
//  Puan.swift
//  OrtalaNot
//
//  Created by CAN AKGUN on 16.11.2021.
//

import Foundation
import StoreKit

@available(iOS 10.3, *)
extension OrtalamaGosterVC {
    
    func puanlamaAl() {
        
        let başlangıç = UserDefaults.standard.value(forKey: "Başlangıç") as? Date ?? Date(timeIntervalSince1970: 0)
        
        if Date().timeIntervalSince1970 - başlangıç.timeIntervalSince1970 > 1 * 1 * 60 * 60 && Date().timeIntervalSince1970 - (UserDefaults.standard.value(forKey: "SonPuanİsteme") as? Date ?? Date(timeIntervalSince1970: 0)).timeIntervalSince1970 > 1 * 1 * 60 * 60 {
            SKStoreReviewController.requestReview()
            UserDefaults.standard.set(Date(), forKey: "SonPuanİsteme")


            UserDefaults.standard.setValue(UserDefaults.standard.integer(forKey: "Puanİsteme") + 1, forKey: "Puanİsteme")
            
        }
        
        
        
    }
    
}
