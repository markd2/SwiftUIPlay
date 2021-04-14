import Combine
import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var sequence: Sequence?

    var runPanelViewModel: RunPanelViewModel!

    private let events = PassthroughSubject<Event, Never>()
    private let playbackState = CurrentValueSubject<Bool, Never>(false)

    // RunPose, index, is there more
    private let posePublisher = PassthroughSubject<SequenceFrame, Never>()

    var currentPose: Int = 0

    private var heartbeatTimer: AnyCancellable?

    private var subscribers = [AnyCancellable]()

    init() {
        sequence = .hardcoded

        let bootstrapRPVM = RunPanelViewModel.hardcoded

        runPanelViewModel = RunPanelViewModel(
          text: bootstrapRPVM.text,
          posePublisher: posePublisher.eraseToAnyPublisher(),
          runPose: bootstrapRPVM.runPose,
          timeLeftInPose: bootstrapRPVM.timeLeftInPose,
          classTime: bootstrapRPVM.classTime,
          events: events,
          playbackState: playbackState.eraseToAnyPublisher()
        )

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

    func stop() {
        heartbeatTimer = nil
        playbackState.value = false
    }

    func advanceToNextFrame() {
        if let sequence = sequence {
            currentPose += 1
            posePublisher.send(SequenceFrame(
                                 runPose: sequence.poses[currentPose],
                                 index: currentPose,
                                 anotherPoseAvailable: true))
        }
    }
}

extension ContentViewModel: EventSubscriber {
    func play() {
        print("play in VM")
        start()
    }

    func pause() {
        print("pause in VM")
        stop()
    }

    func next() {
        print("next in VM")
        advanceToNextFrame()
    }
}
