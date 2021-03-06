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

var cancellables = [AnyCancellable]()

struct PhotoView: View {
    let metadata: Photo
//    @State private var image: UIImage = UIImage(named: "loading-placeholder")!
    @State private var image: Image = Image("loading-placeholder")

    init(metadata: Photo) {
        self.metadata = metadata
        // TODO - don't load it immediately like this, wait until it's
        // visible. ++md 6-march-2021
        loadImage()
    }

    @State var handle: AnyCancellable?

    func loadImage() {
        print("\(metadata.downloadUrl)")
        URLSession.shared.dataTaskPublisher(for: metadata.downloadUrl)
          .map { $0.data }
          .map { UIImage(data: $0)! } // FIXME
          .sink(receiveCompletion: { status in
                    print("status \(status)")
                },
                receiveValue: { imagex in
                    image = Image(uiImage: imagex)
                })
        .store(in: &cancellables)
    }

    var body: some View {
        VStack {
            Text("\(metadata.author)")
            image.resizable()
              .aspectRatio(contentMode: .fit)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(remote: PhotoRemote())
    }
}
