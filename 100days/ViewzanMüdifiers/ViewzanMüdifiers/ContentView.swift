//
//  ContentView.swift
//  ViewzanMüdifiers
//
//  Created by markd on 3/11/22.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = true

    var motto1: some View {
        Text("Greeble Bork")
    }
    let motto2 = Text("Fnord Blork")

    var body: some View {
        VStack {
            motto1
              .foregroundColor(.red)
            motto2
              .foregroundColor(.blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
