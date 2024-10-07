//
//  EUKDaySummaryViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/1/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class EUKDaySummaryViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!
	
	var daysViewController: EUKCycleDaysViewController?
	
	var cycleDayItem: CycleDayItem?
	var items = [SelectItem]()
	var isInitialLoad = true
	var centerMargin = 0.0
	
	//MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setUIElements()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if self.isInitialLoad {
			self.isInitialLoad = false
		} else {
			self.daysViewController?.refreshData()
		}
	}
	
	//MARK: - IBActions
	
	@IBAction func trackAction() {
		if let viewController = EUKTrackViewController.initViewController(date: self.cycleDayItem?.date, calendarItem: self.cycleDayItem?.calendarItem) {
			self.present(viewController, animated: true, completion: nil)
		}
	}
	
	//MARK: - Private
	
	private func setUIElements() {
		let itemWidth = 88.0
		let calculatedMargin = (UIScreen.main.bounds.width - itemWidth * 3) / 4
		let currentMargin = (UIScreen.main.bounds.width / 3 - itemWidth) / 2

		if calculatedMargin > currentMargin {
			self.centerMargin = (calculatedMargin - currentMargin) / 2
		} else {
			self.centerMargin = 0
		}
		
		let headers = [EUKCycleTitleCollectionReusableView.CellIdentifier]
		headers.forEach { identifier in
			self.collectionView.register(UINib(nibName: identifier, bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: identifier)
		}
		
		let cells = [EUKCycleDaysCollectionViewCell.CellIdentifier, EUKCycleItemCollectionViewCell.CellIdentifier, EUKCycleEmptyCollectionViewCell.CellIdentifier]
		cells.forEach { identifier in
			self.collectionView.register(UINib(nibName: identifier, bundle: Bundle.main), forCellWithReuseIdentifier: identifier)
		}
		
		if let viewController = EUKCycleDaysViewController.initViewController() as? EUKCycleDaysViewController {
			viewController.delegate = self
			self.daysViewController = viewController
		}
	}
	
	//MARK: - Public
	
	class func initViewController() -> UIViewController? {
		return UIStoryboard(name: "Cycle", bundle: nil).instantiateViewController(withIdentifier: "EUKDaySummaryViewController")
	}
}

extension EUKDaySummaryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		if (self.daysViewController?.items.count ?? 0) == 0 {
			return 1
		}
		
		return 2
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		}
		
		return max(self.items.count, 1)
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionElementKindSectionHeader {
			if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: EUKCycleTitleCollectionReusableView.CellIdentifier, for: indexPath) as? EUKCycleTitleCollectionReusableView {
				let emptyString = (self.cycleDayItem?.isToday() ?? true) ? "day_summary_empty_today_title" : "day_summary_empty_past_title"
				headerView.titleLabel.text = (self.items.isEmpty ? emptyString.localized : "day_summary_data_title").localized
				headerView.titleLabel.isHidden = indexPath.section == 0
				return headerView
			}
		}
		
		return UICollectionReusableView()
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if indexPath.section == 0 {
			return self.setupCycleDaysCell(collectionView, cellForItemAt: indexPath)
		}
		
		if self.items.isEmpty {
			return self.setupEmptyCell(collectionView, cellForItemAt: indexPath)
		}
		
		return self.setupItemCell(collectionView, cellForItemAt: indexPath)
	}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 && !self.items.isEmpty {
            let selectItem = self.items[indexPath.row]
            if let filterItems = EUKDailyLogViewController.createCollectionItems(calendarItem: self.cycleDayItem?.calendarItem), let filterItem = filterItems.first(where: {
                if let selectItems = $0.1 as? [SelectItem], let foundSelectItem = selectItems.first(where: {$0.title == selectItem.title}){
                    return true
                }
                
                return false
            }) {
                if let viewController = EUKTrackViewController.initViewController(date: self.cycleDayItem?.date, calendarItem: self.cycleDayItem?.calendarItem, expandFilterItem: filterItem.0, expandSelectItem: selectItem) {
                    self.present(viewController, animated: true, completion: nil)
                }
            }
        }
    }
	
	func setupCycleDaysCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EUKCycleDaysCollectionViewCell.CellIdentifier, for: indexPath) as? EUKCycleDaysCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		if let daysViewController = self.daysViewController {
			self.configureChildViewController(childController: daysViewController, onView: cell.viewContainer)
		}
		
		return cell
	}
	
	func setupItemCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let item = self.items[indexPath.row]
		
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EUKCycleItemCollectionViewCell.CellIdentifier, for: indexPath) as? EUKCycleItemCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		cell.selectButton.isUserInteractionEnabled = false
		cell.selectButton.titleLabel.text = item.title.localized
		cell.selectButton.titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
		cell.selectButton.image = UIImage(named: item.imageName)
		cell.selectButton.countLabel.text = "\(item.count)"
		cell.selectButton.countContainerView.isHidden = item.count == 0

		switch indexPath.row % 3 {
		case 0:
			cell.centerConstraint.constant = self.centerMargin
		case 1:
			cell.centerConstraint.constant = 0
		case 2:
			cell.centerConstraint.constant = -self.centerMargin
		default:
			break
		}
		
		return cell
	}
	
	func setupEmptyCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EUKCycleEmptyCollectionViewCell.CellIdentifier, for: indexPath) as? EUKCycleEmptyCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		let isToday = self.cycleDayItem?.isToday() ?? true
		let imageName = isToday ? "IconNoEntriesToday" : "IconNoEntriesPast"
		
		cell.trackButton.addTarget(self, action: #selector(EUKDaySummaryViewController.trackAction), for: .touchUpInside)
		cell.imageView.image = UIImage(named: imageName)
		
		if UIScreen.main.bounds.height < 700 {
			cell.spacingHeight.constant = 20
		}
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		if section == 0 {
			return CGSizeZero
		}
		
		let height = self.items.isEmpty ? 25.0 : 40.0
		
		return CGSize(width: collectionView.bounds.width, height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if indexPath.section == 0 {
			return CGSizeMake(collectionView.bounds.width, 280.0)
		}
		
		if self.items.isEmpty {
			return CGSizeMake(collectionView.bounds.width, 210.0)
		}
		
		return CGSizeMake(collectionView.bounds.width / 3, 150.0)
	}
}

extension EUKDaySummaryViewController: EUKCycleDaysDelegate {
	func itemChanged(_ item: CycleDayItem) {
		self.cycleDayItem = item
		
		self.items.removeAll()
		if let calendarItem = item.calendarItem {
			self.items = CycleManager.sharedInstance.convert(calendarItem: calendarItem)
		}
		
		self.collectionView.reloadData()
	}
}
