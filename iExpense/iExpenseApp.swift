//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Hadi Al zayer on 03/07/1446 AH.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView( )
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
