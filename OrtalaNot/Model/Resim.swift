//
//  Resim.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 23.03.2021.
//

import Foundation
import UIKit

enum İşaret {
    
    case Yukarı
    case Aşağı
    case Yan
    
}

extension UIImageView {
    
    func işaretResmiAyarla(_ işaret: İşaret) {
       
        if işaret == .Yukarı {
            işaretResmiVerileriAyarla(.systemGreen, düz: true, yukarı: true)
        } else if işaret == .Aşağı {
            işaretResmiVerileriAyarla(.systemRed, düz: true, yukarı: false)
        } else {
            işaretResmiVerileriAyarla(.gray, düz: false, yukarı: false)
        }
        
        
    }

    fileprivate func işaretResmiVerileriAyarla(_ renk: UIColor, düz: Bool, yukarı: Bool) {
        
        tintColor = renk
        transform = düz ? .identity : CGAffineTransform(rotationAngle: .pi / 2)
        image = !düz || yukarı ? UIImage(named: "arrow.up") : UIImage(named: "arrow.down")
        
    }
    
}
