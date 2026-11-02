//
//  Kullanıcı.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 10.02.2021.
//

import Foundation

struct Kullanıcı: Codable {
    
    var sınıf: Double
    var dersler: [Ders] {
        didSet {
            kaydet()
        }
    }
    
    var ortalama: Double {
        ortalamaHesapla()
    }
    
    
    func kaydet() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.setValue(encoded, forKey: "Kullanıcı")
//            postN("DersleriTekrarYükle")
        }
        
    }
    
    
    
    
    
    func ortalamaHesapla() -> Double {
        
        var toplam = 0.0
        var dersToplamı = 0
        
        for ders in dersler.filter({!$0.notlar.isEmpty}) {
            toplam += ders.ortalama * Double(ders.haftalikSaat)
            dersToplamı += ders.haftalikSaat
        }
        guard dersToplamı != 0 else {return 0.0}
        return Double(toplam / Double(dersToplamı) * 100).rounded() / 100
    }
    
}

func kullancıyıAl() -> Kullanıcı? {
    if let kullanıcı = UserDefaults.standard.object(forKey: "Kullanıcı") as? Data {
        if let decodedKullanıcı = try? JSONDecoder().decode(Kullanıcı.self, from: kullanıcı) {
            return decodedKullanıcı
        }
        return nil
    }
    return nil
}

var kullanıcı: Kullanıcı!

