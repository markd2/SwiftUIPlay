import SwiftUI

struct ContentView: View {
    @ObservedObject var remote: PhotoRemote

    init(remote: PhotoRemote) {
        self.remote = remote
    }

    var body: some View {
        if let photos = remote.loadedData {
            Text("Blargle \(photos.count)")

            List {
                ForEach(photos) {
                    Text("\($0.author) : \($0.width) x \($0.height)")
                }
            }

        } else {
            Text("Splunge")
              .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(remote: PhotoRemote())
    }
}
