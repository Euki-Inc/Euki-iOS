//
//  EUKWeekCalendarViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 7/2/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

protocol EUKWeekCalendarViewControllerDelegate: NSObject {
	func selectedDate(date: Date, calendarItem: CalendarItem?, calendarFilter: CalendarFilter)
}

class EUKWeekCalendarViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: EUKWeekCalendarViewControllerDelegate?
    var calendarItems = [String: CalendarItem]()
    var dayItems = [DayItem]()
    var todayItem: DayItem?
    
    var startDate: Date?
    var startItem: DayItem?
	
	var selectedDate: Date?
	
	var calendarFilter = CalendarFilter()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		self.initCalendarFilter()
        self.setUIElements()
        self.requestCalendarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.updateUIElements()
		self.collectionView.reloadData()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.collectionView.reloadData()
	}
    
    //MARK: - IBActions
    
    @IBAction func daySelected(button: UIButton) {
        let dayItem = self.dayItems[button.tag]
        let date = dayItem.date
		
		if date.isFuture() {
			return
		}
        
        var calendarItem: CalendarItem?
        if let dateString = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.DateLongFormat), let foundCalendarItem = self.calendarItems[dateString] {
            calendarItem = foundCalendarItem
        }
		
		self.selectedDate = date
		self.collectionView.reloadData()
        
		self.delegate?.selectedDate(date: date, calendarItem: calendarItem, calendarFilter: self.calendarFilter)
    }
    
    
    //MARK: - Private
    
    private func setUIElements() {
        self.collectionView.register(UINib(nibName: "EUKDayCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: EUKDayCollectionViewCell.CellIdentifier)
        
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = self.itemSize()
        layout.minimumLineSpacing = .zero
        layout.numberOfItemsPerPage = 7
        
        self.collectionView.collectionViewLayout = layout
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    private func updateUIElements() {
        (self.collectionView.collectionViewLayout as? PagingCollectionViewLayout)?.itemSize = self.itemSize()
    }
	
	private func initCalendarFilter() {
		let items = LocalDataManager.sharedInstance.filterItems()
		self.refreshFilterItems(usedItems: items.0, notUsedItems: items.1)
	}
    
    private func initDayItems() {
        var dayItems = [DayItem]()
		let endDay = Calendar.current.date(bySetting: Calendar.Component.weekday, value: 7, of: Date()) ?? Date()
        
        for year in 2012 ... 2030 {
            for month in 1 ... 12 {
                let numDays = Date.numDaysMonths(year: year, month: month)
                for day in 1 ... numDays {
                    let item = DayItem(index: dayItems.count, year: year, month: month, day: day)
					
					if item.date.daysDiff(date: endDay) < 0 {
						break
					}
					
                    dayItems.append(item)
                    
                    if Calendar.current.isDateInToday(item.date) {
                        self.todayItem = item
                    }
                    
					if let startDate = self.startDate, Calendar.current.isDate(startDate, inSameDayAs: item.date) {
                        self.startItem = item
                    }
                }
            }
        }
        
        self.dayItems = dayItems
    }
    
    private func requestCalendarItems() {
        self.initDayItems()
        self.collectionView.reloadData()
        
        CalendarManager.sharedInstance.requestItems { [unowned self] (items) in
            self.calendarItems = items
            self.collectionView.reloadData()
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
				self.showDateItem()
			}
        }
    }
    
    private func showDateItem() {
        if let todayItem = self.startItem ?? self.todayItem {
            self.scrollToPosition(index: todayItem.index - todayItem.dayOfWeek + 1)
        }
    }
    
    private func scrollToPosition(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        if let attributes = self.collectionView.layoutAttributesForItem(at: indexPath) {
            let topCell = CGPoint(x: attributes.frame.origin.x - self.collectionView.contentInset.left, y: 0)
            self.collectionView.setContentOffset(topCell, animated: false)
        }
    }
    
    private func itemSize() -> CGSize {
        let width = self.collectionView.bounds.width / 7
        let height = self.collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    //MARK: - Public
    
    func refreshData() {
        CalendarManager.sharedInstance.requestItems { [unowned self] (items) in
            self.calendarItems = items
            self.collectionView.reloadData()
        }
    }
	
	func refreshFilterItems(usedItems: [FilterItem], notUsedItems: [FilterItem]) {
		LocalDataManager.sharedInstance.saveFilterItems(usedItems: usedItems, notUsedItems: notUsedItems)
		
		let filter = CalendarFilter()
		
		var allItems = [FilterItem]()
		allItems.append(contentsOf: usedItems)
		allItems.append(contentsOf: notUsedItems)
		
		allItems.forEach { item in
			if item.title == "bleeding" {
				filter.bleedingOn = item.isOn
			} else if item.title == "emotions" {
				filter.emotionsOn = item.isOn
			} else if item.title == "body" {
				filter.bodyOn = item.isOn
			} else if item.title == "sexual_activity" {
				filter.sexualActivityOn = item.isOn
			} else if item.title == "contraception" {
				filter.contraceptionOn = item.isOn
			} else if item.title == "test" {
				filter.testOn = item.isOn
			} else if item.title == "appointment" {
				filter.appointmentOn = item.isOn
			} else if item.title == "note" {
				filter.noteOn = item.isOn
			}
		}
		
		self.calendarFilter = filter
		self.collectionView.reloadData()
	}
}

class DayItem: NSObject {
    var index: Int
    var year: Int
    var month: Int
    var day: Int
    var date: Date
    var dayOfWeek: Int
    var dayName: String
    
    override init() {
        self.index = -1
        self.year = 0
        self.month = 0
        self.day = 0
        self.date = Date()
        self.dayOfWeek = 0
        self.dayName = ""
    }
    
    convenience init(index: Int, year: Int, month: Int, day: Int) {
        self.init()
        self.index = index
        self.year = year
        self.month = month
        self.day = day
        
        let date = Date.date(year: year, month: month, day: day)
        self.date = date
        self.dayOfWeek = Calendar.current.component(Calendar.Component.weekday, from: date)
		self.dayName = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.eee)?.capitalized ?? ""
    }
}

extension EUKWeekCalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dayItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EUKDayCollectionViewCell.CellIdentifier, for: indexPath) as? EUKDayCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let dayItem = self.dayItems[indexPath.row]
        var calendarItem: CalendarItem?
		let isSelectedDate = Calendar.current.isDate(dayItem.date, inSameDayAs: self.selectedDate ?? Date())
		
        if let dateString = DateManager.sharedInstance.string(date: dayItem.date, format: DateManager.sharedInstance.DateLongFormat), let item = self.calendarItems[dateString] {
            calendarItem = item
        }
        
        cell.actionButton.tag = indexPath.row
        cell.actionButton.addTarget(self, action: #selector(EUKWeekCalendarViewController.daySelected(button:)), for: .touchUpInside)
		
		cell.blurView.isHidden = !isSelectedDate
        
		let isToday = Calendar.current.isDateInToday(dayItem.date)
		cell.setup(day: dayItem.day, dayName: dayItem.dayName, calendarItem: calendarItem, calendarFilter: self.calendarFilter, isSelectedDate: isSelectedDate, isToday: isToday)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.itemSize()
    }
}
