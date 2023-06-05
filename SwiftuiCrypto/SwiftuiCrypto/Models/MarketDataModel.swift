//
//  MarketDataModel.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 26/05/2023.
//

import Foundation

// URL: https://api.coingecko.com/api/v3/global
/*
 {
   "data": {
     "active_cryptocurrencies": 10232,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 745,
     "total_market_cap": {
       "btc": 43776146.94478171,
       "eth": 641474224.9436551,
       "ltc": 13294579127.403078,
       "bch": 10337269545.901867,
       "bnb": 3818334760.8980803,
       "eos": 1369099386973.2024,
       "xrp": 2491867878429.571,
       "xlm": 13268170786886.744,
       "link": 185127558803.45844,
       "dot": 221910268736.88776,
       "yfi": 184351290.67968664,
       "usd": 1155793494339.6123,
       "aed": 4244275975076.569,
       "ars": 272437511001246,
       "aud": 1776104395371.1992,
       "bdt": 123884636456065.03,
       "bhd": 435750328474.95483,
       "bmd": 1155793494339.6123,
       "brl": 5821500672289.752,
       "cad": 1576985447959.864,
       "chf": 1045661399644.474,
       "clp": 935880517074256.1,
       "cny": 8175967599608.968,
       "czk": 25434463295634.168,
       "dkk": 8022362644211.272,
       "eur": 1076924457872.8674,
       "gbp": 937250281462.4061,
       "hkd": 9055798060272.61,
       "huf": 401511945727889.3,
       "idr": 17285380574979030,
       "ils": 4310300678440.721,
       "inr": 95603192574542.4,
       "jpy": 161643499150866.6,
       "krw": 1531913229114642.2,
       "kwd": 355533636793.80835,
       "lkr": 349433414208771.6,
       "mmk": 2426612090056704.5,
       "mxn": 20615079503089.625,
       "myr": 5355369156022.607,
       "ngn": 532449160115628.75,
       "nok": 12774206488120.557,
       "nzd": 1902744688545.9915,
       "php": 64649887002633.445,
       "pkr": 330016065011170.25,
       "pln": 4851376156467.87,
       "rub": 92760312743972.47,
       "sar": 4334447516124.4644,
       "sek": 12502247123108.936,
       "sgd": 1563820960059.3372,
       "thb": 40094476318641.195,
       "try": 23140488288221.703,
       "twd": 35529208751142.65,
       "uah": 42678135940094.48,
       "vef": 115729602588.22554,
       "vnd": 27134490848201310,
       "zar": 22863272374397.855,
       "xdr": 866308832573.3352,
       "xag": 50559643186.94387,
       "xau": 593708002.1723716,
       "bits": 43776146944781.71,
       "sats": 4377614694478171.5
     },
     "total_volume": {
       "btc": 1323582.4100797079,
       "eth": 19395128.623949055,
       "ltc": 401964821.2676039,
       "bch": 312549849.4983313,
       "bnb": 115448276.6995337,
       "eos": 41395051705.54196,
       "xrp": 75342229097.78442,
       "xlm": 401166358693.2045,
       "link": 5597376597.861203,
       "dot": 6709510745.35393,
       "yfi": 5573905.943044872,
       "usd": 34945696356.559494,
       "aed": 128326712518.14894,
       "ars": 8237214158249.033,
       "aud": 53700946754.035904,
       "bdt": 3745682001186.5625,
       "bhd": 13175016766.171926,
       "bmd": 34945696356.559494,
       "brl": 176014483408.71863,
       "cad": 47680537131.42416,
       "chf": 31615825787.83202,
       "clp": 28296574202802.168,
       "cny": 247202361456.6657,
       "czk": 769017160655.6226,
       "dkk": 242558078410.88016,
       "eur": 32561071928.58063,
       "gbp": 28337989360.979424,
       "hkd": 273804248622.65207,
       "huf": 12139810967663.559,
       "idr": 522627670028481.9,
       "ils": 130322985422.51746,
       "inr": 2890585692677.349,
       "jpy": 4887330363946.632,
       "krw": 46317767673389.2,
       "kwd": 10749645656.24127,
       "lkr": 10565203948264.777,
       "mmk": 73369204524489.83,
       "mxn": 623301923924.502,
       "myr": 161920884068.1188,
       "ngn": 16098729371493.21,
       "nok": 386231228429.70795,
       "nzd": 57529946703.82416,
       "php": 1954704998552.3354,
       "pkr": 9978115690343.436,
       "pln": 146682533606.27036,
       "rub": 2804630532154.4497,
       "sar": 131053070910.7987,
       "sek": 378008471131.3126,
       "sgd": 47282505649.92298,
       "thb": 1212266206609.0503,
       "try": 699658270463.5852,
       "twd": 1074234235515.9719,
       "uah": 1290383781298.8071,
       "vef": 3499112576.182307,
       "vnd": 820417905633635.1,
       "zar": 691276580138.1613,
       "xdr": 26193057464.31016,
       "xag": 1528683062.6404035,
       "xau": 17950905.304437466,
       "bits": 1323582410079.7078,
       "sats": 132358241007970.78
     },
     "market_cap_percentage": {
       "btc": 44.279507377171775,
       "eth": 18.7471044813249,
       "usdt": 7.1845008086459385,
       "bnb": 4.134955502669451,
       "usdc": 2.51191946059151,
       "xrp": 2.0791604690058203,
       "ada": 1.0769760762799683,
       "steth": 1.0415131751700848,
       "doge": 0.8533068525856988,
       "matic": 0.7182335303363621
     },
     "market_cap_change_percentage_24h_usd": 1.3533142593024798,
     "updated_at": 1685066547
   }
 }
 
 */

// MARK: - GlobalData
struct GlobalData: Codable {
    var data: MarketDataModel
}

// MARK: - DataClass
struct MarketDataModel: Codable {
    var activeCryptocurrencies, upcomingIcos, ongoingIcos, endedIcos: Int?
    var markets: Int?
    var totalMarketCap, totalVolume, marketCapPercentage: [String: Double]?
    var marketCapChangePercentage24HUsd: Double?
    var updatedAt: Int?

    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
    
    var marketCap: String {
        if let item = totalMarketCap?.first(where: { $0.key == "usd" }) {
            return "$\(item.value.formatterWithAbbreviations())"
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume?.first(where: { $0.key == "usd" }) {
            return "$\(item.value.formatterWithAbbreviations())"
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage?.first(where: { $0.key == "btc" }) {
            return item.value.asPercentString()
        }
        return ""
    }
}
