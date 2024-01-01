//
//  ContentView.swift
//  edutainment
//
//  Created by M Sapphire on 2023/11/22.
//

import SwiftUI

enum viewNumber {
    case Start, SelectRange, SelectQuantity, GameTable, ScoreTable
}

struct ContentView: View {
    @State private var showing: viewNumber = viewNumber.Start
    
    @State var factorRange: Int = 2
    
    @State private var numberOfQuestion = 1
    
    @State private var factor1 = 1
    @State private var factor2 = 1
    @State private var answer = ""
    @State private var score = 0
    
    var body: some View {
        VStack {
            switch showing {
            case viewNumber.Start:
                VStack {
                    Button("Game Start") {
                        withAnimation {
                            showing = viewNumber.SelectRange
                        }
                    }
                    .frame(width: 100, height: 40)
                    .padding(10)
                    .foregroundStyle(.primary)
                    .background(.cyan)
                    .clipShape(.rect(cornerRadius: 10))
                }
                .transition(.scale)
            case viewNumber.SelectRange:
                VStack {
                    VStack {
                        Text("select the range of the factor.")
                            .font(.title.bold())
                        HStack {
                            Text("Range:    \(factorRange)")
                                .padding(20)
                                .bold()
                            
                            Stepper("The range of the factor:", value: $factorRange,in:2...12)
                                .labelsHidden()
                        }
                    }
                    
                    Button("OK") {
                        withAnimation {
                            showing = viewNumber.SelectQuantity
                        }
                    }
                    .frame(width: 100, height: 40)
                    .padding(10)
                    .foregroundStyle(.primary)
                    .background(.cyan)
                    .clipShape(.rect(cornerRadius: 10))
                }
                .transition(.scale)
            case viewNumber.SelectQuantity:
                VStack {
                    VStack {
                        Text("select how many question you want be asked")
                            .font(.title.bold())
                        
                        HStack {
                            Text("Number:   \(numberOfQuestion)")
                                .padding(20)
                                .bold()
                            
                            Stepper("The number of question", value: $numberOfQuestion, in: 1...20)
                                .labelsHidden()
                        }
                    }
                    
                    Button("OK") {
                        withAnimation {
                            showing = viewNumber.GameTable
                            FactorReBuild()
                        }
                    }
                    .frame(width: 100, height: 40)
                    .padding(10)
                    .foregroundStyle(.primary)
                    .background(.cyan)
                    .clipShape(.rect(cornerRadius: 10))
                }
                .transition(.scale)
            case viewNumber.GameTable:
                VStack {
                    List {
                        Section {
                            Text("\(factor1) * \(factor2) = ?")
                        }
                        TextField("tap your answer", text: $answer)
                            .keyboardType(.decimalPad)
                    }
                    .frame(height: 200)
                    .animation(.bouncy(duration: 2), value: showing)
                    
                    Button("Confirm") {
                        withAnimation {
                            if Int(answer) == factor1 * factor2 {
                                score += 1
                            }
                            FactorReBuild()
                            numberOfQuestion -= 1
                            if numberOfQuestion == 0 {
                                showing = viewNumber.ScoreTable
                            }
                        }
                    }
                    .frame(width: 100, height: 40)
                    .padding(10)
                    .foregroundStyle(.primary)
                    .background(.cyan)
                    .clipShape(.rect(cornerRadius: 10))
                }
                .transition(.scale)
            case viewNumber.ScoreTable:
                VStack {
                    Text("Your score is \(score)")
                        .font(.title.bold())
                    Button("restart") {
                        withAnimation {
                            restart()
                        }
                    }
                    .frame(width: 100, height: 40)
                    .padding(10)
                    .foregroundStyle(.primary)
                    .background(.cyan)
                    .clipShape(.rect(cornerRadius: 10))
                }
                .transition(.scale)
            }
        }
    }
    
    func FactorReBuild() {
        factor1 = Int.random(in: 1...factorRange)
        factor2 = Int.random(in: 1...factorRange)
        answer = ""
    }
    
    func restart() {
        factorRange = 2
        numberOfQuestion = 1
        showing = viewNumber.Start
        score = 0
    }
}

#Preview {
    ContentView()
}
