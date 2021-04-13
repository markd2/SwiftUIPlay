import Combine
import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var sequence: Sequence?

    var runPanelViewModel: RunPanelViewModel!

    private let events = PassthroughSubject<Event, Never>()
    private let playbackState = CurrentValueSubject<Bool, Never>(false)

    private var heartbeatTimer: AnyCancellable?

    private var subscribers = [AnyCancellable]()

    init() {
        let bootstrapRPVM = RunPanelViewModel.hardcoded

        runPanelViewModel = RunPanelViewModel(
          text: bootstrapRPVM.text,
          runPose: bootstrapRPVM.runPose,
          timeLeftInPose: bootstrapRPVM.timeLeftInPose,
          classTime: bootstrapRPVM.classTime,
          events: events,
          playbackState: playbackState.eraseToAnyPublisher())

        start()

        let eventSubscription = eventSubscribe(publisher: events.eraseToAnyPublisher())
        subscribers.append(eventSubscription)
    }

    func start() {
        let start = Date()
        playbackState.value = true

        heartbeatTimer = Timer.publish(every: 1.0, on: .main, in: .common)
          .autoconnect()
        .map { timer in
            timer.timeIntervalSince(start)
        }
        .map { timeInterval in
            Int(timeInterval)
        }
        .sink { [weak self] seconds in
            print("lub dub \(seconds)")
            self?.runPanelViewModel.classTime = "snorgle \(seconds)"
        }
    }

}

extension ContentViewModel: EventSubscriber {
    func play() {
        print("play in VM")
        // runPanelViewModel.isRunning = true
        playbackState.value = true
    }

    func pause() {
        print("pause in VM")
        // runPanelViewModel.isRunning = false
        playbackState.value = false
    }
}
