//
//  NotAracı.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 9.02.2021.
//

import Foundation
import UIKit

enum NotAracı: String, Codable {
    
    case Sınav
    case DersİçiKatılım
    case Proje
    
}


extension DersVC {
    
    func bilgilerdenTextField(_ notAracı: NotAracı, _ numara: Int) -> UITextField {
        
        switch (notAracı, numara) {
        case (.Sınav, 1):
            return sınav1TextField
        case (.Sınav, 2):
            return sınav2TextField
        case (.Sınav, 3):
            return sınav3TextField
        case (.DersİçiKatılım, 1):
            return derseKatılım1TextField
        case (.DersİçiKatılım, 2):
            return derseKatılım2TextField
        case (.DersİçiKatılım, 3):
            return derseKatılım3TextField
        case (.Proje, 1):
            return proje1TextField
        case (.Proje, 2):
            return proje2TextField
        default:
            return UITextField()
        }
        
    }
    
    func textFieldBilgisi(_ textField: UITextField) -> (NotAracı, Int) {
        print(textField)
        switch textField {
        case sınav1TextField:
            return (.Sınav, 1)
        case sınav2TextField:
            return (.Sınav, 2)
        case sınav3TextField:
            return (.Sınav, 3)
        case derseKatılım1TextField:
            return (.DersİçiKatılım, 1)
        case derseKatılım2TextField:
            return (.DersİçiKatılım, 2)
        case derseKatılım3TextField:
            return (.DersİçiKatılım, 3)
        case proje1TextField:
            return (.Proje, 1)
        case proje2TextField:
            return (.Proje, 2)
        default:
            return (.Sınav, 1)
        }
    }
    
}
