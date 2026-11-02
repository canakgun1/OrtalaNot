//
//  HesaplaVC.swift
//  OrtalaNot
//
//  Created by CAN AKGUN on 7.04.2021.
//

import UIKit
import GoogleMobileAds

class HesaplaVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var neting: UILabel!
    @IBOutlet weak var neti: UILabel!
    @IBOutlet weak var netd: UILabel!
    @IBOutlet weak var netf: UILabel!
    @IBOutlet weak var netm: UILabel!
    @IBOutlet weak var nett: UILabel!
    @IBOutlet weak var td: UITextField!
    @IBOutlet weak var ty: UITextField!
    @IBOutlet weak var md: UITextField!
    @IBOutlet weak var my: UITextField!
    @IBOutlet weak var fd: UITextField!
    @IBOutlet weak var fy: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var iy: UITextField!
    @IBOutlet weak var dd: UITextField!
    @IBOutlet weak var dy: UITextField!
    @IBOutlet weak var yd: UITextField!
    @IBOutlet weak var yy: UITextField!
    
    var lgs: LGS!
    var interstitial: InterstitialAd?
    
    @objc func tap() {
        [td, ty, md, my, fd, fy, id, iy, dd, dy, yy, yd].forEach { (field) in
            field?.resignFirstResponder()
        }
    }
    
    @objc func keyboardAppeared(notification: Notification) {
        scrollView.contentInset.bottom = ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height)! + 10
    }
    
    @objc func keyboardHidden() {
        scrollView.contentInset.bottom = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 20)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        [td, ty, md, my, fd, fy, dd, dy, id, iy, yd, yy].forEach { (f) in
            f?.delegate = self
        }
        netleriAyarla()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardAppeared), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHidden), name: UIResponder.keyboardDidHideNotification, object: nil)
        loadAd()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tfchange(_ sender: UITextField) {
        let data = [td:20, ty:20, my:20, md:20, fd:20, fy:20, id:10,iy:10,dd:10,dy:10,yy:10,yd:10]
        let tfs = [td:ty, ty:td, my:md, md:my, fd:fy, fy:fd, id:iy, iy:id, yy:yd, yd:yy, dd:dy, dy:dd]
        if sender.text!.allSatisfy({ (a) -> Bool in
            a == " "
        }) {
            sender.text = ""
            netleriAyarla()
            return
        }
        if let sayı = Int(sender.text!) {
            if data[sender]! < sayı {
                sender.text?.removeLast()
            } else if let sayı2 = Int((tfs[sender]!?.text!)!) {
                if sayı + sayı2 > data[sender]! {
                    sender.text?.removeLast()
                }
            }
            
        } else {
            sender.text?.removeLast()
        }
        netleriAyarla()
    }
    
    func netleriAyarla() {
        let türy = Double(td.text!) ?? 0
        let türb = Double(ty.text!) ?? 0
        let türnet = 20 - (türy * 4 / 3) - türb
        
        let maty = Double(md.text!) ?? 0
        let matb = Double(my.text!) ?? 0
        let matnet = 20 - maty * 4 / 3 - matb
        
        let feny = Double(fd.text!) ?? 0
        let fenb = Double(fy.text!) ?? 0
        let fennet = 20 - feny * 4 / 3 - fenb
        
        let inky = Double(id.text!) ?? 0
        let inkb = Double(iy.text!) ?? 0
        let inknet = 10 - inky * 4 / 3 - inkb
        
        let diny = Double(dd.text!) ?? 0
        let dinb = Double(dy.text!) ?? 0
        let dinnet = 10 - diny * 4 / 3 - dinb
        
        let ingy = Double(yd.text!) ?? 0
        let ingb = Double(yy.text!) ?? 0
        let ingnet = 10 - ingy * 4 / 3 - ingb
        
        nett.text = "\(Double(türnet * 100).rounded() / 100)"
        netm.text = "\(Double(matnet * 100).rounded() / 100)"
        netf.text = "\(Double(fennet * 100).rounded() / 100)"
        neti.text = "\(Double(inknet * 100).rounded() / 100)"
        netd.text = "\(Double(dinnet * 100).rounded() / 100)"
        neting.text = "\(Double(ingnet * 100).rounded() / 100)"
        
        
    }

    @IBAction func hesapla(_ sender: UIButton) {
          
        lgsBasıldı += 1
        print("LGS-\(lgsBasıldı)")
        if lgsReklamÇıkmalı {
            presentAd()
        } else {
            puanHesapla()
        }
        
    }
    func eksik() {
        alert(başlık: "Uyarı", mesaj: "Lütfen doğru ve yanlış sayılarını gir.")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LGSOrtalamaVC {
            destination.lgs = lgs
        }
    }
    
    func puanHesapla() {
        let td1 = 20 - (Int(td.text!) ?? 0) - (Int(ty.text!) ?? 0)
        let ty1 = (Int(td.text!) ?? 0)
        let md1 = 20 - (Int(md.text!) ?? 0) - (Int(my.text!) ?? 0)
        let my1 = (Int(md.text!) ?? 0)
        let fd1 = 20 - (Int(fd.text!) ?? 0) - (Int(fy.text!) ?? 0)
        let fy1 = (Int(fd.text!) ?? 0)
        let id1 = 10 - (Int(id.text!) ?? 0) - (Int(iy.text!) ?? 0)
        let iy1 = (Int(id.text!) ?? 0)
        let dd1 = 10 - (Int(dd.text!) ?? 0) - (Int(dy.text!) ?? 0)
        let dy1 = (Int(dd.text!) ?? 0)
        let yd1 = 10 - (Int(yd.text!) ?? 0) - (Int(yy.text!) ?? 0)
        let yy1 = (Int(yd.text!) ?? 0)
        
        lgs = LGS(td: td1, ty: ty1, md: md1, my: my1, fd: fd1, fy: fy1, id: id1, iy: iy1, dd: dd1, dy: dy1, yd: yd1, yy: yy1)
        performSegue(withIdentifier: "LGSSegue", sender: nil)
    }
}
