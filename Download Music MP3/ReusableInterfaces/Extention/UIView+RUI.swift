//
//  UIView+RUI.swift
//  Men Police Suit Photo Editor
//
//  Created by iMac on 25/12/21.
//

import Foundation
import UIKit

extension UIView {
    func getViewImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
