//
//  UIView+Shake.swift
//  Euki
//
//  Created by Víctor Chávez on 4/8/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

extension UIView {
    func startQuivering() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        let startAngle = -0.5 * Double.pi / 450.0
        let stopAngle = -startAngle
        animation.fromValue = NSNumber(value: startAngle)
        animation.toValue = NSNumber(value: 3 * stopAngle)
        animation.autoreverses = true
        animation.duration = 0.15
        animation.repeatCount = 1000
        let timeOffset = Double((arc4random() % 100) / 100) - 0.5
        animation.timeOffset = timeOffset
        layer.add(animation, forKey: "quivering")
    }
    
    func stopQuivering() {
        layer.removeAnimation(forKey: "quivering")
    }
}
