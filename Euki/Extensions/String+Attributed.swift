//
//  String+Attributed.swift
//  Euki
//
//  Created by Víctor Chávez on 3/30/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

public extension String {
    
    func convertToAttributed(links: [String: String]?, uniqueLinks: [String: String]?) -> NSAttributedString{
        let attributes = [
            NSAttributedStringKey.font: UIFont.eukContentTextFont() as Any,
            NSAttributedStringKey.foregroundColor: UIColor.eukiMain as Any,
            NSAttributedStringKey.paragraphStyle: UIFont.paragraphStyle()
        ]
        return self.convertToAttributed(attributes: attributes, links: links, uniqueLinks: uniqueLinks)
    }
    
    func convertToAttributed(attributes: [NSAttributedStringKey: Any], links: [String: String]?, uniqueLinks: [String: String]?) -> NSAttributedString{
        let linesArray = self.components(separatedBy: .newlines)
        
        let fullAttributedString = NSMutableAttributedString()
        
        let dotAttributes = [
            NSAttributedStringKey.font: UIFont.eukContentTextDotFont() as Any,
            NSAttributedStringKey.foregroundColor: UIColor.eukiMain as Any
        ]
        
        for var line in linesArray{
            if line.starts(with: "- "){
                line = line.stringByReplacingFirstOccurrenceOfString(target: "- ", withString: "●  ")
            }
            
            var currentLine: String
            
            if fullAttributedString.string.isEmpty{
                currentLine = line
            } else{
                currentLine = "\n\(line)"
            }
            
            let attributedString = NSMutableAttributedString(string: currentLine)
            attributedString.addAttributes(attributes, range: NSMakeRange(0, attributedString.length))
            
            if line.count > 2 &&
                (line[line.index(line.startIndex, offsetBy: 1)] == "." ||
                    line[line.index(line.startIndex, offsetBy: 0)] == "●" ||
                    line[line.index(line.startIndex, offsetBy: 0)] == "▪" ||
                    line[line.index(line.startIndex, offsetBy: 0)] == "-"){
                
                let paragraphStyle = self.createParagraphAttribute()
                attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
                attributedString.addAttributes(dotAttributes, range: NSMakeRange(0, 2))
            }
            
            fullAttributedString.append(attributedString)
        }

        if let links = links {
            for link in links {
                let ranges = fullAttributedString.string.ranges(of: link.key)
                
                for range in ranges {
                    let linkRange = NSRange(range, in: fullAttributedString.string)
                    fullAttributedString.addAttribute(.link, value: link.value, range: linkRange)
                }
            }
        }
        
        if let uniqueLinks = uniqueLinks {
            for link in uniqueLinks {
                let ranges = fullAttributedString.string.ranges(of: link.key)
                if let range = ranges.first {
                    let linkRange = NSRange(range, in: self)
                    fullAttributedString.addAttribute(.link, value: link.value, range: linkRange)
                }
            }
        }
        
        return fullAttributedString
    }
    
    func createParagraphAttribute() ->NSParagraphStyle{
        var paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [NSTextTab.OptionKey : Any])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 17
        paragraphStyle.lineHeightMultiple = Constants.FontLineSpacingMultiplier
        return paragraphStyle
    }
}
