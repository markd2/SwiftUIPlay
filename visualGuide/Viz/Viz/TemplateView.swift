import SwiftUI

struct TemplateView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Splunge")
              .font(.largeTitle)

            Text("SubSplunge")
              .font(.title)
              .foregroundColor(.gray)

            Text("Stuff for demonstrations go here. Yay!!")
              .frame(maxWidth: .infinity) // extend until you can't no mo
              .font(.title)
              .foregroundColor(.white)
              .padding() // add space all around the text
              .background(.blue)
        }
    }
}
