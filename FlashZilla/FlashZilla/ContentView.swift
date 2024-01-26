//
//  ContentView.swift
//  FlashZilla
//
//  Created by M Sapphire on 2024/1/23.
//

import SwiftUI

extension View {
    func stacked(at position: Int, In total: Int) -> some View{
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @State private var cards = [Card]()
    @State private var showingEditScreen = false
    
    @State private var timeRemain = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenPhase
    @State private var isActive = true
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time remain: \(timeRemain)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            removeCard(at: index)
                        }
                        .stacked(at: index, In: cards.count)
                        .allowsTightening(index == cards.count - 1)
                        .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsTightening(timeRemain > 0)
                .accessibilityAddTraits(.isButton)
                
                if cards.isEmpty {
                    Button("Restart", action: restart)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button("ReAdd") {
                        let tempCard = cards[cards.count - 1]
                        cards.remove(at: cards.count - 1)
                        cards.insert(tempCard, at: 0)
                    }
                    .padding()
                    .foregroundStyle(.black)
                    .background(.white)
                    .font(.footnote)
                    .clipShape(.circle)
                }
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer, perform: { _ in
            guard isActive else { return }
            
            if timeRemain > 0 {
                timeRemain -= 1
            }
        })
        .onChange(of: scenPhase) {
            if scenPhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: restart, content: {
            EditView()
        })
        .onAppear(perform: restart)
    }
    
    func removeCard(at position: Int) {
        guard position >= 0 else { return }
        cards.remove(at: position)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func restart() {
        timeRemain = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decode = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decode
            }
        }
    }
}

#Preview {
    ContentView()
}
