//
//  ContentView.swift
//  WordScramble
//
//  Created by M Sapphire on 2023/11/17.
//
import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word here", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
                
                Section {
                    Text("Score: \(usedWords.count)")
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWords)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
            } message: {
                 Text(errorMessage)
            }
            .toolbar {
                Button("Restart") {
                    RestartGame()
                }
            }
        }
    }
    
    func addNewWords() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard wordShortOrRootWord(word: answer) else {
            wordError(title: "word to short or is rootword", message: "The word is smalled the 3 letter or is just the rootword")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not found", message: "You can't spell this word")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allwords = startWords.components(separatedBy: "\n")
                
                rootWord = allwords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from the bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            }else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let missSpelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return missSpelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func wordShortOrRootWord(word: String) -> Bool{
        if word == rootWord || word.count <= 3 {
            return false
        }
        return true
    }
    
    func RestartGame() {
        usedWords.removeAll()
        startGame()
    }
}

#Preview {
    ContentView()
}
