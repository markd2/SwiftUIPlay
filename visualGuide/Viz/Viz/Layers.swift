import SwiftUI

struct Layers: View {
    var body: some View {
        VStack(spacing: 40) {
            HeaderView(title: "Layers",
                       subtitle: "The Basics",
                       desc: "Can add layers on top (.overlay) and behind (.background)")

            
            
        }
          .font(.title)
        .ignoresSafeArea(edges: .bottom)
    }
}
