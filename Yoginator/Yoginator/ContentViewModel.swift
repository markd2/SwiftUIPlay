import Combine
import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var sequence: Sequence?

    var runPanelViewModel: RunPanelViewModel!

    init() {
        runPanelViewModel = .hardcoded
    }

}
