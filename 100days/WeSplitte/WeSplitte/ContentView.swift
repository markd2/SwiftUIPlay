//
//  ContentView.swift
//  WeSplitte
//
//  Created by markd on 3/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalCheck: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = totalCheck / peopleCount

        return amountPerPerson
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amoont", value: $checkAmount, 
                              format: .currency(code: Locale.current.currencyCode ?? "USD"))
                      .keyboardType(.decimalPad)
                      .focused($amountIsFocused)
                    
                    Picker("Number of peepz", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }

                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< 101) {
                            Text(\($0 %), format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tippage?")
                }

                Section {
                    Text(totalPerPerson, 
                         format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per peep")
                }

                Section {
                    Text(totalCheck, 
                         format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total Checkage")
                }

            }.navigationTitle("WeSplitte")
              .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
