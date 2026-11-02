//
//  SecmeliDersVC.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 17.02.2021.
//

import UIKit

class SecmeliDersVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var ders1TextField: UITextField!
    @IBOutlet weak var ders2TextField: UITextField!
    @IBOutlet weak var ders3TextField: UITextField!
    @IBOutlet weak var ders1Label: UILabel!
    @IBOutlet weak var ders2Label: UILabel!
    @IBOutlet weak var ders3Label: UILabel!
    var picker1: UIPickerView!
    var picker2: UIPickerView!
    var picker3: UIPickerView!
    
    var dersler1 = seçmeliDersler {
        didSet {
            seçmeliDersleriAyarla(&dersler1)
        }
    }
    var dersler2 = seçmeliDersler {
        didSet {
            seçmeliDersleriAyarla(&dersler2)
        }
    }
    var dersler3 = seçmeliDersler {
        didSet {
            seçmeliDersleriAyarla(&dersler3)
        }
    }

    var eskiDers1 = ""
    var eskiDers2 = ""
    var eskiDers3 = ""
    
    
    @objc func viewTapped() {
        [ders1TextField, ders2TextField, ders3TextField].forEach { (field) in
            field?.resignFirstResponder()
        }
    }
    
    @objc func resetText1() {
        ders1TextField.text = ""
    }
    
    @objc func resetText2() {
        ders2TextField.text = ""
    }
    
    @objc func resetText3() {
        ders3TextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        picker1 = UIPickerView()
        picker2 = UIPickerView()
        picker3 = UIPickerView()
        [picker1, picker2, picker3].forEach { (picker) in
            picker?.delegate = self
            picker?.dataSource = self
        }
        
        ders1TextField.inputView = picker1
        ders2TextField.inputView = picker2
        ders3TextField.inputView = picker3
        
        [ders1TextField, ders2TextField, ders3TextField].forEach { (field) in
            field?.tintColor = .clear
        }
        
        ders1TextField.addTarget(self, action: #selector(resetText1), for: .editingChanged)
        ders2TextField.addTarget(self, action: #selector(resetText2), for: .editingChanged)
        ders3TextField.addTarget(self, action: #selector(resetText3), for: .editingChanged)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        addN("PickerRemoved", to: self, action: #selector(viewTapped))
        addN("SeçmeliBitti", to: self, action: #selector(seçmeliBitti))
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func seçmeliDersleriAyarla(_ dersler: inout [String]) {
        
        let tr = Locale(identifier: "tr")
        let derslerSorted = dersler.sorted {
            $0.compare($1, locale: tr) == .orderedAscending
        }
        dersler = derslerSorted
        if dersler.contains("Daha Sonra Seç") {
            dersler.removeAll { (ders) -> Bool in
                ders == "Daha Sonra Seç"
            }
        }
        dersler.insert("Daha Sonra Seç", at: 0)
        
    }
    
    func dersSeçildi(label: inout UILabel, dersler: inout [String], silinecekler1: inout [String], silinecekler2: inout [String], eskiDers: inout String, sıra: Int) {
        
        label.text = dersler[sıra]
        silinecekler1.removeAll { (ders) -> Bool in
            ders == dersler[sıra]
        }
        silinecekler2.removeAll { (ders) -> Bool in
            ders == dersler[sıra]
        }
        if eskiDers != "" {
            silinecekler1.append(eskiDers)
            silinecekler2.append(eskiDers)
        }
        eskiDers = dersler[sıra]
        
    }
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case picker1:
            return dersler1.count
        case picker2:
            return dersler2.count
        case picker3:
            return dersler3.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case picker1:
            dersSeçildi(label: &ders1Label, dersler: &dersler1, silinecekler1: &dersler2, silinecekler2: &dersler3, eskiDers: &eskiDers1, sıra: row)
        case picker2:
            dersSeçildi(label: &ders2Label, dersler: &dersler2, silinecekler1: &dersler1, silinecekler2: &dersler3, eskiDers: &eskiDers2, sıra: row)
        case picker3:
            dersSeçildi(label: &ders3Label, dersler: &dersler3, silinecekler1: &dersler1, silinecekler2: &dersler2, eskiDers: &eskiDers3, sıra: row)
        default:
            print("Picker belirsiz")
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addN("PickerRemoved", to: self, action: #selector(viewTapped))
        addN("SeçmeliBitti", to: self, action: #selector(seçmeliBitti))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeN("PickerRemoved", of: self)
        removeN("SeçmeliBitti", of: self)
    }
    
    @objc func seçmeliBitti() {
        
        let seçmeli1 = ders1Label.text!
        let seçmeli2 = ders2Label.text!
        let seçmeli3 = ders3Label.text!
        
        
        var dersler: [String] = []
        for yazı in [seçmeli1, seçmeli2, seçmeli3] {
            if yazı != "Daha Sonra Seç" {
                dersler.append(yazı)
            }
        }
        kullanıcı = Kullanıcı(sınıf: sınıf, dersler: bütünDersler["\(Int(sınıf)). Sınıf"]!)
        dersler.forEach { (ders) in
            kullanıcı.dersler.append(Ders(haftalikSaat: seçmeliDersSaatleri[ders]!, notlar: [], dersAdı: ders))
        }
        kullanıcı.kaydet()
        postN("DismissGirisPVC")
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case picker1:
            return dersler1[row]
        case picker2:
            return dersler2[row]
        case picker3:
            return dersler3[row]
        default:
            return nil
        }
    }
    
    @IBAction func touchPicker1(_ sender: UITextField) {
        picker1.selectRow(dersler1.firstIndex(of: ders1Label.text!)!, inComponent: 0, animated: true)
    }
    
    @IBAction func touchPicker2(_ sender: UITextField) {
        picker2.selectRow(dersler2.firstIndex(of: ders2Label.text!)!, inComponent: 0, animated: true)
    }
    

    @IBAction func touchPicker3(_ sender: UITextField) {
        picker3.selectRow(dersler3.firstIndex(of: ders3Label.text!)!, inComponent: 0, animated: true)
    }
}

let seçmeliDersler = ["Daha Sonra Seç", "Bilim Uygulamaları", "Bilişim Teknolojileri ve Yazılım", "Çevre Eğitimi", "Drama", "Düşünme Eğitimi", "Görsel Sanatlar (Haftada 2)", "Görsel Sanatlar (Haftada 4)", "Halk Kültürü", "Hukuk ve Adalet", "İletişim ve Sunum Becerileri", "Kent Kültürü", "Kur'an-ı Kerim", "Matematik Uygulamaları", "Medya Okuryazarlığı", "Müzik (Haftada 2)", "Müzik (Haftada 4)", "Okuma Becerileri", "Peygamberimizin Hayatı", "Spor ve Fizikî Etkinlikler (Haftada 2)", "Spor ve Fizikî Etkinlikler (Haftada 4)", "Temel Dinî Bilgiler", "Yabancı Dil", "Yaşayan Diller ve Lehçeler", "Yazarlık ve Yazma Becerileri", "Zekâ Oyunları"]
