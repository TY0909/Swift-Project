//
//  DetailView.swift
//  HabitTracking
//
//  Created by M Sapphire on 2023/12/6.
//

import SwiftUI

struct DetailView: View {
    var habit: HabitItem
    var habitsArray: Habits
    @State private var showingButton = true
    
    var body: some View {
        NavigationStack {
            HStack {
                Image(systemName: habit.imageName)
                    .imageScale(.large)
                Text(habit.habitName)
                    .font(.title)
            }
            
            VStack {
                Text("Last Days: \(habit.days + (showingButton ? 0 : 1))")
                    .font(.headline)
                    .padding(.vertical)
                
                if showingButton {
                    Button("Click") {
                        let newhabit = HabitItem(imageName: habit.imageName, habitName: habit.habitName, days: habit.days + 1)
                        let index = habitsArray.items.firstIndex(where: {$0 == habit})
                        habitsArray.items[index ?? 0] = newhabit
                        withAnimation {
                            showingButton.toggle()
                        }
                    }
                    .padding(20)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 20))
                }
                
                if !showingButton {
                    Text("OK")
                        .font(.title)
                }
            }
        }
    }
}

#Preview {
    let testitem = HabitItem(imageName: "baseball", habitName: "baseball", days: 2)
    return DetailView(habit: testitem, habitsArray: Habits())
}
