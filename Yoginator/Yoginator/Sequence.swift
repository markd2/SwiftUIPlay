import Foundation

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


extension Sequence {
    static var hardcoded: Sequence {
        let poses = [
          Pose(name: "Scoobydooasana", imageName: "standing-bow ", defaultDuration: 10),
          Pose(name: "Radioasana", imageName: "", defaultDuration: 4),
          Pose(name: "Greebleborkenasana", imageName: "", defaultDuration: 10)
        ]

        let runPoses = poses.map { RunPose(pose: $0, duration: $0.defaultDuration) }

        return Sequence(poses: runPoses, isRunning: false, currentTime: 0)
    }
}
