import Combine
import Foundation

enum Event {
    case play
    case pause
    case next
    case start
}


protocol EventSubscriber: class {
    func play()
    func pause()
    func next()
    func start()
}

extension EventSubscriber {
    func play() {}
    func pause() {}
    func next() {}
    func start() {}

    func eventSubscribe(publisher: AnyPublisher<Event, Never>) -> AnyCancellable {
        publisher
          .receive(on: DispatchQueue.main)
          .sink { [weak self] event in
              switch event {

              case .play:
                  self?.play()

              case .pause:
                  self?.pause()

              case .next:
                  self?.next()

              case .start:
                  self?.start()
              }
          }
    }
}
