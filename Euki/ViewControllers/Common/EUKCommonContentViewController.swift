//
//  EUKCommonContentViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 3/25/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKCommonContentViewController: EUKCommonExpandableViewController {
    static let IdViewController = "ContentViewController"
    let ContentCellIdentifier = "ContentCellIdentifier"
    let OptionsCellIdentifier = "OptionsCellIdentifier"
    let SelectableRowCellIdentifier = "SelectableRowCellIdentifier"
    
    enum CellTags: Int {
        case titleLabel = 100,
        bookmarkButton, imageView, contentContainer, contentTextView, imageViewContainer
    }
    
    enum OptionCellTags: Int {
        case optionContainer = 100,
        imageView, title, topLine, rightLine, bottomLine, selectButton,
        option1View = 200, option2View = 201
    }
    
    var contentItem: ContentItem?
    var expandContentItem: ContentItem?
    
    var titleAttributes = [
        NSAttributedStringKey.foregroundColor: UIColor.eukiMain,
        NSAttributedStringKey.font: UIFont.eukContentTitleFont() as Any
    ]
    
    var textAttributes = [
        NSAttributedStringKey.foregroundColor: UIColor.eukiMain,
        NSAttributedStringKey.font: UIFont.eukContentTextFont() as Any,
        NSAttributedStringKey.paragraphStyle: UIFont.paragraphStyle()
    ]
    
    var boldTextAttributes = [
        NSAttributedStringKey.foregroundColor: UIColor.eukiMain,
        NSAttributedStringKey.font: UIFont.eukBoldContentTextFont() as Any,
        NSAttributedStringKey.paragraphStyle: UIFont.paragraphStyle()
    ]
    
    var sourceAttributes = [
        NSAttributedStringKey.foregroundColor: UIColor.eukiMain,
        NSAttributedStringKey.font: UIFont.eukContentTextSourceFont() as Any
    ]
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createContent()
        self.setUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = (self.contentItem?.isDeeperLevel() ?? false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.autoScrollToExpanded()
    }
    
    //MARK: - IBActions
    
    @IBAction func showItem(_ button: UIButton) {
        guard let items = self.contentItem?.selectableItems else {
            return
        }
        
        if button.tag == OptionCellTags.selectButton.rawValue {
            guard let index = button.superview?.tag else {
                return
            }
            self.showContentItem(item: items[index])
            return
        }
        
        self.showContentItem(item: items[button.tag])
    }
    
    override func addBookmarkAction() {
        guard let contentItem = self.contentItem else {
            return
        }
        BookmarksManager.sharedInstance.addBookmark(contentItemId: contentItem.id)
        self.showBookmarkButton()
    }
    
    override func removeBookmarkAction() {
        guard let contentItem = self.contentItem else {
            return
        }
        BookmarksManager.sharedInstance.removeBookmark(contentItemId: contentItem.id)
        self.showBookmarkButton()
    }
    
    //MARK: - Private
    
    override func showBackButton() {
        if let shortTitle = self.contentItem?.shortTitle {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: shortTitle.localized, style: .plain, target: nil, action: nil)
        }
    }
    
    func createContent() {
    }
    
    override func setUIElements() {
        super.setUIElements()
        
        guard let contentItem = self.contentItem else {
            return
        }
        self.tableView.register(UINib(nibName: "EUKSelectableTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: self.SelectableRowCellIdentifier)
        self.tableView.estimatedRowHeight = 50.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.title = (contentItem.title ?? contentItem.id).localized
        self.expandableSection = 1
    }
    
    override func showBookmarkButton() {
        guard let contentItem = self.contentItem else {
            return
        }
        let bookmarkButtonItem = BookmarksManager.sharedInstance.isBookmark(contentItemId: contentItem.id) ? self.bookmarkButtonOnItem : self.bookmarkButtonOffItem
        self.navigationItem.rightBarButtonItem = bookmarkButtonItem
    }
    
    func autoScrollToExpanded() {
        if let expandContentItem = self.expandContentItem {
            for (index, expandableItem) in self.items.enumerated() {
                if expandableItem.id == expandContentItem.id {
                    let indexPath = IndexPath(row: index, section: self.expandableSection)
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                    self.expandContentItem = nil
                    return
                }
            }
        }
    }
    
    //MARK: - Public
    
    class func initViewController(anyClass: AnyClass?) -> EUKCommonContentViewController?{
        if let commonContentViewController = UIStoryboard(name: "Common", bundle: Bundle.main).instantiateViewController(withIdentifier: EUKCommonContentViewController.IdViewController) as? EUKCommonContentViewController{
            if let anyClass = anyClass {
                object_setClass(commonContentViewController, anyClass)
            }
            return commonContentViewController
        }
        return nil
    }
}

extension EUKCommonContentViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        if let contentItem = self.contentItem, section == 2 {
            var count = CGFloat(contentItem.selectableItems?.count ?? 0) / 2.0
            count.round(.up)
            return Int(count)
        }
        
        if section == 3 {
            return contentItem?.selectableRowItems?.count ?? 0
        }
        
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.ContentCellIdentifier, for: indexPath)
            
            guard let contentItem = self.contentItem else {
                return cell
            }
            
            if let titleLabel = cell.viewWithTag(CellTags.titleLabel.rawValue) as? UILabel {
                titleLabel.text = (contentItem.title ?? contentItem.id).localized
            }
            if let imageView = cell.viewWithTag(CellTags.imageView.rawValue) as? UIImageView {
                imageView.image = UIImage(named: contentItem.imageIcon)
                imageView.isHidden = contentItem.imageIcon.isEmpty
            }
            if let contentTextView = cell.viewWithTag(CellTags.contentTextView.rawValue) as? UITextView {
                let linkAttributes = [
                    NSAttributedStringKey.font.rawValue: UIFont.eukContentTextFont() as Any,
                    NSAttributedStringKey.foregroundColor.rawValue: UIColor.eukLink as Any
                ]
                
                let attributedString = NSMutableAttributedString()
                
                if !contentItem.content.isEmpty {
                    attributedString.append(contentItem.content.localized.convertToAttributed(attributes: self.textAttributes, links: contentItem.links, uniqueLinks: contentItem.uniqueLinks))
                }
                
                if let contentItems = contentItem.contentItems {
                    for item in contentItems {
                        if !attributedString.string.isEmpty {
                            attributedString.append(NSAttributedString(string: "\n\n", attributes: self.textAttributes))
                        }
                        attributedString.append(NSAttributedString(string: item.id.localized, attributes: self.titleAttributes))
                        attributedString.append(NSAttributedString(string: "\n", attributes: self.titleAttributes))
                        attributedString.append(NSAttributedString(string: item.content.localized, attributes: self.textAttributes))
                    }
                }
                
                if let source = contentItem.source, !source.isEmpty {
                    if !attributedString.string.isEmpty {
                        attributedString.append(NSAttributedString(string: "\n\n", attributes: self.textAttributes))
                    }
                    let sourceString = String(format: "source_format".localized, source.localized)
                    attributedString.append(NSAttributedString(string: sourceString, attributes: self.sourceAttributes))
                }
                
                contentItem.boldStrings?.forEach({ boldString in
                    let range = (attributedString.string as NSString).range(of: boldString.localized)
                    if (range.location != NSNotFound) {
                        attributedString.setAttributes(self.boldTextAttributes, range: range)
                    }
                })
                
                contentTextView.attributedText = attributedString
                contentTextView.linkTextAttributes = linkAttributes
                contentTextView.delegate = self
                cell.viewWithTag(CellTags.contentContainer.rawValue)?.isHidden = attributedString.string.count == 0
            }
            let imageViewContainer = cell.contentView.viewWithTag(CellTags.imageViewContainer.rawValue)
            imageViewContainer?.isHidden = contentItem.imageIcon.isEmpty
            
            return cell
        }
        
        if indexPath.section == 2 {
            guard let contentItem = self.contentItem, let selectableItems = contentItem.selectableItems else {
                return UITableViewCell()
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: self.OptionsCellIdentifier, for: indexPath)
            let index = indexPath.row * 2
            
            if let option1View = cell.contentView.viewWithTag(OptionCellTags.option1View.rawValue) {
                self.configView(view: option1View, contentItem: selectableItems[index], index: index)
            }
            
            if let option2View = cell.contentView.viewWithTag(OptionCellTags.option2View.rawValue) {
                if index + 1 < selectableItems.count {
                    self.configView(view: option2View, contentItem: selectableItems[index + 1], index: index + 1)
                    option2View.isHidden = false
                } else {
                    option2View.isHidden = true
                }
            }
            
            return cell
        }
        
        if indexPath.section == 3 {
            guard let contentItem = self.contentItem, let selectableRowItems = contentItem.selectableRowItems, let cell = tableView.dequeueReusableCell(withIdentifier: self.SelectableRowCellIdentifier, for: indexPath) as? EUKSelectableTableViewCell else {
                return UITableViewCell()
            }
            
            let selectableRowItem = selectableRowItems[indexPath.row]
            cell.titleLabel.text = selectableRowItem.id.localized
            return cell
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func configView(view: UIView, contentItem: ContentItem?, index: Int) {
        view.viewWithTag(OptionCellTags.optionContainer.rawValue)?.isHidden = contentItem == nil
        view.viewWithTag(OptionCellTags.topLine.rawValue)?.isHidden = index / 2 > 0
        view.viewWithTag(OptionCellTags.rightLine.rawValue)?.isHidden = false
        view.viewWithTag(OptionCellTags.bottomLine.rawValue)?.isHidden = false
        
        guard let contentItem = contentItem else {
            return
        }
        if let titleLabel = view.viewWithTag(OptionCellTags.title.rawValue) as? UILabel {
            titleLabel.text = contentItem.title?.localized ?? contentItem.id.localized
        }
        if let imageView = view.viewWithTag(OptionCellTags.imageView.rawValue) as? UIImageView {
            if contentItem.imageIcon.isEmpty {
                imageView.image = #imageLiteral(resourceName: "IconAbortion")
            } else {
                imageView.image = UIImage(named: contentItem.imageIcon)
            }
        }
        if let button = view.viewWithTag(OptionCellTags.selectButton.rawValue) as? UIButton {
            button.superview?.tag = index
            button.addTarget(self, action: #selector(EUKCommonContentViewController.showItem(_:)), for: .touchUpInside)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
        
        if indexPath.section == 3 {
            cell.contentView.addBorders(edges: .top, color: indexPath.row == 0 ? UIColor.eukiMain : UIColor.white, thickness: 1.0)
            cell.contentView.addBorders(edges: .bottom, color: UIColor.eukiMain, thickness: 1.0)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        if indexPath.section == 2 {
            return
        }
        if indexPath.section == 3 {
            tableView.deselectRow(at: indexPath, animated: true)
            if let contentItem = self.contentItem, let selectableRowItems = contentItem.selectableRowItems {
                let selectableRowItem = selectableRowItems[indexPath.row]
                self.showContentItem(item: selectableRowItem)
                
            }
            return
        }
        super.tableView(tableView, didSelectRowAt: indexPath)
    }
}
