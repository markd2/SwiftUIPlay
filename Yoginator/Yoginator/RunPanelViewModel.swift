import SwiftUI

class RunPanelViewModel: ObservableObject {
    let text: String
    let runPose: RunPose
    let timeLeftInPose: String
    let classTime: String
    let isRunning: Bool

    init(text: String, runPose: RunPose,
         timeLeftInPose: String, classTime: String, isRunning: Bool) {
        self.text = text
        self.runPose = runPose
        self.timeLeftInPose = timeLeftInPose
        self.classTime = classTime
        self.isRunning = isRunning
    }
}

extension RunPanelViewModel {
   static var hardcoded: RunPanelViewModel {
       let runPose = RunPose(pose: .hardcoded, duration: 60)

       return RunPanelViewModel(text: "Greeble",
                                runPose: runPose,
                                timeLeftInPose: "0:30",
                                classTime: "17:44",
                                isRunning: true)
   }
}
