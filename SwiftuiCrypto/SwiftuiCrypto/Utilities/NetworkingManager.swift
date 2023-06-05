//
//  NetworkingManager.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 20/05/2023.
//

import Foundation
import Combine

enum NetwokingError: LocalizedError {
    case badURLResponse(url: URL)
    case unknown
    
    var errorDescription: String {
        switch self {
        case .badURLResponse(url: let url):
            return "[CuongPT - Error] Bad response from \(url)"
        case .unknown:
            return "[CuongPT - Error] Unknown error occured"
        }
    }
}

class NetworkingManager {
    static let shared: NetworkingManager = NetworkingManager()
    private init() { }
    
    func dowload(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { try self.handleURLResponse(output: $0,
                                                 url: url)
            }
            .receive(on: DispatchQueue.main)
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetwokingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
