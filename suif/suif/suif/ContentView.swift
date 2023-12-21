//
//  ContentView.swift
//  suif
//
//  Created by Mark Dalrymple on 12/21/23.
//

import SwiftUI

struct Card {
    var front: String
    var back: String
}

struct CardView: View {
    var card: Card
     @State var isBackVisible = false

    var body: some View {
        ZStack {
            Text(isBackVisible ? card.back : card.front)
              .font(.system(size: 24))
              .bold()
              .multilineTextAlignment(.leading)

            Button {
                isBackVisible.toggle()
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
