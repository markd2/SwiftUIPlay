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

struct ExpenseItem: Identifiable, Codable {
    var id = UUID() // uh... x2  Isn't creating this every time in a struct bad? Then hacking it to var because of codable?  todo: put uuidgen into an initializer
    let name: String
    let type: String
    let amount: Double // baby Jesus is crying
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self,
                                                            from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}


struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "tortoise")
                }
            }
        }
        .navigationTitle("Splunge")
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
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


struct AddView: View {
    @State private var name = ""
    @State private var type = "impersonal"
    @State private var amount = 0.0

    @ObservedObject var expenses: Expenses

    @Environment(\.dismiss) var dismiss

    let types = ["bidness", "impersonal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount,
                          format: .currency(code: "USD"))
                  .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item) // ewww
                    dismiss()
                }
            }
        }
    }
}
