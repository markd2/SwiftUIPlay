import SwiftUI
import Combine

class RunPanelViewModel: ObservableObject {
    var text: String
    var runPose: RunPose
    var timeLeftInPose: String
    @Published /* private(set) */ var classTime: String
    var isRunning: Bool

    private var events: PassthroughSubject<Event, Never>

    init(text: String, runPose: RunPose,
         timeLeftInPose: String, classTime: String, isRunning: Bool,
         events: PassthroughSubject<Event, Never>) {
        self.text = text
        self.runPose = runPose
        self.timeLeftInPose = timeLeftInPose
        self.classTime = classTime
        self.isRunning = isRunning
        self.events = events
    }

    func pause() {
        events.send(.pause)
    }
}

extension RunPanelViewModel {
   static var hardcoded: RunPanelViewModel {
       let runPose = RunPose(pose: .hardcoded, duration: 60)

       return RunPanelViewModel(text: "Greeble",
                                runPose: runPose,
                                timeLeftInPose: "0:30",
                                classTime: "17:44",
                                isRunning: true,
                                events: PassthroughSubject<Event, Never>())
   }
}
