//
//  CoinDetailModel.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 29/05/2023.
//

import Foundation
// URL: https://api.coingecko.com/api/v3/coins/bitcoin?tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false

// MARK: - Welcome
struct CoinDetailModel: Codable {
    var id, symbol, name: String?
//    var assetPlatformID: NSNull?
//    var platforms: Platforms?
//    var detailPlatforms: DetailPlatforms?
    var blockTimeInMinutes: Int?
    var hashingAlgorithm: String?
//    var categories: [String]?
//    var publicNotice: NSNull?
//    var additionalNotices: [Any?]?
    var description: Tion?
    var links: Links?
//    var image: Image?
//    var countryOrigin, genesisDate: String?
//    var sentimentVotesUpPercentage, sentimentVotesDownPercentage: Double?
//    var watchlistPortfolioUsers, marketCapRank, coingeckoRank: Int?
//    var coingeckoScore, developerScore, communityScore, liquidityScore: Double?
//    var publicInterestScore: Double?
//    var publicInterestStats: PublicInterestStats?
//    var statusUpdates: [Any?]?
//    var lastUpdated: String?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, links, description
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
    }
    
    var readableDescription: String {
        return description?.en?.removingHTMLOccurances ?? ""
    }
}

// MARK: - Tion
struct Tion: Codable {
    var en, de, es, fr: String?
    var it, pl, ro, hu: String?
    var nl, pt, sv, vi: String?
    var tr, ru, ja, zh: String?
    var zhTw, ko, ar, th: String?
    var id, cs, da, el: String?
    var hi, no, sk, uk: String?
    var he, fi, bg, hr: String?
    var lt, sl: String?
}

// MARK: - DetailPlatforms
//struct DetailPlatforms {
//    var empty: Empty?
//}

// MARK: - Empty
//struct Empty {
//    var decimalPlace: NSNull?
//    var contractAddress: String?
//}
//
//// MARK: - Image
//struct Image {
//    var thumb, small, large: String?
//}

// MARK: - Links
struct Links: Codable {
    var homepage: [String]?
//    var blockchainSite, officialForumURL: [String]?
//    var chatURL, announcementURL: [String]?
//    var twitterScreenName, facebookUsername: String?
//    var bitcointalkThreadIdentifier: NSNull?
//    var telegramChannelIdentifier: String?
    var subredditURL: String?
//    var reposURL: ReposURL?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}

// MARK: - ReposURL
//struct ReposURL {
//    var github: [String]?
//    var bitbucket: [Any?]?
//}

// MARK: - Platforms
//struct Platforms {
//    var empty: String?
//}

// MARK: - PublicInterestStats
//struct PublicInterestStats {
//    var alexaRank: Int?
//    var bingMatches: NSNull?
//}
