import SwiftUI

class RunPanelViewModel: ObservableObject {
    let text: String
    let runPose: RunPose
    let timeLeftInPose: String
    let classTime: String

    init(text: String, runPose: RunPose,
         timeLeftInPose: String, classTime: String) {
        self.text = text
        self.runPose = runPose
        self.timeLeftInPose = timeLeftInPose
        self.classTime = classTime
    }
}

extension RunPanelViewModel {
   static var hardcoded: RunPanelViewModel {
       let runPose = RunPose(pose: .hardcoded, duration: 60)

       return RunPanelViewModel(text: "Greeble",
                                runPose: runPose,
                                timeLeftInPose: "0:30",
                                classTime: "17:44")
   }
}
