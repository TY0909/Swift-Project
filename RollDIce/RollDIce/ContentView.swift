//
//  ContentView.swift
//  RollDIce
//
//  Created by M Sapphire on 2024/1/30.
//

import SwiftUI

struct ContentView: View {
    @State private var rollSides = 20
    @State private var rollResult = 0
    @State private var isRolling = false
    @State private var resultArray = [Int]()
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 5)
                        .frame(width: 100, height: 100)
                    
                    Text(String(rollResult))
                        .font(.largeTitle)
                }
                .onReceive(timer, perform: { _ in
                    if isRolling {
                        rollDice()
                    }
                })
                
                Button {
                    if isRolling == true {
                        resultArray.append(rollResult)
                        saveResult()
                    }
                    isRolling.toggle()
                    loadResult()
                } label: {
                    Text("Click to roll and stop")
                        .foregroundStyle(.black)
                        .padding()
                        .background(.green)
                        .clipShape(.capsule)
                }
                
                VStack {
                    Text("sum: \(resultArray.reduce(0, +))")
                    
                    Picker("Select sides", selection: $rollSides) {
                        Text("4 Sides")
                            .tag(4)
                        Text("6 Sides")
                            .tag(6)
                        Text("8 Sides")
                            .tag(8)
                        Text("10 Sides")
                            .tag(10)
                        Text("12 Sides")
                            .tag(12)
                        Text("20 Sides")
                            .tag(20)
                        Text("100 Sides")
                            .tag(100)
                    }
                }
            }
        }
        .onAppear(perform: loadResult)
    }
    
    func rollDice() {
        rollResult = Int.random(in: 1..<rollSides)
    }
    
    func saveResult() {
        if let data = try? JSONEncoder().encode(resultArray) {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent("data", conformingTo: .json)
                try? data.write(to: fileURL)
            }
        }
    }
    
    func loadResult() {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent("data", conformingTo: .json)
            if let data = try? Data(contentsOf: fileURL) {
                if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
                    resultArray = decoded
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
