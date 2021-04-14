import Combine
import Foundation

enum Event {
    case play
    case pause
    case next
}


protocol EventSubscriber: class {
    func play()
    func pause()
    func next()
}

extension EventSubscriber {
    func play() {}
    func pause() {}
    func next() {}

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

              case .next:
                  self?.next()
                  print("NEXT FROM THUNK")
              }
          }
    }
}
