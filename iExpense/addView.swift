//
//  addView.swift
//  iExpense
//
//  Created by Hadi Al zayer on 05/07/1446 AH.
//

import SwiftUI

struct addView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business","Personal"]
    
    var expense : Expenses
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(types , id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar{
                Button("Svae"){
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expense.items.append(item)
                    dismiss()
                }
            }
        }
        
    }
    
}

#Preview {
    addView(expense: Expenses())
}
