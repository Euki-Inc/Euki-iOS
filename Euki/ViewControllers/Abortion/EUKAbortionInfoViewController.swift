//
//  EUKAbortionInfoViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 12/5/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKAbortionInfoViewController: EUKCommonContentViewController {
    var AbortionInfoCellIdentifier = "AbortionInfoCellIdentifier"
    var SetRemindersCellIdenifier = "SetRemindersCellIdenifier"
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AbortionInfoCellIdentifier = "AbortionInfoCellIdentifier"
        self.SetRemindersCellIdenifier = "SetRemindersCellIdenifier"
        self.tableView.register(UINib(nibName: "EUKAbortionInfoTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: self.AbortionInfoCellIdentifier)
        self.tableView.register(UINib(nibName: "EUKSetRemindersTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: self.SetRemindersCellIdenifier)
    }
    
    //MARK: - Private
    
    override func createContent() {
        super.createContent()
        guard let contentItem = self.contentItem else {
            return
        }
        
        var expandableItems = [ExpandableItem]()
        
        if let contentItems = contentItem.expandableItems {
            for contentItem in contentItems {
                let exoandableItem = ExpandableItem(id: contentItem.id, title: contentItem.title?.localized ?? contentItem.id.localized, text: contentItem.content.localized, contentItem: contentItem)
                if let expandContentItem = self.expandContentItem, contentItem == expandContentItem {
                    exoandableItem.isExpanded = true
                }
                expandableItems.append(exoandableItem)
            }
        }
        
        self.items.removeAll()
        self.items.append(contentsOf: expandableItems)
    }
    
    @objc func showReminders() {
        let remindersViewConroller = EUKRemindersViewController.initNavViewController()
        self.present(remindersViewConroller, animated: true, completion: nil)
    }
    
    //MARK: - Public
    
    class func initViewController() -> EUKAbortionInfoViewController? {
        if let viewController = super.initViewController(anyClass: EUKAbortionInfoViewController.self) as? EUKAbortionInfoViewController {
            return viewController
        }
        return nil
    }
    
}

extension EUKAbortionInfoViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2 + (self.contentItem?.contentItems ?? [ContentItem]()).count
        }
        
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contentItem = self.contentItem else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: self.ContentCellIdentifier, for: indexPath)
                if let titleLabel = cell.viewWithTag(CellTags.titleLabel.rawValue) as? UILabel {
                    titleLabel.text = (contentItem.title ?? contentItem.id).localized
                }
                cell.contentView.viewWithTag(CellTags.contentContainer.rawValue)?.isHidden = true
                cell.contentView.viewWithTag(CellTags.imageViewContainer.rawValue)?.isHidden = contentItem.imageIcon.isEmpty
                return cell
            } else if indexPath.row == (contentItem.contentItems?.count ?? 0) + 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: self.SetRemindersCellIdenifier, for: indexPath) as? EUKSetRemindersTableViewCell else {
                    return UITableViewCell()
                }
                cell.setRemindersButton.addTarget(self, action: #selector(EUKAbortionInfoViewController.showReminders), for: .touchUpInside)
                return cell
            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: self.AbortionInfoCellIdentifier, for: indexPath) as? EUKAbortionInfoTableViewCell, let contentItems = self.contentItem?.contentItems else {
                return UITableViewCell()
            }
            
            let contentItem = contentItems[indexPath.row - 1]
            cell.titleTextView.setLinkText(string: contentItem.id.localized, links: contentItem.links, uniqueLinks: contentItem.uniqueLinks)
			cell.titleTextView.delegate = self
            cell.titleTextView.isHidden = contentItem.id.isEmpty
            cell.iconView.image = UIImage(named: contentItem.imageIcon)
            cell.iconView.isHidden = contentItem.imageIcon.isEmpty
            
            return cell
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
}
