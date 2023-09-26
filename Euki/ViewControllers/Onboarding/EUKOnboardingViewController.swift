//
//  EUKOnboardingViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 4/10/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKOnboardingViewController: EUKCommonPagerViewController {
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIEleements()
    }
    
    //MARK: - Private
    
    func setUIEleements() {
        self.pageControl.isHidden = true
        for view in self.pageViewController!.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    
    override func createViewControllers(){
        let storyboard = UIStoryboard(name: "Onboardings", bundle: Bundle.main)
        
        for index in 1 ... 7 {
            let viewControllerId = "OnboardingScreen\(index)"
            
            if let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId) as? EUKBaseViewController{
                viewController.index = index - 1
                self.viewControllers.append(viewController)
            }
        }
    }
    
    func showNext(){
        if self.currentIndex == self.viewControllers.count - 1 {
            (UIApplication.shared.delegate as? AppDelegate)?.showMainViewController()
        } else {
            self.goToNextPage()
        }
    }
    
    func showTerms() {
        for viewController in self.viewControllers {
            if let termsViewController = viewController as? EUKTermsOfUseViewController {
                self.showPageViewController(viewController: termsViewController, direction: .forward)
                break
            }
        }
    }
}
