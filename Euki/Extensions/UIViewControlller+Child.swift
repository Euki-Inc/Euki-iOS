//
//  UIViewControlller+Child.swift
//  Euki
//
//  Created by Víctor Chávez on 3/17/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

public extension UIViewController {
    func configureChildViewController(childController: UIViewController, onView: UIView?) {
        guard var holderView = self.view else{
            return
        }
        
        if childController.parent != nil {
            childController.willMove(toParentViewController: nil)
            childController.view.removeFromSuperview()
            childController.removeFromParentViewController()
        }
        
        if let onView = onView {
            holderView = onView
        }
        addChildViewController(childController)
        holderView.addSubview(childController.view)
        self.constrainViewEqual(holderView: holderView, view: childController.view)
        childController.didMove(toParentViewController: self)
    }
    
    
    func constrainViewEqual(holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let pinTop = NSLayoutConstraint(item: view,
                                        attribute: .top,
                                        relatedBy: .equal,
                                        toItem: holderView,
                                        attribute: .top,
                                        multiplier: 1.0,
                                        constant: 0.0)
        let pinBottom = NSLayoutConstraint(item: view,
                                           attribute: .bottom,
                                           relatedBy: .equal,
                                           toItem: holderView,
                                           attribute: .bottom,
                                           multiplier: 1.0,
                                           constant: 0.0)
        let pinLeft = NSLayoutConstraint(item: view,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: holderView,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0.0)
        let pinRight = NSLayoutConstraint(item: view,
                                          attribute: .right,
                                          relatedBy: .equal,
                                          toItem: holderView,
                                          attribute: .right,
                                          multiplier: 1.0,
                                          constant: 0.0)
        
        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }
	
	func removeFromParent() {
		if self.parent != nil {
			self.willMove(toParentViewController: nil)
			self.view.removeFromSuperview()
			self.removeFromParentViewController()
		}
	}
}
