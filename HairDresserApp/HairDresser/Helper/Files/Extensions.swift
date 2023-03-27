//
//  Extensions.swift
//  HairDresser
//
//  Created by Lakshmi Sowjanya on 11/03/23.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Double {
    
    func convertToString(decimal: Int = 2) -> String {
        let string = String(format: "%.2f", self)
        return string
    }
    
}
