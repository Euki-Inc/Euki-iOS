//
//  UIColor.swift
//  Euki
//
//  Created by Víctor Chávez on 3/17/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class var eukNavBackground: UIColor{
        return UIColor(named: "NavBackgroundColor") ?? UIColor.white
    }
    
    class var eukGreen: UIColor{
        return UIColor(named: "Green") ?? UIColor.green
    }
    
    class var eukCoral: UIColor{
        return UIColor(named: "Coral") ?? UIColor.green
    }
    
    class var eukGreenClear: UIColor{
        return UIColor(named: "GreenClear") ?? UIColor.green
    }
    
    class var eukPurple: UIColor{
        return UIColor(named: "Purple") ?? UIColor.green
    }
    
    class var eukPurpleClear: UIColor{
        return UIColor(named: "PurpleClear") ?? UIColor.green
    }
	
	class var eukiAccent: UIColor{
		return UIColor(red: 97.0 / 255.0, green: 79.0 / 255.0, blue: 194.0 / 255.0, alpha: 1.0)
	}
	
	class var eukiMain: UIColor{
		return UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
	}
    
    class var eukLink: UIColor{
        return UIColor.fromHex(hexString: "#EA7D77")
    }
    
    @nonobjc class var eukDeepLavender: UIColor {
        return UIColor(red: 121.0 / 255.0, green: 113.0 / 255.0, blue: 164.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukDustyTeal: UIColor {
        return UIColor(red: 75.0 / 255.0, green: 123.0 / 255.0, blue: 111.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukPaleTeal: UIColor {
        return UIColor(red: 145.0 / 255.0, green: 181.0 / 255.0, blue: 172.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukIceBlue: UIColor {
        return UIColor(red: 243.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukLeather: UIColor {
        return UIColor(red: 159.0 / 255.0, green: 145.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukSlateGrey: UIColor {
        return UIColor(red: 90.0 / 255.0, green: 89.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukWhite: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var eukBlueberry: UIColor {
        return UIColor(red: 69.0 / 255.0, green: 53.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukIris: UIColor {
        return UIColor(red: 97.0 / 255.0, green: 79.0 / 255.0, blue: 194.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukPaleLavender: UIColor {
        return UIColor(red: 236.0 / 255.0, green: 234.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukGunmetal: UIColor {
        return UIColor(red: 58.0 / 255.0, green: 87.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukBlueBlue: UIColor {
        return UIColor(red: 35.0 / 255.0, green: 74.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukLipstickRed: UIColor {
        return UIColor(red: 195.0 / 255.0, green: 0.0, blue: 39.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukTangerine: UIColor {
        return UIColor(red: 249.0 / 255.0, green: 149.0 / 255.0, blue: 24.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukPinkishBrown: UIColor {
        return UIColor(red: 181.0 / 255.0, green: 109.0 / 255.0, blue: 96.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukBrownishGrey: UIColor {
        return UIColor(white: 96.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukRobinSEgg: UIColor {
        return UIColor(red: 94.0 / 255.0, green: 212.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var eukPaleTealTwo: UIColor {
        return UIColor(red: 129.0 / 255.0, green: 202.0 / 255.0, blue: 171.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var eukMacaroniAndCheese: UIColor {
        return UIColor(red: 218.0 / 255.0, green: 203.0 / 255.0, blue: 73.0 / 255.0, alpha: 1.0)
    }
	
	@nonobjc class var eukBackground: UIColor {
		return UIColor(red: 243.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var eukLightMint: UIColor {
		return UIColor(red: 181.0 / 255.0, green: 250.0 / 255.0, blue: 188.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var eukPrimaryLighter: UIColor {
		return UIColor(red: 199.0 / 255.0, green: 185.0 / 255.0, blue: 1.0, alpha: 1.0)
	}
    
    @nonobjc class var eukDisdabledGrey: UIColor {
        return UIColor(red: 210.0 / 255.0, green: 210.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0)
    }

    
    //MARK: - Calendar Colors
    
    class var eukAppointment: UIColor{
        return self.eukBlueBlue
    }
    
    class var eukBleeding: UIColor{
        return self.eukLipstickRed
    }
    
    class var eukBody: UIColor{
        return self.eukPinkishBrown
    }
    
    class var eukContraception: UIColor{
        return self.eukRobinSEgg
    }
    
    class var eukEmotions: UIColor{
        return self.eukTangerine
    }
    
    class var eukNote: UIColor{
        return self.eukMacaroniAndCheese
    }
    
    class var eukSexualActivity: UIColor{
        return self.eukBrownishGrey
    }
    
    class var eukTest: UIColor{
        return self.eukPaleTealTwo
    }
    
    class var eukTabBarSelectedColor: UIColor {
        return UIColor.colorWithHexString("#45359D")
    }
    
    class var eukCalendarItemDisabledColor: UIColor {
        return UIColor.colorWithHexString("#F3F6F6", alpha: 0.6)
    }
    
    //MARK: - Private
    
    public class func colorWithHexString(_ hexString:String) -> UIColor {
        return self.colorWithHexString(hexString, alpha: -1)
    }
    
    public class func colorWithHexString(_ hexString:String, alpha alphaParam:CGFloat) -> UIColor {
        let colorString = hexString.replacingOccurrences(of: "#", with: "")
        var alpha, red, blue, green:CGFloat
        switch(colorString.count) {
        case 3: // #RGB
            alpha = 1.0
            red   = self.colorComponentFrom(colorString, start: 0, length: 1)
            green = self.colorComponentFrom(colorString, start: 1, length: 1)
            blue  = self.colorComponentFrom(colorString, start: 2, length: 1)
            break;
        case 4: // #ARGB
            alpha = self.colorComponentFrom(colorString, start: 0, length: 1)
            red   = self.colorComponentFrom(colorString, start: 1, length: 1)
            green = self.colorComponentFrom(colorString, start: 2, length: 1)
            blue  = self.colorComponentFrom(colorString, start: 3, length: 1)
            break;
        case 6: // #RRGGBB
            alpha = 1.0
            red   = self.colorComponentFrom(colorString, start: 0, length: 2)
            green = self.colorComponentFrom(colorString, start: 2, length: 2)
            blue  = self.colorComponentFrom(colorString, start: 4, length: 2)
            break;
        case 6: // #AARRGGBB
            alpha = self.colorComponentFrom(colorString, start: 0, length: 2)
            red   = self.colorComponentFrom(colorString, start: 2, length: 2)
            green = self.colorComponentFrom(colorString, start: 4, length: 2)
            blue  = self.colorComponentFrom(colorString, start: 6, length: 2)
            break;
        default:
            alpha = 1.0
            red   = 0
            green = 0
            blue  = 0
            break;
        }
        if (alphaParam != -1) {
            alpha = alphaParam
        }
        return UIColor(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    //MARK: - Private
    
    fileprivate class func colorComponentFrom(_ str:String, start:Int, length:Int) -> CGFloat {
        let range = str.characters.index(str.startIndex, offsetBy: start)..<str.characters.index(str.startIndex, offsetBy: start+length)
        let substring = str.substring(with: range)
        let fullHex = length == 2 ? substring : "\(substring)\(substring)"
        var hexComponent:CUnsignedInt = 0
        Scanner(string: fullHex).scanHexInt32(&hexComponent)
        return CGFloat(hexComponent)/255.0
    }
    
    public func hexStringThrows(_ includeAlpha: Bool = true) throws -> String  {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        guard r >= 0 && r <= 1 && g >= 0 && g <= 1 && b >= 0 && b <= 1 else {
            let error = UIColorInputError.unableToOutputHexStringForWideDisplayColor
            print(error.localizedDescription)
            throw error
        }
        
        if (includeAlpha) {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
    
    /**
     Hex string of a UIColor instance, fails to empty string.
     
     - parameter includeAlpha: Whether the alpha should be included.
     */
    public func hexString(_ includeAlpha: Bool = true) -> String  {
        guard let hexString = try? hexStringThrows(includeAlpha) else {
            return ""
        }
        return hexString
    }
}
