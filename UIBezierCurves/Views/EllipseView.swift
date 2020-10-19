import UIKit

class EllipseView: UIView {
    
    override func draw(_ rect: CGRect)
    {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100, y: 100),
                                      radius: CGFloat(100),
                                      startAngle: CGFloat(0),
                                      endAngle: CGFloat(Double.pi * 2),
                                      clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayer)
    }
}
