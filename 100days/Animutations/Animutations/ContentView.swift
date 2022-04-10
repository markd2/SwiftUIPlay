//
//  ContentView.swift
//  Animutations
//
//  Created by markd on 4/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Bite Me") {
            animationAmount += 0.3
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        // .animation(.interpolatingSpring(stiffness: 50, damping: 1),
        // value: animationAmount)
        .animation(.easeInOut(duration: 2)
                     // .repeatCount(3, autoreverses: true)
                     .repeatForever(autoreverses: true),
                   // .delay(1),
                   value: animationAmount)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
