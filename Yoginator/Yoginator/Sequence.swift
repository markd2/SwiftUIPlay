import Foundation
import Combine

struct Sequence {
    let poses: [RunPose]
    let isRunning: Bool
    let currentTime: Int
}

struct SequenceFrame {
    let runPose: RunPose
    let index: Int
    let anotherPoseAvailable: Bool
}

typealias SequenceFramePublisher = AnyPublisher<SequenceFrame, Never>
typealias SequenceFrameMaybePublisher = AnyPublisher<SequenceFrame?, Never>


extension Sequence {
    static var hardcoded: Sequence {
        let poses = [
            Pose(name: "Scoobydooasana", imageName: "standing-bow", defaultDuration: 10),
            Pose(name: "Radioasana", imageName: "tree", defaultDuration: 4),
            Pose(name: "Greebleborkenasana", imageName: "warrior-1", defaultDuration: 10),
            Pose(name: "Rollinitiativasana", imageName: "chair", defaultDuration: 10)
        ]
        
        let runPoses = poses.map { RunPose(pose: $0, duration: $0.defaultDuration) }
        
        return Sequence(poses: runPoses, isRunning: false, currentTime: 0)
    }
}
