import UIKit

@IBDesignable class SelectButton: UIButton {
    @IBInspectable var borderColor: UIColor = .white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setTitleColor(.black, for: .normal)
    }
}
