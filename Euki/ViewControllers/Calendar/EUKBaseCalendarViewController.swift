//
//  EUKBaseCalendarViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 5/31/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKBaseCalendarViewController: EUKBaseViewController {
    static let ViewControllerId = "CalendarViewController"
    
    var EmptyCellIdentifier = "EmptyCellIdentifier"
    var HeaderViewIdentifier = "HeaderViewIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var calendarFilter: CalendarFilter?
    var calendarItems = [String: CalendarItem]()
    var monthItems = [MonthItem]()
    var todayItem: MonthItem?
	var predictionRange: [ClosedRange<Date>]?
	var isFirstLoad = true
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.EmptyCellIdentifier = "EmptyCellIdentifier"
        self.HeaderViewIdentifier = "HeaderViewIdentifier"
        super.viewDidLoad()
		self.setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.requestCalendarItems()
    }
    
    //MARK: - IBActions
    
    @IBAction func daySelected(button: UIButton) {
        guard let index = button.superview?.tag else {
            return
        }
        
        let monthItem = self.monthItems[index]
        let day = button.tag
        let date = Date.date(year: monthItem.year, month: monthItem.month, day: day)
        
        var calendarItem: CalendarItem?
        if let dateString = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.DateLongFormat), let foundCalendarItem = self.calendarItems[dateString] {
            calendarItem = foundCalendarItem
        }
        
        self.selectedDate(date: date, calendarItem: calendarItem)
    }
    
    @IBAction func todayAction() {
        self.showTodayItem()
    }
    
    @IBAction func previousMonthAction() {
        self.changeMonthItem(direction: -1)
    }
    
    @IBAction func nextMonthAction() {
        self.changeMonthItem(direction: 1)
    }
    
    //MARk: - Private
	
	private func setupCollectionView() {
		self.collectionView.register(UINib(nibName: "EUKMonthDaysCollectionReusableView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.HeaderViewIdentifier)
		self.collectionView.register(UINib(nibName: "EUKDayCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: EUKDayCollectionViewCell.CellIdentifier)
	}
    
    func initMonthItems() {
        var monthItems = [MonthItem]()
        let date = Date()
        
        for year in 1950 ... 2050 {
            for month in 1 ... 12 {
                let item = MonthItem(year: year, month: month)
                monthItems.append(item)
                
                let components = Calendar.current.dateComponents([.year, .month], from: date)
                if let currentYear = components.year, let currentMonth = components.month, year == currentYear && month == currentMonth {
                    self.todayItem = item
                }
            }
        }
        
        self.monthItems = monthItems
    }
    
    func requestCalendarItems() {
        CalendarManager.sharedInstance.requestItems { items in
			CalendarManager.sharedInstance.predictionRange { predictionRange in
				self.predictionRange = predictionRange
				self.initMonthItems()
				self.calendarItems = items
				self.collectionView.reloadData()
				self.showTodayItem()
			}
        }
    }
    
    func selectedDate(date: Date, calendarItem: CalendarItem?) {
    }
    
    func showMonthLabel() {
        if let label = collectionView.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionHeader).last?.viewWithTag(100) as? UILabel {
            self.monthLabel.text = label.text
        }
    }
    
    func showTodayItem() {
        if let todayItem = self.todayItem, let index = self.monthItems.index(of: todayItem) {
            let date = Date.date(year: todayItem.year, month: todayItem.month)
			monthLabel.text = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.CalendarFormat)?.capitalized
            self.scrollToSection(index)
        }
    }
    
    func changeMonthItem(direction: Int) {
        let text = self.monthLabel.text
        
        if let index = self.monthItems.firstIndex(where: { item in
            let date = Date.date(year: item.year, month: item.month)
			let dateString = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.CalendarFormat)?.capitalized
            return dateString == text
        }) {
            let newIndex = index + direction
            let newItem = self.monthItems[newIndex]
            let newDate = Date.date(year: newItem.year, month: newItem.month)
			let newString = DateManager.sharedInstance.string(date: newDate, format: DateManager.sharedInstance.CalendarFormat)?.capitalized
            self.monthLabel.text = newString
            self.scrollToSection(newIndex)
        }
    }
    
    func scrollToSection(_ section:Int)  {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let indexPath = IndexPath(row: 0, section: section)
            if let attributes = self.collectionView.layoutAttributesForSupplementaryElement(ofKind: UICollectionElementKindSectionHeader, at: indexPath) {
                let topOfHeader = CGPoint(x: 0, y: attributes.frame.origin.y - self.collectionView.contentInset.top)
                self.collectionView.setContentOffset(topOfHeader, animated:true)
            }
        }
    }
    
    //MARK: - Public
    
    class func initViewController(anyClass: AnyClass?) -> EUKBaseCalendarViewController?{
        if let calendarViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: EUKBaseCalendarViewController.ViewControllerId) as? EUKBaseCalendarViewController{
            if let anyClass = anyClass {
                object_setClass(calendarViewController, anyClass)
            }
            return calendarViewController
        }
        return nil
    }
}

class MonthItem: NSObject {
    var year: Int
    var month: Int
    var numDays: Int
    var firstDayweek: Int
    
    override init() {
        self.year = 0
        self.month = 0
        self.numDays = 0
        self.firstDayweek = 0
    }
    
    convenience init(year: Int, month: Int) {
        self.init()
        self.year = year
        self.month = month
        
        let numDays = Date.numDaysMonths(year: year, month: month)
        let weekDay = Date.dayOfWeek(year: year, month: month, day: 1)
        
        self.numDays = numDays
        self.firstDayweek = weekDay
    }
}

extension EUKBaseCalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.monthItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let monthItem = self.monthItems[section]
        return monthItem.firstDayweek + monthItem.numDays - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let calendarFilter = self.calendarFilter else {
            return UICollectionViewCell()
        }
        
        let monthItem = self.monthItems[indexPath.section]
        let day = indexPath.row - monthItem.firstDayweek + 2
        let date = Date.date(year: monthItem.year, month: monthItem.month, day: day)
        
        if indexPath.row + 1 < monthItem.firstDayweek {
            return collectionView.dequeueReusableCell(withReuseIdentifier: self.EmptyCellIdentifier, for: indexPath)
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EUKDayCollectionViewCell.CellIdentifier, for: indexPath) as? EUKDayCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.dayLabel.text = "\(day)"
        
        cell.actionButton.tag = day
        cell.actionButton.superview?.tag = indexPath.section
        cell.actionButton.addTarget(self, action: #selector(EUKBaseCalendarViewController.daySelected(button:)), for: .touchUpInside)
        
        var calendarItem: CalendarItem?
        if let dateString = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.DateLongFormat),
            let item = self.calendarItems[dateString] {
            calendarItem = item
        }
		
		let isToday = Calendar.current.isDateInToday(date)
		
		var isPrediction = false
		predictionRange?.forEach({ range in
			if range.lowerBound <= date && date <= range.upperBound {
				isPrediction = true
			}
		})
		
        cell.setup(day: day, calendarItem: calendarItem, calendarFilter: calendarFilter, isSelectedDate: isToday, isToday: isToday, isPrediction: isPrediction)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.HeaderViewIdentifier, for: indexPath)
            
            let monthItem = self.monthItems[indexPath.section]
            let date = Date.date(year: monthItem.year, month: monthItem.month)
            
            if let titleLabel = headerView.viewWithTag(100) as? UILabel {
				titleLabel.text = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.CalendarFormat)?.capitalized
            }
            
            return headerView
        }
        
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 7
        return CGSize(width: width, height: width * 50 / 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 70)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.showMonthLabel()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.showMonthLabel()
        }
    }
}
