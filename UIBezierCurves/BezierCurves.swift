//
//  BezierCurves.swift
//  UIBezierCurves
//
//  Created by AP Yauheni Levin on 27.09.20.
//

import UIKit

@IBDesignable class BezierCurves: UIView {

    @IBInspectable var boundsColor: UIColor = .white {
        didSet {
            layer.borderWidth = 1
            layer.backgroundColor = boundsColor.cgColor
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        //drop
        let dropPath = UIBezierPath()
        dropPath.move(to: center)
        dropPath.addCurve(to: center, controlPoint1: CGPoint(x: center.x + 100,
                                                             y: center.y + 150),
                          controlPoint2: CGPoint(x: center.x - 100, y: center.y + 150))
        UIColor.blue.setStroke()
        dropPath.lineWidth = 4
        dropPath.stroke()
    }
    
}
