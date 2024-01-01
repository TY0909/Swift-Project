//
//  iExpenseApp.swift
//  iExpense
//
//  Created by M Sapphire on 2023/11/23.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
