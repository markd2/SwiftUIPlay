import SwiftUI
import Combine

class RunPanelViewModel: ObservableObject {
    var text: String
    var runPose: RunPose
    var timeLeftInPose: String
    @Published private(set) var isRunning: Bool = false
    @Published /* private(set) */ var classTime: String
    var anotherPoseAvailable = true

    private var events: PassthroughSubject<Event, Never>
    private var subscribers: [AnyCancellable] = []

    init(text: String, runPose: RunPose,
         timeLeftInPose: String, classTime: String,
         events: PassthroughSubject<Event, Never>,
         playbackState: AnyPublisher<Bool, Never>) {
        self.text = text
        self.runPose = runPose
        self.timeLeftInPose = timeLeftInPose
        self.classTime = classTime

        self.events = events

        playbackState.sink { [weak self] isPlaying in
            self?.isRunning = isPlaying
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
       let runPose = RunPose(pose: .hardcoded, duration: 60)

       return RunPanelViewModel(
         text: "Greeble",
         runPose: runPose,
         timeLeftInPose: "0:30",
         classTime: "17:44",
         events: PassthroughSubject<Event, Never>(),
        playbackState: CurrentValueSubject<Bool, Never>(false).eraseToAnyPublisher())
   }
}
