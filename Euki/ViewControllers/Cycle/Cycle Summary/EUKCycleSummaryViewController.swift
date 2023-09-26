//
//  EUKDaySummaryViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/1/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class EUKCycleSummaryViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var cycleLengthLabel: UILabel!
	@IBOutlet weak var variationLabel: UILabel!
	@IBOutlet weak var periodLengthLabel: UILabel!
	@IBOutlet weak var currentCycleDayLabel: UILabel!
	
	var periodData: CyclePeriodData?
	var showAll = false
	
	//MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setUIElements()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.requestData()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.tableView.reloadData()
	}
	
	//MARK: - IBActions
	
	@IBAction func showAllAction() {
		self.showAll = true
		self.tableView.reloadData()
	}

	//MARK: - Public
	
	class func initViewController() -> UIViewController? {
		return UIStoryboard(name: "Cycle", bundle: nil).instantiateViewController(withIdentifier: "EUKCycleSummaryViewController")
	}
	
	//MARK: - Private
	
	private func setUIElements() {
		self.tableView.register(UINib(nibName: EUKCycleSumaryDayTableViewCell.CellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: EUKCycleSumaryDayTableViewCell.CellIdentifier)
		self.tableView.register(UINib(nibName: EUKCycleSumarySeeMoreTableViewCell.CellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: EUKCycleSumarySeeMoreTableViewCell.CellIdentifier)
	}
	
	private func updateUIElements() {
		let cycleLength: String
		let variation: String
		let periodLength: String
		let currentDay: String
		
		if let value = self.periodData?.averageCycleLength {
			cycleLength = String(format: "%.1f", value)
		} else {
			cycleLength = "-"
		}
		
		if let value = self.periodData?.variation {
			variation = "\(value)"
		} else {
			variation = "-"
		}
		
		if let value = self.periodData?.averagePeriodLength {
			periodLength = String(format: "%.1f", value)
		} else {
			periodLength = "-"
		}
		
		if let value = self.periodData?.currentDayCycle {
			currentDay = "\(value)"
		} else {
			currentDay = "-"
		}
		
		
		self.cycleLengthLabel.text = String(format: "cycle_summary_days_format".localized, cycleLength).appending(Double(cycleLength) ?? 0 > 1 ? "s" : "")
		self.variationLabel.text = String(format: "cycle_summary_days_format".localized, variation).appending(Int(variation) ?? 0 > 1 ? "s" : "")
		self.periodLengthLabel.text = String(format: "cycle_summary_days_format".localized, periodLength).appending(Double(periodLength) ?? 0 > 1 ? "s" : "")
		self.currentCycleDayLabel.text = String(format: "your_current_cycle_day".localized, currentDay)
	}
	
	private func requestData() {
		CycleManager.sharedInstance.requestCyclePeriodData { data in
			self.periodData = data
			self.updateUIElements()
			self.tableView.reloadData()
		}
	}
	
	private func deletePeriod(item: CyclePeriodItem) {
		let alertViewController = UIAlertController(title: nil, message: "delete_period".localized, preferredStyle: .alert)
		alertViewController.view.tintColor = UIColor.eukiAccent
		let cancelAction = UIAlertAction(title: "cancel".localized.uppercased(), style: .destructive, handler: nil)
		let deleteAction = UIAlertAction(title: "delete".localized.uppercased(), style: .default, handler: { [unowned self] (_) in
			CycleManager.sharedInstance.deletePeriod(item: item) { success in
				self.requestData()
			}
		})
		alertViewController.addAction(cancelAction)
		alertViewController.addAction(deleteAction)
		self.present(alertViewController, animated: true, completion: nil)
	}
}

extension EUKCycleSummaryViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		let count = self.periodData?.items.count ?? 0
		
		if count == 0 {
			return 1
		}
		
		if !self.showAll && count > 1 {
			return 2
		}
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = self.periodData?.items.count ?? 0
		
		if count == 0 {
			return 1
		}
		
		if section == 0 {
			return self.showAll ? count : 1
		}
		
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			return self.periodCycleCell(tableView, cellForRowAt: indexPath)
		}
		return self.seeMoreCell(tableView, cellForRowAt: indexPath)
	}
	
	func periodCycleCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: EUKCycleSumaryDayTableViewCell.CellIdentifier, for: indexPath) as? EUKCycleSumaryDayTableViewCell else {
			return UITableViewCell()
		}
		
		let maxWidth = tableView.bounds.width - 32
		
		guard let data = self.periodData, !data.items.isEmpty else {
			cell.periodSizeTrailingConstraint.constant = 0
			cell.bleedingSizeTrailingConstraint.constant = maxWidth * 5 / 6
			cell.bleedingLabel.text = "-"
			cell.rangeLabel.text = "date_starting_period".localized
			cell.currentDayIndicatorView.isHidden = true
			return cell
		}
		
		let item = data.items[indexPath.row]
		let isCurrentPeriod = Calendar.current.isDate(item.endDate, inSameDayAs: Date())
		
		let startString = DateManager.sharedInstance.string(date: item.initialDate, format: DateManager.sharedInstance.MMMdd)?.capitalized ?? ""
		let endString: String
		let daysString: String
		
		if Calendar.current.isDate(item.endDate, inSameDayAs: Date()) {
			endString = "cycle_today".localized
			daysString = ""
		} else {
			endString = DateManager.sharedInstance.string(date: item.endDate, format: DateManager.sharedInstance.MMMdd)?.capitalized ?? ""
			daysString = "\(item.initialDate.daysDiff(date: item.endDate) + 1) \("days".localized.lowercased()), "
		}
		
		cell.rangeLabel.text = "\(daysString)\(startString) - \(endString)"
		
		let maxCycleLength = Double(data.maxCycleLength ?? 30)
		let cycleLength = item.initialDate.daysDiff(date: item.endDate)
		
		let cycleMargin = maxWidth * (1.0 - Double(cycleLength) / maxCycleLength)
		let periodMargin = maxWidth * (1.0 - Double(item.duration) / maxCycleLength) - 10
		
		cell.periodSizeTrailingConstraint.constant = cycleMargin
		cell.bleedingSizeTrailingConstraint.constant = periodMargin
		
		cell.bleedingLabel.text = "\(item.duration)"
		
		if let currentDayCycle = data.currentDayCycle, isCurrentPeriod {
			let dayMargin = maxWidth * Double(currentDayCycle) / maxCycleLength + 5
			cell.currentDayIndicatorView.isHidden = false
			cell.dayIndicatorLeadingConstraint.constant = dayMargin
		} else {
			cell.currentDayIndicatorView.isHidden = true
		}
		
		if isCurrentPeriod {
			cell.periodSizeTrailingConstraint.constant = 0
		}
		
		if indexPath.row > 0 {
			// Add Delete Button
			
			let deleteButton = MGSwipeButton(title: "delete".localized.uppercased(), backgroundColor: UIColor.eukPurpleClear, padding: 30) { [unowned self] (_) -> Bool in
				self.deletePeriod(item: item)
				return true
			}
			
			deleteButton.setTitleColor(UIColor.eukiAccent, for: .normal)
			deleteButton.addBorders(edges: [.right, .left], color: UIColor.eukiMain, thickness: 0.5)
			cell.rightButtons = [deleteButton]
		}
		
		return cell
	}
	
	func seeMoreCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: EUKCycleSumarySeeMoreTableViewCell.CellIdentifier, for: indexPath) as? EUKCycleSumarySeeMoreTableViewCell else {
			return UITableViewCell()
		}
		
		cell.seeButton.addTarget(self, action: #selector(EUKCycleSummaryViewController.showAllAction), for: .touchUpInside)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80.0
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.section == 1 {
			cell.addBorders(edges: [.top, .bottom], color: UIColor.eukBackground, thickness: 1.0)
		} else {
			cell.addBorders(edges: [.top], color: indexPath.row == 0 ? UIColor.eukiMain : UIColor.white, thickness: 1.0)
			cell.addBorders(edges: [.bottom], color: UIColor.eukiMain, thickness: 1.0)
		}
	}
}
