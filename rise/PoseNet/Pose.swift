/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Implementation details of a structure used to describe a pose.
*/

import CoreGraphics
import Foundation

@objcMembers

@objc public class Pose : NSObject {

    public static let edges = [
        Edge(from: Joint.nose, to: Joint.leftEye, index: 0),
        Edge(from: Joint.leftEye, to: Joint.leftEar, index: 1),
        Edge(from: Joint.nose, to: Joint.rightEye, index: 2),
        Edge(from: Joint.rightEye, to: Joint.rightEar, index: 3),
        Edge(from: Joint.nose, to: Joint.leftShoulder, index: 4),
        Edge(from: Joint.leftShoulder, to: Joint.leftElbow, index: 5),
        Edge(from: Joint.leftElbow, to: Joint.leftWrist, index: 6),
        Edge(from: Joint.leftShoulder, to: Joint.leftHip, index: 7),
        Edge(from: Joint.leftHip, to: Joint.leftKnee, index: 8),
        Edge(from: Joint.leftKnee, to: Joint.leftAnkle, index: 9),
        Edge(from: Joint.nose, to: Joint.rightShoulder, index: 10),
        Edge(from: Joint.rightShoulder, to: Joint.rightElbow, index: 11),
        Edge(from: Joint.rightElbow, to: Joint.rightWrist, index: 12),
        Edge(from: Joint.rightShoulder, to: Joint.rightHip, index: 13),
        Edge(from: Joint.rightHip, to: Joint.rightKnee, index: 14),
        Edge(from: Joint.rightKnee, to: Joint.rightAnkle, index: 15)
    ]
    
    public let joints = [
        Joint(name: 0),
        Joint(name: 1),
        Joint(name: 2),
        Joint(name: 3),
        Joint(name: 4),
        Joint(name: 5),
        Joint(name: 6),
        Joint(name: 7),
        Joint(name: 8),
        Joint(name: 9),
        Joint(name: 10),
        Joint(name: 11),
        Joint(name: 12),
        Joint(name: 13),
        Joint(name: 14),
        Joint(name: 15),
        Joint(name: 16),
    ]
    
    func getJoint(index: Int) -> Joint {
        return joints[index];
    }
    
    /// The confidence score associated with this pose.
    var confidence: Double = 0.0

    /// Returns all edges that link **from** or **to** the specified joint.
    ///
    /// - parameters:
    ///     - jointName: Query joint name.
    /// - returns: All edges that connect to or from `jointName`.
    static func edges(for jointName: Int) -> [Edge] {
        return Pose.edges.filter {
            $0.parent == jointName || $0.child == jointName
        }
    }

    /// Returns the edge having the specified parent and child  joint names.
    ///
    /// - parameters:
    ///     - parentJointName: Edge's parent joint name.
    ///     - childJointName: Edge's child joint name.
    /// - returns: All edges that connect to or from `jointName`.
    static func edge(from parentJointName: Int, to childJointName: Int) -> Edge? {
        return Pose.edges.first(where: { $0.parent == parentJointName && $0.child == childJointName })
    }
}

@objc public class Edge : NSObject {
    let index: Int
    let parent: Int
    let child: Int
    
    init(from parent: Int, to child: Int, index: Int) {
        self.index = index
        self.parent = parent
        self.child = child
    }
    
}


