import SwiftUI

struct RunPanelView: View {
    @EnvironmentObject var viewModel: RunPanelViewModel

    var body: some View {
        if let frame = viewModel.frame {
            Text(viewModel.text)
            Text("Pose \(frame.index + 1)")
            
            Text(frame.runPose.pose.name)
            Image(frame.runPose.pose.imageName)
            
            Text(viewModel.timeLeftInPose)
            Text(viewModel.classTime)

            if viewModel.isRunning {
                Text("Running (pause button)").fontWeight(.bold)
                Button("Pause", action: {
                                    viewModel.pause()
                                })
            } else {
                Text("Paused (run button)").fontWeight(.bold)
                Button("Run", action: {
                                  viewModel.play()
                              })
            }
            
            if frame.anotherPoseAvailable {
                Button(">>>", action: {
                                  viewModel.next()
                              })
            } else {
                Button("End", action: {
                                  viewModel.next()
                              })
            }
        } else {
            Text("No Frame")
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
