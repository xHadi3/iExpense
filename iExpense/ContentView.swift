//
//  ContentView.swift
//  iExpense
//
//  Created by Hadi Al zayer on 03/07/1446 AH.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var allExpenses: [ExpenseItem]  // Get all expenses
    
    @State private var expenseType = "Personal"  // Selected filter type
    @State private var sortOrder: [SortDescriptor<ExpenseItem>] = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount, order: .reverse)
    ]

    // Filter & sort dynamically
    var filteredExpenses: [ExpenseItem] {
        allExpenses
            .filter { expenseType == "All" || $0.type == expenseType }  // Show all if "All" is selected
            .sorted(using: sortOrder)
    }


    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredExpenses) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            Text(item.type).font(.subheadline)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .font(fontStyle(amount: item.amount))
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    addView()
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
                
                // Filter Menu
                Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                    Picker("Filter", selection: $expenseType) {
                        Text("Personal").tag("Personal")
                        Text("Business").tag("Business")
                        Text("All").tag("All") // Option to show all expenses
                    }
                }

                // Sort Menu
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Button("Name (A-Z)") {
                        sortOrder = [SortDescriptor(\ExpenseItem.name)]
                    }
                    Button("Name (Z-A)") {
                        sortOrder = [SortDescriptor(\ExpenseItem.name, order: .reverse)]
                    }
                    Button("Amount (Cheapest First)") {
                        sortOrder = [SortDescriptor(\ExpenseItem.amount)]
                    }
                    Button("Amount (Most Expensive First)") {
                        sortOrder = [SortDescriptor(\ExpenseItem.amount, order: .reverse)]
                    }
                }
            }
        }
    }

    func removeItem(at offsets: IndexSet) {
        for offset in offsets {
            let item = filteredExpenses[offset]  // Remove from filtered list
            modelContext.delete(item)
        }
    }

    func fontStyle(amount: Double) -> Font {
        if amount < 10 {
            return .headline
        } else if amount < 100 {
            return .subheadline
        } else {
            return .title
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}
