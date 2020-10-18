import Foundation
import QuartzCore

class Rectangle: Figure {
    override init(initialCoordinates: CGPoint) {
        super.init(initialCoordinates: initialCoordinates)
        self.type = .rectangle
    }
}
