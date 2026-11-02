//
//  DersVC.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 25.02.2021.
//

import UIKit

class DersVC: UIViewController, UITextFieldDelegate {
    
    var dersAdı: String! {
        didSet {
            print(dersAdı)
            
        }
    }
    @IBOutlet weak var yazıStackView: UIStackView!
    @IBOutlet weak var buDersinOrtalamasıLabel: UILabel!
    @IBOutlet weak var diğerDerslerHeight: NSLayoutConstraint!
    @IBOutlet weak var buDersHeight: NSLayoutConstraint!
    @IBOutlet weak var dersAdıLabel: UILabel!
    @IBOutlet weak var ortalamaSWTop: NSLayoutConstraint!
    @IBOutlet weak var ortalamaSWBottom: NSLayoutConstraint!
    @IBOutlet weak var ortalamaStackView: UIStackView!
    @IBOutlet weak var ortalamaYükseltiyorLabel: UILabel!
    @IBOutlet weak var dersinOrtalamasıLabel: UILabel!
    @IBOutlet weak var artışImageView: UIImageView!
    @IBOutlet weak var sınav1TextField: UITextField!
    @IBOutlet weak var sınav2TextField: UITextField!
    @IBOutlet weak var derseKatılım1TextField: UITextField!
    @IBOutlet weak var derseKatılım2TextField: UITextField!
    @IBOutlet weak var derseKatılım3TextField: UITextField!
    @IBOutlet weak var projelerStackView: RoundedShadowView2!
    @IBOutlet weak var proje1TextField: UITextField!
    @IBOutlet weak var proje2TextField: UITextField!
    
    @IBOutlet weak var sınav3SW: RoundedShadowView2!
    @IBOutlet weak var sınav3TextField: UITextField!
    lazy var views = [sınav1TextField, sınav2TextField, sınav3TextField, derseKatılım1TextField, derseKatılım2TextField, derseKatılım3TextField, proje1TextField, proje2TextField]
    
    @objc func viewTapped() {
        views.forEach { (newView) in
            newView!.resignFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = dersAdı
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        if kullanıcı.sınıf > 8 {
            sınav3SW.isHidden = false
        } else {
            sınav3SW.isHidden = true
        }
        notlarıYerleştir()
        dersinOrtalamasınıGöster()
        grafiğiAyarla()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func textFieldTextChanged(_ sender: UITextField) {
        yazıDeğişti(sender: sender)
    }
    @IBAction func textFieldStarted(_ sender: UITextField) {
        yazıDeğişti(sender: sender)
    }
    
    func yazıDeğişti(sender: UITextField) {
        
        let notSilinecek = sender.text! == "" || Double(sender.text!) == nil
        let bilgi = textFieldBilgisi(sender)
        let not = notSilinecek ? 404.4 : Double(sender.text!)!
        if (not > 100 && !notSilinecek) || (Double(sender.text!) == nil && sender.text! != "") {
            alert(başlık: "Geçersiz Not", mesaj: "Lütfen 100 veya daha küçük bir not girin.")
            sender.text?.removeLast()
            return
        }
        notuDeğiştir(çeşit: bilgi.0, numara: bilgi.1, not: not)
        
    }
    
    func notlarıYerleştir() {
        
        for şimdikiView in views {
            let bilgi = textFieldBilgisi(şimdikiView!)
            print(kullanıcı.dersler)
            print(dersAdı)
            let şimdikiDers = kullanıcı.dersler.filter { (ders) -> Bool in
                ders.dersAdı == dersAdı
            }
            let şimdikiNot = şimdikiDers.first!.notlar.filter { (not) -> Bool in
                (not.çeşit, not.numara) == (bilgi.0, bilgi.1)
            }
            if !şimdikiNot.isEmpty {
                let olabilir = "\(şimdikiNot.first!.puan)".hasSuffix(".0") || "\(şimdikiNot.first!.puan)".hasSuffix(",0")
                let puan = "\(şimdikiNot.first!.puan)"
                if olabilir {
                    şimdikiView?.text = "\(puan.prefix(puan.count - 2))"
                    
                } else {
                    şimdikiView?.text = puan
                }
                
            }
            
        }
        
    }
    
    func notYok() {
        
        ortalamaYükseltiyorLabel.text = "Not Yok"
        yazıStackView.isHidden = true
        ortalamaYükseltiyorLabel.font = ortalamaYükseltiyorLabel.font.withSize(18.0)
        dersinOrtalamasıLabel.text = ""
        artışImageView.image = UIImage()
        
    }
    
    func notuDeğiştir(çeşit: NotAracı, numara: Int, not: Double) {
        
        let dersNo = kullanıcı.dersler.firstIndex { (ders) -> Bool in
            ders.dersAdı == title
        }!
        let notNo = kullanıcı.dersler[dersNo].notlar.firstIndex { (not) -> Bool in
            (not.çeşit == çeşit, not.numara == numara) == (true, true)
        }
        
        if notNo == nil {
            if not == 404.4 {
                return
            } else {
                kullanıcı.dersler[dersNo].notlar.append(Not(puan: not, çeşit: çeşit, numara: numara))
                
            }
        } else {
            if not == 404.4 {
                kullanıcı.dersler[dersNo].notlar.remove(at: notNo!)
            } else {
                kullanıcı.dersler[dersNo].notlar[notNo!].puan = not
            }
        }   
        dersinOrtalamasınıGöster()
        kullanıcı.kaydet()
        
    }
    
    func dersinOrtalamasınıGöster() {
        grafiğiAyarla()
        let ders = kullanıcı.dersler.first {$0.dersAdı == title}!
        guard !ders.notlar.isEmpty else { notYok(); return}
        ortalamaYükseltiyorLabel.font = ortalamaYükseltiyorLabel.font.withSize(15.0)
        print(ders)
        let ortalamaYükseltiyor = ders.ortalama > kullanıcı.ortalama
        let ortalamaEşit = ders.ortalama == kullanıcı.ortalama
        
        ortalamaYükseltiyorLabel.text = "Genel ortalamandan \(ortalamaYükseltiyor ? "yüksek:" : "az:")"
        dersinOrtalamasıLabel.text = "\(((ders.ortalama - kullanıcı.ortalama) * 100).rounded() / 100)"

        artışImageView.işaretResmiAyarla(ortalamaYükseltiyor ? .Yukarı : .Aşağı)
        if ortalamaEşit {
            artışImageView.işaretResmiAyarla(.Yan)
            ortalamaYükseltiyorLabel.text = "Genel ortalamana eşit:"
            dersinOrtalamasıLabel.text = "\(ders.ortalama)"
        }
        yazıStackView.isHidden = false
        buDersinOrtalamasıLabel.text = "\(ders.ortalama)"
        
        
    }
    
    func grafiğiAyarla() {
        
        dersAdıLabel.text = title
        diğerDerslerHeight.constant = CGFloat(kullanıcı.ortalama * 1.65)
        buDersHeight.constant = CGFloat(kullanıcı.dersler.first{$0.dersAdı == title}!.ortalama * 1.65)
        
    }
    
    
}
