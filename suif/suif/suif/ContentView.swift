//
//  ContentView.swift
//  suif
//
//  Created by Mark Dalrymple on 12/21/23.
//

import SwiftUI

struct ContentView: View {
    var text: String = "Splunge Monkey"

    var body: some View {
        ZStack {
            Text(text)
              .font(.system(size: 24))
              .bold()
              .multilineTextAlignment(.center)
            Image(systemName: "arrow.left.arrow.right.circle.fill")
              .font(.system(size: 36))
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

#Preview {
    VStack {
        ContentView(text: "oopack")
    }
}

#Preview {
    ContentView(text: "Once upon a midnight dreary while I pondered weak and weary over many a quaint and curious volume of Klingon lore")
}
