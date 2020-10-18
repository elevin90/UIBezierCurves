//
//  BezierCurves.swift
//  UIBezierCurves
//
//  Created by AP Yauheni Levin on 27.09.20.
//

import UIKit

@IBDesignable class CanvasView: UIView {
    
    var figure: Figure?
    var rectangles: [RectangleView] = []
    
    func drawFigure(_ figure: Figure) {

    }
    
    @IBInspectable var boundsColor: UIColor = .white {
        didSet {
            layer.borderWidth = 1
            layer.backgroundColor = boundsColor.cgColor
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
//        guard let figure = self.figure else { return }
//        switch figure.type {
//        case .line:
            drawLine()
//        default:
//            break
//        }
//        drawLine()
    }
    
    private func drawLine() {
        let path = UIBezierPath()
        path.move(to: figure?.initialCoordinates ?? .zero)
        for point in figure?.points ?? [] {
            path.addLine(to: point)
        }
        UIColor.blue.setStroke()
        path.lineWidth = 4
        path.stroke()
    }
    
    func drawRectangle() {
        let rectangle = RectangleView()
        rectangle.frame = .zero
        addSubview(rectangle)
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: []) {
            rectangle.frame = CGRect(x: self.bounds.width / 2 - 100,
                                     y:  self.bounds.height / 2 - 100,
                                     width: 200,
                                     height: 200)
        } completion: { (finished) in
            self.addBorder(to: rectangle)
        }
    }
    
    func addBorder(to rectangle: UIView) {
        let strokeBorder = DashBorderLayer(view: rectangle)
        rectangle.layer.addSublayer(strokeBorder)
    }
}
