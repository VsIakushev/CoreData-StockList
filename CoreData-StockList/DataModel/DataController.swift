//
//  DataController.swift
//  CoreData-StockList
//
//  Created by Vitaliy Iakushev on 27.01.2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "StockInfoDataModel")
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
             
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("Could not save data...")
        }
    }
    
    func addStockInfoEntity(ticker: String, share: Double, amount: Double, price: Double, quantity: Double, context: NSManagedObjectContext) {
        let stockInfoEntity = StockInfoEntity(context: context)
        stockInfoEntity.ticker = ticker
        stockInfoEntity.share = share
        stockInfoEntity.amount = amount
        stockInfoEntity.price = price
        stockInfoEntity.quantity = quantity
        
        save(context: context)
    }
    
    func editStockinfoEntity(stockInfoEntity: StockInfoEntity, ticker: String, share: Double, amount: Double, price: Double, quantity: Double, context: NSManagedObjectContext) {
        stockInfoEntity.ticker = ticker
        stockInfoEntity.share = share
        stockInfoEntity.amount = amount
        stockInfoEntity.price = price
        stockInfoEntity.quantity = quantity
        
        save(context: context)
    }
    
    // добавить функцию removeAll? Чтобы при создании нового портфеля данные записывались заново
    
}
