//
//  SinifGirVC.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 15.02.2021.
//

import UIKit

class SinifGirVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var sınıfLabel: UILabel!
    @IBOutlet weak var sınıfTextField: UITextField!
    var picker: UIPickerView!
    
    @objc func viewTapped() {
        sınıfTextField.resignFirstResponder()
    }
    @objc func resetText() {
        sınıfTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        
        sınıfTextField.inputView = picker
        sınıfTextField.tintColor = .clear
        sınıfTextField.addTarget(self, action: #selector(resetText), for: .editingChanged)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        addN("PickerRemoved", to: self, action: #selector(viewTapped))
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 28
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let dersler = ["1. Sınıf", "2. Sınıf", "3. Sınıf", "4. Sınıf", "5. Sınıf", "6. Sınıf", "7. Sınıf", "8. Sınıf", "Anadolu Lisesi - Hazırlık", "Anadolu Lisesi - 9. Sınıf", "Anadolu Lisesi - 10. Sınıf", "Anadolu Lisesi - 11. Sınıf", "Anadolu Lisesi - 12. Sınıf", "Fen Lisesi - 9. Sınıf", "Fen Lisesi - 10. Sınıf", "Fen Lisesi - 11. Sınıf", "Fen Lisesi - 12. Sınıf", "Sosyal Bilimler Lisesi - Hazırlık", "Sosyal Bilimler Lisesi - 9. Sınıf", "Sosyal Bilimler Lisesi - 10. Sınıf", "Sosyal Bilimler Lisesi - 11. Sınıf", "Sosyal Bilimler Lisesi - 12. Sınıf", "Spor Lisesi - 9. Sınıf", "Spor Lisesi - 10. Sınıf", "Spor Lisesi - 11. Sınıf", "Spor Lisesi - 12. Sınıf", "Robert - 12. Sınıf", "Robert - A"]
        
        sınıfLabel.text = dersler[row]
        
        if dersler[row].contains("Robert") {
            yazıSonu = String(dersler[row].suffix(dersler[row].count - 9))
        } else {
            yazıSonu = ""
        }
        
        if dersler[row].contains("Hazırlık") {
            sınıf = 8.5
        } else if dersler[row].contains("12") {
            sınıf = 12
        } else if dersler[row].contains("11") {
            sınıf = 11
        } else if dersler[row].contains("10") {
            sınıf = 10
        } else if dersler[row].contains("9") {
            sınıf = 9
        } else {
            if dersler[row].contains("Sınıf") {
                sınıf = Double(dersler[row].prefix(dersler[row].count - 7))!
            } else {
                sınıf = 12
            }
            
        }
        if dersler[row].contains("Anadolu") {
            liseTürü = "Anadolu Lisesi"
        } else if dersler[row].contains("Fen") {
            liseTürü = "Fen Lisesi"
        } else if dersler[row].contains("Sosyal") {
            liseTürü = "Sosyal Bilimler Lisesi"
        } else if dersler[row].contains("Spor") {
            liseTürü = "Spor Lisesi"
        } else if dersler[row].contains("Robert") {
            liseTürü = "Robert"
        }
        
        
        if sınıf > 4, sınıf <= 8 {
            seçmeliDersVar = true
        } else {
            seçmeliDersVar = false
        }
        sınıfDeğişti = true
        postN("SınıfSeçildi")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeN("PickerRemoved", of: self)
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let dersler = ["1. Sınıf", "2. Sınıf", "3. Sınıf", "4. Sınıf", "5. Sınıf", "6. Sınıf", "7. Sınıf", "8. Sınıf", "Anadolu Lisesi - Hazırlık", "Anadolu Lisesi - 9. Sınıf", "Anadolu Lisesi - 10. Sınıf", "Anadolu Lisesi - 11. Sınıf", "Anadolu Lisesi - 12. Sınıf", "Fen Lisesi - 9. Sınıf", "Fen Lisesi - 10. Sınıf", "Fen Lisesi - 11. Sınıf", "Fen Lisesi - 12. Sınıf", "Sosyal Bilimler Lisesi - Hazırlık", "Sosyal Bilimler Lisesi - 9. Sınıf", "Sosyal Bilimler Lisesi - 10. Sınıf", "Sosyal Bilimler Lisesi - 11. Sınıf", "Sosyal Bilimler Lisesi - 12. Sınıf", "Spor Lisesi - 9. Sınıf", "Spor Lisesi - 10. Sınıf", "Spor Lisesi - 11. Sınıf", "Spor Lisesi - 12. Sınıf", "Robert - 12. Sınıf", "Robert - A"]
        return dersler[row]
    }

}
