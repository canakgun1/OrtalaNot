//
//  Ders.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 9.02.2021.
//

import Foundation

struct Ders: Codable {
    
    var haftalikSaat: Int
    var notlar: [Not]
    var dersAdı: String
    var ortalama: Double {
        ortalamaHesapla()
    }
    
    func ortalamaHesapla() -> Double {
        
        
        if kullanıcı.sınıf > 8 || kullanıcı.sınıf < 5 {
            
            if notlar.isEmpty {
                return 0.0
            }
            
            var toplam = 0.0
            var sayı = 0.0
            
            for n in notlar {
                
                toplam += n.puan
                sayı += 1.0
            }
            
            return (toplam / sayı * 100).rounded() / 100
            
        }
        var notOrtalaması = 0.0
        var sınavNotlarıToplamı = 0.0
        var dersİçiKatılımNotlarıToplamı = 0.0
        var projeNotlarıToplamı = 0.0
        var sınavSayısı = 0
        var dersİçiKatılımSayısı = 0
        var projeSayısı = 0
        for not in notlar {
            switch not.çeşit {
            case .DersİçiKatılım:
                dersİçiKatılımNotlarıToplamı += not.puan
                dersİçiKatılımSayısı += 1
            case .Sınav:
                sınavNotlarıToplamı += not.puan
                sınavSayısı += 1
            case .Proje:
                projeNotlarıToplamı += not.puan
                projeSayısı += 1
            }
        }
        var projeVar = projeSayısı > 0
        var dersİçiKatılımVar = dersİçiKatılımSayısı > 0
        var sınavVar = sınavSayısı > 0
        if sınavVar, dersİçiKatılımVar, projeVar {
            let dersİçiKatılımNotlarıOrtalaması = round(Double(dersİçiKatılımNotlarıToplamı / Double(dersİçiKatılımSayısı)) * 100).rounded() / 100
            let projeNotlarıOrtalaması = round(Double(projeNotlarıToplamı / Double(projeSayısı)) * 100).rounded() / 100
//            let sınavNotlarıOrtalaması = round(Double(sınavNotlarıToplamı / Double(sınavSayısı)) * 100).rounded() / 100
            let projeVeDersİçiKatılımNotlarıOrtalaması = round(Double((projeNotlarıOrtalaması + dersİçiKatılımNotlarıOrtalaması) / 2) * 100).rounded() / 100
            notOrtalaması = round(Double((projeVeDersİçiKatılımNotlarıOrtalaması + sınavNotlarıToplamı) / Double(sınavSayısı + 1)) * 100).rounded() / 100
            
            return notOrtalaması
        }
        if sınavVar, dersİçiKatılımVar {
            let dersİçiKatılımNotlarıOrtalaması = round(Double(dersİçiKatılımNotlarıToplamı / Double(dersİçiKatılımSayısı)) * 100).rounded() / 100
            
//            let sınavNotlarıOrtalaması = round(Double(sınavNotlarıToplamı / Double(sınavSayısı)) * 100).rounded() / 100
            
            notOrtalaması = round(Double((dersİçiKatılımNotlarıOrtalaması + sınavNotlarıToplamı) / Double(sınavSayısı + 1)) * 100).rounded() / 100
            
            return notOrtalaması
        }
        if sınavVar, projeVar {
            
            let projeNotlarıOrtalaması = round(Double(projeNotlarıToplamı / Double(projeSayısı)) * 100).rounded() / 100
//            let sınavNotlarıOrtalaması = round(Double(sınavNotlarıToplamı / Double(sınavSayısı)) * 100).rounded() / 100
            
            notOrtalaması = round(Double((projeNotlarıOrtalaması + sınavNotlarıToplamı) / Double(sınavSayısı + 1)) * 100).rounded() / 100
            
            return notOrtalaması
        }
        if sınavVar {
            
            let sınavNotlarıOrtalaması = round(Double(sınavNotlarıToplamı / Double(sınavSayısı)) * 100).rounded() / 100
            
            return sınavNotlarıOrtalaması
        }
        if projeVar, dersİçiKatılımVar {
            let dersİçiKatılımNotlarıOrtalaması = round(Double(dersİçiKatılımNotlarıToplamı / Double(dersİçiKatılımSayısı)) * 100).rounded() / 100
            let projeNotlarıOrtalaması = round(Double(projeNotlarıToplamı / Double(projeSayısı)) * 100).rounded() / 100
            
            let projeVeDersİçiKatılımNotlarıOrtalaması = round(Double((projeNotlarıOrtalaması + dersİçiKatılımNotlarıOrtalaması) / 2) * 100).rounded() / 100
            notOrtalaması = projeVeDersİçiKatılımNotlarıOrtalaması
            
            return notOrtalaması
        }
        if projeVar {
            
            let projeNotlarıOrtalaması = round(Double(projeNotlarıToplamı / Double(projeSayısı)) * 100).rounded() / 100
            
            notOrtalaması = projeNotlarıOrtalaması
            
            return notOrtalaması
        }
        if dersİçiKatılımVar {
            let dersİçiKatılımNotlarıOrtalaması = round(Double(dersİçiKatılımNotlarıToplamı / Double(dersİçiKatılımSayısı)) * 100).rounded() / 100
            
            notOrtalaması = dersİçiKatılımNotlarıOrtalaması
            
            return notOrtalaması
        }
        return 0
        
    }
    
}

let seçmeliDersSaatleri = ["Bilim Uygulamaları" : 2, "Bilişim Teknolojileri ve Yazılım" : 2, "Çevre Eğitimi" : 2, "Drama" : 2, "Düşünme Eğitimi" : 2, "Görsel Sanatlar (Haftada 2)" : 2, "Görsel Sanatlar (Haftada 4)" : 4, "Halk Kültürü" : 2, "Hukuk ve Adalet" : 2, "İletişim ve Sunum Becerileri" : 2, "Kent Kültürü" : 2, "Kur'an-ı Kerim" : 2, "Matematik Uygulamaları" : 2, "Medya Okuryazarlığı" : 2, "Müzik (Haftada 2)" : 2, "Müzik (Haftada 4)" : 4, "Okuma Becerileri" : 2, "Peygamberimizin Hayatı" : 2, "Spor ve Fizikî Etkinlikler (Haftada 2)" : 2, "Spor ve Fizikî Etkinlikler (Haftada 4)" : 4, "Temel Dinî Bilgiler" : 2, "Yabancı Dil" : 2, "Yaşayan Diller ve Lehçeler" : 2, "Yazarlık ve Yazma Becerileri" : 2, "Zekâ Oyunları" : 2]

let bütünDersler = [
    "1. Sınıf" : [
        Ders(haftalikSaat: 10, notlar: [], dersAdı: "Türkçe"),
        Ders(haftalikSaat: 5, notlar: [], dersAdı: "Matematik"),
        Ders(haftalikSaat: 4, notlar: [], dersAdı: "Hayat Bilgisi"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Görsel Sanatlar"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Müzik"),
        Ders(haftalikSaat: 5, notlar: [], dersAdı: "Oyun ve Fiziki Etkinlikler")
    ],
    "2. Sınıf" : [
        Ders(haftalikSaat: 10, notlar: [], dersAdı: "Türkçe"),
        Ders(haftalikSaat: 5, notlar: [], dersAdı: "Matematik"),
        Ders(haftalikSaat: 4, notlar: [], dersAdı: "Hayat Bilgisi"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Yabancı Dil"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Görsel Sanatlar"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Müzik"),
        Ders(haftalikSaat: 5, notlar: [], dersAdı: "Oyun ve Fiziki Etkinlikler")
    ],
    "3. Sınıf" : [
        Ders(haftalikSaat: 8, notlar: [], dersAdı: "Türkçe"),
        Ders(haftalikSaat: 5, notlar: [], dersAdı: "Matematik"),
        Ders(haftalikSaat: 3, notlar: [], dersAdı: "Hayat Bilgisi"),
        Ders(haftalikSaat: 3, notlar: [], dersAdı: "Fen Bilimleri"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Yabancı Dil"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Görsel Sanatlar"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Müzik"),
        Ders(haftalikSaat: 5, notlar: [], dersAdı: "Oyun ve Fiziki Etkinlikler")
    ],
    "4. Sınıf" : [
        Ders(haftalikSaat: 8, notlar: [], dersAdı: "Türkçe"),
        Ders(haftalikSaat: 5, notlar: [], dersAdı: "Matematik"),
        Ders(haftalikSaat: 3, notlar: [], dersAdı: "Sosyal Bilgiler"),
        Ders(haftalikSaat: 3, notlar: [], dersAdı: "Fen Bilimleri"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Yabancı Dil"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Din Kültürü ve Ahlak Bilgisi"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Görsel Sanatlar"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Müzik"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Oyun ve Fiziki Etkinlikler"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Trafik Güvenliği"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "İnsan Hakları, Yurttaşlık ve Demokrasi")
    ],
    "5. Sınıf" : [
        Ders(haftalikSaat: 6, notlar: [], dersAdı: "Türkçe"),
        Ders(haftalikSaat: 5, notlar: [], dersAdı: "Matematik"),
        Ders(haftalikSaat: 4, notlar: [], dersAdı: "Fen Bilimleri"),
        Ders(haftalikSaat: 3, notlar: [], dersAdı: "Sosyal Bilgiler"),
        Ders(haftalikSaat: 3, notlar: [], dersAdı: "Yabancı Dil"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Din Kültürü ve Ahlak Bilgisi"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Görsel Sanatlar"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Müzik"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Beden Eğitimi ve Spor"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Bilişim Teknolojileri ve Yazılım")
    ],
    "6. Sınıf" : [
        Ders(haftalikSaat: 6, notlar: [], dersAdı: "Türkçe"),
        Ders(haftalikSaat: 5, notlar: [], dersAdı: "Matematik"),
        Ders(haftalikSaat: 4, notlar: [], dersAdı: "Fen Bilimleri"),
        Ders(haftalikSaat: 3, notlar: [], dersAdı: "Sosyal Bilgiler"),
        Ders(haftalikSaat: 3, notlar: [], dersAdı: "Yabancı Dil"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Din Kültürü ve Ahlak Bilgisi"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Görsel Sanatlar"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Müzik"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Beden Eğitimi ve Spor"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Bilişim Teknolojileri ve Yazılım")
    ],
    "7. Sınıf" : [
        Ders(haftalikSaat: 5, notlar: [], dersAdı: "Türkçe"),
        Ders(haftalikSaat: 5, notlar: [], dersAdı: "Matematik"),
        Ders(haftalikSaat: 4, notlar: [], dersAdı: "Fen Bilimleri"),
        Ders(haftalikSaat: 3, notlar: [], dersAdı: "Sosyal Bilgiler"),
        Ders(haftalikSaat: 4, notlar: [], dersAdı: "Yabancı Dil"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Din Kültürü ve Ahlak Bilgisi"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Görsel Sanatlar"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Müzik"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Beden Eğitimi ve Spor"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Teknoloji ve Tasarım")
    ],
    "8. Sınıf" : [
        Ders(haftalikSaat: 5, notlar: [], dersAdı: "Türkçe"),
        Ders(haftalikSaat: 5, notlar: [], dersAdı: "Matematik"),
        Ders(haftalikSaat: 4, notlar: [], dersAdı: "Fen Bilimleri"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "T.C. İnkılap Tarihi ve Atatürkçülük"),
        Ders(haftalikSaat: 4, notlar: [], dersAdı: "Yabancı Dil"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Din Kültürü ve Ahlak Bilgisi"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Görsel Sanatlar"),
        Ders(haftalikSaat: 1, notlar: [], dersAdı: "Müzik"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Beden Eğitimi ve Spor"),
        Ders(haftalikSaat: 2, notlar: [], dersAdı: "Teknoloji ve Tasarım")
    ]
]
var lise = [
    "Anadolu Lisesi" : [
        "Hazırlık" : [ Ders(haftalikSaat: 4, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 3, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 20, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL" ),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİLGİSAYAR BİLİMİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "GÖRSEL SANATLAR/MÜZİK")],
        "9. Sınıf" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "TARİH"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "COĞRAFYA"),  Ders(haftalikSaat: 6, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FİZİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "KİMYA"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BİYOLOJİ"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "GÖRSEL SANATLAR/MÜZİK"),  Ders(haftalikSaat: 1, notlar: [], dersAdı: "SAĞLIK BİLGİSİ VE TRAFİK KÜLTÜRÜ")],
        "10. Sınıf" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "TARİH"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "COĞRAFYA"),  Ders(haftalikSaat: 6, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FİZİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "KİMYA"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BİYOLOJİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FELSEFE"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "GÖRSEL SANATLAR/MÜZİK")],
        "11. Sınıf" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "TARİH"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FELSEFE"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "GÖRSEL SANATLAR/MÜZİK")],
        "12. Sınıf" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "T.C. İNKILAP TARİHİ VE ATATÜRKÇÜLÜK"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "GÖRSEL SANATLAR/MÜZİK")]
    ],
    "Sosyal Bilimler Lisesi" : [
        "Hazırlık" : [ Ders(haftalikSaat: 4, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 3, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 20, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR/GÖRSEL SANATLAR/MÜZİK"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİLGİSAYAR BİLİMİ")],
        "9. Sınıf" : [ Ders(haftalikSaat: 7, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "TARİH"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "COĞRAFYA"),  Ders(haftalikSaat: 6, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FİZİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "KİMYA"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BİYOLOJİ"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR/GÖRSEL SANATLAR/MÜZİK"),  Ders(haftalikSaat: 1, notlar: [], dersAdı: "SAĞLIK BİLGİSİ VE TRAFİK KÜLTÜRÜ")],
        "10. Sınıf" : [ Ders(haftalikSaat: 7, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "TARİH"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "COĞRAFYA"),  Ders(haftalikSaat: 6, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FİZİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "KİMYA"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BİYOLOJİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FELSEFE"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR/GÖRSEL SANATLAR/MÜZİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "SOSYAL BİLİM ÇALIŞMALARI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "OSMANLI TÜRKÇESİ")],
        "11. Sınıf" : [ Ders(haftalikSaat: 6, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "TARİH"),  Ders(haftalikSaat: 3, notlar: [], dersAdı: "TÜRK KÜLTÜR VE MEDENİYET TARİHİ"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "COĞRAFYA"),  Ders(haftalikSaat: 5, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR/GÖRSEL SANATLAR/MÜZİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "SOSYAL BİLİM ÇALIŞMALARI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "PSİKOLOJİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "SOSYOLOJİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "MANTIK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "OSMANLI TÜRKÇESİ")],
        "12. Sınıf" : [ Ders(haftalikSaat: 8, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "T.C. İNKILAP TARİHİ VE ATATÜRKÇÜLÜK"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "ÇAĞDAŞ TÜRK VE DÜNYA TARİHİ"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "COĞRAFYA"),  Ders(haftalikSaat: 6, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR/GÖRSEL SANATLAR/MÜZİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "SOSYAL BİLİM ÇALIŞMALARI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "SOSYOLOJİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "SANAT TARİHİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "OSMANLI TÜRKÇESİ")]
    ],
    "Fen Lisesi" : [
        "9. Sınıf" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "TARİH"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "COĞRAFYA"),  Ders(haftalikSaat: 6, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FİZİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "KİMYA"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BİYOLOJİ"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BİLGİSAYAR BİLİMİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "GÖRSEL SANATLAR/MÜZİK"),  Ders(haftalikSaat: 1, notlar: [], dersAdı: "SAĞLIK BİLGİSİ VE TRAFİK KÜLTÜRÜ")],
        "10. Sınıf" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "TARİH"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "COĞRAFYA"),  Ders(haftalikSaat: 6, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FİZİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "KİMYA"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BİYOLOJİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FELSEFE"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BİLGİSAYAR BİLİMİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "GÖRSEL SANATLAR/MÜZİK")],
        "11. Sınıf" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "TARİH"),  Ders(haftalikSaat: 6, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "FİZİK"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "KİMYA"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİYOLOJİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FELSEFE"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR")],
        "12. Sınıf" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "T.C. İNKILAP TARİHİ VE ATATÜRKÇÜLÜK"),  Ders(haftalikSaat: 6, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "FİZİK"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "KİMYA"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİYOLOJİ"),  Ders(haftalikSaat: 4, notlar: [], dersAdı: "BİRİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "İKİNCİ YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR")]
        ],
    "Spor Lisesi" : [
        "9. Sınıf" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "TARİH"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "COĞRAFYA"),  Ders(haftalikSaat: 6, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FİZİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "KİMYA"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BİYOLOJİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "GÖRSEL SANATLAR/MÜZİK"),  Ders(haftalikSaat: 1, notlar: [], dersAdı: "SAĞLIK BİLGİSİ VE TRAFİK KÜLTÜRÜ"), Ders(haftalikSaat: 3, notlar: [], dersAdı: "Temel Spor Eğitimi"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "Eğitsel Oyunlar"), Ders(haftalikSaat: 4, notlar: [], dersAdı: "Takım Sporları"), Ders(haftalikSaat: 3, notlar: [], dersAdı: "Spor Uygulamaları")],
        "10. Sınıf" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "TARİH"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "COĞRAFYA"),  Ders(haftalikSaat: 5, notlar: [], dersAdı: "MATEMATİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FİZİK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "KİMYA"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "BİYOLOJİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FELSEFE"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "YABANCI DİL"),  Ders(haftalikSaat: 1, notlar: [], dersAdı: "GÖRSEL SANATLAR/MÜZİK"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "Genel Jimnastik"), Ders(haftalikSaat: 4, notlar: [], dersAdı: "Takım Sporları"), Ders(haftalikSaat: 4, notlar: [], dersAdı: "Bireysel Sporlar"), Ders(haftalikSaat: 3, notlar: [], dersAdı: "Spor Uygulamaları")],
        "11. Sınıf" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "TARİH"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "FELSEFE"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "GÖRSEL SANATLAR/MÜZİK"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "Spor Anatomisi ve Fizyolojisi"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "Sporcu Sağlığı"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "Spor ve Beslenme"), Ders(haftalikSaat: 3, notlar: [], dersAdı: "Ritim Eğitimi ve Halk Dansları"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "Atletizm"), Ders(haftalikSaat: 4, notlar: [], dersAdı: "Takım Sporları"), Ders(haftalikSaat: 4, notlar: [], dersAdı: "Bireysel Sporlar"), Ders(haftalikSaat: 3, notlar: [], dersAdı: "Spor Uygulamaları")],
        "12. Sınıf" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE EDEBİYATI"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "T.C. İNKILAP TARİHİ VE ATATÜRKÇÜLÜK"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "YABANCI DİL"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "GÖRSEL SANATLAR/MÜZİK"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "Beden Eğitimi ve Spor Tarihi"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "Antrenman Bilgisi"), Ders(haftalikSaat: 1, notlar: [], dersAdı: "Antrenörlük Eğitimi"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "Spor Yönetimi ve Organizasyonu"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "Spor Psikolojisi ve Sosyolojisi"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "Atletizm"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "Artistik Jimnastik"), Ders(haftalikSaat: 4, notlar: [], dersAdı: "Takım Sporları"), Ders(haftalikSaat: 4, notlar: [], dersAdı: "Bireysel Sporlar"), Ders(haftalikSaat: 3, notlar: [], dersAdı: "Spor Uygulamaları")]
    ],
    "Robert" : [
        "12. Sınıf" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE Edebiyatı"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 3, notlar: [], dersAdı: "T.C. İNKILAP TARİHİ VE ATATÜRKÇÜLÜK"),  Ders(haftalikSaat: 5, notlar: [], dersAdı: "Seçmeli 1"),  Ders(haftalikSaat: 5, notlar: [], dersAdı: "Seçmeli 2"),
                         Ders(haftalikSaat: 5, notlar: [], dersAdı: "Seçmeli 3"), Ders(haftalikSaat: 5, notlar: [], dersAdı: "Seçmeli 4"), Ders(haftalikSaat: 5, notlar: [], dersAdı: "SEÇMELİ 5"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR")],
        "A" : [ Ders(haftalikSaat: 5, notlar: [], dersAdı: "TÜRK DİLİ VE Edebiyatı"),  Ders(haftalikSaat: 2, notlar: [], dersAdı: "DİN KÜLTÜRÜ VE AHLAK BİLGİSİ"),  Ders(haftalikSaat: 3, notlar: [], dersAdı: "T.C. İNKILAP TARİHİ VE ATATÜRKÇÜLÜK"),  Ders(haftalikSaat: 5, notlar: [], dersAdı: "Literature and Technology"),  Ders(haftalikSaat: 5, notlar: [], dersAdı: "MODERN FİZİK"),
                         Ders(haftalikSaat: 5, notlar: [], dersAdı: "ELECTRONİCS"), Ders(haftalikSaat: 5, notlar: [], dersAdı: "ENVİRONMENTAL SCİENCE"), Ders(haftalikSaat: 5, notlar: [], dersAdı: "SEÇMELİ 5"), Ders(haftalikSaat: 2, notlar: [], dersAdı: "BEDEN EĞİTİMİ VE SPOR")]
        
    ]
]
