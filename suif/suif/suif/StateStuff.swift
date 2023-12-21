import SwiftUI

struct StateStuff: View {
    @State var count = 0

    var body: some View {
        VStack {
            if count <= 9_000 {
                Text("Count: \(count)")
            } else {
                HStack {
                    Image(systemName: "exclamationmark.circle")
                    Text("OVER 9000!!!1!!")
                }
            }

            Button("Snorgle") {
                count += 1  // by changing this, it automatially forces a refresh
            } 
        }
    }
}

#Preview {
    StateStuff()
}

#Preview {
    StateStuff(count: 8998)
}
