//
//  BasicInfoView.swift
//  CoreData-StockList
//
//  Created by Vitaliy Iakushev on 27.01.2023.
//

import SwiftUI
import CoreData

struct BasicInfoView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var stockInfoEntity: FetchedResults<StockInfoEntity>.Element
    
    @State private var ticker = ""
    @State private var share:Double = 0
    
    
    var body: some View {
        VStack {
            VStack {
            Text("Тут будет базовая информация о компании, описание, логотип, история. А так же информация о позиции в портфеле")
            Text(stockInfoEntity.ticker ?? "")
            Text(" \(stockInfoEntity.share, specifier: "%.2f")%")
            Text(" $\(stockInfoEntity.amount, specifier: "%.2f")")
            Text(" $\(stockInfoEntity.price, specifier: "%.2f")")
            Text(" \(stockInfoEntity.quantity, specifier: "%.1f")")
            }
            .padding()
            //кнопку можно убрать, т.к. в NavBar есть кнопка "Назад"
            Button("Close") {
                dismiss()
            }
        }
       
    }
}
//
//struct BasicInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        BasicInfoView()
//    }
//}
