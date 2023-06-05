//
//  HomeViewModel.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 20/05/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = [
        
    ]
    @Published var allCoins: [CoinModel] = []
    @Published var porfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService: CoinDataService = CoinDataService()
    private let marketDataService: MarketDataService = MarketDataService()
    private let portfolioDataService: PortfolioDataService = PortfolioDataService()
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    enum SortOption {
        case rank
        case rankReversed
        case holdings
        case holdingsReversed
        case price
        case priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
    // Vì searchText đã combineLatest allCoins của coinDataService, nên ko cần add subscriber cho coinDataService.$allCoins ở đoạn này nữa
//        coinDataService.$allCoins
//            .sink { returnedCoins in
//                self.allCoins = returnedCoins
//            }
//            .store(in: &cancellables)
        
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
//            .map { [weak self] (text, startingCoins) -> [CoinModel] in
//                self?.fillterCoins(text: text, coins: startingCoins) ?? []
//            }
            .map(filterAndSortCoins)
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            })
            .store(in: &cancellables)
        
        // update portfolio coin
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink(receiveValue: { [weak self] returnedCoins in
                self?.porfolioCoins = self?.sortPortfolioCoinsIfNeed(coins: returnedCoins) ?? returnedCoins
            })
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest($porfolioCoins)
            .map(mapGlobalMarketData)
            .sink(receiveCompletion: { _ in
                print("CuongPT8 ----- LOIIIII")
            }, receiveValue: { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.shared.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins: [CoinModel] = fillterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func fillterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText: String = text.lowercased()
        let filleredCoins = coins.filter { coin in
            return coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText) || coin.id.lowercased().contains(lowercasedText)
        }
        return filleredCoins
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice ?? 0 < $1.currentPrice ?? 0 })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice ?? 0 > $1.currentPrice ?? 0 })
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCOins: [CoinModel],
                                             portfolioCoins: [PortfolioEntity]) -> [CoinModel] {
        allCOins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioCoins.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func sortPortfolioCoinsIfNeed(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?,
                                     portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap: StatisticModel = StatisticModel(title: "Market Cap",
                                       value: data.marketCap,
                                       percentageChange: data.marketCapChangePercentage24HUsd)
        let volume: StatisticModel = StatisticModel(title: "24h Volome",
                                                    value: data.volume)
        let btcDomainance: StatisticModel = StatisticModel(title: "BTC Dominance",
                                                           value: data.btcDominance)
        
        let portfolioValue: Double = portfolioCoins.map { coin -> Double in
            return coin.currentHoldingsValue
        }.reduce(0, +)
        
        let previousValue: Double = portfolioCoins.map({ coin -> Double in
            let currentValue: Double = portfolioValue //coin.currentHoldings ?? 0
            let percentChange: Double = coin.priceChangePercentage24H ?? 0 / 100
            let previousValue: Double = currentValue * (1 + percentChange)
            return previousValue
        }).reduce(0, +)
        
        let percentChange = ((previousValue - portfolioValue) / previousValue)
        
        let portfolio: StatisticModel = StatisticModel(title: "Portfolio Value",
                                                       value: "\(portfolioValue.asCurrencyWith2Decimals())",
                                                       percentageChange: percentChange)
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDomainance,
            portfolio
        ])
        return stats
    }
}
