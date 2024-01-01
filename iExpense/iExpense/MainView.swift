//
//  MainView.swift
//  iExpense
//
//  Created by M Sapphire on 2023/12/19.
//

import SwiftData
import SwiftUI

struct MainView: View {
    @Query var expenses: [Expense]
    
    var body: some View {
        List {
            ForEach(expenses, id: \.id) { expense in
                HStack {
                    VStack {
                        Text(expense.name)
                            .font(.headline)
                        Text(expense.type)
                    }
                    
                    Spacer()
                    Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
        }
        .navigationTitle("iExpense")
    }
    
    init(sortOrder: [SortDescriptor<Expense>], filter: String) {
        _expenses = Query(filter: #Predicate<Expense> { item in
            item.type != filter
        },sort: sortOrder)
    }
}

#Preview {
    MainView(sortOrder: [SortDescriptor(\Expense.name)], filter: "Personal")
        .modelContainer(for: Expense.self)
}
