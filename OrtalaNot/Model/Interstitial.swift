//
//  Interstitial.swift
//  OrtalaNot
//
//  Created by CAN AKGUN on 28.11.2021.
//

import UIKit
import GoogleMobileAds

extension NotlarimVC: FullScreenContentDelegate {
    
    func loadAd() {
        
        let request = Request()
        InterstitialAd.load(with: NOTLARIM_ID, request: request, completionHandler: { [self] ad, error in
            
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            
            
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
            postN("AdYüklendi")
        }
        )
        
    }
    
    func presentAd() {
        
        if interstitial != nil {
            interstitial?.present(from: self)
        } else {
            print("Ad wasn't ready")
        }
        
    }
    
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        
        if reklamTipi == "Ortalama" {
            performSegue(withIdentifier: "ortalamaVCSegue", sender: self)
        }
        
        loadAd()
        
    }
    
}

extension HesaplaVC: FullScreenContentDelegate {
    
    func loadAd() {
        
        let request = Request()
        InterstitialAd.load(with: HESAPLA_ID, request: request, completionHandler: { [self] ad, error in
            
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
            
        }
        )
        
    }
    
    func presentAd() {
        
        if interstitial != nil {
            interstitial?.present(from: self)
        } else {
            print("Ad wasn't ready")
        }
        
    }
    
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        
        puanHesapla()
        loadAd()
        
    }
    
}

var ortalamayaBasıldı: Int = 0

var ortalamaReklamÇıkmalı: Bool {
    
    return !reklamYok && [1, 3, 6, 10, 15, 21, 28, 36, 45, 55].contains(ortalamayaBasıldı)
    
}

var lgsBasıldı: Int = 0

var lgsReklamÇıkmalı: Bool {
    
    return [1, 3, 6, 10, 15, 21, 28, 36, 45, 55].contains(lgsBasıldı)
    
}

var reklamTipi = "İlk"
