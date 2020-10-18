import Foundation
import QuartzCore

class Line: Figure {
    override init(initialCoordinates: CGPoint) {
        super.init(initialCoordinates: initialCoordinates)
        self.type = .ellipse
    }
}
