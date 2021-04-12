import SwiftUI

struct RunPanelView: View {
    @EnvironmentObject var viewModel: RunPanelViewModel

    var body: some View {
        Text(viewModel.text)
        Text(viewModel.runPose.pose.name)
        Text(viewModel.timeLeftInPose)
        Text(viewModel.classTime)
        if viewModel.isRunning {
            Text("Running (pause button)").fontWeight(.bold)
        } else {
            Text("Paused (run button)").fontWeight(.bold)
        }
    }
}


/* I really (still) can't use previews.  FB9077466. sigh. #ilyxc */
/*
struct RunPanelView_Previews: PreviewProvider {
    static var previews: some View {
        RunPanelView()
          .environmentObject(RunPanelViewModel(text: "flong"))
    }
}
*/
