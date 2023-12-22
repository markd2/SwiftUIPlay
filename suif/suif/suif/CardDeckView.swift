import SwiftUI

struct CardDeckView: View {
    var cards: [Card] = [
      Card(front: "What is 7+7", back: "14"),
      Card(front: "What is the airspeed velocity of an unladen swallow?", back: "african or european"),
      Card(front: "From what is cognac made?", back: "Grapes")
    ]

    var body: some View {
        TabView {
            ForEach(cards) { card in
                CardView(card: card)
            }
        }.tabViewStyle(.page)
    }
}

#Preview {
    CardDeckView().background(.gray)
}
