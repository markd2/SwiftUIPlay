//
//  ContentView.swift
//  suif
//
//  Created by Mark Dalrymple on 12/21/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .border(Color.purple)
            
            Text("Hello, world!")
                .border(Color.purple)
                .padding()

            Text("Hello, world!")
                .border(Color.purple)
                .padding()
                .border(Color.purple)
        }
    }
}

#Preview {
    ContentView()
}
