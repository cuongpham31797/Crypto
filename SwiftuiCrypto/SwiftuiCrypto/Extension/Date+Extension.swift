//
//  Date+Extension.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 30/05/2023.
//

import Foundation

extension Date {
    // "2021-11-10T14:24:11.849Z"
    init(coinGeckoString: String) {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var showFormatter: DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return showFormatter.string(from: self)
    }
}
