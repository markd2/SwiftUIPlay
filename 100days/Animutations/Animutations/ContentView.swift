//
//  ContentView.swift
//  Animutations
//
//  Created by markd on 4/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]),
                                          startPoint: .topLeading,
                                          endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            // .animation(.spring(), value: dragAmount)
        .offset(dragAmount)
        .gesture(
          DragGesture()
            .onChanged { dragAmount = $0.translation }
            .onEnded { _ in 
                withAnimation(.spring()) {
                    dragAmount = .zero 
                }
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
