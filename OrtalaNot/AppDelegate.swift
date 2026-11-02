//
//  AppDelegate.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 9.02.2021.
//

import UIKit
import Firebase
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        MobileAds.shared.start(completionHandler: nil)
        MobileAds.shared.requestConfiguration.testDeviceIdentifiers = [ "f83f9180af89fc823964031d0bdae724" ]
        ilkYüklemeMiBak()
        return true
    }
    


}


func ilkYüklemeMiBak() {
    
    if let gerçekKullanıcı = kullancıyıAl() {
        kullanıcı = gerçekKullanıcı
    } else {
        UserDefaults.standard.set(Date(), forKey: "Başlangıç")
        kullanıcı = Kullanıcı(sınıf: 0, dersler: [])
        kullanıcı.kaydet()
    }
    lise.forEach { (key, val) in
        val.forEach { (key1, val1) in
            
            let mapped = val1.map {Ders(haftalikSaat: $0.haftalikSaat, notlar: $0.notlar, dersAdı: $0.dersAdı.lowercased().capitalized)}
            lise[key]![key1] = mapped
        }
    }
    
}
