//
//  MarketDataService.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 26/05/2023.
//

import Foundation
import Combine

class MarketDataService {
    private var marketDataSubscription: AnyCancellable?
    @Published var marketData: MarketDataModel?
    
    init() {
        getMarketData()
    }
    
    func getMarketData() {
        guard let url: URL = URL(string: "https://api.coingecko.com/api/v3/global") else {
            return
        }
        
        marketDataSubscription = NetworkingManager.shared.dowload(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.shared.handleCompletion(completion:),
                  receiveValue: { [weak self] returnedMarketData in
                self?.marketData = returnedMarketData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
