import SwiftUI
import UIKit

struct ContentView: View {
    @State private var newItem = ""
    @State private var items: [String] = ["Greeble", "Bork"]
    @State private var randomItem = ""

    var body: some View {
        VStack {
            Text("Choosinator")
              .padding()
            TextField("Something to do", text: $newItem, 
                      onCommit: {
                          items += [newItem]
                          newItem = ""
                          // ??? How to re-focus text field when adding an item
                      })
            Button("Choose one") {
                randomItem = items.randomElement() ?? ""
            }
            Text(randomItem)
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
