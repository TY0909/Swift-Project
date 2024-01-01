//
//  ContentView.swift
//  UnitConversion
//
//  Created by M Sapphire on 2023/11/14.
//

import SwiftUI

struct ContentView: View {
    @State private var inputdUnit: String = "s"
    @State private var outputUnit: String = "s"
    @State private var inputvalue: Double = 0.00
    let unitsArray = ["s","min","hour","days"]
    
    @FocusState private var isInputValueFocused: Bool
    var outputValue: Double {
        var input = inputvalue
        switch inputdUnit {
        case unitsArray[0]:
            input *= 1
        case unitsArray[1]:
            input *= 60
        case unitsArray[2]:
            input *= 60 * 60
        case unitsArray[3]:
            input *= 60 * 60 * 24
        default:
            input *= 1
        }
        var output = Measurement(value: input, unit:UnitDuration.seconds)
        var result: Double = input
        switch outputUnit {
        case unitsArray[0]:
            result = output.value
        case unitsArray[1]:
            result = output.converted(to: UnitDuration.minutes).value
        case unitsArray[2]:
            result = output.converted(to: UnitDuration.hours).value
        case unitsArray[3]:
            output = output.converted(to: UnitDuration.hours)
            result = output.value / 24
        default:
            result = output.value
        }
        return result
    }
    var body: some View {
        NavigationStack {
            Form {
                Section("Choose the input unit") {
                    Picker("Input Unit",selection: $inputdUnit) {
                        ForEach(unitsArray, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Choose the output unit") {
                    Picker("Output unit",selection: $outputUnit) {
                        ForEach(unitsArray,id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Enter input value") {
                    TextField("Input value", value: $inputvalue,format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isInputValueFocused)
                }
                Section("The result") {
                    Text(outputValue,format: .number)
                }
            }
            .navigationTitle("Unit Conversion")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isInputValueFocused {
                    Button("Done") {
                        isInputValueFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
