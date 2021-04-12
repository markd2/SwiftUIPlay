import Combine
import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var sequence: Sequence?

    var runPanelViewModel: RunPanelViewModel!

    private var heartbeatTimer: AnyCancellable?

    init() {
        runPanelViewModel = .hardcoded
        start()
    }

    func start() {
        let start = Date()

        heartbeatTimer = Timer.publish(every: 1.0, on: .main, in: .common)
          .autoconnect()
        .map { timer in
            timer.timeIntervalSince(start)
        }
        .map { timeInterval in
            Int(timeInterval)
        }
        .sink { [weak self] seconds in
            print("lub dub \(seconds)")
            self?.runPanelViewModel.classTime = "snorgle \(seconds)"
        }
    }

}
