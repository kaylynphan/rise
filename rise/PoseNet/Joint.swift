/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Implementation details of a structure used to describe a joint.
*/

import CoreGraphics
import Foundation

@objcMembers

@objc public class Joint : NSObject {
    
    static let nose = 0;
    static let leftEye = 1;
    static let rightEye = 2;
    static let leftEar = 3;
    static let rightEar = 4;
    static let leftShoulder = 5;
    static let rightShoulder = 6;
    static let leftElbow = 7;
    static let rightElbow = 8;
    static let leftWrist = 9;
    static let rightWrist = 10;
    static let leftHip = 11;
    static let rightHip = 12;
    static let leftKnee = 13;
    static let rightKnee = 14;
    static let leftAnkle = 15;
    static let rightAnkle = 16;
    

    /// The total number of joints available.
    static var numberOfJoints: Int {
        return 17;
    }

    /// The name used to identify the joint.
    let name: Int;

    /// The position of the joint relative to the image.
    ///
    /// The position is initially relative to the model's input image size and then mapped to the original image
    /// size after constructing the associated pose.
    var position: CGPoint

    /// The joint's respective cell index into model's output grid.
    var cell: Cell

    /// The confidence score associated with this joint.
    ///
    /// The joint confidence is obtained from the `heatmap` array output by the PoseNet model.
    var confidence: Double

    /// A boolean value that indicates if the joint satisfies the joint threshold defined in the configuration.
    var isValid: Bool

    init(name: Int,
         cell: Cell = .zero,
         position: CGPoint = .zero,
         confidence: Double = 0,
         isValid: Bool = false) {
        self.name = name
        self.cell = cell
        self.position = position
        self.confidence = confidence
        self.isValid = isValid
    }
}
