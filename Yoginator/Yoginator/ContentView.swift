import SwiftUI

struct ContentView: View {

    @EnvironmentObject var viewModel: ContentViewModel

    var body: some View {
        RunPanelView()
          .environmentObject(viewModel.runPanelViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
