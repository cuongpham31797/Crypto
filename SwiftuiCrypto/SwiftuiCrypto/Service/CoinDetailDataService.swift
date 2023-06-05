//
//  CoinDetailDataService.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 29/05/2023.
//

import Foundation
import Combine

class CoinDetailDataService {
    private var coinDetailSubscription: AnyCancellable?
    private let coin: CoinModel
    @Published var coinDetails: CoinDetailModel? = nil
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinsDeatils()
    }
    
    func getCoinsDeatils() {
        guard let url: URL = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {
            return
        }
        
        coinDetailSubscription = NetworkingManager.shared.dowload(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.shared.handleCompletion(completion:),
                  receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
