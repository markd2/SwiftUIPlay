import SwiftUI

struct Snacks: View {
    var body: some View {
        HStack {
            Image(systemName: "waveform.circle.fill")
              .foregroundColor(.mint)
              .font(.system(size: 50))

            VStack(alignment: .leading) {
                Text("Steve Rules")
                  .font(.title)
                Text("Blah Blah Blah")
            }
        }
    }
}

#Preview {
    Snacks()
}
