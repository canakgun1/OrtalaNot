//
//  Düzelt.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 19.02.2021.
//

import Foundation

extension Array where Element == String {
    
    func düzelt() {
        var bu = self
        
        if bu.contains("Yaşayan Diller ve Lehçeler") {
            if bu.contains("Yabancı Dil") {
                let index = bu.firstIndex(of: "Yabancı Dil")
                bu.removeAll { (ders) -> Bool in
                    ders == "Yaşayan Diller ve Lehçeler"
                }
                bu.insert("Yaşayan Diller ve Lehçeler", at: index! + 1)
                
            }
            else if bu.contains("Temel Dinî Bilgiler") {
                let index = bu.firstIndex(of: "Temel Dinî Bilgiler")
                bu.removeAll { (ders) -> Bool in
                    ders == "Yaşayan Diller ve Lehçeler"
                }
                bu.insert("Yaşayan Diller ve Lehçeler", at: index! + 1)
                
            }
            else if bu.contains("Spor ve Fizikî Etkinlikler (Haftada 4)") {
                let index = bu.firstIndex(of: "Spor ve Fizikî Etkinlikler (Haftada 4)")
                bu.removeAll { (ders) -> Bool in
                    ders == "Yaşayan Diller ve Lehçeler"
                }
                bu.insert("Yaşayan Diller ve Lehçeler", at: index! + 1)
                
            }
        }
        
        
        
        
        if bu.contains("Çevre Eğitimi") {
            if bu.contains("Bilişim Teknolojileri ve Yazılım") {
                let index = bu.firstIndex(of: "Bilişim Teknolojileri ve Yazılım")
                bu.removeAll { (ders) -> Bool in
                    ders == "Çevre Eğitimi"
                }
                bu.insert("Çevre Eğitimi", at: index! + 1)
                
            }
            else if bu.contains("Bilim Uygulamaları") {
                let index = bu.firstIndex(of: "Bilim Uygulamaları")
                bu.removeAll { (ders) -> Bool in
                    ders == "Çevre Eğitimi"
                }
                bu.insert("Çevre Eğitimi", at: index! + 1)
                
            }
            bu.insert("Çevre Eğitimi", at: 0)
            
        }
        
        
        
        
        if bu.contains("İletişim ve Sunum Becerileri") {
            if bu.contains("Hukuk ve Adalet") {
                let index = bu.firstIndex(of: "Hukuk ve Adalet")
                bu.removeAll { (ders) -> Bool in
                    ders == "İletişim ve Sunum Becerileri"
                }
                bu.insert("İletişim ve Sunum Becerileri", at: index! + 1)
                
            }
            else if bu.contains("Halk Kültürü") {
                let index = bu.firstIndex(of: "Halk Kültürü")
                bu.removeAll { (ders) -> Bool in
                    ders == "İletişim ve Sunum Becerileri"
                }
                bu.insert("İletişim ve Sunum Becerileri", at: index! + 1)
                
            }
            else if bu.contains("Görsel Sanatlar (Haftada 4)") {
                let index = bu.firstIndex(of: "Görsel Sanatlar (Haftada 4)")
                bu.removeAll { (ders) -> Bool in
                    ders == "İletişim ve Sunum Becerileri"
                }
                bu.insert("İletişim ve Sunum Becerileri", at: index! + 1)
                
            }
        }
        
    }
    
}

