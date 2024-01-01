//
//  ContentView.swift
//  MoonShot
//
//  Created by M Sapphire on 2023/11/29.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let colmus = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var showingGridLayout = false
    var body: some View {
        NavigationStack {
            Group {
                if showingGridLayout {
                    GridLayout(astronauts: astronauts, missions: missions)
                }
                else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .toolbar {
                Button("Switch") {
                    showingGridLayout.toggle()
                }
                .padding(.horizontal,50)
                .font(.title2)
            }
        }
    }
}

#Preview {
    ContentView()
}
