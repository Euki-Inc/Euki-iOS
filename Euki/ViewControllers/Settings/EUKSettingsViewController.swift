//
//  EUKSettingsViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 11/26/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKSettingsViewController: EUKBasePinCheckViewController {
    let ContainerCellIdentifier = "ContainerCellIdentifier"
    let SelectableCellIdentifier = "SelectableCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    var topViewController: EUKTopSettingsViewController?
    var isFirstTime = true
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.navigationTitle = "privacy"
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "EUKSelectableTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: self.SelectableCellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.isFirstTime {
            self.isFirstTime = false
            self.topViewController?.updateUIElements()
        }
    }
}

extension EUKSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.ContainerCellIdentifier, for: indexPath)
            
            if self.topViewController == nil {
                self.topViewController = EUKTopSettingsViewController.initViewController()
            }
            
            if let topViewController = self.topViewController {
                topViewController.delegate = self
                self.configureChildViewController(childController: topViewController, onView: cell.contentView)
            }
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.SelectableCellIdentifier, for: indexPath) as? EUKSelectableTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.row == 0{
            cell.titleLabel.text = "privacy_faq".localized
        }else if indexPath.row == 1{
            cell.titleLabel.text = "Privacy best practices_dropdown".localized
        }else{
            cell.titleLabel.text = "privacy_statement".localized
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return self.topViewController?.calculatedHeight ?? 1000.0
        }
        
        return 82.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }
        
        if indexPath.row == 0 {
            cell.contentView.addBorders(edges: .top, color: UIColor.eukiMain, thickness: 1.0)
        }
        cell.contentView.addBorders(edges: .bottom, color: UIColor.eukiMain, thickness: 1.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            return
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                self.pushContentItem(contentItem: PrivacyContentManager.sharedInstance.privacyFAQS())
            } else if indexPath.row == 1 {
                self.pushContentItem(contentItem: PrivacyContentManager.sharedInstance.privacyBestPractices())
            } else {
                self.pushContentItem(contentItem: PrivacyContentManager.sharedInstance.privacyStatement())
            }
        }
    }
    
}

extension EUKSettingsViewController: TopSettingsDelegate {
    func heightUpdated() {
        self.tableView.reloadData()
    }
}
