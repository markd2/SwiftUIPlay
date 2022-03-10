//
//  ContentView.swift
//  WeSplitte
//
//  Created by markd on 3/9/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Snorglepants2")
                }
            }
            .navigationTitle("Snorgle")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
