//
//  TakdirTeşekkürVC.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 17.03.2021.
//

import UIKit

class TakdirVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var takdirSegmented: UISegmentedControl!
    @IBOutlet weak var ortalamalarStackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gerekenOrtalamaLabel: UILabel!
    @IBOutlet weak var seninOrtalamanLabel: UILabel!
    
    var teşekkür: Bool! {
        didSet {
            if isViewLoaded {
                gerekenDeğer = teşekkür ? 70.0 : 85.0
                gerekenOrtalamaLabel.text = "Gereken ortalama: \(gerekenDeğer)"
                tableView.reloadData()
            }
            title = "Nasıl \(teşekkür ? "Teşekkür" : "Takdir") Alırım?"
            
        }
    }
    var gerekenDeğer = 85.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        gerekenDeğer = teşekkür ? 70.0 : 85.0
        gerekenOrtalamaLabel.text = "Gereken ortalama: \(gerekenDeğer)"
        tableView.reloadData()
        takdirSegmented.selectedSegmentIndex = teşekkür ? 1 : 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gerekenOrtalamaLabel.text = "Gereken ortalama: \(teşekkür ? "70.0" : "85.0")"
        seninOrtalamanLabel.text = "Senin ortalaman: \(kullanıcı.ortalama)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kullanıcı.dersler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TakdirCell", for: indexPath) as! TakdirCell
        cell.dersAdıLabel.text = kullanıcı.dersler[indexPath.row].dersAdı
        let ortalama = kullanıcı.dersler[indexPath.row].ortalama
        cell.fotoğraf.isHidden = false
        if kullanıcı.dersler[indexPath.row].notlar.isEmpty {
            cell.fotoğraf.isHidden = true
        } else if ortalama == gerekenDeğer {
            cell.fotoğraf.işaretResmiAyarla(.Yan)
        } else if ortalama > gerekenDeğer {
            cell.fotoğraf.işaretResmiAyarla(.Yukarı)
        } else {
            cell.fotoğraf.işaretResmiAyarla(.Aşağı)
        }
        let yazı = yazıAyarla(ders: kullanıcı.dersler[indexPath.row])
        cell.yazıLabel.text = yazı
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    @IBAction func takdirSegmentedChanged(_ sender: UISegmentedControl) {
        teşekkür = takdirSegmented.selectedSegmentIndex == 1
        tableView.reloadData()
    }
    
    func yazıAyarla(ders: Ders) -> String {
        
        if ders.notlar.isEmpty {
            return "Bu dersten henüz notun yok. Notun olduğu zaman derse ekleyebilirsin."
        }
        
        if kullanıcı.sınıf > 8 {
            let kalanSınavlar = 3 - ders.notlar.filter({$0.çeşit == .Sınav}).count
            let kalanDerseKatılımlar = 3 - ders.notlar.filter({$0.çeşit == .DersİçiKatılım}).count
            
            if ders.ortalama >= gerekenDeğer {
                switch (kalanSınavlar, kalanDerseKatılımlar) {
                case (3,3), (3,2), (3,1), (2,3), (2,2), (2,1), (1,3), (1,2), (1,1):
                    return "Süper! Bu dersten notun yeterli. Kalan \(kalanSınavlar) sınavından ve \(kalanDerseKatılımlar) derse katılım notundan \(Int(gerekenDeğer)) üstü almaya çalış."
                case (0,3), (0,2), (0,1):
                    return "Süper! Bu dersten notun yeterli. Kalan \(kalanDerseKatılımlar) derse katılım notundan \(Int(gerekenDeğer)) üstü almaya çalış."
                case (3,0), (2,0), (1,0):
                    return "Süper! Bu dersten notun yeterli. Kalan \(kalanSınavlar) sınavından \(Int(gerekenDeğer)) üstü almaya çalış."
                case (0,0):
                    return "Süper! Bu dersten notun yeterli."
                default:
                    return ""
                }
            } else {
                
                switch (kalanSınavlar, kalanDerseKatılımlar) {
                case (0,0):
                    return "Maalesef, bu dersten notun yeterli değil."
                default:
                    return "Bu dersten notun gerekenin altında ancak henüz girilmemiş notlarını hâlâ yükseltebilirsin."
                }
                
            }
        } else {
            let kalanSınavlar = 2 - ders.notlar.filter({$0.çeşit == .Sınav}).count
            let kalanDerseKatılımlar = 3 - ders.notlar.filter({$0.çeşit == .DersİçiKatılım}).count
            
            if ders.ortalama >= gerekenDeğer {
                switch (kalanSınavlar, kalanDerseKatılımlar) {
                case (2,3), (2,2), (2,1), (1,3), (1,2), (1,1):
                    return "Süper! Bu dersten notun yeterli. Kalan \(kalanSınavlar) sınavından ve \(kalanDerseKatılımlar) derse katılım notundan \(Int(gerekenDeğer)) üstü almaya çalış."
                case (0,3), (0,2), (0,1):
                    return "Süper! Bu dersten notun yeterli. Kalan \(kalanDerseKatılımlar) derse katılım notundan \(Int(gerekenDeğer)) üstü almaya çalış."
                case (2,0), (1,0):
                    return "Süper! Bu dersten notun yeterli. Kalan \(kalanSınavlar) sınavından \(Int(gerekenDeğer)) üstü almaya çalış."
                case (0,0):
                    return "Süper! Bu dersten notun yeterli."
                default:
                    return ""
                }
            } else {
                
                switch (kalanSınavlar, kalanDerseKatılımlar) {
                case (0,0):
                    return "Maalesef, bu dersten notun yeterli değil."
                default:
                    return "Bu dersten notun gerekenin altında ancak henüz girilmemiş notlarını hâlâ yükseltebilirsin."
                }
                
            }
        }
    }
}
