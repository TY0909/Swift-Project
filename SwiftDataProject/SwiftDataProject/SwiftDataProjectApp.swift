//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by M Sapphire on 2023/12/16.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
