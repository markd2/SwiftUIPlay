//
//  ContentView.swift
//  ViewzanMüdifiers
//
//  Created by markd on 3/11/22.
//

import SwiftUI

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
          .font(.largeTitle)
          .padding()
          .foregroundColor(.white)
          .background(.blue)
          .clipShape(Capsule())
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
            CapsuleText(text: "Snorkle")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
