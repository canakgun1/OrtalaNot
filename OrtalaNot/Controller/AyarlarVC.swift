//
//  AyarlarVC.swift
//  OrtalaNot
//
//  Created by CAN AKGUN on 3.09.2023.
//

import UIKit

class AyarlarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sinifDegistir(_ sender: UIButton) {
        alert(başlık: "Sınıf Değiştir", mesaj: "Sınıf seviyenizi değiştirmek istediğinize emin misiniz? Tüm notlarınız silinecektir.", actions:
        [
            UIAlertAction(title: "Vazgeç", style: .cancel),
            UIAlertAction(title: "Evet", style: .destructive, handler: { _ in
                self.sil()
            })
        ]
        )
    }
}
