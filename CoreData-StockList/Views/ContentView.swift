//
//  ContentView.swift
//  CoreData-StockList
//
//  Created by Vitaliy Iakushev on 26.01.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.share, order: .reverse)]) var stockInfoEntity: FetchedResults<StockInfoEntity>
    
    @State private var showingAddView = false
    // показать AddStockInfoView, потом можно будет удалить, когда добавление будет автоматически
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Text("Total portfolio amount $: \(totalPortfolioAmount(), specifier: "%.2f")")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                List {
                    ForEach(stockInfoEntity, id: \.self) { stockInfoEntity in
                        // Nav link - to editView, maybe do it later. Or make companyInfoView with basic info about company !!!
                        NavigationLink(destination: BasicInfoView(stockInfoEntity: stockInfoEntity)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(stockInfoEntity.ticker!)

                                    Text(" \(stockInfoEntity.share, specifier: "%.2f")%") +
                                    Text(" $\(stockInfoEntity.amount, specifier: "%.2f")") +
                                    Text(" $\(stockInfoEntity.price, specifier: "%.2f")") +
                                    Text(" \(stockInfoEntity.quantity, specifier: "%.1f")")
                                }
                            }
                        }
                        
                    } .onDelete(perform: deleteStockInfoEntity) //по идее эта функция не нужна, ручного удаления в проде не будет
                }
                .listStyle(.plain) // чтобы ширина списка была на весь экран
            }
            .navigationTitle("Stocks in Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        showingAddView.toggle()
                    } label: {
                        Label("Add Company", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddStockInfoView()
            }
            // toolBar потом можно убрать, т.к функционал будет автоматическим
        }
        .navigationViewStyle(.stack)
    }

    // функция удаления, для ручного режима. Потом удалить, когда портфель будет составляться автоматически
    private func deleteStockInfoEntity(offsets: IndexSet) {
        withAnimation {
            offsets.map {stockInfoEntity[$0]}.forEach(managedObjContext.delete)
            DataController().save(context: managedObjContext)
        }
    }
    
    private func totalPortfolioAmount() -> Double {
        var totalPortfolioAmount: Double = 0
        for stock in stockInfoEntity {
            totalPortfolioAmount += stock.amount
        }
        return totalPortfolioAmount
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
