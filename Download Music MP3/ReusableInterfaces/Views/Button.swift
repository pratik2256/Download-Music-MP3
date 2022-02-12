import UIKit

@IBDesignable
class Button: UIButton {
    
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
            self.layer.cornerRadius = cornerRadius
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
                self.layer.shadowOffset = CGSize(width: 0.5, height: 3)
                self.layer.shadowColor = shadowColor.cgColor
                self.layer.shadowOpacity = 0.5
                self.layer.shadowRadius = 3
            }
        }
    }
    
    @IBInspectable var applyShadowLikeAndroid : UIColor = UIColor.clear {
        didSet {
            if applyShadowLikeAndroid == UIColor.clear {
                self.layer.shadowRadius = 0
                self.layer.shadowColor = applyShadowLikeAndroid.cgColor
            } else {
                self.layer.masksToBounds = false;
                self.layer.shadowColor = applyShadowLikeAndroid.cgColor
                self.layer.shadowOpacity = 0.50
                self.layer.shadowOffset = CGSize.zero
                self.layer.shadowRadius = 7
            }
        }
    }
}
