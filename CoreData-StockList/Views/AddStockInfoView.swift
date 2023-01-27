//
//  AddStockInfoView.swift
//  CoreData-StockList
//
//  Created by Vitaliy Iakushev on 27.01.2023.
//

import SwiftUI

//Это тестовое-вью потом можно будет удалить, StockInfoEntity будут создаваться автоматически при составлении портфеля

struct AddStockInfoView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    //dismiss - dismisses the currentView when we will press submit and close this view
    
    @State private var ticker = ""
    @State private var share: Double = 0.0 // будет считаться и обновляться автоматически
    @State private var amount: Double = 0.0 // будет считаться и обновляться автоматически
    @State private var price: Double = 0.0 // данные приходят с сервера
    @State private var quantity: Double = 0.0 // считается 1 раз при создании портфеля
    
    var body: some View {
        VStack{
            Form{
                Section(header: Text("Enter Company Ticker:")){
                    TextField("Company Ticker", text: $ticker)
                }
                Section(header: Text("Enter Company's Share in Portfolio:")){
                    TextField("Share in Portfolio", value: $share, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Enter Company's Amount in Portfolio:")){
                    TextField("Share in Portfolio", value: $amount, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Enter Company's stock's price:")){
                    TextField("Share in Portfolio", value: $price, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Enter quantity of stocks:")){
                    TextField("Share in Portfolio", value: $quantity, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
                
                Button("Submit"){
                    DataController().addStockInfoEntity(ticker: ticker, share: share, amount: amount, price: price, quantity: quantity, context: managedObjContext)
                    dismiss()
                }
            }
        }
    }
}

struct AddStockInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AddStockInfoView()
    }
}
