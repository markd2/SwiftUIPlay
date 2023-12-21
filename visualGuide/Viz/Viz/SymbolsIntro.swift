import SwiftUI

struct SymbolsIntro: View {
    var body: some View {
        VStack(spacing: 20) {
            HeaderView(title: "Images",
                       subtitle: "Using SF Symbols",
                       desc: "Using icons and whatnot to add clarity to demonstrations. Can be found in the Symbol Font Library or SF Symbols")
            
            // systemname: for SF Symbols
            Image(systemName: "hand.thumbsup.fill")
              .font(.largeTitle)
            
            Image("SF Symbols")
        }
          .font(.title)
        .ignoresSafeArea(edges: .bottom)
    }
}
