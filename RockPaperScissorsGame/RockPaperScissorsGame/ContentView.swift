//
//  ContentView.swift
//  RockPaperScissorsGame
//
//  Created by M Sapphire on 2023/11/15.
//

import SwiftUI

struct ContentView: View {
    @State private var playerOption: String = ""
    @State private var computerOption: String = "???"
    @State private var randomIndex: Int = 0
    @State private var resultShow: String = "result"
    @State private var isresultShow: Bool = false
    @State private var score: Int = 0
    @State private var runningTimes: Int = 0
    @State private var isGameReset: Bool = false
    
    let options = ["rock","paper","scissors"]
    
    var body: some View {
        NavigationStack {
            Spacer()
            
            VStack {
                Text("Game")
                    .font(.largeTitle.bold())
            }
            .padding()
            
            VStack {
                Text("This is the ccomputer option")
                    .padding()
                Text(computerOption)
                    .foregroundStyle(.red)
            }
            .padding()
            
            Spacer()
            VStack {
                Section {
                    Text("select your option this turn")
                        .font(.title)
                        .padding()
                    
                    HStack(spacing: 50) {
                        ForEach(options, id: \.self) { item in
                            Button() {
                                playerOption = item
                                Game()
                            } label: {
                                Text(item)
                            }
                            .foregroundStyle(.blue)
                        }
                    }
                    .padding(30)
                    .alert(resultShow, isPresented: $isresultShow) {
                        Button("Done") {
                            isresultShow = false
                        }
                    }
                    .alert("your score is \(score)", isPresented: $isGameReset) {
                        Button("Restart",action: reset)
                    }
                }
                
                Section {
                    Text("score:\(score)")
                    Text("times:\(runningTimes)")
                }
                .font(.subheadline)
            }
            
            Spacer()
            Spacer()
        }
    }
    
    func reset() {
        computerOption = "???"
        score = 0
        runningTimes = 0
    }
    
    func Game() {
        randomIndex = Int.random(in: 0..<3)
        computerOption = options[randomIndex]
        switch playerOption {
        case "rock":
            if computerOption == "scissors" {
                resultShow = "Win"
            }
            else if computerOption == "paper" {
                resultShow = "Lose"
            }
            else {
                resultShow = "Nothing"
            }
        case "paper":
            if computerOption == "rock" {
                resultShow = "Win"
            }
            else if computerOption == "scissors" {
                resultShow = "Lose"
            }
            else {
                resultShow = "Nothing"
            }
        case "scissors":
            if computerOption == "paper" {
                resultShow = "Win"
            }
            else if computerOption == "rock" {
                resultShow = "Lose"
            }
            else {
                resultShow = "Nothing"
            }
        default:
            resultShow = "error"
        }
        
        runningTimes += 1
        if runningTimes == 10 {
            isresultShow = false
            isGameReset = true
        }
        else {
            isresultShow = true
        }

        if resultShow == "Win" {
            score += 1
        }
    }
}

#Preview {
    ContentView()
}
