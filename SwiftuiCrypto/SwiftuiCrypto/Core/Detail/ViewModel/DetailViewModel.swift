//
//  DetailViewModel.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 29/05/2023.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var addtionalStatistics: [StatisticModel] = []
    @Published var coinDescrtion: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    @Published var coin: CoinModel
    private let coinDetailService: CoinDetailDataService
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink(receiveCompletion: { _ in
                print("LOI ROI NE")
            }, receiveValue: { [weak self] returnedArrays in
                self?.overviewStatistics = returnedArrays.overview
                self?.addtionalStatistics = returnedArrays.additional
            })
            .store(in: &cancellables)
        
        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                self?.coinDescrtion = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?,
                                     coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        return (createOverviewArray(coinModel: coinModel), createAdditionalArray(coinDetailModel: coinDetailModel,
                                                                                 coinModel: coinModel))
    }
    
    private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        // overview
        let price: String = coinModel.currentPrice?.asCurrencyWith2Decimals() ?? ""
        let priceChange: Double = coinModel.priceChangePercentage24H ?? 0
        let priceStat: StatisticModel = StatisticModel(title: "Current Price",
                                                       value: price,
                                                       percentageChange: priceChange)
        let marketCap: String = "$" + (coinModel.marketCap?.formatterWithAbbreviations() ?? "")
        let marketCapPercentChange: Double = coinModel.marketCapChangePercentage24H ?? 0
        let marketCapStat: StatisticModel = StatisticModel(title: "Market Capitalization",
                                                           value: marketCap,
                                                           percentageChange: marketCapPercentChange)
        let rank: String = "\(coinModel.rank)"
        let rankStat: StatisticModel = StatisticModel(title: "Rank", value: rank)
        
        let volume: String = "$" + (coinModel.totalVolume?.formatterWithAbbreviations() ?? "")
        let volumeStat: StatisticModel = StatisticModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticModel] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        return overviewArray
    }
    
    private func createAdditionalArray(coinDetailModel: CoinDetailModel?,
                                       coinModel: CoinModel) -> [StatisticModel] {
        // additional
        let high: String = coinModel.high24H?.asCurrencyWith2Decimals() ?? "n/a"
        let highStat: StatisticModel = StatisticModel(title: "24h High",
                                                      value: high)
        let low: String = coinModel.low24H?.asCurrencyWith2Decimals() ?? "n/a"
        let lowStat: StatisticModel = StatisticModel(title: "24h low",
                                                     value: low)
        let priceChange2: String = coinModel.priceChange24H?.asCurrencyWith2Decimals() ?? "n/a"
        let pricePercentChange2: Double = coinModel.priceChangePercentage24H ?? 0
        let priceChangeStat: StatisticModel = StatisticModel(title: "24h Price Change",
                                                             value: priceChange2,
                                                             percentageChange: pricePercentChange2)
        let marketCapChange: String = "$" + (coinModel.marketCapChange24H?.formatterWithAbbreviations() ?? "")
        let marketCapPercentChange2: Double = coinModel.marketCapChangePercentage24H ?? 0
        let marketCapChangeStat: StatisticModel = StatisticModel(title: "24h Market Cap Change",
                                                                 value: marketCapChange,
                                                                 percentageChange: marketCapPercentChange2)
        let blockTime: Int = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString: String = (blockTime == 0) ? "n/a" : "\(blockTime)"
        let blockStat: StatisticModel = StatisticModel(title: "Block Time",
                                                       value: blockTimeString)
        let hasing: String = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hasingStat: StatisticModel = StatisticModel(title: "Hasing Algoritm",
                                                        value: hasing)
        let additionalArray: [StatisticModel] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hasingStat
        ]
        return additionalArray
    }
}
