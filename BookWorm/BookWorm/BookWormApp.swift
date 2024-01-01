//
//  BookWormApp.swift
//  BookWorm
//
//  Created by M Sapphire on 2023/12/12.
//
import SwiftData
import SwiftUI

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
