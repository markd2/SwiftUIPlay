import Combine
import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var sequence: Sequence?

    var runPanelViewModel: RunPanelViewModel!

    private let events = PassthroughSubject<Event, Never>()
    private let playbackState = CurrentValueSubject<Bool, Never>(false)

    // RunPose, index, is there more
    private let posePublisher = PassthroughSubject<SequenceFrame?, Never>()

    var currentPose: Int = 0

    private var heartbeatTimer: AnyCancellable?
    private var frameTimeLeft: Int?

    private var subscribers = [AnyCancellable]()

    init() {
        sequence = .hardcoded

        let bootstrapRPVM = RunPanelViewModel.hardcoded

        runPanelViewModel = RunPanelViewModel(
          posePublisher: posePublisher.eraseToAnyPublisher(),
          timeLeftInPose: bootstrapRPVM.timeLeftInPose,
          classTime: bootstrapRPVM.classTime,
          events: events,
          playbackState: playbackState.eraseToAnyPublisher()
        )

        let eventSubscription = eventSubscribe(publisher: events.eraseToAnyPublisher())
        subscribers.append(eventSubscription)

        moveToFrame(index: 0)
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
            if var frameTimeLeft = self?.frameTimeLeft {
                frameTimeLeft -= 1
                self?.frameTimeLeft = frameTimeLeft // #loloptionals
                if frameTimeLeft <= 0 {
                    self?.advanceToNextFrame()
                }
                self?.runPanelViewModel.classTime = "Time left: \(frameTimeLeft)"
            }
        }
    }

    func stop() {
        heartbeatTimer = nil
        playbackState.value = false
    }

    func moveToFrame(index: Int?) {
        if let index = index, let sequence = sequence {
            currentPose = index
            let runPose = sequence.poses[index]

            posePublisher.send(SequenceFrame(
                                 runPose: runPose,
                                 index: currentPose,
                                 anotherPoseAvailable: index < sequence.poses.count - 1))
            frameTimeLeft = Int(runPose.duration)
        } else {
            posePublisher.send(nil)
        }
    }

    func advanceToNextFrame() {
        if let sequence = sequence {
            currentPose += 1
            if currentPose < sequence.poses.count {
                moveToFrame(index: currentPose)
            } else {
                moveToFrame(index: nil)
                stop()
            }
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
