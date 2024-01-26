//
//  EditView.swift
//  FlashZilla
//
//  Created by M Sapphire on 2024/1/25.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPormpt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Prompt:", text: $newPormpt)
                    TextField("Answer", text: $newAnswer)
                    Button("Save", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeCard(at: indexSet)
                    })
                }
            }
            .navigationTitle("Edit cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
    }
    
    
    func done() {
        dismiss()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decode = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decode
            }
        }
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.setValue(data, forKey: "Cards")
        }
    }
    
    func addCard() {
        let trimedPormpt = newPormpt.trimmingCharacters(in: .whitespaces)
        let trimedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimedAnswer.isEmpty == false && trimedPormpt.isEmpty == false else { return }
        
        let card = Card(prompt: trimedPormpt, answer: trimedAnswer)
        cards.insert(card, at: 0)
        saveData()
        newPormpt = ""
        newAnswer = ""
    }
    
    func removeCard(at offSet: IndexSet) {
        cards.remove(atOffsets: offSet)
        saveData()
    }
}

#Preview {
    EditView()
}
