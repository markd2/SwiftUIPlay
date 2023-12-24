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
    @Environment(\.accessibilityReduceMotion) var reduceMotion: Bool
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
                if reduceMotion {
                    isBackVisible.toggle()
                } else {
                    withAnimation {
                        isBackVisible.toggle()
                    }
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

private struct ScreamAtMeKey: EnvironmentKey {
    static let defaultValue = false
}

// Set via .environent(\.screamAtMe, true)
extension EnvironmentValues {
    var screamAtMe: Bool {
        get { self[ScreamAtMeKey.self] }
        set { self[ScreamAtMeKey.self] = newValue }
    }
}

// Set via .screamAtMe(true)
extension View {
    func screamAtMe(_  aaaaaah: Bool) -> some View {
        environment(\.screamAtMe, aaaaaah)
    }
}

struct ContentView: View {
    @State var cards: [Card] = [
      Card(front: "What is 7+7", back: "14"),
      Card(front: "What is the airspeed velocity of an unladen swallow?", back: "african or european"),
      Card(front: "From what is cognac made?", back: "Grapes")
    ]
    @State var isShowingCreateCardView = false

    var body: some View {
        ZStack {
            CardDeckView(cards: cards)
            
            Button {
                isShowingCreateCardView = true
            } label: {
                Image(systemName: "plus")
                  .font(.headline)
                  .padding()
                  .background(.orange)
                  .clipShape(Circle())
            }
              .padding([.top, .trailing])
              .frame(maxWidth: .infinity, maxHeight: .infinity,
                     alignment: .topTrailing)
        }.background(.gray)
          .sheet(isPresented: $isShowingCreateCardView) {
              CreateCardView()
                // .environment(\.screamAtMe, true)
              .screamAtMe(true)
          }
    }
}

#Preview {
    VStack {
        ContentView()
    }
}

