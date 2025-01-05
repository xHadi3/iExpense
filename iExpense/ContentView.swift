//
//  ContentView.swift
//  iExpense
//
//  Created by Hadi Al zayer on 03/07/1446 AH.
//

import SwiftUI

struct ExpenseItem : Identifiable , Codable{
    var id = UUID()
    let name : String
    let type: String
    let amount: Double
}

@Observable
class Expenses{
    var items = [ExpenseItem](){
        didSet {
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey:"Items" )
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
    
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showAddView = false
    var body: some View {
        NavigationStack{
            List {
                Section("Personal expenses"){
                    ForEach(expenses.items){ item in
                        if item.type == "Personal"{
                            HStack{
                                VStack(alignment: .leading){
                                    Text(item.name).font(.headline)
                                    Text(item.type).font(.subheadline)
                                    
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD" ) )
                                    .font(fontStyle(amount: item.amount))
                            }
                        }
                    } .onDelete(perform: removeItem)
                    
                    
                    
                }
                Section("Business expenses"){
                    ForEach(expenses.items){ item in
                        if item.type == "Business"{
                            HStack{
                                VStack(alignment: .leading){
                                    Text(item.name).font(.headline)
                                    Text(item.type).font(.subheadline)
                                    
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD" ) )
                                    .font(fontStyle(amount: item.amount))
                            }
                        }
                    } .onDelete(perform: removeItem)
                    
                    
                    
                }
                
              
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button("Add Expense", systemImage: "plus"){
                    showAddView = true
                }
            }
            .sheet(isPresented: $showAddView){
                addView(expense: expenses)
            }
        }
        
        
    }
    func removeItem(at offsets:IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    func fontStyle(amount:Double) ->Font{
        if amount < 10{
            return .headline
        }
        else if amount < 100{
            return .subheadline
        }
        else if amount > 100{
            return .title
        }
        else{
            return .body
        }
    }

}

#Preview {
    ContentView()
}
