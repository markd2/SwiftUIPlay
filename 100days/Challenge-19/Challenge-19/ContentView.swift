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
    let allUnits = [Units.celsius, .freedom, .kelvin]

    var body: some View {
        Form {
            Section {
                Picker("From Units", selection: $fromUnits) {
                    ForEach(allUnits, id: \.self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section {
b                Picker("To Units", selection: $toUnits) {
                    ForEach(allUnits, id: \.self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }


        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
