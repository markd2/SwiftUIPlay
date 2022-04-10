//
//  ContentView.swift
//  WordScrambule
//
//  Created by markd on 4/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    init() {
        if let fileURL = Bundle.main.url(forResource: "start",
                                         withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                print("YAY!")
            }
        }
    }

    var body: some View {
        NavigationView {
            List {
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
        }
          .navigationTitle(rootWord)
        .onSubmit(addNewWord)
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
