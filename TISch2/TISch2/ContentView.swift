import SwiftUI
import Combine

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
    @State var image: UIImage? = nil

    init(metadata: Photo) {
        self.metadata = metadata
        // TODO - don't load it immediately like this, wait until it's
        // visible. ++md 6-march-2021
        loadImage()
    }

    @State var handle: AnyCancellable?

    func loadImage() {
        print("\(metadata.downloadUrl)")
        handle = URLSession.shared.dataTaskPublisher(for: metadata.downloadUrl)
          .map { $0.data }
          .map { UIImage(data: $0) }
          .sink(receiveCompletion: { status in
                    print("status´ \(status)")
                },
                receiveValue: { image in
                    self.image = image
                })
    }

    var body: some View {
        VStack {
            Text("\(metadata.author)")
            if let image = image {
                Image(uiImage: image).resizable()
                  .aspectRatio(contentMode: .fit)
            } else {
                Image("loading-placeholder")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(remote: PhotoRemote())
    }
}
