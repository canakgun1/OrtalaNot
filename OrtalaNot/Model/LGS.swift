//
//  LGS.swift
//  OrtalaNot
//
//  Created by CAN AKGUN on 7.04.2021.
//

import Foundation

struct LGS {

    var td: Int
    var ty: Int
    var md: Int
    var my: Int
    var fd: Int
    var fy: Int
    var id: Int
    var iy: Int
    var dd: Int
    var dy: Int
    var yd: Int
    var yy: Int
    
    var puan: Double {
        
        let TÜR_SORU_PUANI = 4.18
        let MAT_SORU_PUANI = 4.98
        let FEN_SORU_PUANI = 3.83
        let İNK_SORU_PUANI = 1.68
        let DİN_SORU_PUANI = 1.93
        let İNG_SORU_PUANI = 1.61
        
        let TÜR_YANLIŞLARDAN_KAYIP = TÜR_SORU_PUANI * Double(ty) * 4 / 3
        let MAT_YANLIŞLARDAN_KAYIP = MAT_SORU_PUANI * Double(my) * 4 / 3
        let FEN_YANLIŞLARDAN_KAYIP = FEN_SORU_PUANI * Double(fy) * 4 / 3
        let İNK_YANLIŞLARDAN_KAYIP = İNK_SORU_PUANI * Double(iy) * 4 / 3
        let DİN_YANLIŞLARDAN_KAYIP = DİN_SORU_PUANI * Double(dy) * 4 / 3
        let İNG_YANLIŞLARDAN_KAYIP = İNG_SORU_PUANI * Double(yy) * 4 / 3
        
        let tb = 20 - td - ty
        let mb = 20 - md - my
        let fb = 20 - fd - fy
        let db = 10 - dd - dy
        let sb = 10 - id - iy
        let yb = 10 - yd - yy
        
        let TÜR_BOŞLARDAN_KAYIP = TÜR_SORU_PUANI * Double(tb)
        let MAT_BOŞLARDAN_KAYIP = MAT_SORU_PUANI * Double(mb)
        let FEN_BOŞLARDAN_KAYIP = FEN_SORU_PUANI * Double(fb)
        let İNK_BOŞLARDAN_KAYIP = İNK_SORU_PUANI * Double(sb)
        let DİN_BOŞLARDAN_KAYIP = DİN_SORU_PUANI * Double(db)
        let İNG_BOŞLARDAN_KAYIP = İNG_SORU_PUANI * Double(yb)
        
        if ty + td + md + my + fd + fy + iy + id + dd + dy + yd + yy == 0 {
            return 200
        }
        if td + md + fd + id + dd + yd == 90 {
            return 500
        }
        if ty + my + fy + iy + dy + yy == 90 {
            return 100
        }
        
        return ((500
                 - TÜR_BOŞLARDAN_KAYIP - TÜR_YANLIŞLARDAN_KAYIP
                 - MAT_BOŞLARDAN_KAYIP - MAT_YANLIŞLARDAN_KAYIP
                 - FEN_BOŞLARDAN_KAYIP - FEN_YANLIŞLARDAN_KAYIP
                 - İNK_BOŞLARDAN_KAYIP - İNK_YANLIŞLARDAN_KAYIP
                 - DİN_BOŞLARDAN_KAYIP - DİN_YANLIŞLARDAN_KAYIP
                 - İNG_BOŞLARDAN_KAYIP - İNG_YANLIŞLARDAN_KAYIP
                
                ) * 1000).rounded() / 1000

    }

}
