//
//  UIApplication+Extension.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 25/05/2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEdititng() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }
}
