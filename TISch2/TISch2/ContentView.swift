import SwiftUI

struct ContentView: View {
    @ObservedObject var remote: PhotoRemote
    
    init(remote: PhotoRemote) {
        self.remote = remote
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if let photos = remote.loadedData {
                    Text("Blargle \(photos.count)")
                    
                    Text("Flongwaffle")
                    NavigationLink(destination: Text("Snorgle")) {
                        Text("Linky")
                    }
                    List {
                        ForEach(photos) { metadata in
                            NavigationLink(destination: Text("blorf")) {
                                PhotoView(metadata: metadata)
                            }
                        }
                    }
                } else {
                    Text("Splunge")
                      .padding()
                }
            }
            .navigationBarTitle("Florp")
        }
    }
}

struct PhotoView: View {
    let metadata: Photo
    var body: some View {
        VStack {
            Text("\(metadata.author)")
            Image("loading-placeholder")
              .resizable()
              .aspectRatio(contentMode: .fit)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(remote: PhotoRemote())
    }
}
