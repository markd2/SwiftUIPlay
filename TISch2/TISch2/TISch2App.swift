import SwiftUI
import Combine

@main
struct TISch2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    init() {
        loadPhoto()
    }

    var remote: Remote<WebPhoto, Photo>?

    mutating func loadPhoto() {
        let url = URL(string: "https://picsum.photos/v2/list")!
        remote = Remote(url: url)
        remote?.load() { webItem in
            return Photo(webPhoto: webItem)
        }
    }
}

class Remote<WebType, RealType>: ObservableObject where WebType: Decodable {
    var flunge: AnyCancellable?
    
    let url: URL
    var loadedData: [RealType]? = nil

    init(url: URL) {
        self.url = url
    }

    func load(converter: @escaping (WebType) -> RealType) {
        flunge = URLSession.shared.dataTaskPublisher(for: url)
          .map { $0.data }
          .decode(type: [WebType].self, decoder: JSONDecoder())
          .map { $0.map { webItem in converter(webItem) } }
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
