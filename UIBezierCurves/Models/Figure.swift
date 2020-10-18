import Foundation
import QuartzCore

class Figure  {
    var points: [CGPoint] = []
    let initialCoordinates: CGPoint
    var type: FigureType?
    init(initialCoordinates: CGPoint) {
        self.initialCoordinates = initialCoordinates
        points.append(initialCoordinates)
    }
}

enum FigureType {
    case line
    case rectangle
    case ellipse
    case none
}
