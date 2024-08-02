//
//  UITextView.swift
//  Euki
//
//  Created by Víctor Chávez on 3/31/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

public extension UITextView {
    func setLinkText(string: String, links: [String: String]?, uniqueLinks: [String: String]?, boldStrings: [String]? = nil) {
        let linkAttributes = [
            NSAttributedStringKey.font.rawValue: UIFont.eukContentTextFont() as Any,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.eukLink as Any
        ]
        let boldTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.eukiMain,
            NSAttributedStringKey.font: UIFont.eukBoldContentTextFont() as Any,
            NSAttributedStringKey.paragraphStyle: UIFont.paragraphStyle()
        ]
        
        let attributedString = NSMutableAttributedString(attributedString: string.convertToAttributed(links: links, uniqueLinks: uniqueLinks))
        boldStrings?.forEach({ boldString in
            let range = (attributedString.string as NSString).range(of: boldString.localized)
            attributedString.addAttributes(boldTextAttributes, range: range)
        })
        
        self.attributedText = attributedString
        self.linkTextAttributes = linkAttributes
    }
}
