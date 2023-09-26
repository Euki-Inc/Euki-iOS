//
//  EUKCycleDaysViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/11/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

protocol EUKCycleDaysDelegate {
	func itemChanged(_ item: CycleDayItem)
}

class EUKCycleDaysViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var leftButton: UIButton!
	@IBOutlet weak var rightButton: UIButton!
	
	var delegate: EUKCycleDaysDelegate?
	var items = [CycleDayItem]()
	
	var isInitialLoad = true
	var currentIndex = 0
	
	fileprivate var pageSize: CGSize {
		let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
		var pageSize = layout.itemSize
		if layout.scrollDirection == .horizontal {
			pageSize.width += layout.minimumLineSpacing
		} else {
			pageSize.height += layout.minimumLineSpacing
		}
		return pageSize
	}

	//MARK: - Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.setUIElements()
		self.requestData()
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.collectionView.reloadData()
	}
    
	//MARK: - IBActions
	
	@IBAction func leftAction() {
		let newIndex = self.currentIndex - 1
		self.changeIndex(newIndex)
		self.scrollToIndex(newIndex, animated: true)
	}
	
	@IBAction func rightAction() {
		let newIndex = self.currentIndex + 1
		self.changeIndex(newIndex)
		self.scrollToIndex(newIndex, animated: true)
	}
	
	//MARK: - Private
	
	private func setUIElements() {
		self.collectionView.register(UINib(nibName: "EUKCycleDayCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: EUKCycleDayCollectionViewCell.CellIdentifier)
		
		let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
		layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 60)
	}
	
	private func requestData() {
		CycleManager.sharedInstance.requestCycleItems { items in
			self.items.removeAll()
			self.items.append(contentsOf: items)
			self.collectionView.reloadData()
		}
	}
	
	private func changeIndex(_ index: Int) {
		self.currentIndex = index
		
		self.leftButton.isHidden = index == 0
		self.rightButton.isHidden = index == self.items.count - 1
		
		let item = self.items[index]
		self.delegate?.itemChanged(item)
	}
	
	private func scrollToIndex(_ index: Int, animated: Bool = false) {
		let indexPath = IndexPath(row: index, section: 0)
		self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: animated)
	}
	
	//MARK: - Public
	
	func refreshData() {
		CycleManager.sharedInstance.requestCycleItems { items in
			self.items.removeAll()
			self.items.append(contentsOf: items)
			self.collectionView.reloadData()
			
			let item = self.items[self.currentIndex]
			self.delegate?.itemChanged(item)
		}
	}

	class func initViewController() -> UIViewController? {
		UIStoryboard(name: "Cycle", bundle: nil).instantiateViewController(withIdentifier: "EUKCycleDaysViewController")
	}
}

extension EUKCycleDaysViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EUKCycleDayCollectionViewCell.CellIdentifier, for: indexPath) as? EUKCycleDayCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		let item = self.items[indexPath.row]
		cell.setup(date: item.date, isBleeding: item.calendarItem?.hasPeriod() ?? false, dayCycle: item.dayCycle, dateNextCycle: item.dateNextCycle)
		cell.dataView.isHidden = indexPath.row != self.currentIndex
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if self.isInitialLoad {
			self.isInitialLoad = false
			self.scrollToIndex(self.items.count - 1)
			self.changeIndex(self.items.count - 1)
		}
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
		let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
		let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
		
		let currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
		self.changeIndex(currentPage)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		for cell in self.collectionView.visibleCells {
			if let cell = cell as? EUKCycleDayCollectionViewCell {
				cell.dataView.isHidden = cell.alpha < 0.7
			}
		}
	}
}
