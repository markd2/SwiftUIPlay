//
//  ContentView.swift
//  ViewzanMüdifiers
//
//  Created by markd on 3/11/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Sneegleflunge")
          .padding()
          .background(.red)
          .padding()
          .background(.blue)
          .padding()
          .background(.green)
          .padding()
          .background(.yellow)
          .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
