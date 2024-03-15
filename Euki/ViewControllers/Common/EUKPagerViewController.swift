//
//  EUKCommonSwipeView.swift
//  Euki
//
//  Created by Dhekra Rouatbi on 14/3/2024.
//  Copyright © 2024 Ibis. All rights reserved.
//

import Foundation
import UIKit

class EUKPagerViewController: EUKCommonPagerViewController {
    
    var swipePagerItems: [SwipePagerItem] = []
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
    }
    
    override func updateUIElements(){
        super.updateUIElements()
        pageControl.pageIndicatorTintColor = UIColor.eukDisdabledGrey
        pageControl.currentPageIndicatorTintColor = UIColor.eukiAccent
    }
    
    override func createViewControllers() {
        
        let storyboard = UIStoryboard(name: "Common", bundle: Bundle.main)
        let viewControllerId = "EUKCommonPagerContentViewController"
        
        for (index,item) in swipePagerItems.enumerated() {
            if let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId) as? EUKCommonPagerContentViewController {
                viewController.index = index
                viewController.imageName = item.icon
                viewController.descriptionText = item.content.localized
                self.viewControllers.append(viewController)
            }
        }
    }
    
    //MARK: - Private
    
    private func setUIElements() {
        
        containerView.addshadow()
        
        setupPageControl()
        
        // Add tapGestureRecognizer to remove the table view expand action
        self.view.setTapGestureRecognizer{}
    }
    
    private func setupPageControl() {
        if #available(iOS 14.0, *) {
            pageControl.preferredIndicatorImage = UIImage(named: "pageIndicatorOn")
        }
        pageControl.pageIndicatorTintColor = UIColor.eukDisdabledGrey
        pageControl.currentPageIndicatorTintColor = UIColor.eukiAccent
        
        // Add tapGestureRecognizer to remove the table view expand action
        self.pageControl.setTapGestureRecognizer {}
    }
    
    //MARK: - Public
    
    class func initViewController() -> UIViewController? {
        return UIStoryboard(name: "Common", bundle: nil).instantiateViewController(withIdentifier: "EUKPagerViewController")
    }
}
