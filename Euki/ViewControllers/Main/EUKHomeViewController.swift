//
//  EUKHomeViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 3/25/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKHomeViewController: EUKCommonTilesViewController {
    static var ShouldShowAbortion = false

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "nav_info".localized
        self.collectionView.register(UINib(nibName: "EUKReminderCollectionReusableView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.HeaderViewIdentifier)
        self.setUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.verifyAlertToShow()
        
        if EUKHomeViewController.ShouldShowAbortion {
            EUKHomeViewController.ShouldShowAbortion = false
            if let abortionViewController = EUKAbortionViewController.initViewController() {
                self.navigationController?.pushViewController(abortionViewController, animated: true)
            }
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func reminderOkAction() {
        self.alertReminderItem = nil
        self.alertAppointment = nil
        self.verifyAlertToShow()
        
        CalendarManager.sharedInstance.todayCalendarItem { [unowned self] (calendarItem) in
            if let viewController = EUKTrackViewController.initViewController(date: Date(), calendarItem: calendarItem) {
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func reminderDismissAction() {
        self.alertReminderItem = nil
        self.alertAppointment = nil
        self.verifyAlertToShow()
    }
    
    //MARK: - Private
    
    func setUIElements() {
        let searchIconBarItem = UIBarButtonItem(image: UIImage(named: "IconNavSearch"), style: .plain, target: self, action: #selector(EUKHomeViewController.showGlobalSearch))
		let searchLabelBarItem = UIBarButtonItem(title: "search".localized.uppercased(), style: .plain, target: self, action: #selector(EUKHomeViewController.showGlobalSearch))
		searchIconBarItem.tintColor = UIColor.eukiAccent
		searchLabelBarItem.tintColor = UIColor.eukiMain
        self.navigationItem.rightBarButtonItems = [searchLabelBarItem, searchIconBarItem]
    }
    
    @objc func showGlobalSearch() {
        if let viewController = UIStoryboard(name: "GlobalSearch", bundle: Bundle.main).instantiateInitialViewController() {
			viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    override func createItems() {
        self.items = HomeManager.sharedInstance.requestMainItems()
        self.usedItems.removeAll()
        self.notUsedItems.removeAll()
        
        let order = HomeManager.sharedInstance.homeOrder()
        self.usedItems.append(contentsOf: order.0)
        self.notUsedItems.append(contentsOf: order.1)
    }
    
    override func itemChanged(item: ContentItem, title: String?) {
        HomeManager.sharedInstance.saveTitle(item: item, title: title)
    }
    
    override func saveItems() {
        HomeManager.sharedInstance.saveHomeOrder(usedItems: self.usedItems, notUsedItems: self.notUsedItems)
    }
    
    override func showContentItem(item: ContentItem) {
        switch item.id {
        case "abortion":
            if let abortionViewController = EUKAbortionViewController.initViewController() {
                self.navigationController?.pushViewController(abortionViewController, animated: true)
            }
        case "stis":
            ContentManager.sharedInstance.requestSTIs { [unowned self] (contentItem) in
                if let contentItem = contentItem {
                    if let viewController = EUKAutoContentViewController.initViewController() {
                        viewController.contentItem = contentItem
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                }
            }
        case "contraception":
            ContentManager.sharedInstance.requestContraception { [unowned self] (contentItem) in
                if let contentItem = contentItem {
                    if let viewController = EUKAutoContentViewController.initViewController() {
                        viewController.contentItem = contentItem
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                }
            }
        case "miscarriage":
            ContentManager.sharedInstance.requestMiscarriage { [unowned self] (contentItem) in
                if let contentItem = contentItem {
                    if let viewController = EUKAutoContentViewController.initViewController() {
                        viewController.contentItem = contentItem
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                }
            }
        case "sexuality":
            ContentManager.sharedInstance.requestSexRelationships { [unowned self] (contentItem) in
                if let contentItem = contentItem {
                    if let viewController = EUKAutoContentViewController.initViewController() {
                        viewController.contentItem = contentItem
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                }
            }
        case "pregnancy_options":
            ContentManager.sharedInstance.requestPregnancyOptions { [unowned self] (contentItem) in
                if let contentItem = contentItem {
                    if let viewController = EUKAutoContentViewController.initViewController() {
                        viewController.contentItem = contentItem
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                }
            }
        default:
            print("Option not supported")
        }
    }
    
    func verifyAlertToShow() {
        if self.alertReminderItem != nil || self.alertAppointment != nil {
            return
        }
        
        RemindersManager.sharedInstance.pendingNotify { [unowned self] (reminderItem) in
            if reminderItem == nil {
                CalendarManager.sharedInstance.pendingNotify(responseHandler: { [unowned self] (appointment) in
                    self.alertAppointment = appointment
                    self.collectionView.reloadData()
                })
            } else {
                self.alertReminderItem = reminderItem
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - Public

    class func initViewController() -> EUKHomeViewController? {
        if let homeViewController = super.initViewController(anyClass: EUKHomeViewController.self) as? EUKHomeViewController {
            return homeViewController
        }
        return nil
    }
}

extension EUKHomeViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.HeaderViewIdentifier, for: indexPath) as? EUKReminderCollectionReusableView {
                headerView.dismissButton.addTarget(self, action: #selector(EUKHomeViewController.reminderDismissAction), for: .touchUpInside)
                headerView.okButton.addTarget(self, action: #selector(EUKHomeViewController.reminderOkAction), for: .touchUpInside)
                
                if let reminderItem = self.alertReminderItem {
                    headerView.titleLabel.text = reminderItem.title
                    headerView.contentLabel.text = reminderItem.text
                    headerView.addBorders(edges: .bottom, color: UIColor.eukiMain, thickness: 0.9)
                    headerView.okButton.isHidden = true
                    headerView.isHidden = false
                } else if let appointment = self.alertAppointment {
                    headerView.titleLabel.text = appointment.title
                    headerView.contentLabel.text = appointment.location
                    headerView.addBorders(edges: .bottom, color: UIColor.eukiMain, thickness: 0.9)
                    headerView.isHidden = false
                } else {
                    headerView.isHidden = true
                }
                
                return headerView
            }
        }
        
        return super.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if self.alertReminderItem == nil && self.alertAppointment == nil {
            return CGSize.zero
        }
        return CGSize(width: collectionView.bounds.size.width, height: 152.0)
    }
}
