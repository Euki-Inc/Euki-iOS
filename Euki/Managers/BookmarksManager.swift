//
//  BookmarksManager.swift
//  Euki
//
//  Created by Víctor Chávez on 5/8/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class BookmarksManager: NSObject {
    static let sharedInstance = BookmarksManager()
    var bookmarkIds = [String]()
    
    func loadBookmarks() {
        self.bookmarkIds = LocalDataManager.sharedInstance.bookmarks()
    }
    
    func isBookmark(contentItemId: String) -> Bool {
        return self.bookmarkIds.contains(contentItemId)
    }
    
    func requestBookmarks(responseHandler: @escaping ([Bookmark]) -> Void) {
        var bookmarks = [Bookmark]()
        
        for bookmarkId in self.bookmarkIds {
            if let contentItem = ContentManager.sharedInstance.requestContentItem(id: bookmarkId) {
                let title = contentItem.title ?? contentItem.id
                let bookmark = Bookmark(id: contentItem.id, title: title, content: contentItem.content, contentItem: contentItem)
                bookmarks.append(bookmark)
            }
        }
        
        responseHandler(bookmarks)
    }
    
    func addBookmark(contentItemId: String) {
        bookmarkIds.append(contentItemId)
        LocalDataManager.sharedInstance.saveBookmarks(bookmarks: bookmarkIds)
    }
    
    func removeBookmark(contentItemId: String) {
        if let index = self.bookmarkIds.index(of: contentItemId) {
            self.bookmarkIds.remove(at: index)
			LocalDataManager.sharedInstance.saveBookmarks(bookmarks: self.bookmarkIds)
        }
    }
    
    func removeAllBookmarks() {
        self.bookmarkIds.removeAll()
		LocalDataManager.sharedInstance.saveBookmarks(bookmarks: self.bookmarkIds)
    }
}
