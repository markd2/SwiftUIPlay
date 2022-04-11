//
//  ContentView.swift
//  ExpenseSieve
//
//  Created by markd on 4/10/22.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Greeble"
    @Published var lastName = "Bork"
}


struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                      .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
              .toolbar {
                  EditButton()
              }
        }
    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
