import UIKit

class RectangleView: UIView {

    private var strokeBorder: DashBorderLayer?
    
    @IBInspectable var color: UIColor = .clear {
        didSet { backgroundColor = color }
    }
    
    override func draw(_ rect: CGRect) {
        backgroundColor = .gray
        backgroundColor?.set()
        isUserInteractionEnabled = true
        UIBezierPath(rect: rect).fill()
    }
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    override func didMoveToSuperview() {
        if self.gestureRecognizers == nil {
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            panGestureRecognizer.delegate = self
            let pinchGestureRecogniser = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
            pinchGestureRecogniser.delegate = self
            let rotationGesrure = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(_:)))
            rotationGesrure.delegate = self
        
            addGestureRecognizer(panGestureRecognizer)
            addGestureRecognizer(pinchGestureRecogniser)
            addGestureRecognizer(rotationGesrure)
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        guard let gView = gesture.view else { return }
        addBorder()
        gView.center = CGPoint(x: gView.center.x + translation.x,
                               y: gView.center.y + translation.y)
        
        gesture.setTranslation(.zero, in: self)
    }
    
    @objc func handleRotate(_ gesture: UIRotationGestureRecognizer) {
        guard let gView = gesture.view else { return }
        addBorder()
        gView.transform = gView.transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let gView = gesture.view else { return }
        addBorder()
        gView.transform = gView.transform.scaledBy(x: gesture.scale,
                                                   y: gesture.scale)
        gesture.scale = 1
    }
    
    func resetFocus() {
        strokeBorder?.removeFromSuperlayer()
    }
    
    func addBorder() {
        guard strokeBorder?.superlayer == nil else {
            return
        }
        strokeBorder = DashBorderLayer(view: self)
        if let border = strokeBorder {
            layer.addSublayer(border)
        }
    }
}

extension CGPoint {
    static func +=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
}

extension RectangleView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
