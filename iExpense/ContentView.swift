//
//  ContentView.swift
//  iExpense
//
//  Created by Hadi Al zayer on 03/07/1446 AH.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Query private var expenses:[ExpenseItem]
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount, order: .reverse)
    
    ]

    var body: some View {
        NavigationStack{
            List {
                ForEach(expenses){ item in
                   
                            HStack{
                                VStack(alignment: .leading){
                                    Text(item.name).font(.headline)
                                    Text(item.type).font(.subheadline)
                                    
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD" ) )
                                    .font(fontStyle(amount: item.amount))
                            }
                     
                    } .onDelete(perform: removeItem)
                    
                    
                    
              
//                Section("Business expenses"){
//                    ForEach(expenses.items){ item in
//                        if item.type == "Business"{
//                            HStack{
//                                VStack(alignment: .leading){
//                                    Text(item.name).font(.headline)
//                                    Text(item.type).font(.subheadline)
//                                    
//                                }
//                                Spacer()
//                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD" ) )
//                                    .font(fontStyle(amount: item.amount))
//                            }
//                        }
//                    } .onDelete(perform: removeItem)
//                    
//                    
//                    
//                }
                
              
            }
            .navigationTitle("iExpense")
            
            .toolbar{
                    NavigationLink{
                        addView()
                    }
            label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
                
            ///
//                Button("Add Expense", systemImage: "plus"){
//                    showAddView = true
//                }
//            .sheet(isPresented: $showAddView){
//               
//            }
            ///
            
        }
    }
    func removeItem(at offsets:IndexSet){
        for offset in offsets{
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
    
    init(sortOrder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(sort: sortOrder)
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
    ContentView(sortOrder: [SortDescriptor(\ExpenseItem.name)])
        .modelContainer(for: ExpenseItem.self)
}
