//
//  UIView+ConstraintIdentifier.swift
//  Euki
//
//  Created by Stefanita Oaca on 22.08.2024.
//  Copyright © 2024 Ibis. All rights reserved.
//

import UIKit

extension UIView{
    func constraintWith(identifier: String) -> NSLayoutConstraint?{
        return self.constraints.first(where: {$0.identifier == identifier})
    }
}
