//
//  AlertView.swift
//  CustomAlertView
//
//  Created by Shantaram Kokate on 9/11/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

enum AnimationOption: Int
{
    case zoomInOut
}

class AlertView: UIView {
    
    var containerView: UIView!
    
    var animationOption: AnimationOption = .zoomInOut
    
    // MAKR: - Lazy loading view
    
    internal lazy var backgroundView: UIView = {
        let view = UIView()
        view.frame = frame
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        return view
    }()

    convenience init(_ view: UIView)
    {
        self.init(frame: UIScreen.main.bounds)
        setupUIView(view: view)
    }
    
    func setupUIView(view: UIView)
    {
        containerView = view
        setupBackgroundView()
        setupContainerView()
    }
    
    func setupBackgroundView()
    {
        addSubview(backgroundView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tapGesture.numberOfTapsRequired = 1
        // backgroundView.addGestureRecognizer(tapGesture)
    }
    
    func setupContainerView()
    {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(containerView)
        
        self.addConstraint(NSLayoutConstraint(item: containerView!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: containerView!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: containerView!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: containerView!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
        self.layoutIfNeeded()
    }
    
    @objc func dismissView()
    {
        dismiss()
    }
    
    // Alert View Methods
    
    func show()
    {
        self.backgroundView.alpha = 0
          if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            let subviewsList = topController.view.subviews
            for view in subviewsList where view is AlertView {
                // view.removeFromSuperview()
                break
            }
            topController.view.addSubview(self)
        }
        
        self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = 1.0
            self.containerView.transform = CGAffineTransform.identity
        }, completion: { (_) in
            self.backgroundView.alpha = 1.0
        })
    }
    
    func dismiss()
    {
        self.backgroundView.alpha = 1.0
        self.containerView.transform = .identity
        UIView.animate(withDuration: 0.11, animations: {
            self.backgroundView.alpha = 0.0
            self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { (_) in
            self.backgroundView.alpha = 0.0
            self.removeFromSuperview()
        })
    }
}
