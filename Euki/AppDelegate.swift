//
//  AppDelegate.swift
//  Euki
//
//  Created by Víctor Chávez on 3/17/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        self.setUIAppearance()
        self.setIQKeyboard()
        LocalDataManager.sharedInstance.checkMigration()
        PrivacyManager.sharedInstance.verifyAutoRemoveData()
        
        if LocalDataManager.sharedInstance.showOnboardingScreens() {
            PrivacyManager.sharedInstance.removeAllData()
        } else {
            if let _ = LocalDataManager.sharedInstance.pinCode() {
                if let viewController = UIStoryboard(name: "Onboardings", bundle: Bundle.main).instantiateViewController(withIdentifier: "EnterPinCode") as? EUKCheckCodeViewController {
                    viewController.shouldShowMainViewController = true
                    self.window?.rootViewController = viewController
                }
            } else {
                self.showMainViewController()
            }
        }
        
        BookmarksManager.sharedInstance.loadBookmarks()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: EUKBaseBackgroundCheckViewController.BackToForgroundNotification), object: nil)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
		CoreDataManager.sharedInstance.saveContext()
    }
    
    func setUIAppearance(){
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundImage = UIImage(color: UIColor.eukNavBackground)
            appearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
			appearance.shadowColor = UIColor.black
            UIApplication.shared.statusBarStyle = .lightContent
            
            appearance.largeTitleTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.black,
                NSAttributedStringKey.font: UIFont.eukContentTitleFont() as Any
            ]
            
            UINavigationBar.appearance().tintColor = UIColor.eukiMain
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().setBackgroundImage(UIImage(color: UIColor.eukNavBackground), for: .default)
            UINavigationBar.appearance().tintColor = UIColor.eukiMain
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.eukiMain]
            UIApplication.shared.statusBarStyle = .lightContent

            UINavigationBar.appearance().largeTitleTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.eukiMain,
                NSAttributedStringKey.font: UIFont.eukContentTitleFont() as Any
            ]
        }
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.eukBarItemFont()!], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.eukBarItemFont()!], for: .focused)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.eukBarItemFont()!], for: .selected)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.eukBarItemFont()!], for: .disabled)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.eukBarItemFont()!], for: .highlighted)
    }
    
    func setIQKeyboard(){
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
    }
    
    func showMainViewController(){
		if let mainViewController = EUKMainViewController.initViewController() {
			self.window?.rootViewController = mainViewController
		}
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: EUKMainViewController.ShowHomeNotification), object: nil)
    }
}
