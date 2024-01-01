//
//  ContentView.swift
//  Navigation
//
//  Created by M Sapphire on 2023/12/1.
//

import SwiftUI
@Observable
class PathStore {
    var path: [Int] {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
                path = decoded
                return
            }
        }
        
        path = []
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(path)
            try data.write(to: savePath)
        } catch {
            print("Failed to save Navigation data")
        }
    }
}

struct DetailView: View {
    var number: Int
    @Binding var path: [Int]
    
    var body: some View {
        NavigationLink("Go to the random number", value: Int.random(in: 1...1000))
            .navigationTitle("Random Number: \(number)")
            .toolbar {
                Button("Home") {
                    path.removeAll()
                }
            }
    }
}

struct ContentView: View {
    @State private var pathStroe = PathStore()
    @State private var str = ""
    var body: some View {
        /*
        NavigationStack(path: $pathStroe.path) {
            DetailView(number: 0, path: $pathStroe.path)
                .navigationDestination(for: Int.self) { number in
                    DetailView(number: number, path: $pathStroe.path)
                }
        }
         */
        NavigationStack {
            List {
                TextField("Hello world", text: $str)
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            Button("tap me") {
                                
                            }
                        }
                    }
                    .keyboardType(.default)
            }
        }
    }
}

#Preview {
    ContentView()
}
