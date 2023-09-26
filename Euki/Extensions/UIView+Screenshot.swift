//
//  UIView+Screenshot.swift
//  Euki
//
//  Created by Víctor Chávez on 4/25/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

extension UIView {
    var screenShot: UIImage?  {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 1.0);
        if let _ = UIGraphicsGetCurrentContext() {
            drawHierarchy(in: bounds, afterScreenUpdates: true)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return screenshot
        }
        return nil
    }
}
