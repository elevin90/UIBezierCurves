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
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: stackBackgroundView.bottomAnchor),
            canvasView.leftAnchor.constraint(equalTo: view.leftAnchor),
            canvasView.rightAnchor.constraint(equalTo: view.rightAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        canvasView.backgroundColor = UIColor.white
    }
    
    @IBAction func handleLines(_ sender: Any) {
        canvasView.clear()
        canvasView.currentLocation = nil
        canvasView.figureType = .line
    }
    
    @IBAction func handleRectangle(_ sender: Any) {
        canvasView.clear()
        canvasView.currentLocation = view.center
        canvasView.figureType = .rectangle
    }
    
    @IBAction func handleEllipse(_ sender: Any) {
        canvasView.clear()
        canvasView.currentLocation = view.center
        canvasView.figureType = .ellipse
        canvasView.setNeedsDisplay()
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
