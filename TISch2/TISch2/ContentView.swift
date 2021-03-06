import SwiftUI

struct ContentView: View {
    @ObservedObject var remote: PhotoRemote

    init(remote: PhotoRemote) {
        self.remote = remote
    }

    var body: some View {
        Text("Splunge")
            .padding()
        Text("Blargle \(remote.loadedData?.count ?? -666)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(remote: PhotoRemote())
    }
}
