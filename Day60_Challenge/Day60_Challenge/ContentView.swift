//
//  ContentView.swift
//  Day60_Challenge
//
//  Created by M Sapphire on 2023/12/20.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var usersQuery: [User]
    
    var body: some View {
        NavigationStack {
            List(usersQuery) { people in
                NavigationLink {
                    DetailView(user: people)
                } label: {
                    HStack {
                        Text(people.name)
                        Spacer()
                        
                        Image(systemName: "circle.fill")
                            .foregroundStyle(people.isActive ? Color.green : Color.red)
                    }
                }
            }
            .navigationTitle("Day60_Challenge")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Delete", systemImage: "trash") {
                        try? modelContext.delete(model: User.self)
                    }
                }
            }
            .onAppear {
                Task {
                    if usersQuery.isEmpty {
                        await FetchData()
                    }
                }
            }
        }
    }
    
    func FetchData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print("Get data, \(data)")
            
            let decoded = try JSONDecoder().decode([User].self, from: data)
            
            for item in decoded {
                modelContext.insert(item)
            }
        } catch {
            print("Error: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
