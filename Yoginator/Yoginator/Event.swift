import Combine
import Foundation

enum Event {
    case pause
    case resume
    case next
    case start
}

typealias EventPassthroughPublisher = PassthroughSubject<Event, Never>
typealias EventPublisher = AnyPublisher<Event, Never>

protocol EventSubscriber: class {
    func pause()
    func resume()
    func next()
    func start()
}

extension EventSubscriber {
    func pause() {}
    func resume() {}
    func next() {}
    func start() {}

    func eventSubscribe(publisher: EventPublisher) -> AnyCancellable {
        publisher
          .receive(on: DispatchQueue.main)
          .sink { [weak self] event in
              switch event {

              case .pause:
                  self?.pause()

              case .resume:
                  self?.resume()

              case .next:
                  self?.next()

              case .start:
                  self?.start()
              }
          }
    }
}
