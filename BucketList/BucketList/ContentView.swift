//
//  ContentView.swift
//  BucketList
//
//  Created by M Sapphire on 2023/12/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("read and write") {
            let data = Data("Test message".utf8)
            let url = URL.documentsDirectory.appending(path: "message.txt")
            
            do {
                try data.write(to: url, options: [.atomic, .completeFileProtection])
                let input = try String(contentsOf: url)
                print(input)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
