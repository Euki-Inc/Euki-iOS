//
//  UIFont.swift
//  Euki
//
//  Created by Víctor Chávez on 3/17/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func eukTileLargeFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 18.0, weight: .medium)
    }
    
    class func eukTileSmallFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 16.0, weight: .medium)
    }
    
    class func eukButtonFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 16.0)
    }
    
    class func eukGreenButtonFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 17.0, weight: .medium)
    }
    
    class func eukContentTitleFont() -> UIFont? {
		return UIFont.systemFont(ofSize: 20.0, weight: .regular)
    }
    
    class func eukContentTextFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 16.0, weight: .regular)
    }
    
    class func eukBoldContentTextFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 16.0, weight: .bold)
    }
    
    class func eukContentTextDotFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 10.0, weight: .medium)
    }
    
    class func eukContentTextSourceFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 14.0, weight: .regular)
    }
    
    class func eukBarItemFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 12.0, weight: .semibold)
    }
    
    class func paragraphStyle() -> NSMutableParagraphStyle {
        return self.paragraphStyle(height: Constants.FontLineSpacingMultiplier)
    }
    
    class func paragraphStyle(height: CGFloat) -> NSMutableParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = height
        return style
    }
}
