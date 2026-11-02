//
//  LGSOrtalamaVC.swift
//  OrtalaNot
//
//  Created by CAN AKGUN on 11.04.2021.
//

import UIKit

class LGSOrtalamaVC: UIViewController {

    @IBOutlet weak var puan: UILabel!
    @IBOutlet weak var yüzdelikDilim: UILabel!
    @objc func tapped() {
        dismiss(animated: true, completion: nil)
    }
    let yüzdeler = [99.74, 99.7, 99.7, 99.7, 99.7, 99.37, 98.77, 97.41, 94.99, 91.51, 87.15, 82.44, 77.55, 77.55, 67.9, 67.9, 58.46, 53.87, 49.41, 87.15, 40.87, 36.86, 33.06, 29.48, 26.11, 22.98, 20.1, 17.43, 15.04, 12.82, 10.82, 9.03, 7.33, 5.78, 4.35, 3.09, 2.0, 1.05, 0.33, 0.01]
    var lgs: LGS!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
        puan.text = "\(lgs.puan)"
        
        if lgs.puan == 500 {
            yüzdelikDilim.text = "%0.01"
        } else if lgs.puan > 490 {
            yüzdelikDilim.text = "%0.33 - %0.01"
        } else if lgs.puan < 130 {
            yüzdelikDilim.text = "%99"
        }
        else {
            let a1 = yüzdeler[Int(((lgs.puan - 100) / 10 - 0.001).rounded(.down)) - 1]
            let a2 = yüzdeler[(Int(((lgs.puan - 100) / 10 - 0.001).rounded(.down)))]
            yüzdelikDilim.text = "%\(a2) - %\(a1)"
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    

}
