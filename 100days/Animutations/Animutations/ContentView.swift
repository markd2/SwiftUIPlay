//
//  ContentView.swift
//  Animutations
//
//  Created by markd on 4/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0

    var body: some View {
        Button("Bite Me") {
            withAnimation {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .clipShape(Circle())
        .foregroundColor(.white)
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
