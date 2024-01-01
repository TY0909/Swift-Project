//
//  ContentView.swift
//  HabitTracking
//
//  Created by M Sapphire on 2023/12/6.
//

import SwiftUI
struct HabitItem: Codable, Identifiable,Equatable {
    var id = UUID()
    let imageName: String
    let habitName: String
    let days: Int
}
@Observable
class Habits {
    var items = [HabitItem]() {
        didSet {
            if let decoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(decoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
struct ContentView: View {
    @State private var habitsTrackingItems = Habits()
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habitsTrackingItems.items) { item in
                    NavigationLink {
                        DetailView(habit: item, habitsArray: habitsTrackingItems)
                    } label: {
                        HStack {
                            Image(systemName: item.imageName)
                                .padding(.horizontal)
                            
                            Text(item.habitName)
                                .font(.headline)
                            
                            Spacer()
                            Text(item.days <= 1 ? "Last Day: \(item.days)" : "Last Days: \(item.days)")
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    habitsTrackingItems.items.remove(atOffsets: indexSet)
                })
            }
            .navigationTitle("Habit Tracking")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    showingAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddView, content: {
                AddView(habitsItems: habitsTrackingItems)
            })
        }
    }
}

#Preview {
    ContentView()
}
