//
//  ContentView.swift
//  HotProSpects
//
//  Created by M Sapphire on 2024/1/12.
//

import SwiftUI

struct ContentView: View {
    @StateObject var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProSpectView(filter: .none)
                .tabItem { Label("Everyone", systemImage: "person.3") }
            
            ProSpectView(filter: .contacted)
                .tabItem { Label("Contacted", systemImage: "checkmark.circle") }
            
            ProSpectView(filter: .uncontacted)
                .tabItem { Label("Uncontacted", systemImage: "questionmark.diamond") }
            
            MeView()
                .tabItem { Label("Me", systemImage: "person.3") }
        }
        .environmentObject(prospects)
    }
}

#Preview {
    ContentView()
}
