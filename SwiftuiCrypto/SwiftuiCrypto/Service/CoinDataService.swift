//
//  CoinDataService.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 20/05/2023.
//

import Foundation
import Combine

class CoinDataService {
    private var coinSubscription: AnyCancellable?
    @Published var allCoins: [CoinModel] = []
    
    
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url: URL = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
            return
        }
        
        coinSubscription = NetworkingManager.shared.dowload(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.shared.handleCompletion(completion:),
                  receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
