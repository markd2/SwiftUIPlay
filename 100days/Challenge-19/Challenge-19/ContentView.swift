//
//  ContentView.swift
//  Challenge-19
//
//  Created by markd on 3/10/22.
//

import SwiftUI

struct ContentView: View {
    enum Units: String {
        case celsius
        case freedom
        case kelvin
    }
    @State var fromUnits: Units = .freedom
    @State var toUnits: Units = .kelvin
    @State var value: Double = 0

    @FocusState private var amountIsFocused: Bool

    let allUnits = [Units.celsius, .freedom, .kelvin]

    var converted: Double {
        let kelvinValue: Double

        switch fromUnits {
        case .celsius:
            kelvinValue = value + 273.15
        case .kelvin:
            kelvinValue = value
        case .freedom:
            kelvinValue = (value - 32)  * 5/9 + 273.15
        }

        let resultValue: Double

        switch toUnits {
        case .celsius:
            resultValue = kelvinValue - 273.15
        case .kelvin:
            resultValue = kelvinValue
        case .freedom:
            resultValue = (kelvinValue - 273.15) * 9/5 + 32
        }

        return resultValue
    }

    var body: some View {
        Form {
            Section {
                Picker("From Units", selection: $fromUnits) {
                    ForEach(allUnits, id: \.self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("From Units")
            }

            Section {
                TextField("Amoont", value: $value, format: .number)
                  .keyboardType(.decimalPad)
                  .focused($amountIsFocused)
            }

            Section {
                Picker("To Units", selection: $toUnits) {
                    ForEach(allUnits, id: \.self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("To Units")
            }

            Section {
                Text(converted, format: .number)
            } header: {
                Text("Result")
            }
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
