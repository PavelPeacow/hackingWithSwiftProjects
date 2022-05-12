//
//  ContentView.swift
//  WordScramble
//
//  Created by Павел Кай on 12.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            List {
                Text("Your score is \(score)")
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                    
                }
            }
            .navigationTitle(rootWord)
        }
        .onSubmit(addNewWord)
        .onAppear(perform: startGame)
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isSameWord(word: answer) else {
            wordError(title: "Same word!", message: "You typed the same word!")
            return
        }
        
        guard isBiggerThanThree(word: answer) else {
            wordError(title: "Short word", message: "Word shorter than three letter")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't speel that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        score += answer.count
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
       
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isSameWord(word: String) -> Bool {
        word != rootWord
    }
    
    func isBiggerThanThree(word: String) -> Bool {
        return word.count >= 3
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func startGame() {
        if let starWorldURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            
            if let startWords = try? String(contentsOf: starWorldURL) {
                
                let allWorld = startWords.components(separatedBy: "\n")
                rootWord = allWorld.randomElement() ?? "silkworm"
                return
                
            }
            
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
