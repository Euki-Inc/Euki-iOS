//
//  EUKTopLevelViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 3/25/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKCommonTopLevelViewController: EUKBasePinCheckViewController {
    static let IdViewController = "TopLevelViewController"
    let TopLevelCellIdentifier = "TopLevelCellIdentifier"
    let CellSeparation: CGFloat = 8
    
    enum CellTags: Int{
        case button = 100,
        title
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var contentItem: ContentItem?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createContent()
        self.setUIElements()
        
        self.collectionView.register(UINib(nibName: "EUKTileCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: TopLevelCellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.reloadData()
    }
    
    //MARK: - Private
    
    func createContent() {
    }
    
    func setUIElements() {
        guard let contentItem = self.contentItem else {
            return
        }
        
        self.title = (contentItem.title ?? contentItem.id).localized
        self.titleLabel.text = self.title
    }
    
    //MARK: - Public
    
    class func initViewController(anyClass: AnyClass?) -> EUKCommonTopLevelViewController?{
        if let commonTopLevelViewController = UIStoryboard(name: "Common", bundle: Bundle.main).instantiateViewController(withIdentifier: EUKCommonTopLevelViewController.IdViewController) as? EUKCommonTopLevelViewController{
            if let anyClass = anyClass {
                object_setClass(commonTopLevelViewController, anyClass)
            }
            return commonTopLevelViewController
        }
        return nil
    }
}

extension EUKCommonTopLevelViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contentItem?.selectableItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.TopLevelCellIdentifier, for: indexPath) as? EUKTileCollectionViewCell, let contentItems = self.contentItem?.selectableItems else {
            return UICollectionViewCell()
        }
        
        let item = contentItems[indexPath.row]
        
        cell.imageView.image = UIImage(named: item.imageIcon)
        cell.titleLabel.text = item.id.localized
        cell.actionButton.isHidden = true
        
        for constraint in cell.marginsConstraints {
            if let identifier = constraint.identifier, let identifierInt = Int(identifier) {
                var constant: CGFloat = 0
                switch identifierInt {
                case 1:
                    constant = 3
                case 2:
                    constant = 6
                case 3:
                    constant = 3
                case 4:
                    constant = 6
                default:
                    break
                }
                constraint.constant = constant
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (self.contentItem?.selectableItems?.count ?? 0) == 1 {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }

        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let contentItems = self.contentItem?.selectableItems else {
            return
        }
        
        let item = contentItems[indexPath.row]
        self.showContentItem(item: item)
    }
}
