import Foundation
import SwiftUI

struct Pose {
    let name: String
    let imageName: String
    let defaultDuration: TimeInterval
}


extension Pose {
    static var hardcoded: Pose {
        return Pose(name: "Scoobydooasana",
                    imageName: "scoobydoo",
                    defaultDuration: 25)
    }
}
