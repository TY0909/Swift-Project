//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by M Sapphire on 2023/11/14.
//

import SwiftUI

struct FlagImage: View {
    var imageSource: String
    
    var body: some View {
        Image(imageSource)
            .clipShape(.capsule)
            .shadow(radius: 5)
            
    }
}
struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .foregroundStyle(.red)
    }
}

extension View {
    func SetLargeTitle() -> some View{
        modifier(LargeTitle())
    }
}
struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var score: Int = 0
    @State private var selectedAnswer: Int = 0
    @State private var gameOversign: Bool = false
    @State private var runTImes: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops:[
                .init(color: .blue, location: 0.3),
                .init(color: .red, location: 0.3)
            ],center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the flag")
                    .SetLargeTitle()
                
                VStack(spacing:15) {
                    VStack {
                        Text("tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        }label: {
                            FlagImage(imageSource: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("score:\(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue",action: askQuestion)
        }message: {
            if scoreTitle == "Correct" {
                Text("True, your score is \(score)")
            }
            else {
                Text("Wrong! That's the flag of \(countries[selectedAnswer])")
            }
        }
        .alert("game over", isPresented: $gameOversign) {
            Button("Restart",action: reset)
        }message: {
            Text("Your score is \(score)")
        }
        
    }
    func reset() {
        askQuestion()
        score = 0
        runTImes = 0
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }
        else {
            scoreTitle = "False"
        }
        runTImes += 1
        selectedAnswer = number
        if runTImes == 8 {
            gameOversign = true
            showingScore = false
        }
        else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
