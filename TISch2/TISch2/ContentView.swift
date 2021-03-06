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
                        ForEach(photos) { photo in
                            NavigationLink(destination: Text("blorf")) {
                                Text("\(photo.author) : \(photo.width) x \(photo.height)")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(remote: PhotoRemote())
    }
}
