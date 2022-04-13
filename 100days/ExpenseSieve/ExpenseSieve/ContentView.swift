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

struct ExpenseItem {
    let name: String
    let type: String
    let amount: Double // baby Jesus is crying
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}


struct ContentView: View {
    @StateObject var expenses = Expenses()

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.name) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .toolbar {
                Button {
                    let expense = ExpenseItem(name: "Test", type: "Personal",
                                              amount: 5)
                    expenses.items.append(expense)
                } label: {
                    Image(systemName: "tortoise")
                }
            }
        }
        .navigationTitle("Splunge")
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
