//
//  ContentView.swift
//  ViewzanMüdifiers
//
//  Created by markd on 3/11/22.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = true

    var body: some View {
        Button("Hello World") {
            useRedText.toggle()
        }
        .foregroundColor(useRedText ? .red : .blue)

        VStack {
            Text("Greeble")
            Text("Bork")
              .font(.largeTitle)
            Text("Hoover")
            Text("Fnord")
        }
          .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
