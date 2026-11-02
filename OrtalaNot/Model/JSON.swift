//
//  JSON.swift
//  OrtalaNot
//
//  Created by CAN AKGUN on 17.11.2021.
//

import Foundation

func JSON(_ data: Any) -> Data? {
    
    return try? JSONSerialization.data(withJSONObject: data)
    
}
