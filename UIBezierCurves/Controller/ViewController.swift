import UIKit

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private var figureType: FigureType = .none
    private var currentLocation: CGPoint?
    @IBOutlet private weak var stackBackgroundView: UIView!
    
    lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    lazy var canvasView: CanvasView = {
        let canvasView = CanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        return canvasView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(canvasView)
        canvasView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                               action: #selector(handleSelection(_:))))
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: stackBackgroundView.bottomAnchor),
            canvasView.leftAnchor.constraint(equalTo: view.leftAnchor),
            canvasView.rightAnchor.constraint(equalTo: view.rightAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        canvasView.backgroundColor = UIColor.white
    }
    
    @objc func handleSelection(_ sender: UITapGestureRecognizer) {
        guard figureType == .line else {
            return
        }
        self.currentLocation = sender.location(in: canvasView)
        draw()
        canvasView.setNeedsDisplay()
    }
    
    @IBAction func handleLines(_ sender: Any) {
        figureType = .line
    }
    
    @IBAction func handleRectangle(_ sender: Any) {
        figureType = .rectangle
        canvasView.figure = nil
        currentLocation = view.center
        canvasView.setNeedsDisplay()
        draw()
    }
    
    @IBAction func handleEllipse(_ sender: Any) {
        figureType = .ellipse
        canvasView.figure = nil
        canvasView.setNeedsDisplay()
    }
    
    func draw() {
        if figureType == .none || currentLocation == nil {
            return
        }
        guard let location = currentLocation else { return }
        switch figureType {
        case .line:
            if canvasView.figure == nil {
                canvasView.figure = Line(initialCoordinates: location)
            }
            canvasView.figure?.points.append(location)
        case .rectangle:
            canvasView.drawRectangle()
            canvasView.setNeedsDisplay()
        default:
            break
        }
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
