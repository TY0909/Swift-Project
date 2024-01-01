//
//  Book.swift
//  BookWorm
//
//  Created by M Sapphire on 2023/12/13.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var rating: Int
    var review: String
    var date: String {
        let tempDate = Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: tempDate)
    }
    
    init(title: String, author: String, genre: String, rating: Int, review: String) {
        self.title = title
        self.author = author
        self.genre = genre
        self.rating = rating
        self.review = review
    }
}
