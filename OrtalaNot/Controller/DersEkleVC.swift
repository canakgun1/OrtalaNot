//
//  DersEkleVC.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 10.02.2021.
//

import UIKit

class DersEkleVC: UIViewController {

    @IBOutlet weak var haftalıkDersSaati: UILabel!
    @IBOutlet weak var haftalıkDersStepper: UIStepper!
    @IBOutlet weak var sınavlarStepper: UIStepper!
    @IBOutlet weak var derseKatılımStepper: UIStepper!
    @IBOutlet weak var projelerStepper: UIStepper!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dersAdıStackView: UIStackView!
    @IBOutlet weak var haftalıkDersSaatiStackView: UIStackView!
    @IBOutlet weak var dersAdıTextField: UITextField!
    @IBOutlet weak var birinciSınavStackView: UIStackView!
    @IBOutlet weak var ikinciSınavStackView: UIStackView!
    @IBOutlet weak var üçüncüSınavStackView: UIStackView!
    @IBOutlet weak var birinciSınavTextField: UITextField!
    @IBOutlet weak var ikinciSınavTextField: UITextField!
    @IBOutlet weak var üçüncüSınavTextField: UITextField!
    @IBOutlet weak var birinciDerseKatılımStackView: UIStackView!
    @IBOutlet weak var ikinciDerseKatılımStackView: UIStackView!
    @IBOutlet weak var üçüncüDerseKatılımStackView: UIStackView!
    @IBOutlet weak var birinciDerseKatılımTextField: UITextField!
    @IBOutlet weak var ikinciDerseKatılımTextField: UITextField!
    @IBOutlet weak var üçüncüDerseKatılımTextField: UITextField!
    @IBOutlet weak var birinciProjeStackView: UIStackView!
    @IBOutlet weak var ikinciProjeStackView: UIStackView!
    @IBOutlet weak var birinciProjeTextField: UITextField!
    @IBOutlet weak var ikinciProjeTextField: UITextField!
    
    var derseKatılımEski: Int = 2
    var projeEski: Int = 0
    var sınavEski: Int = 2
    
    @objc func keyboardAppeared(notification: Notification) {
        scrollView.contentInset.bottom = ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height)! + 10
    }
    
    @objc func keyboardHidden() {
        scrollView.contentInset.bottom = 0
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [haftalıkDersStepper, projelerStepper, sınavlarStepper, derseKatılımStepper].forEach { (stepper) in
            stepperAyarla(stepper: stepper!)
            if stepper != haftalıkDersStepper {stepper?.isHidden = true}
        }
        haftalıkDersStepper.layer.cornerRadius = 8.0
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardAppeared), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHidden), name: UIResponder.keyboardDidHideNotification, object: nil)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        if kullanıcı.sınıf <= 8 {
            sınavSileBasıldı("")
        }
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    func sınavSileBasıldı(_ sender: Any) {
        
        if üçüncüSınavStackView.isHidden {
            if ikinciSınavStackView.isHidden {
                birinciSınavStackView.isHidden = true
                birinciSınavTextField.text = ""
                
            } else {
                ikinciSınavStackView.isHidden = true
                ikinciSınavTextField.text = ""
            }
        } else {
            üçüncüSınavStackView.isHidden = true
            üçüncüSınavTextField.text = ""
        }
    }
    func sınavEkleyeBasıldı(_ sender: Any) {
        
        if birinciSınavStackView.isHidden {
            birinciSınavStackView.isHidden = false
        } else {
            if ikinciSınavStackView.isHidden {
                ikinciSınavStackView.isHidden = false
            } else {
                üçüncüSınavStackView.isHidden = false
                
            }
        }
    }
    func derseKatılımSileBasıldı(_ sender: Any) {
        
        if üçüncüDerseKatılımStackView.isHidden {
            if ikinciDerseKatılımStackView.isHidden {
                birinciDerseKatılımStackView.isHidden = true
                birinciDerseKatılımTextField.text = ""
                
            } else {
                ikinciDerseKatılımStackView.isHidden = true
                ikinciDerseKatılımTextField.text = ""
            }
        } else {
            üçüncüDerseKatılımStackView.isHidden = true
            üçüncüDerseKatılımTextField.text = ""
        }
    }
    func derseKatılımEkleyeBasıldı(_ sender: Any) {
        
        if birinciDerseKatılımStackView.isHidden {
            birinciDerseKatılımStackView.isHidden = false
        } else {
            if ikinciDerseKatılımStackView.isHidden {
                ikinciDerseKatılımStackView.isHidden = false
            } else {
                üçüncüDerseKatılımStackView.isHidden = false
                
            }
        }
    }
    func projeSileBasıldı(_ sender: Any) {
        
        if ikinciProjeStackView.isHidden {
            birinciProjeStackView.isHidden = true
            birinciProjeTextField.text = ""
            
        } else {
            ikinciProjeStackView.isHidden = true
            ikinciProjeTextField.text = ""
        }
    }
    func projeEkleyeBasıldı(_ sender: Any) {
        
        if birinciProjeStackView.isHidden {
            birinciProjeStackView.isHidden = false
        } else {
            ikinciProjeStackView.isHidden = false
            
        }
    }
    @IBAction func stepperDeğişti(_ sender: UIStepper) {
        
        switch sender {
        case sınavlarStepper:
            if sınavEski < Int(sınavlarStepper.value) {
                sınavEkleyeBasıldı(self)
            }
            if sınavEski > Int(sınavlarStepper.value) {
                sınavSileBasıldı(self)
            }
            sınavEski = Int(sender.value)
        case projelerStepper:
            if projeEski < Int(projelerStepper.value) {
                projeEkleyeBasıldı(self)
            }
            if projeEski > Int(projelerStepper.value) {
                projeSileBasıldı(self)
            }
            projeEski = Int(sender.value)
        case derseKatılımStepper:
            if derseKatılımEski < Int(derseKatılımStepper.value) {
                derseKatılımEkleyeBasıldı(self)
            }
            if derseKatılımEski > Int(derseKatılımStepper.value) {
                derseKatılımSileBasıldı(self)
            }
            derseKatılımEski = Int(sender.value)
        case haftalıkDersStepper:
            if Int(haftalıkDersStepper.value) == 38 {
                reklamYok = true
            }
            haftalıkDersSaati.text = "\(Int(haftalıkDersStepper.value))"
        default:
            return ()
        }
    }
    
    @IBAction func ekleyeBasıldı(_ sender: UIButton) {
        guard let dersAdı = dersAdıTextField.text, dersAdı != "" else {
            dersAdıYok()
            return
        }
        let aynıDers = kullanıcı.dersler.contains { (ders) -> Bool in
            ders.dersAdı == dersAdı
        }
        guard !aynıDers else {
            aynıDersUyarısı(ders: dersAdı)
            return
        }
        guard let haftalıkDersSaati = haftalıkDersSaati.text, haftalıkDersSaati != "" else {
            haftalıkDersSaatiYok(ders: dersAdı)
            return
        }
        guard Int(haftalıkDersSaati) != nil else {
            haftalıkDersSaatiSayıDeğil(ders: dersAdı)
            return
        }
        guard Int(haftalıkDersSaati) ?? 0 > 0 else {
            haftalıkDersSaatiPozitifDeğil(ders: dersAdı)
            return
        }
        guard !uyarıYazılarınıVarsaGöster(.Sınav) else {
            return
        }
        guard !uyarıYazılarınıVarsaGöster(.DersİçiKatılım) else {
            return
        }
        guard !uyarıYazılarınıVarsaGöster(.Proje) else {
            return
        }

        var notlar: [Not] = []

        var textFields = [birinciSınavTextField, ikinciSınavTextField, üçüncüSınavTextField, birinciProjeTextField, ikinciProjeTextField, birinciDerseKatılımTextField, ikinciDerseKatılımTextField, üçüncüDerseKatılımTextField]
        textFields.removeAll { (textF) -> Bool in
            return textF?.text == ""
        }
        var sınavNo = 1
        var derseKatılımNo = 1
        var projeNo = 1
        for textField in textFields {
            let çeşit = textFieldAracı(textField!)
            var numara = 0
            switch çeşit {
            case .Sınav:
                numara = sınavNo
                sınavNo += 1
            case .DersİçiKatılım:
                numara = derseKatılımNo
                derseKatılımNo += 1
            case .Proje:
                numara = projeNo
                projeNo += 1
            }
            notlar.append(Not(puan: Double(textField!.text!)!, çeşit: çeşit, numara: numara))
            

        }

        kullanıcı.dersler.append(Ders(haftalikSaat: Int(haftalıkDersSaati)!, notlar: notlar, dersAdı: dersAdı))
        kullanıcı.kaydet()

        performSegue(withIdentifier: "UnwindToNotlar", sender: nil)
         
    }
    
//    MARK: DERSLER
    
    func dersAdıYok() {
        alert(başlık: "Ders Adı", mesaj: "Lütfen eklemek istediğiniz dersin adını girin.")
    }
    
    func haftalıkDersSaatiYok(ders: String) {
        alert(başlık: "Haftalık Ders Saati", mesaj: "Lütfen \(ders) dersi için haftalık ders saatini girin.")
    }
    
    func haftalıkDersSaatiSayıDeğil(ders: String) {
        alert(başlık: "Haftalık Ders Saati", mesaj: "Lütfen \(ders) dersinin haftalık ders saati olarak bir tamsayı girin.")
    }
    
    func haftalıkDersSaatiPozitifDeğil(ders: String) {
        alert(başlık: "Haftalık Ders Saati", mesaj: "Lütfen \(ders) dersinin haftalık ders saati olarak sıfırdan büyük bir sayı girin.")
    }
    
    func aynıDersUyarısı(ders: String) {
        alert(başlık: "Aynı Ders", mesaj: "\(ders) dersi için notlarınıza ulaşmak ve notlarınızı düzenlemek için Notlarım menüsünden \(ders) dersini seçebilirsin.")
    }
    
    func textFieldAracı(_ textField: UITextField) -> NotAracı {
        switch textField {
        case birinciSınavTextField, ikinciSınavTextField, üçüncüSınavTextField:
            return .Sınav
        case birinciDerseKatılımTextField, ikinciDerseKatılımTextField, üçüncüDerseKatılımTextField:
            return .DersİçiKatılım
        case birinciProjeTextField, ikinciProjeTextField:
            return .Proje
        default:
            return .Sınav
        }
    }
    
    func uyarıYazılarınıVarsaGöster(_ notAracı: NotAracı) -> Bool {
        
        var textFieldlar: [UITextField] = []
        var isim = ""
        switch notAracı {
        case .DersİçiKatılım:
            textFieldlar = [birinciDerseKatılımTextField, ikinciDerseKatılımTextField, üçüncüDerseKatılımTextField]
            isim = "Derse Katılım"
        case .Sınav:
            textFieldlar = [birinciSınavTextField, ikinciSınavTextField, üçüncüSınavTextField]
            isim = "Sınav"
            
        case .Proje:
            textFieldlar = [birinciProjeTextField, ikinciProjeTextField]
            isim = "Proje"
        }
        var uygunOlmayanSınavlar: [String] = []
        for sınavTextField in textFieldlar {
            if let sınavNotu = sınavTextField.text, sınavNotu != "" {
                if let sayıSınavNotu = Double(sınavNotu), sayıSınavNotu <= 100 {
//                    Sayı uygun
                } else {
                    uygunOlmayanSınavlar.append(textFieldAdı(sınavTextField))
                }
                
            }
        }
        var yazı = "Lütfen "
        var sıra = 0
        for sınav in uygunOlmayanSınavlar {
            sıra += 1
            if sıra != uygunOlmayanSınavlar.count {
                if sıra + 1 == uygunOlmayanSınavlar.count {
                    yazı += sınav + " ve "
                } else {
                    yazı += sınav + ", "
                }
                
            } else {
                if sıra == 1 {
                    yazı += sınav + " notu olarak 100 veya daha küçük bir sayı girin."
                } else {
                    yazı += sınav + " notları olarak 100 veya daha küçük bir sayı girin."
                }
                
            }
            
        }
        guard yazı == "Lütfen " else {
            alert(başlık: "\(isim) Notları", mesaj: yazı)
            return true
        }
        return false
    }
    
    func textFieldAdı(_ textField: UITextField) -> String {
        
        switch textField {
        case birinciSınavTextField:
            return "1. sınav"
        case ikinciSınavTextField:
            return "2. sınav"
        case üçüncüSınavTextField:
            return "3. sınav"
        case birinciDerseKatılımTextField:
            return "1. derse katılım"
        case ikinciDerseKatılımTextField:
            return "2. derse katılım"
        case üçüncüDerseKatılımTextField:
            return "3. derse katılım"
        case birinciProjeTextField:
            return "1. proje"
        case ikinciProjeTextField:
            return "2. proje"
        default:
            return "1. sınav"
        }
    }
    
    func stepperAyarla(stepper: UIStepper) {
        if #available(iOS 13.0, *) {
            stepper.setDecrementImage(stepper.decrementImage(for: .normal)?.withTintColor(.white), for: .normal)
            stepper.setIncrementImage(stepper.incrementImage(for: .normal)?.withTintColor(.white), for: .normal)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NotlarimVC, segue.identifier == "UnwindToNotlar" {
            destination.tableView.reloadData()
        }
    }
}
