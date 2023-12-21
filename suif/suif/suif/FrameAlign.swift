import SwiftUI

struct FrameAlign: View {
    var body: some View {
        Text("Splunge Monkey")
          .frame(width: 300, height: 300,
                 alignment: .topLeading)
          .border(.red, width: 2)
    }
}

#Preview {
    FrameAlign()
}
