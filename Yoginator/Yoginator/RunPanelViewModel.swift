import SwiftUI
import Combine



class RunPanelViewModel: ObservableObject {
    var timeLeftInPose: String
    @Published private(set) var isRunning: Bool = false
    @Published /* private(set) */ var classTime: String
    @Published private(set) var frame: SequenceFrame? = nil

    var anotherPoseAvailable = true

    private var events: PassthroughSubject<Event, Never>
    private var subscribers: [AnyCancellable] = []

    init(posePublisher: AnyPublisher<SequenceFrame?, Never>,
         timeLeftInPose: String, classTime: String,
         events: PassthroughSubject<Event, Never>,
         playbackState: AnyPublisher<Bool, Never>) {
        self.timeLeftInPose = timeLeftInPose
        self.classTime = classTime

        self.events = events

        playbackState.sink { [weak self] isPlaying in
            self?.isRunning = isPlaying
        }
        .store(in: &subscribers)

        posePublisher.sink { [weak self] newFrame in
            print("new pose \(newFrame)")
            self?.frame = newFrame
        }
        .store(in: &subscribers)
    }

    func play() {
        events.send(.play)
    }

    func pause() {
        events.send(.pause)
    }

    func next() {
        events.send(.next)
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
