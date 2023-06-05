//
//  PortfolioDataService.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 26/05/2023.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let enityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { [weak self] _, error in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
            self?.getPortfolio()
        }
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { savedEntity in
            return savedEntity.coinID == coin.id
        }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                remove(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
}

extension PortfolioDataService {
    private func getPortfolio() {
        let request: NSFetchRequest<PortfolioEntity> = NSFetchRequest<PortfolioEntity>(entityName: enityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("CuongPT8 -- Error when fetching Portfolio request -- \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChange()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChange()
    }
    
    private func remove(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChange()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("CuongPT8 -- Error when saving Portfolio request -- \(error)")
        }
    }
    
    private func applyChange() {
        save()
        getPortfolio()
    }
}
