//
//  CoinModel.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 20/05/2023.
//

import Foundation

// MARK: - CoinModel
struct CoinModel: Identifiable, Codable {
    var id, symbol, name: String
    var image: String?
    var currentPrice: Double?
    var marketCap, marketCapRank: Double?
    var fullyDilutedValuation: Double?
    var totalVolume, high24H, low24H, priceChange24H: Double?
    var priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H, circulatingSupply: Double?
    var totalSupply, maxSupply: Double?
    var ath, athChangePercentage: Double?
    var athDate: String?
    var atl, atlChangePercentage: Double?
    var atlDate: String?
    var roi: Roi?
    var lastUpdated: String?
    var sparklineIn7D: SparklineIn7D?
    var priceChangePercentage24HInCurrency: Double?
    var currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: self.id,
                         symbol: self.symbol,
                         name: self.name,
                         image: self.image,
                         currentPrice: self.currentPrice,
                         marketCap: self.marketCap,
                         marketCapRank: self.marketCapRank,
                         fullyDilutedValuation: self.fullyDilutedValuation,
                         totalVolume: self.totalVolume,
                         high24H: self.high24H,
                         low24H: self.low24H,
                         priceChange24H: self.priceChange24H,
                         priceChangePercentage24H: self.priceChangePercentage24H,
                         marketCapChange24H: self.marketCapChange24H,
                         marketCapChangePercentage24H: self.marketCapChangePercentage24H,
                         circulatingSupply: self.circulatingSupply,
                         totalSupply: self.totalSupply,
                         maxSupply: self.maxSupply,
                         ath: self.ath,
                         athChangePercentage: self.athChangePercentage,
                         athDate: self.athDate,
                         atl: self.atl,
                         atlChangePercentage: self.atlChangePercentage,
                         atlDate: self.atlDate,
                         lastUpdated: self.lastUpdated,
                         sparklineIn7D: self.sparklineIn7D,
                         priceChangePercentage24HInCurrency: self.priceChangePercentage24HInCurrency,
                         currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 1) * (currentPrice ?? 1)
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

// MARK: - Roi
struct Roi: Codable {
    var times: Double?
    var currency: Currency?
    var percentage: Double?
}

enum Currency: String, Codable {
    case btc = "btc"
    case eth = "eth"
    case usd = "usd"
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    var price: [Double]?
}
