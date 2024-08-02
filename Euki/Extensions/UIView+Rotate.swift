//
//  UIView+Rotate.swift
//  Euki
//
//  Created by Víctor Chávez on 3/30/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

public extension UIView {
    func rotate(_ angle: CGFloat) {
        let radians = angle / 180.0 * .pi
        let rotation = CGAffineTransform(rotationAngle: radians)
        self.transform = rotation
    }
}
