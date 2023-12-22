//
//  ContentView.swift
//  suif
//
//  Created by Mark Dalrymple on 12/21/23.
//

import SwiftUI

struct Card: Identifiable {
    var front: String
    var back: String
    var id = UUID()
}

struct CardView: View {
    var card: Card

    @State var isBackVisible = false
    var degrees: Double {
        isBackVisible ? 180 : 0
    }

    var body: some View {
        ZStack {
            Group {
                Text(card.back)
                .scaleEffect(x: -1)
                .opacity(isBackVisible ? 1: 0)

                Text(card.front)
                  .opacity(isBackVisible ? 0: 1)

            }
              .font(.system(size: 24))
              .bold()
              .multilineTextAlignment(.center)

            Button {
                withAnimation {
                    isBackVisible.toggle()
                }
            } label: {
                Image(systemName: "arrow.left.arrow.right.circle.fill")
                  .font(.system(size: 36))
            }
              .frame(maxWidth: .infinity, maxHeight: .infinity,
                     alignment: .bottomTrailing)
        }
          .padding()
          .frame(width: 300, height: 225)
          .background(.orange)
          .cornerRadius(10)
          .shadow(radius: 10)
          .padding()
          .rotation3DEffect(.degrees(degrees), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
}

struct ContentView: View {
    var body: some View {
        CardView(card: Card(front: "What is 7 + 7?", back: "14"))
    }
}

#Preview {
    VStack {
        CardView(card: Card(front: "What is 7 + 7?", back: "14"))
    }
}

#Preview {
    VStack {
        CardView(card: Card(front: "What is the airspeed velolicity of an unladen swallow?",
                            back: "African or European?"))
    }
}

#if false
#Preview {
    CardView(text: "Once upon a midnight dreary while I pondered weak and weary over many a quaint and curious volume of Klingon lore")
}
#endif
