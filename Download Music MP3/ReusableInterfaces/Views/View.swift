import UIKit

@IBDesignable
class View: UIView {
    
    @IBInspectable var borderColor : UIColor = UIColor.clear {
        didSet {
            setBorderColor(borderColor: borderColor.cgColor)
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            setCornerRadius(cornerRadius)
        }
    }
    
    @IBInspectable var shadowColor : UIColor = UIColor.clear {
        didSet {
            if shadowColor == UIColor.clear {
                self.layer.shadowRadius = 0
                self.layer.shadowColor = shadowColor.cgColor
            }
            else
            {
                self.layer.masksToBounds = false;
                self.layer.shadowOffset = CGSize(width: 0.5, height: 1.5)
                self.layer.shadowColor = shadowColor.cgColor
                self.layer.shadowOpacity = 0.5
                self.layer.shadowRadius = 2
            }
        }
    }
    
    @IBInspectable var applyButtomShadow : UIColor = UIColor.clear {
        didSet {
            if shadowColor == UIColor.clear {
                self.layer.shadowRadius = 0
                self.layer.shadowColor = applyButtomShadow.cgColor
            }
            else
            {
                self.layer.masksToBounds = false;
                self.layer.shadowOffset = CGSize(width: -0.5, height: 1)
                self.layer.shadowColor = applyButtomShadow.cgColor
                self.layer.shadowOpacity = 0.5
                self.layer.shadowRadius = 0.5
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }
}

extension UIView {
    
    func setBorderColor(borderColor : CGColor) {
        self.layer.borderColor = borderColor
    }
    
    func setCornerRadius(_ cornerRadius : CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
}
