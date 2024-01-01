//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by M Sapphire on 2023/12/16.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [SortDescriptor(\User.name), SortDescriptor(\User.joinDate)]
    
    var body: some View {
        NavigationStack {
            UserView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
                .navigationTitle("Users")
                .toolbar {
                    
                    ToolbarItem {
                        Button("Add user", systemImage: "plus") {
                            let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                            let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                            let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                            let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

                            modelContext.insert(first)
                            modelContext.insert(second)
                            modelContext.insert(third)
                            modelContext.insert(fourth)
                        }
                    }
                    ToolbarItemGroup(placement: .topBarLeading) {
                        
                        Button("delete user", systemImage: "trash") {
                            try? modelContext.delete(model: User.self)
                        }
                    }
                    ToolbarItem {
                        Button(showingUpcomingOnly ? "showing Everyone" : "showing upcoming") {
                            showingUpcomingOnly.toggle()
                        }
                    }
                    
                    ToolbarItem {
                        Menu("Soprt", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("sort by name")
                                    .tag([SortDescriptor(\User.name), SortDescriptor(\User.joinDate)])
                                
                                Text("sort by date")
                                    .tag([SortDescriptor(\User.joinDate), SortDescriptor(\User.name)])
                            }
                        }
                    }
                    
                }
        }
    }
}

#Preview {
    ContentView()
}
