import Foundation

struct Sequence {
    let poses: [RunPose]
    let isRunning: Bool
    let currentTime: Int
}


extension Sequence {
    static var hardcoded: Sequence {
        let poses = [
          Pose(name: "Scoobydooasana", imageName: "", defaultDuration: 30),
          Pose(name: "Radioasana", imageName: "", defaultDuration: 15),
          Pose(name: "Greebleborkenasana", imageName: "", defaultDuration: 10)
        ]

        let runPoses = poses.map { RunPose(pose: $0, duration: $0.defaultDuration) }

        return Sequence(poses: runPoses, isRunning: false, currentTime: 0)
    }
}
