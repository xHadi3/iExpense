//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Hadi Al zayer on 26/08/1446 AH.
//

import Foundation
import SwiftData

@Model
class ExpenseItem : Identifiable{
    var id = UUID()
    var name : String
    var type: String
    var amount: Double
    var expense: Expenses?
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
