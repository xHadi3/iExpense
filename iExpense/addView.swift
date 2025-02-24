//
//  addView.swift
//  iExpense
//
//  Created by Hadi Al zayer on 05/07/1446 AH.
//

import SwiftUI

struct addView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "New Expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business","Personal"]
    
   
    
    var body: some View {
        
            Form{
//                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(types , id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        modelContext.insert(item)
                        
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        dismiss()
                    }
                }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

#Preview {
    addView()
        .modelContainer(for: ExpenseItem.self)
}
