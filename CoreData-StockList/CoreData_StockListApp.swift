//
//  CoreData_StockListApp.swift
//  CoreData-StockList
//
//  Created by Vitaliy Iakushev on 26.01.2023.
//

import SwiftUI

@main
struct CoreData_StockListApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            AddStockInfoView()
//            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
