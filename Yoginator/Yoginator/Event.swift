import Combine
import Foundation

enum Event {
    case play
    case pause
}


protocol EventSubscriber: class {
    func play()
    func pause()
}

extension EventSubscriber {
    func play() {}
    func pause() {}

    func eventSubscribe(publisher: AnyPublisher<Event, Never>) -> AnyCancellable {
        publisher
          .receive(on: DispatchQueue.main)
          .sink { [weak self] event in
              switch event {
              case .play:
                  self?.play()
                  print("PLAY FROM THUNK")
              case .pause:
                  self?.pause()
                  print("PAUSE FROM THUNK")
              }
          }
    }
}
