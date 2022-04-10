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
            // animationAmount += 0.3
        }
        .onAppear {
            animationAmount = 2
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        // .scaleEffect(animationAmount)
        // .blur(radius: (animationAmount - 1) * 3)
        .overlay(
          Circle()
            .stroke(.blue)
            .scaleEffect(animationAmount)
            .opacity(2 - animationAmount)
            .animation(.easeInOut(duration: 2)
                         .repeatForever(autoreverses: false),
                       value: animationAmount)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
