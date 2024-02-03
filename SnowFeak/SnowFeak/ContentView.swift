//
//  ContentView.swift
//  SnowFeak
//
//  Created by M Sapphire on 2024/1/31.
//

import SwiftUI

struct ContentView: View {
    enum sortedRules {
        case none, byWord, byCountry
    }
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    @StateObject var favorites = Favorites()
    @State private var sortedRule = sortedRules.none
    
    var filterRersorts: [Resort] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    var sortedResorts: [Resort] {
        switch sortedRule {
        case .none:
            return filterRersorts
        case .byWord:
            return filterRersorts.sorted(by: { $0.name < $1.name })
        case .byCountry:
            return filterRersorts.sorted(by: { $0.country < $1.country })
        }
    }
    var body: some View {
        NavigationView {
            List(sortedResorts) { item in
                NavigationLink {
                    ResortView(resort: item)
                } label: {
                    HStack {
                        Image(item.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 20)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 1)
                            )
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text("\(item.runs) runs")
                        }
                        
                        if favorites.contains(item) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite rersort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem {
                    Menu {
                        Button("sorted by name") { sortedRule = .byWord }
                        Button("sorted by country") { sortedRule = .byCountry }
                        Button("default") { sortedRule = .none }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down.circle")
                    }
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

#Preview {
    ContentView()
}
