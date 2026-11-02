//
//  Sifirla.swift
//  OrtalaNot
//
//  Created by CAN AKGUN on 3.09.2023.
//

import Foundation
import UIKit

extension AyarlarVC {
    
    func sil() {
        
        UserDefaults.standard.removeObject(forKey: "Başlangıç")
        UserDefaults.standard.removeObject(forKey: "SonPuanİsteme")
        UserDefaults.standard.removeObject(forKey: "Puanİsteme")
        UserDefaults.standard.removeObject(forKey: "Kullanıcı")
        
        ortalamayaBasıldı = 0
        lgsBasıldı = 0
        şuAnkiPageVC = 1
        seçmeliDersVar = false
        sınıf = 1.0
        yazıSonu = ""
        sınıfDeğişti = false
        liseTürü = ""
        teşekkür = false
        ilkYüklemeMiBak()
        
        var notlarV = (((presentingViewController as! UITabBarController).viewControllers?[0] as! UINavigationController).viewControllers[0] as! NotlarimVC)
        notlarV.tableView.reloadData()
        notlarV.giriş()
        self.dismiss(animated: true)

    }

    
}
