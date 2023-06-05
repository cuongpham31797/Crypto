//
//  Double+Extension.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 20/05/2023.
//

import Foundation

extension Double {
    
    /// convert a Double to a Currency with 2 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.34
    /// Convert 0.123456 to $0.12
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// convert a Double to a Currency as a String with 2 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.34"
    /// Convert 0.123456 to "$0.12"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number: NSNumber = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// convert a Double to a string representation
    /// ```
    /// Convert 12.3456 to "12.34"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
    /// convert a Double to a String with K, M, Bn, Tr abbreviations
    /// ```
    ///  Convert 12 to 12.00
    ///  Convert 1234 to 1.23K
    ///  Convert 123456 to 123.45K
    ///  Convert 12345678 to 12.34M
    ///  Convert 1234567890 to 1.23Bn
    ///  Convert 123456789012 to 123.45Bn
    ///  Convert 12345678901234 to 12.34Tr
    /// ```
    func formatterWithAbbreviations() -> String {
        let num: Double = abs(Double(self))
        let sign: String = (self < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted: Double = num / 1_000_000_000_000
            let stringFormatted: String = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted: Double = num / 1_000_000_000
            let stringFormatted: String = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted: Double = num / 1_000_000
            let stringFormatted: String = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted: Double = num / 1_000
            let stringFormatted: String = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()
        default:
            return "\(sign)\(self)"
        }
    }
}
