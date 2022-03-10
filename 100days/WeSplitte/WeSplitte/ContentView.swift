//
//  ContentView.swift
//  WeSplitte
//
//  Created by markd on 3/9/22.
//

import SwiftUI

struct ContentView: View {
    @State var name = "blork"

    var body: some View {
        Form {
            TextField("Greeble bork flonk", text: $name)
            Text("Snorglepants \(name)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
