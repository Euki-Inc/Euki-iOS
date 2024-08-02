//
//  EUKEditText.swift
//  Euki
//
//  Created by Víctor Chávez on 12/3/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import SwiftyJSON

class EUKTextView: UITextView {
    
    @IBInspectable var localizedKey:String = "" {
        didSet {
            self.setLocalizedString()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var linkJson:String = "" {
        didSet {
            self.setLocalizedString()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var uniqueLinkJson:String = "" {
        didSet {
            self.setLocalizedString()
            setNeedsDisplay()
        }
    }
    
    //MARK: - Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUIElements()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.setUIElements()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUIElements()
    }
    
    //MARK: - Private
    
    func setUIElements(){
        self.setLocalizedString()
    }
    
    func setLocalizedString(){
        if !self.localizedKey.isEmpty{
            let attributes = [
                NSAttributedStringKey.foregroundColor: self.textColor ?? UIFont.eukContentTextFont() as Any,
                NSAttributedStringKey.font: self.font as Any,
                NSAttributedStringKey.paragraphStyle: UIFont.paragraphStyle() as Any
            ]
            
            let linkAttributes = [
                NSAttributedStringKey.font.rawValue: UIFont.eukContentTextFont() as Any,
                NSAttributedStringKey.foregroundColor.rawValue: UIColor.eukLink as Any,
                NSAttributedStringKey.paragraphStyle.rawValue: UIFont.paragraphStyle() as Any
            ]
            
            var links = [String: String]()
            let linksJSON = JSON(parseJSON: self.linkJson)
            for (key, value) in linksJSON {
                if let stringValue = value.string {
                    links[key.localized] = stringValue
                }
            }
            
            var uniqueLinks = [String: String]()
            let uniqueLinksJSON = JSON(parseJSON: self.uniqueLinkJson)
            for (key, value) in uniqueLinksJSON {
                if let stringValue = value.string {
                    uniqueLinks[key.localized] = stringValue
                }
            }
            
            
            let attributedString = self.localizedKey.localized.convertToAttributed(attributes: attributes, links: links, uniqueLinks: uniqueLinks)
            self.attributedText = attributedString
            self.linkTextAttributes = linkAttributes
        }
    }
}
