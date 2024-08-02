//
//  EUKCommonPagerViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 4/10/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKCommonPagerViewController: EUKBaseViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pageViewController: UIPageViewController!
    
    var viewControllers = [EUKBaseViewController]()
    var currentIndex = 0
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPageViewController()
        self.createViewControllers()
        
        if self.viewControllers.count > 0{
            self.pageViewController.setViewControllers([self.viewControllers[0]], direction: .forward, animated: false, completion: nil)
        }
        
        self.updateUIElements()
    }
    
    //MARK: - Private
    
    func updateUIElements(){
        self.pageControl.numberOfPages = viewControllers.count
        self.pageControl.currentPage = self.currentIndex
    }
    
    func initPageViewController(){
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        self.configureChildViewController(childController: pageViewController, onView: self.containerView)
        self.pageViewController = pageViewController
    }
    
    func createViewControllers(){
    }
    
    func goToNextPage() {
        guard let currentViewController = self.pageViewController.viewControllers?.first else { return }
        guard let nextViewController = self.pageViewController(self.pageViewController, viewControllerAfter: currentViewController) as? EUKBaseViewController else {
            return
        }
        self.showPageViewController(viewController: nextViewController, direction: .forward)
    }
    
    func goToPreviousPage() {
        guard let currentViewController = self.pageViewController.viewControllers?.first else { return }
        guard let previousViewController = self.pageViewController(self.pageViewController, viewControllerBefore: currentViewController) as? EUKBaseViewController else {
            return
        }
        self.showPageViewController(viewController: previousViewController, direction: .reverse)
    }
    
    func showPageViewController(viewController: EUKBaseViewController, direction: UIPageViewControllerNavigationDirection) {
        self.pageViewController.setViewControllers([viewController], direction: direction, animated: true, completion: nil)
        self.currentIndex = viewController.index
        self.updateUIElements()
    }
    
    func jumptoPage(index : Int) {
        let vc = self.viewControllers[index]
        var direction = UIPageViewControllerNavigationDirection.forward
        
        if currentIndex >= index {
            direction = .reverse
        }
        
        if (currentIndex < index) {
            for i in 0...index {
                if (i == index) {
                    self.pageViewController.setViewControllers([vc], direction: direction, animated: true, completion: nil)
                } else {
                    self.pageViewController.setViewControllers([self.viewControllers[i]], direction: direction, animated: false, completion: nil)
                }
            }
        } else {
            for i in stride(from: self.currentIndex, through: index, by: -1) {
                if i == index {
                    self.pageViewController.setViewControllers([vc], direction: direction, animated: true, completion: nil)
                } else {
                    self.pageViewController.setViewControllers([self.viewControllers[i]], direction: direction, animated: false, completion: nil)
                }
            }
        }
        currentIndex = index
    }
}

extension EUKCommonPagerViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let viewController = self.pageViewController.viewControllers?[0] as? EUKBaseViewController{
            self.currentIndex = viewController.index
            self.updateUIElements()
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = 0
        
        if let viewController = viewController as? EUKBaseViewController{
            index = viewController.index
            
            if index == 0{
                return nil
            }
        }
        
        index = index - 1
        return self.viewControllers[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = 0
        
        if let viewController = viewController as? EUKBaseViewController{
            index = viewController.index
            
            if index == self.viewControllers.count - 1{
                return nil
            }
        }
        
        index = index + 1
        return self.viewControllers[index]
    }
}
