//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by M Sapphire on 2023/11/15.
//

import SwiftUI

struct ContentView: View {
    var spells: some View {
        Group {
            Text("Hello Swift")
            Text("Obliviate")
            Text("three")
        }
    }
    
    var body: some View {
        VStack {
            spells
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
