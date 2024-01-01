//
//  ContentView.swift
//  WebSplit
//
//  Created by M Sapphire on 2023/11/13.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isAmountFocus: Bool
    
    let tipPencentages = [10,15,20,25,0]
    var totalAmount :Double {
        checkAmount * (1 + Double(tipPercentage) / 100)
    }
    var totalAverage: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipPercent = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipPercent
        let totalAmount = checkAmount + tipValue
        
        return totalAmount / peopleCount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("checkAmount", value: $checkAmount, format:.currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocus)
                    
                    Picker("number of people:",selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?") {
                    Picker("tipPercentage",selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0) %")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total amount") {
                    Text(totalAmount,format:.currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .primary)
                }
                Section("Amount per person") {
                    Text(totalAverage,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("checkAmount")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isAmountFocus {
                    Button("Done") {
                        isAmountFocus = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
