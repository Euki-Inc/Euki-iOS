//
//  EUKCommonHomeViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 3/18/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import AudioToolbox

class EUKCommonTilesViewController: EUKBasePinCheckViewController {
    static let IdViewController = "CommonTilesViewController"
    let TileCellIdentifier = "TileCellIdentifier"
    let HeaderViewIdentifier = "HeaderViewIdentifier"
    let FooterViewIdentifier = "FooterViewIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items = [ContentItem]()
    var isEditingTiles = false
    var usedItems = [ContentItem]()
    var notUsedItems = [ContentItem]()
    var locationTouched = CGPoint(x: 0, y: 0)
    var bottomButton: UIButton?
    var alertReminderItem: ReminderItem?
    var alertAppointment: Appointment?
    
    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.mustShowBookmarkButton = false
        super.viewDidLoad()
        self.createItems()
        self.collectionView.register(UINib(nibName: "EUKTileCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: TileCellIdentifier)
        self.collectionView.register(UINib(nibName: "EUKTileFooterCollectionReusableView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: self.FooterViewIdentifier)
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
        self.showItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.reloadData()
    }
    
    //MARK: - IBActions
    
    @IBAction func changeItemUsed(_ button: UIButton) {
        let item = self.items[button.tag]
        if let index = self.usedItems.index(of: item) {
            let sourceIndexPath = IndexPath(row: index, section: 0)
            let destinationIndexPath = IndexPath(row: self.usedItems.count - 1, section: 0)
            
            self.usedItems.remove(at: index)
            self.notUsedItems.insert(item, at: 0)
            self.updateItems()
            
            self.collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
        } else if let index = self.notUsedItems.index(of: item) {
            let sourceIndexPath = IndexPath(row: index + self.usedItems.count, section: 0)
            let destinationIndexPath = IndexPath(row: self.usedItems.count, section: 0)
            
            self.notUsedItems.remove(at: index)
            self.usedItems.append(item)
            self.updateItems()
            
            self.collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.collectionView.reloadData()
        })
    }
    
    @IBAction func changeEditing(_ button: UIButton?) {
        self.isEditingTiles = !self.isEditingTiles
        let title = (self.isEditingTiles ? "done" : "edit").localized.uppercased()
        self.bottomButton?.setTitle(title, for: .normal)
        self.updateItems()
        self.collectionView.reloadData()
    }
	
	@IBAction func favoriteAction() {
		if let bookmarkViewController = EUKBookmarksViewController.initViewController() {
			self.navigationController?.pushViewController(bookmarkViewController, animated: true)
		}
	}
    
    //MARK: - Private
    
    func createItems() {
    }
    
    func showItems() {
        self.updateItems()
        self.collectionView.reloadData()
    }
    
    func updateItems() {
        self.items.removeAll()
        self.items.append(contentsOf: self.usedItems)
        
        if self.isEditingTiles {
            self.items.append(contentsOf: self.notUsedItems)
        }
        
        self.saveItems()
    }
    
    func editContentItem(item: ContentItem) {
        let alertController = UIAlertController(title: "change_name".localized, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok".localized, style: .default) { [unowned self] (_) in
            if let textFields = alertController.textFields, textFields.count > 0 {
                let title = textFields[0].text
                
                if let title = title, !title.isEmpty {
                    item.title = title
                } else {
                    item.title = nil
                }
                
                self.itemChanged(item: item, title: title)
                self.collectionView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "cancel".localized, style: .destructive, handler: nil)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "name".localized
            textField.text = item.title?.localized ?? item.id.localized
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func itemChanged(item: ContentItem, title: String?) {
    }
    
    func saveItems() {
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        if !self.isEditingTiles {
            self.changeEditing(nil)
        }
        
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
				self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
			}
        case .changed:
            self.locationTouched = gesture.location(in: gesture.view!)
            self.collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            if let indexPath = self.collectionView.indexPathForItem(at: self.locationTouched) {
                if indexPath.row < self.usedItems.count {
                    self.collectionView.endInteractiveMovement()
                } else {
                    self.collectionView.cancelInteractiveMovement()
                }
            } else {
                self.collectionView.cancelInteractiveMovement()
            }
        default:
            self.collectionView.cancelInteractiveMovement()
        }
    }
    
    //MARK: - Public
    
    class func initViewController(anyClass: AnyClass?) -> EUKCommonTilesViewController?{
        if let commonTilesViewController = UIStoryboard(name: "Common", bundle: Bundle.main).instantiateViewController(withIdentifier: EUKCommonTilesViewController.IdViewController) as? EUKCommonTilesViewController{
            if let anyClass = anyClass {
                object_setClass(commonTilesViewController, anyClass)
            }
            return commonTilesViewController
        }
        return nil
    }
}

extension EUKCommonTilesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.TileCellIdentifier, for: indexPath) as? EUKTileCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = self.items[indexPath.row]
        
        cell.imageView.image = UIImage(named: item.imageIcon)
        cell.titleLabel.text = item.title?.localized ?? item.id.localized
        
        if let font = self.isEditingTiles || item.id == "stis" ? UIFont.eukTileSmallFont() : UIFont.eukTileLargeFont() {
            cell.titleLabel.font = font
        }
        
        cell.actionButton.isHidden = !self.isEditingTiles
        
        if self.usedItems.contains(item) {
            cell.actionButton.setImage(UIImage(named: "BtnTileRemove"), for: .normal)
        } else {
            cell.actionButton.setImage(UIImage(named: "BtnTileAdd"), for: .normal)
        }
        cell.actionButton.tag = indexPath.row
        cell.actionButton.addTarget(self, action: #selector(EUKCommonTilesViewController.changeItemUsed(_:)), for: .touchUpInside)
        
        for constraint in cell.marginsConstraints {
            if let identifier = constraint.identifier, let identifierInt = Int(identifier) {
                var constant: CGFloat = 0
                switch identifierInt {
                case 1:
                    constant = self.items.count < 4 ? 3 : 6
                case 2:
                    constant = self.items.count < 4 ? 6 : (indexPath.row % 2 == 0 ? 6 : 14)
                case 3:
                    constant = self.items.count < 4 ? 3 : 6
                case 4:
                    constant = self.items.count < 4 ? 6 : (indexPath.row % 2 == 0 ? 14 : 6)
                default:
                    break
                }
                constraint.constant = constant * (self.isEditingTiles ? 1.2 : 1.0)
            }
        }
        
        if self.isEditingTiles {
            cell.mainView.startQuivering()
        } else {
            cell.mainView.stopQuivering()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.items.count <= 3 {
            return CGSize(width: collectionView.bounds.width, height: 200.0)
        }
        
        let factor: CGFloat = 199.0 / 168.0
        let width = collectionView.bounds.width / 2
        return CGSize(width: Int(width), height: Int(CGFloat(width) * factor))
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter {
            if let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: self.FooterViewIdentifier, for: indexPath) as? EUKTileFooterCollectionReusableView {
                let title = (self.isEditingTiles ? "done" : "edit_tiles").localized.uppercased()
                footerView.actionButton.setTitle(title, for: .normal)
                bottomButton = footerView.actionButton
                footerView.actionButton.addTarget(self, action: #selector(EUKCommonTilesViewController.changeEditing(_:)), for: .touchUpInside)
				footerView.bookmarkButton.addTarget(self, action: #selector(EUKCommonTilesViewController.favoriteAction), for: .touchUpInside)
                return footerView
            }
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		return CGSize(width: collectionView.bounds.size.width, height: 170.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if !self.isEditingTiles {
            return false
        }
        
        return indexPath.row < self.usedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if destinationIndexPath.row < self.usedItems.count {
            let sourceItem = self.usedItems[sourceIndexPath.row]
            self.usedItems.remove(at: sourceIndexPath.row)
            self.usedItems.insert(sourceItem, at: destinationIndexPath.row)
            self.updateItems()
        } else {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let item = self.items[indexPath.row]
        
        if self.isEditingTiles {
            self.editContentItem(item: item)
        } else {
            self.showContentItem(item: item)
        }
    }
}
