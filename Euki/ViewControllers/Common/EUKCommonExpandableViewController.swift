//
//  EUKCommonExpandableViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 3/30/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKCommonExpandableViewController: EUKBasePinCheckViewController {
    let ExpandableCellIdentifier = "ExpandableCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var frontImageView: UIImageView!
    
    var navTitle: String?
    var prefix: String?
    var count: Int = 0
    var expandableSection = 0
    var items = [ExpandableItem]()
    var cellHeightsDictionary:[IndexPath: CGFloat] = [:]
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        self.initItems()
    }
    
    //MARK: - IBActions
    
    @IBAction func bookmarkAction(_ sender: UIButton) {
        let item = self.items[sender.tag]
        let contentItem = ContentItem(id: item.id, title: item.title, content: item.text)
        
        if let normalImage = sender.image(for: .normal), normalImage == UIImage(named: "BtnBookmarkOn"){
            BookmarksManager.sharedInstance.removeBookmark(contentItemId: item.id)
        } else {
            BookmarksManager.sharedInstance.addBookmark(contentItemId: contentItem.id)
        }
        
        let imageName = BookmarksManager.sharedInstance.isBookmark(contentItemId: item.id) ? "BtnBookmarkOn" : "BtnBookmarkOff"
        sender.setImage(UIImage(named: imageName), for: .normal)
    }
    
    //MARK: - Private
    
    func setUIElements(){
        self.tableView.estimatedRowHeight = 50.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.title = self.navTitle
        self.navigationItem.title = self.navTitle
    }
    
    func updateCells(row: Int){
        self.frontImageView.isHidden = true
        
        var index = 0
        var indexPathArray: [IndexPath] = []
        indexPathArray.append(IndexPath(row: row, section: self.expandableSection))
        for item in self.items{
            if row == index{
                self.items[row].isExpanded = !self.items[row].isExpanded
            } else{
                if item.isExpanded{
                    item.isExpanded = false
                    indexPathArray.append(IndexPath(row: index, section: self.expandableSection))
                }
            }
            index = index + 1
        }
        self.tableView.reloadRows(at: indexPathArray, with: .fade)
        self.tableView.scrollToRow(at: IndexPath(row: row, section: self.expandableSection), at: .top, animated: true)
    }
    
    func initItems(){
    }
}

extension EUKCommonExpandableViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.ExpandableCellIdentifier, for: indexPath) as? ExpandableTableViewCell{
            
            cell.titleLabel.text = item.title
            cell.contentTextView.setLinkText(string: item.text, links: item.contentItem.links, uniqueLinks: item.contentItem.uniqueLinks, boldStrings: item.contentItem.boldStrings)
            cell.contentTextView.isHidden = !item.isExpanded
            cell.contentTextView.delegate = self
            cell.bottomSeparatorView.isHidden = indexPath.row < self.items.count - 1
            
            let imageName = BookmarksManager.sharedInstance.isBookmark(contentItemId: item.id) ? "BtnBookmarkOn" : "BtnBookmarkOff"
            cell.bookmarkButton.setImage(UIImage(named: imageName), for: .normal)
            cell.bookmarkButton.addTarget(self, action: #selector(EUKCommonExpandableViewController.bookmarkAction(_:)), for: .touchUpInside)
            cell.bookmarkButton.isHidden = !item.isExpanded
            cell.bookmarkButton.tag = indexPath.row
            cell.arrowImageView.isHidden = item.isExpanded
           
            self.configurePagerView(cell: cell, item: item)

            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.cellHeightsDictionary[indexPath] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.cellHeightsDictionary[indexPath]
        if let height = height {
            return height
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.updateCells(row: indexPath.row)
    }

    func configurePagerView(cell:ExpandableTableViewCell,item: ExpandableItem ) {
        
        cell.swipeView.isHidden = !item.isExpanded

        for view in cell.swipeView.subviews {
            view.removeFromSuperview()
        }

        let items = item.contentItem.swipePagerItems
        let viewController = EUKPagerViewController.initViewController() as? EUKPagerViewController
        let containerView = cell.swipeView
        
        guard let items, let viewController, let containerView else {
            cell.heightConstraint.constant = 0
            return
        }

        if !items.isEmpty && item.isExpanded  {
            viewController.swipePagerItems = item.contentItem.swipePagerItems ?? []
            cell.heightConstraint.constant = getFormattedSize(645)
            self.configureChildViewController(childController: viewController, onView: containerView)

        } else {
            cell.heightConstraint.constant = 0
        }
    }
}
