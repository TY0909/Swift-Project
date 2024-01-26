//
//  Card.swift
//  FlashZilla
//
//  Created by M Sapphire on 2024/1/23.
//

import Foundation

struct Card: Codable {
    var id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
