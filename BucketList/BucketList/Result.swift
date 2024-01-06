//
//  Result.swift
//  BucketList
//
//  Created by M Sapphire on 2024/1/4.
//

import Foundation

struct Result: Codable {
    var query: Query
}

struct Query: Codable {
    var page: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "no more information"
    }
    
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}
