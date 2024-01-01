//
//  Day60_ChallengeApp.swift
//  Day60_Challenge
//
//  Created by M Sapphire on 2023/12/20.
//

import SwiftData
import SwiftUI

@main
struct Day60_ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
