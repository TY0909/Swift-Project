//
//  ExpenseItem.swift
//  iExpense
//
//  Created by M Sapphire on 2023/12/19.
//

import SwiftData
import Foundation

@Model
class Expense {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
