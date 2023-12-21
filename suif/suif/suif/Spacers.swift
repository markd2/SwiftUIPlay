import SwiftUI

struct Spacers: View {
    var body: some View {
        HStack {
            Text("Splunge Monkey")
            Spacer() // causes text border to go from snugli to wide
        }
        .border(.red, width: 2)
    }
}

#Preview {
    Spacers()
}
