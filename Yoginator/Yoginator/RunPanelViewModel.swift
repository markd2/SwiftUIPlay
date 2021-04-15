import SwiftUI
import Combine



class RunPanelViewModel: ObservableObject {
    @Published var timeLeftInPose: String  // !!! hook this up to a publisher
    @Published private(set) var isRunning: Bool = false
    @Published /* private(set) */ var classTime: String
    @Published private(set) var frame: SequenceFrame? = nil

    var anotherPoseAvailable = true

    private var events: PassthroughSubject<Event, Never>
    private var subscribers: [AnyCancellable] = []

    init(posePublisher: SequenceFrameMaybePublisher,
         timeLeftInPose: String, classTime: String,
         events: EventPassthroughPublisher,
         playbackState: BoolPublisher) {
        self.timeLeftInPose = timeLeftInPose
        self.classTime = classTime

        self.events = events

        playbackState.sink { [weak self] isPlaying in
            self?.isRunning = isPlaying
        }
        .store(in: &subscribers)

        posePublisher.sink { [weak self] newFrame in
            self?.frame = newFrame
        }
        .store(in: &subscribers)
    }

    func resume() {
        events.send(.resume)
    }

    func pause() {
        events.send(.pause)
    }

    func next() {
        events.send(.next)
    }

    func start() {
        events.send(.start)
    }
}

extension RunPanelViewModel {
   static var hardcoded: RunPanelViewModel {
       return RunPanelViewModel(
        posePublisher: PassthroughSubject<SequenceFrame?, Never>().eraseToAnyPublisher(),
         timeLeftInPose: "0:30",
         classTime: "17:44",
         events: PassthroughSubject<Event, Never>(),
        playbackState: CurrentValueSubject<Bool, Never>(false).eraseToAnyPublisher())
   }
}
