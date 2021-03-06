import SwiftUI
import Combine

typealias PhotoRemote = Remote<WebPhoto, Photo>

@main
struct TISch2App: App {
    var remote: PhotoRemote 

    var body: some Scene {
        WindowGroup {
            ContentView(remote: remote)
        }
    }

    init() {
        let url = URL(string: "https://picsum.photos/v2/list")!
        self.remote = Remote(url: url)
        remote.load() { webItem in
            return Photo(webPhoto: webItem)
        }
    }
}

class Remote<WebType, RealType>: ObservableObject where WebType: Decodable {
    var flunge: AnyCancellable?
    
    let url: URL
    @Published public private(set) var loadedData: [RealType]? = nil

    init(url: URL) {
        self.url = url
    }

    init() {
        url = URL(string: "https://picsum.photos/v2/list")!
    }

    func load(converter: @escaping (WebType) -> RealType) {
        flunge = URLSession.shared.dataTaskPublisher(for: url)
          .map { $0.data }
          .decode(type: [WebType].self, decoder: JSONDecoder())
          .map { $0.map { webItem in converter(webItem) } }
          .receive(on: OperationQueue.main)
          .sink(receiveCompletion: { status in
                    print("status´ \(status)")
                },
                receiveValue: { blargle in
                    print("blargle \(blargle)")
                    self.loadedData = blargle
                })
    }
}

struct Photo: Identifiable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: URL
    let downloadUrl: URL

    init(webPhoto: WebPhoto) {
        self.id = webPhoto.id ?? ""
        self.author = webPhoto.author ?? ""
        self.width = webPhoto.width ?? 0
        self.height = webPhoto.height ?? 0
        self.url = URL(string: webPhoto.url!)!
        self.downloadUrl = URL(string: webPhoto.download_url!)!
    }
    
}

struct WebPhoto: Codable {
    let id: String?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let download_url: String?
}
