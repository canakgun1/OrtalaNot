//
//  OrtalamaGosterVC.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 9.02.2021.
//

import UIKit

class OrtalamaGosterVC: UIViewController {
    
    @IBOutlet weak var dersSayısıLabel: UILabel!
    @IBOutlet weak var ortalamaLabel: UILabel!
    @IBOutlet weak var yeterliLabel: UILabel!
    @IBOutlet weak var eksikLabel: UILabel!
    @IBOutlet weak var takdirButton: RoundedShadowButton!
    @IBOutlet weak var teşekkürButton: RoundedShadowButton!
    
    var notlarVC: UIViewController!
    
    @objc func viewTapped() {
        dismiss(animated: true, completion: nil)
        if #available(iOS 10.3, *) {
            puanlamaAl()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        addN("ortalamadismiss", to: self, action: #selector(viewTapped))
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        view.addGestureRecognizer(tap)
        dersSayısıLabel.text = "\(kullanıcı.dersler.count) dersten aldığın notların ortalaması:"
        
        ortalamaLabel.text = "\(kullanıcı.ortalama)"
        var yazı = ""
        if kullanıcı.ortalama >= 85.00 {
            yazı = "Şu anda takdir almak için yeterli."
        } else if kullanıcı.ortalama >= 70.00 {
            yazı = "Şu anda teşekkür almak için yeterli."
        } else {
            yazı = ""
        }
        yeterliLabel.text = yazı
        var eksikYok = false
        if kullanıcı.sınıf > 8 {
            eksikYok = kullanıcı.dersler.allSatisfy { (ders) -> Bool in
                ders.notlar.filter { (not) -> Bool in
                    not.çeşit == .Sınav || not.çeşit == .DersİçiKatılım
                }.count >= 5
            }
        } else {
            eksikYok = kullanıcı.dersler.allSatisfy { (ders) -> Bool in
                ders.notlar.filter { (not) -> Bool in
                    not.çeşit == .Sınav || not.çeşit == .DersİçiKatılım
                }.count == 5
            }
        }
        eksikLabel.isHidden = eksikYok
        // Do any additional setup after loading the view.
    }
    @IBAction func takdirButtonPressed(_ sender: UIButton) {
        teşekkür = false
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0.0
        }) { _ in
            self.notlarVC.performSegue(withIdentifier: "takdirTeşekkürSegue", sender: self)
            self.dismiss(animated: false, completion: nil)
        }
        
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func teşekkürButtonPressed(_ sender: UIButton) {
        teşekkür = true
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0.0
        }) { _ in
            self.notlarVC.performSegue(withIdentifier: "takdirTeşekkürSegue", sender: self)
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
}

var teşekkür: Bool = false
