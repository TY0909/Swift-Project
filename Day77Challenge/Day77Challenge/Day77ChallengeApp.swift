//
//  Day77ChallengeApp.swift
//  Day77Challenge
//
//  Created by M Sapphire on 2024/1/10.
//

import SwiftData
import SwiftUI

@main
struct Day77ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Picture.self)
    }
}
