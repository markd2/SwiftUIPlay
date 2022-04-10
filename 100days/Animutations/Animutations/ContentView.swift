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
        print(animationAmount)

        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                                      .easeInOut(duration: 1)
                                        .repeatCount(3, autoreverses: true)
                                    ),
                    in: 1...10)
            Spacer()

            Button("Bite Me") {
                animationAmount += 1
            }
              .padding(40)
            .background(.purple)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
