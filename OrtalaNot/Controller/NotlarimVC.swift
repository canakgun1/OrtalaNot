//
//  ViewController.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 9.02.2021.
//

import UIKit
import StoreKit
import Firebase
import GoogleMobileAds

class NotlarimVC: UIViewController, UITableViewDelegate, UITableViewDataSource, BannerViewDelegate {
    
    var notSayisi: Int!
    var seçilenDers: Int!
    
    var interstitial: InterstitialAd?
    var bannerView: BannerView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ortalamaHesaplaButton: UIButton!
    @IBOutlet weak var dersEkleButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(kullanıcı.dersler)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.view.backgroundColor = #colorLiteral(red: 0, green: 0.517336607, blue: 0.8884229064, alpha: 1)
            navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0.517336607, blue: 0.8884229064, alpha: 1)
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)]
        } else {
            // Fallback on earlier versions
        }
        if kullanıcı.sınıf == 0 || kullanıcı.dersler.isEmpty {
            self.giriş()
            
        } else {
            ortalamaHesaplaButton.isEnabled = true
            dersEkleButton.isEnabled = true
            addN("AdYüklendi", to: self, action: #selector(ilkReklamGöster))
        }
        
        addN("DersleriTekrarYükle", to: self, action: #selector(tableViewReload))
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.517336607, blue: 0.8884229064, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 20)!, NSAttributedString.Key.foregroundColor : UIColor.white]
//        loadAd()
        bannerView = BannerView(adSize: AdSizeBanner)

//        addBannerViewToView(bannerView)
        bannerView.adUnitID = NOTLARIM_BANNER_ID
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(Request())
        // Do any additional setup after loading the view.
    }
    
    @objc func ilkReklamGöster() {
        reklamTipi = "İlk"
        removeN("AdYüklendi", of: self)
        presentAd()
    }
    
    func bannerViewDidReceiveAd(_ bannerView: BannerView) {
        addBannerViewToView(bannerView)
    }
    
    func addBannerViewToView(_ bannerView: BannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: view.safeAreaLayoutGuide,
                              attribute: .bottom,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
    
    @objc func tableViewReload() {
        ortalamaHesaplaButton.isEnabled = true
        dersEkleButton.isEnabled = true
        tableView.reloadData()
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kullanıcı.dersler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        kullanıcı.kaydet()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NotCell", for: indexPath) as? NotCell {
            cell.selectionStyle = .none
            cell.dersLabel.text = kullanıcı.dersler[indexPath.row].dersAdı
            cell.dersSayısıLabel.text = "\(kullanıcı.dersler[indexPath.row].haftalikSaat) ders / hafta"
            let ortalama = kullanıcı.dersler[indexPath.row].ortalama
            cell.notLabel.text = kullanıcı.dersler[indexPath.row].notlar.isEmpty ? "Not Yok" : "\(ortalama)"
            if let sayı = Double(cell.notLabel.text!) {
                if sayı < 50.00 {
                    cell.notLabel.textColor = .systemRed
                } else {
                    cell.notLabel.textColor = .black
                }
            }
            
            var sınavSayısı = 0
            var dersİçiKatılımSayısı = 0
            var projeSayısı = 0
            for not in kullanıcı.dersler[indexPath.row].notlar {
                switch not.çeşit {
                case .DersİçiKatılım:
                    
                    dersİçiKatılımSayısı += 1
                case .Sınav:
                    
                    sınavSayısı += 1
                case .Proje:
                    
                    projeSayısı += 1
                }
            }
            var projeVar = projeSayısı > 0
            var dersİçiKatılımVar = dersİçiKatılımSayısı > 0
            var sınavVar = sınavSayısı > 0
            let sınavYazısı = "\(sınavVar ? "\(sınavSayısı) sınav" : "")"
            let projeYazısı = "\(projeVar ? "\(projeSayısı) proje" : "")"
            let dersİçiKatılımYazısı = "\(dersİçiKatılımVar ? "\(dersİçiKatılımSayısı) derse katılım" : "")"
            var yazı = ""
            if dersİçiKatılımVar, projeVar, sınavVar {
                yazı = "\(sınavYazısı), \(projeYazısı), \(dersİçiKatılımYazısı)"
            } else if dersİçiKatılımVar, projeVar {
                yazı = "\(projeYazısı), \(dersİçiKatılımYazısı)"
            } else if dersİçiKatılımVar, sınavVar {
                yazı = "\(sınavYazısı), \(dersİçiKatılımYazısı)"
            } else if dersİçiKatılımVar {
                yazı = "\(dersİçiKatılımYazısı)"
            } else if sınavVar, projeVar {
                yazı = "\(sınavYazısı), \(projeYazısı)"
            } else if sınavVar {
                yazı = "\(sınavYazısı)"
            } else if projeVar {
                yazı = "\(projeYazısı)"
            }
            cell.sınavlarLabel.text = yazı
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        seçilenDers = indexPath.row
        performSegue(withIdentifier: "DerseBasıldıSegue", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Sil"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Dersi Sil", message: "\(kullanıcı.dersler[indexPath.row].dersAdı) dersini silmek istediğine emin misin? Bu işlemi geri alamazsın.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Vazgeç", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { (_) in
                kullanıcı.dersler.remove(at: indexPath.row)
                kullanıcı.kaydet()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func giriş() {
        ortalamaHesaplaButton.isEnabled = false
        dersEkleButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = UIStoryboard(name: "Giris", bundle: nil).instantiateViewController(withIdentifier: "GirisPVCSuperID")
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
        
    }

    @IBAction func ortalamaHesaplayaBasıldı(_ sender: UIButton) {

        if kullanıcı.dersler.isEmpty {
            alert(başlık: "Ders Yok", mesaj: "Ortalamanı hesaplamak için lütfen sağ üst köşedeki artı işaretine basarak derslerini ekle.")
            return
        }
        else if kullanıcı.dersler.filter({!$0.notlar.isEmpty}).isEmpty {
            alert(başlık: "Not Yok", mesaj: "Ortalamanı hesaplamak için lütfen derslerinin üzerine tıklayıp notlarını ekle.")
            return
        }
        
        ortalamayaBasıldı += 1
        print("Ort-\(ortalamayaBasıldı)")
        if ortalamaReklamÇıkmalı {
            reklamTipi = "Ortalama"
            presentAd()
        } else {
            performSegue(withIdentifier: "ortalamaVCSegue", sender: self)
        }
        
        
    }
    
    @IBAction func dersEkleButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "DersEkleSegue", sender: nil)
    }
    
    
    @IBAction func unwindToNotlarim(segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        removeN("DersleriTekrarYükle", of: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        if interstitial == nil {
            loadAd()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DersVC, segue.identifier == "DerseBasıldıSegue" {
            destination.dersAdı = kullanıcı.dersler[seçilenDers].dersAdı
        } else if let destination = segue.destination as? OrtalamaGosterVC {
            destination.notlarVC = self
        }
        else if let destination = segue.destination as? TakdirVC {
            destination.teşekkür = teşekkür
        }
        
    }
    
}

var reklamYok = false
