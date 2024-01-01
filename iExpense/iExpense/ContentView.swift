//
//  ContentView.swift
//  iExpense
//
//  Created by M Sapphire on 2023/11/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingAddExpenses = false
    
    @State private var sortOrder = [SortDescriptor(\Expense.name), SortDescriptor(\Expense.amount)]
    @State private var filter = "Personal"
    
    var body: some View {
        NavigationStack {
            MainView(sortOrder: sortOrder, filter: filter)
                .toolbar {
                    ToolbarItem {
                        Button("Add Expense", systemImage: "plus") {
                            showingAddExpenses = true
                        }
                    }
                    
                    ToolbarItem {
                        Menu("Selct order", systemImage: "filemenu.and.selection") {
                            Picker("Select order", selection: $sortOrder) {
                                Text("Sort by name")
                                    .tag([SortDescriptor(\Expense.name), SortDescriptor(\Expense.amount)])
                                
                                Text("Sort by amount")
                                    .tag([SortDescriptor(\Expense.amount), SortDescriptor(\Expense.name)])
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Menu("Select filter", systemImage: "arrow.up.arrow.down") {
                            Picker("Select filter", selection: $filter) {
                                Text("Business")
                                    .tag("Personal")
                                
                                Text("Personal")
                                    .tag("Business")
                                
                                Text("all")
                                    .tag("None")
                            }
                        }
                    }
                }
                .sheet(isPresented: $showingAddExpenses, content: {
                    AddView()
                })
        }
    }
}
#Preview {
    ContentView()
}
