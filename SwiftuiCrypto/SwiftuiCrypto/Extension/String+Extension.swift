//
//  String+Extension.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 01/06/2023.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>",
                                         with: "",
                                         options: .regularExpression,
                                         range: nil)
    }
}
