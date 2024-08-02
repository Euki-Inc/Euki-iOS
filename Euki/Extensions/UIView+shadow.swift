//
//  UIView+shadow.swift
//  Euki
//
//  Created by Dhekra Rouatbi on 15/3/2024.
//  Copyright © 2024 Ibis. All rights reserved.
//

import Foundation


extension UIView {
    func addshadow() {
        self.layer.applySketchShadow(
            color: .black,
            alpha: 0.2,
            x: 0,
            y: 4,
            blur: 4,
            spread: 0)
    }
}


extension CALayer {
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0)
  {
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
