//
//  AddBook.swift
//  BookWorm
//
//  Created by M Sapphire on 2023/12/13.
//
import SwiftData
import SwiftUI

struct AddBook: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var rating = 3
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter the book name", text: $title)
                    
                    TextField("Enter the author name", text: $author)
                    
                    Picker("Select the genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("White the review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, rating: rating, review: review)
                        
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .disabled(isBookInValid())
                }
            }
            .navigationTitle("Add book")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func isBookInValid() -> Bool{
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        return false
    }
}

#Preview {
    AddBook()
}
