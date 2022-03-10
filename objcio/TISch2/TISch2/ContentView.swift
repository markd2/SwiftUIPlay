import SwiftUI
import Combine

struct PhotosList: View {
    var photos: [Photo]

    var body: some View {
        List {
            ForEach(photos) { metadata in
                NavigationLink(destination: Text("blorf")) {
                    PhotoView(metadata: metadata)
                }
            }
        }
    }
}

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
                    PhotosList(photos: remote.loadedData ?? [])
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

struct PhotoView: View  {
    let metadata: Photo
    @ObservedObject var imageLoader: Loader<UIImage>

    init(metadata: Photo) {
        self.metadata = metadata
        imageLoader = Loader<UIImage>(url: metadata.downloadUrl) { data in
            UIImage(data:  data)!
        }
    }

    var body: some View {
        VStack {
            Text("\(metadata.author)")
            if let image = imageLoader.value {
                Image(uiImage: image).resizable()
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
