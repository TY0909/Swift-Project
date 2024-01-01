//
//  AddView.swift
//  HabitTracking
//
//  Created by M Sapphire on 2023/12/6.
//

import SwiftUI

struct AddView: View {
    @State private var imageName: String = "baseball"
    @State private var habitName: String = ""
    @State private var LastDays: Int = 0
    var habitsItems: Habits
    @Environment(\.dismiss) var dismiss
    
    let imageTypes = ["baseball", "basketball"]
    var body: some View {
        NavigationStack {
            Form {
                Picker("Select the Image", selection: $imageName) {
                    ForEach(imageTypes, id: \.self) { types in
                        Text(types)
                    }
                }
                
                TextField("HabitName", text: $habitName)
                Picker("Last Day(s)", selection: $LastDays) {
                    ForEach(0..<1000) { day in
                        Text(String(day))
                    }
                }
                .navigationTitle("Add new habit")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancle") {
                            dismiss()
                        }
                            .padding(.horizontal)
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            let item = HabitItem(imageName: imageName.lowercased(), habitName: habitName, days: LastDays)
                            habitsItems.items.append(item)
                            dismiss()
                        }
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    AddView(habitsItems: Habits())
}
