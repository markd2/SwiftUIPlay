import SwiftUI

struct FlexibleSize: View {
    var body: some View {
        Text("Splunge Monkey")

//          .lineLimit(1)
//          .frame(maxWidth: 100)

          .frame(maxWidth: .infinity, alignment: .leading)
          .border(Color.red, width: 2)
    }
}

#Preview {
    FlexibleSize()
}
