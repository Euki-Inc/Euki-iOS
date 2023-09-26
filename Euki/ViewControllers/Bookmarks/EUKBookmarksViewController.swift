//
//  EUKBookmarksViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 5/8/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKBookmarksViewController: EUKBasePinCheckViewController {
    let CellIdentifier = "BookmarkCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    enum CellTags: Int {
        case title = 100,
        description
    }
    
    var bookmarks = [Bookmark]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.mustShowBookmarkButton = false
        super.viewDidLoad()
        self.emptyView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestBookmarks()
    }
    
    //MARK: - Private
    
    func requestBookmarks() {
        BookmarksManager.sharedInstance.requestBookmarks { [unowned self] (bookmarks) in
            self.bookmarks.removeAll()
            self.bookmarks.append(contentsOf: bookmarks)
            self.tableView.reloadData()
        }
    }
    
    func showContentView(bookmark: Bookmark) {
        let contentItem = bookmark.contentItem
        var contentItemToShow = contentItem
        var expandedContentItem: ContentItem?
        if contentItem.isExpandableChild && contentItem.parent != nil {
            contentItemToShow = contentItem.parent!
            expandedContentItem = contentItem
        }
        
        self.viewController(item: contentItemToShow) { [unowned self] (viewController) in
            if let viewController = viewController {
                if let contentViewController = viewController as? EUKCommonContentViewController {
                    contentViewController.expandContentItem = expandedContentItem
                }
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    //MARK: - Public
    
    class func initViewController() -> EUKBookmarksViewController? {
        if let viewController = UIStoryboard(name: "Bookmarks", bundle: Bundle.main).instantiateInitialViewController() as? EUKBookmarksViewController {
            return viewController
        }
        
        return nil
    }
}

extension EUKBookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
		self.emptyView.isHidden = bookmarks.count > 0
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.CellIdentifier, for: indexPath) as? MGSwipeTableCell else{
            return UITableViewCell()
        }
        
        let bookmark = self.bookmarks[indexPath.row]
        
        if let titleLabel = cell.viewWithTag(CellTags.title.rawValue) as? UILabel {
            titleLabel.text = bookmark.title.localized
            titleLabel.numberOfLines = 2
        }
        if let contentLabel = cell.viewWithTag(CellTags.description.rawValue) as? UILabel {
            contentLabel.text = bookmark.content.localized
            contentLabel.isHidden = bookmark.content.isEmpty
            contentLabel.numberOfLines = 3
        }
        
        let deleteButton = MGSwipeButton(title: "delete".localized.uppercased(), backgroundColor: UIColor.eukPurpleClear, padding: 30) { [unowned self] (_) -> Bool in
            BookmarksManager.sharedInstance.removeBookmark(contentItemId: bookmark.id)
            self.bookmarks.remove(at: indexPath.row)
            self.tableView.reloadData()
            return true
        }
        
        deleteButton.setTitleColor(UIColor.eukiAccent, for: .normal)
        deleteButton.addBorders(edges: [.right, .left], color: UIColor.eukiMain, thickness: 0.5)
        cell.rightButtons = [deleteButton]
        
        cell.addBorders(edges: [.top], color: UIColor.eukiMain, thickness: 0.5)
        cell.addBorders(edges: [.bottom], color: indexPath.row == self.bookmarks.count - 1 ? UIColor.eukiMain : UIColor.white, thickness: 0.5)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let bookmark = self.bookmarks[indexPath.row]
        self.showContentView(bookmark: bookmark)
    }
}
