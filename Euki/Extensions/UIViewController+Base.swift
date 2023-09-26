//
//  UIViewController+Base.swift
//  Euki
//
//  Created by Víctor Chávez on 3/17/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import SafariServices
import MaterialShowcase

extension UIViewController {
	func alertViewController(
		title: String? = nil,
		message: String? = nil,
		showCancel: Bool = false,
		okHandler: ((UIAlertAction) -> Void)? = nil,
		cancelHandler: ((UIAlertAction) -> Void)? = nil,
		okTitle: String? = nil,
		cancelTitle: String? = nil) -> UIAlertController {
			let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
			alertViewController.view.tintColor = UIColor.eukiAccent
			let cancelAction = UIAlertAction(title: (cancelTitle ?? "cancel").localized.uppercased(), style: .destructive, handler: cancelHandler)
			let okAction = UIAlertAction(title: (okTitle ?? "ok").localized.uppercased(), style: .default, handler: okHandler)
			
			if showCancel {
				alertViewController.addAction(cancelAction)
			}
			alertViewController.addAction(okAction)
			return alertViewController
    }
    
    func showURL(string: String){
        let urlString = string.lowercased().contains("http") ? string : "http://\(string)"
        
        if let url = URL(string: urlString){
            self.showURL(url: url)
        }
    }
    
    func showURL(url: URL){
        let safariViewController = SFSafariViewController(url: url)
        
        if #available(iOS 10.0, *) {
            safariViewController.preferredBarTintColor = UIColor.eukNavBackground
            safariViewController.preferredControlTintColor = UIColor.eukiAccent
        } else {
            safariViewController.view.tintColor = UIColor.white
        }
        
        self.present(safariViewController, animated: true, completion: nil)
    }
    
    func createTutorial(title: String, content: String) -> MaterialShowcase {
        let showcase = MaterialShowcase()
        showcase.backgroundViewType = .circle
        showcase.targetTintColor = UIColor.eukLightMint
		showcase.backgroundPromptColor = UIColor.eukLightMint
		
        showcase.primaryText = title
        showcase.secondaryText = "\n\(content)"
        showcase.isTapRecognizerForTargetView = false
		showcase.primaryTextColor = UIColor.black
		showcase.secondaryTextColor = UIColor.black
		showcase.primaryTextFont = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.regular)
		showcase.secondaryTextFont = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.regular)
        return showcase
    }
}
