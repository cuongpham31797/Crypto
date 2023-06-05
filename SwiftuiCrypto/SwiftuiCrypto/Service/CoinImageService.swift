//
//  CoinImageService.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 25/05/2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager: LocalFileManager = LocalFileManager.shared
    private let folderName: String = "coin_images"
    private let imageName: String
    @Published var image: UIImage? = nil
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: coin.id,
                                                 folderName: folderName) {
            image = savedImage
//            print("Retrieved Image from File Manager")
        } else {
            dowloadCoinImage()
//            print("Dowloading image now")
        }
    }
    
    private func dowloadCoinImage() {
        guard let url: URL = URL(string: coin.image ?? "") else {
            return
        }
        
        imageSubscription = NetworkingManager.shared.dowload(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.shared.handleCompletion(completion:),
                  receiveValue: { [weak self] returnedImage in
                guard let self = self, let dowloadImage = returnedImage else {
                    return
                }
                self.image = dowloadImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: dowloadImage,
                                           imageName: self.imageName,
                                           folderName: self.folderName)
            })
    }
}
