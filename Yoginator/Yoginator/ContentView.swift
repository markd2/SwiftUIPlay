import SwiftUI

struct ContentView: View {
    var body: some View {
        RunPanelView()
          .environmentObject(RunPanelViewModel.hardcoded)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
