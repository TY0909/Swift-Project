//
//  Prospect.swift
//  HotProSpects
//
//  Created by M Sapphire on 2024/1/15.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name: String = "Sapphire"
    var emailAddress: String = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let saveDataKey = "SaveData"
    
    init() {
//        if let data = UserDefaults.standard.data(forKey: saveDataKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                self.people = decoded
//                return
//            }
//        }
        do {
            if let fileDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let url = fileDirectory.appendingPathComponent("data", conformingTo: .json)
                let data = try Data(contentsOf: url)
                let decoded = try JSONDecoder().decode([Prospect].self, from: data)
                self.people = decoded
                return
            }
        } catch {
            print("failed to read data")
        }
        self.people = []
    }
    
    private func save() {
        do {
            if let data = try? JSONEncoder().encode(self.people) {
                //UserDefaults.standard.set(data, forKey: saveDataKey)
                if let fileDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let url = fileDirectory.appendingPathComponent("data", conformingTo: .json)
                    try data.write(to: url)
                }
            }
        } catch {
            print("save error")
        }
    }
    
    func add(_ prospect: Prospect) {
        self.people.append(prospect)
        save()
    }
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func rankByName() {
        self.people = self.people.sorted(by: { $0.name < $1.name })
    }
    func rankByEmail() {
        self.people = self.people.sorted(by: { $0.emailAddress < $1.emailAddress })
    }
}
