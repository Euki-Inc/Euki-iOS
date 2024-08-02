//
//  Helper.swift
//  Euki
//
//  Created by Dhekra Rouatbi on 15/3/2024.
//  Copyright © 2024 Ibis. All rights reserved.
//

import Foundation

func getFormattedSize(_ size: CGFloat) -> CGFloat {
    let widthScreen: CGFloat =  UIScreen.main.bounds.size.width
    let result = CGFloat(size) * (widthScreen / Constants.defaultReferenceScreenWidth)
    return result
}

