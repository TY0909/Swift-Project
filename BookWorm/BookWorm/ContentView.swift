//
//  ContentView.swift
//  BookWorm
//
//  Created by M Sapphire on 2023/12/12.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    
    @State private var showAddscreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating == 1 ? .red : .black)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    deleteBook(at: indexSet)
                })
            }
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .navigationTitle("Book warm")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem {
                    Button("Add book", systemImage: "plus") {
                        showAddscreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showAddscreen) {
                AddBook()
            }
        }
    }
    
    func deleteBook(at offSets: IndexSet) {
        for offSet in offSets {
            let book = books[offSet]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
