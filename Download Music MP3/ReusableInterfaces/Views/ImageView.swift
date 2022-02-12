import UIKit

@IBDesignable
class ImageView: UIImageView {
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            setCornerRadius(cornerRadius)
        }
    }
}
