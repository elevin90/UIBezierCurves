import UIKit

@IBDesignable class CanvasView: UIView {
    var figureType: FigureType = .none {
        didSet {
            drawFigures()
        }
    }
    
    var currentLocation: CGPoint?
    var figure: Figure?
    var rectangles: [RectangleView] = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBInspectable var boundsColor: UIColor = .white {
        didSet {
            layer.borderWidth = 1
            layer.backgroundColor = boundsColor.cgColor
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawLine()
        addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                               action: #selector(handleSelection(_:))))
    }
    
    func clear() {
        subviews.forEach{
            $0.removeFromSuperview()
        }
        setNeedsDisplay()
    }
    
    @objc func handleSelection(_ sender: UITapGestureRecognizer) {
        let tappedView = hitTest(sender.location(in: self), with: nil)
        for rectangle in rectangles {
            if tappedView != rectangle {
                rectangle.resetFocus()
            } else {
                rectangle.addBorder()
            }
        }
        guard figureType == .line else {
            return
        }
        self.currentLocation = sender.location(in: self)
        drawFigures()
        setNeedsDisplay()
    }
    
    func drawFigures() {
        if figureType == .none || currentLocation == nil {
            return
        }
        guard let location = currentLocation else { return }
        switch figureType {
        case .line:
            if figure == nil {
                figure = Line(initialCoordinates: location)
            }
            figure?.points.append(location)
        case .rectangle:
            drawRectangle()
            setNeedsDisplay()
        case .ellipse:
            drawEllipse()
            setNeedsDisplay()
        default:
            break
        }
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
    
    private func drawEllipse() {
        let defaultSize = CGSize(width: 200, height: 200)
        let defaultOrigin = CGPoint(x: bounds.width / 2 - defaultSize.width / 2,
                                    y: bounds.height / 2 - defaultSize.height / 2)
        let defaultFrame = CGRect(origin: defaultOrigin, size: defaultSize)
        let ellipse = EllipseView(frame: CGRect(x: 0,
                                                y: defaultOrigin.y,
                                                width: defaultFrame.width,
                                                height: defaultFrame.height))
        ellipse.alpha = 0
        addSubview(ellipse)
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                ellipse.alpha = 1
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.9, animations: {
                ellipse.frame.origin.x = defaultOrigin.x
            })
        }

    }
    
    func drawRectangle() {
        let rectangle = RectangleView()
        addSubview(rectangle)
        let defaultSize = CGSize(width: 200, height: 200)
        let defaultOrigin = CGPoint(x: bounds.width / 2 - defaultSize.width / 2,
                                    y: bounds.height / 2 - defaultSize.height / 2)
        let defaultFrame = CGRect(origin: defaultOrigin, size: defaultSize)
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.2,
                       options: []) {
            rectangle.frame = defaultFrame
        } completion: { (finished) in
            rectangle.addBorder()
            self.rectangles.append(rectangle)
        }
    }
    
    func resetFocus() {
        rectangles.forEach{ $0.resetFocus() }
    }
}
