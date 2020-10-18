import UIKit

class DashBorderLayer: CAShapeLayer {

    init(view: UIView) {
        super.init()
        self.strokeColor = UIColor.black.cgColor
        self.lineDashPattern = [4, 4]
        self.frame = view.bounds
        self.fillColor = nil
        self.path = UIBezierPath(rect: view.bounds).cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

