//
//  GirisPVC.swift
//  NotUygulamasiGecici
//
//  Created by CAN AKGUN on 15.02.2021.
//

import UIKit

class GirisPVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    let vc = UIStoryboard(name: "Giris", bundle: nil).instantiateViewController(withIdentifier: "GirişVC")
    let vc2 = UIStoryboard(name: "Giris", bundle: nil).instantiateViewController(withIdentifier: "SeçmeliDersVC")
    
    var sayfa = 0

    @objc func ileri() {
        sayfa += 1
        setViewControllers([vc2], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func geri() {
        sayfa -= 1
        setViewControllers([vc], direction: .reverse, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        
        addN("Girişİleri", to: self, action: #selector(ileri))
        addN("GirişGeri", to: self, action: #selector(geri))
        for view in view.subviews {

            if view is UIScrollView {

                (view as! UIScrollView).isScrollEnabled = false
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return UIViewController()
    }
 
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return UIViewController()
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return 2
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return sayfa
//    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeN("GirişGeri", of: self)
        removeN("Girişİleri", of: self)
    }
}

class GirisPVCSuper: UIViewController {
    
    @IBOutlet weak var geriDüğmesi: UIButton!
    @IBOutlet weak var ileriDüğmesi: UIButton!
    @IBOutlet weak var seçmeliDersLabel: UILabel!
    @objc func viewTapped() {
       
        postN("PickerRemoved")
    }
    
    @objc func dismissPVC() {
        postN("DersleriTekrarYükle")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func seçmeliDersLabelGöster() {
        seçmeliDersLabel.isHidden = false
    }
    
    @objc func seçmeliDersLabelSakla() {
        seçmeliDersLabel.isHidden = true
    }
    
    @objc func sınıfSeçildi() {
        ileriDüğmesi.isEnabled = true
        if seçmeliDersVar {
            self.ileriDüğmesi.setImage(UIImage(named: "rightarrow"), for: .normal)
            self.ileriDüğmesi.setTitle("", for: .normal)
        } else {
            self.ileriDüğmesi.setImage(nil, for: .normal)
            self.ileriDüğmesi.setTitle("Bitti", for: .normal)
        }
    }
    
    func ilkokulVeyaLiseBitti() {
        if !sınıfDeğişti {
            let controller = UIAlertController(title: "1. Sınıf", message: "Sınıf seviyen olarak 1. sınıfı seçmek istediğine emin misin?", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Vazgeç", style: .cancel, handler: nil))
            controller.addAction(UIAlertAction(title: "Evet", style: .default, handler: { (alert) in
                kullanıcı = Kullanıcı(sınıf: sınıf, dersler: bütünDersler["\(Int(sınıf)). Sınıf"]!)
                kullanıcı.kaydet()
                postN("DismissGirisPVC")
            }))
            present(controller, animated: true, completion: nil)
            return
        }
        if sınıf == 8.5 {
            let ders = lise[liseTürü]!["Hazırlık"]
            kullanıcı = Kullanıcı(sınıf: sınıf, dersler: ders!)
        }
        else if sınıf > 4 {
            var ders: [Ders]?
            if liseTürü == "Robert" {
                ders = lise[liseTürü]![yazıSonu]
            } else {
                ders = lise[liseTürü]!["\(Int(sınıf)). Sınıf"]
            }

            kullanıcı = Kullanıcı(sınıf: sınıf, dersler: ders!)
        } else {
            kullanıcı = Kullanıcı(sınıf: sınıf, dersler: bütünDersler["\(Int(sınıf)). Sınıf"]!)
        }
        kullanıcı.kaydet()
        postN("DismissGirisPVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        seçmeliDersLabel.alpha = 0.0
        geriDüğmesi.isHidden = true
        addN("DismissGirisPVC", to: self, action: #selector(dismissPVC))
        addN("SınıfSeçildi", to: self, action: #selector(sınıfSeçildi))
        self.ileriDüğmesi.setImage(nil, for: .normal)
        self.ileriDüğmesi.setTitle("Bitti", for: .normal)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeN("DismissGirisPVC", of: self)
        removeN("SınıfSeçildi", of: self)
    }
    @IBAction func geriDüğmesineBasıldı(_ sender: UIButton) {
        postN("GirişGeri")
        
        if şuAnkiPageVC == 2 {
            UIView.animate(withDuration: 0.3) {
                self.seçmeliDersLabel.alpha = 0.0
                self.ileriDüğmesi.setImage(UIImage(named: "rightarrow"), for: .normal)
                self.ileriDüğmesi.setTitle("", for: .normal)
            }
            geriDüğmesi.isHidden = true
        }
        şuAnkiPageVC -= 1
    }
    @IBAction func ileriDüğmesineBasıldı(_ sender: UIButton) {
        
        
        
        if self.ileriDüğmesi.title(for: .normal)! == "Bitti" {
            if şuAnkiPageVC == 1 {
                ilkokulVeyaLiseBitti()
                return
            }
            postN("SeçmeliBitti")
            return
        }
        geriDüğmesi.isHidden = false
        if şuAnkiPageVC == 1 {
            UIView.animate(withDuration: 0.3) {
                self.seçmeliDersLabel.alpha = 1.0
                self.ileriDüğmesi.setImage(nil, for: .normal)
                self.ileriDüğmesi.setTitle("Bitti", for: .normal)
            }
            postN("Girişİleri")
            
            seçmeliDersLabel.isHidden = false
        }
        
        şuAnkiPageVC += 1
        
        
    }
}

var şuAnkiPageVC = 1
var seçmeliDersVar = false
var sınıf = 1.0
var yazıSonu = ""
var sınıfDeğişti = false
var liseTürü = ""
