//
//  EUKCalendarListViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/4/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class EUKCalendarListViewController: EUKBaseViewController {
    static let ViewControllerID = "CalendarListViewController"
    let ListCellIdentifier = "ListCellIdentifier"
    
    enum CellTags: Int {
        case title = 100,
        stackView
    }
    
    @IBOutlet weak var tableView: UITableView!

    var calendarFilter: CalendarFilter?
    var calendarItems = [CalendarItem]()
    var filteredItems = [CalendarItem]()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.filterItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.requestCalendarItems()
    }

    //MARK: - Private
    
    func setUIElements() {
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func requestCalendarItems() {
        CalendarManager.sharedInstance.requestDayItems { [unowned self] (items) in
            self.calendarItems = items
            self.filterItems()
        }
    }
    
    func filterItems() {
        guard let calendarFilter = self.calendarFilter else {
            return
        }
        
        self.filteredItems.removeAll()
        for calendarItem in self.calendarItems {
            if calendarFilter.showAll() {
                self.filteredItems.append(calendarItem)
            } else if (calendarFilter.bleedingOn && calendarItem.bleedingSize != nil) ||
                (calendarFilter.emotionsOn && calendarItem.emotions.count > 0) ||
                (calendarFilter.bodyOn && calendarItem.body.count > 0) ||
                (calendarFilter.sexualActivityOn && calendarItem.hasSexualActivity()) ||
                (calendarFilter.contraceptionOn && (calendarItem.contraceptionPill != nil || calendarItem.contraceptionDailyOther.count > 0 || calendarItem.contraceptionIud != nil || calendarItem.contraceptionImplant != nil || calendarItem.contraceptionPatch != nil || calendarItem.contraceptionRing != nil ||
                    calendarItem.contraceptionShot != nil || calendarItem.contraceptionLongTermOther.count > 0)) ||
                (calendarFilter.testOn && (calendarItem.testSTI != nil || calendarItem.testPregnancy != nil)) ||
                (calendarFilter.appointmentOn && calendarItem.appointments.count > 0) ||
                (calendarFilter.noteOn && calendarItem.note != nil) {
                self.filteredItems.append(calendarItem)
            }
        }
        
        self.tableView.reloadData()
    }
    
}

extension EUKCalendarListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let calendarFilter = self.calendarFilter else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.ListCellIdentifier, for: indexPath)
        let calendarItem = self.filteredItems[indexPath.row]
        
        if let titleLabel = cell.contentView.viewWithTag(CellTags.title.rawValue) as? UILabel {
			titleLabel.text = DateManager.sharedInstance.string(date: calendarItem.date, format: DateManager.sharedInstance.dddMMMMdd)?.capitalized
        }
        if let stackView = cell.contentView.viewWithTag(CellTags.stackView.rawValue) as? UIStackView {
            stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
            
            // Bleeding data
            var bleedingStrings = [String]()
            if let bleedingSize = calendarItem.bleedingSize, (calendarFilter.bleedingOn || calendarFilter.showAll()) {
                bleedingStrings.append("bleeding_size_\(bleedingSize.rawValue + 1)".localized)
            }
			for (index, value) in calendarItem.bleedingClotsCounter.enumerated() {
				if value > 0 && (calendarFilter.bleedingOn || calendarFilter.showAll()) {
					bleedingStrings.append(self.countValue(count: value, text: "bleeding_clots_\(index + 1)".localized))
				}
			}
            for (index, value) in calendarItem.bleedingProductsCounter.enumerated() {
                if value > 0 && (calendarFilter.bleedingOn || calendarFilter.showAll()) {
					bleedingStrings.append(self.countValue(count: value, text: "bleeding_produc_\(index + 1)".localized))
                }
            }
            let bleedingString = bleedingStrings.toString()
            if (!bleedingString.isEmpty) {
                stackView.addArrangedSubview(self.createDotTitle(color: UIColor.eukBleeding, title: bleedingString))
            }
            
            // Emotions data
            if calendarFilter.emotionsOn || calendarFilter.showAll() {
                let value = calendarItem.emotions.map({ "emotions_\($0.rawValue + 1)".localized }).toString()
                if (!value.isEmpty) {
                    stackView.addArrangedSubview(self.createDotTitle(color: UIColor.eukEmotions, title: value))
                }
            }
            
            // Body data
            if calendarFilter.bodyOn || calendarFilter.showAll() {
                let value = calendarItem.body.map({ "body_\($0.rawValue + 1)".localized }).toString()
                if (!value.isEmpty) {
                    stackView.addArrangedSubview(self.createDotTitle(color: UIColor.eukBody, title: value))
                }
            }
            
            // Sexual data
            var sexualStrings = [String]()
            for (index, value) in calendarItem.sexualProtectionSTICounter.enumerated() {
                if value > 0 && (calendarFilter.sexualActivityOn || calendarFilter.showAll()) {
					sexualStrings.append(self.countValue(count: value, text: "protection_sti_\(index + 1)_list".localized))
                }
            }
            for (index, value) in calendarItem.sexualProtectionPregnancyCounter.enumerated() {
                if value > 0 && (calendarFilter.sexualActivityOn || calendarFilter.showAll()) {
					sexualStrings.append(self.countValue(count: value, text: "protection_pregnancy_\(index + 1)_list".localized))
                }
            }
            for (index, value) in calendarItem.sexualOtherCounter.enumerated() {
                if value > 0 && (calendarFilter.sexualActivityOn || calendarFilter.showAll()) {
					sexualStrings.append(self.countValue(count: value, text: "protection_other_\(index + 1)".localized))
                }
            }
            let sexualString = sexualStrings.toString()
            if (!sexualString.isEmpty) {
                stackView.addArrangedSubview(self.createDotTitle(color: UIColor.eukSexualActivity, title: sexualString))
            }
            
            // Contraception data
            var contraceptionStrings = [String]()
            if calendarFilter.contraceptionOn || calendarFilter.showAll() {
                if let contraceptionPill = calendarItem.contraceptionPill {
                    contraceptionStrings.append("contraception_pill_\(contraceptionPill.rawValue + 1)_list".localized)
                }
                for contraceptionDailyOther in calendarItem.contraceptionDailyOther {
                    contraceptionStrings.append("contraception_other_\(contraceptionDailyOther.rawValue + 1)".localized)
                }
                if let contraceptionIud = calendarItem.contraceptionIud {
                    contraceptionStrings.append("contraception_uid_\(contraceptionIud.rawValue + 1)_list".localized)
                }
                if let contraceptionImplant = calendarItem.contraceptionImplant {
                    contraceptionStrings.append("contraception_implant_\(contraceptionImplant.rawValue + 1)_list".localized)
                }
                if let contraceptionPatch = calendarItem.contraceptionPatch {
                    contraceptionStrings.append("contraception_patch_\(contraceptionPatch.rawValue + 1)_list".localized)
                }
                if let contraceptionRing = calendarItem.contraceptionRing {
                    contraceptionStrings.append("contraception_ring_\(contraceptionRing.rawValue + 1)_list".localized)
                }
                
                if let contraceptionShot = calendarItem.contraceptionShot {
                    contraceptionStrings.append("shot_list".localized)
                }
                for _ in calendarItem.contraceptionLongTermOther {
                    contraceptionStrings.append("icon_contraception_injection".localized)
                }
            }
            let contraceptionString = contraceptionStrings.toString()
            if (!contraceptionString.isEmpty) {
                stackView.addArrangedSubview(self.createDotTitle(color: UIColor.eukContraception, title: contraceptionString))
            }
            
            // Test data
            var testStrings = [String]()
            if let testSTI = calendarItem.testSTI, (calendarFilter.testOn || calendarFilter.showAll()) {
                testStrings.append("test_sti_\(testSTI.rawValue + 1)_list".localized)
            }
            if let testPregnancy = calendarItem.testPregnancy, (calendarFilter.testOn || calendarFilter.showAll()) {
                testStrings.append("test_pregnancy_\(testPregnancy.rawValue + 1)_list".localized)
            }
            let testString = testStrings.toString()
            if (!testString.isEmpty) {
                stackView.addArrangedSubview(self.createDotTitle(color: UIColor.eukTest, title: testString))
            }
            
            // Appointments Data
            if calendarItem.appointments.count > 0 && (calendarFilter.appointmentOn || calendarFilter.showAll()) {
                stackView.addArrangedSubview(self.createDotTitle(color: UIColor.eukAppointment, title: "appointment".localized))
                
                for appointment in calendarItem.appointments {
                    var text = ""
                    
                    if let title = appointment.title {
                        text = title
                    }
                    if let location = appointment.location {
                        text = "\(text) - \(location)"
                    }
                    if let date = appointment.date, let dateString = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.TimeFormat) {
                        if dateString != "12:00 AM" {
                            text = "\(text) (\(dateString))"
                        }
                    }
                    
                    let appointmentView = self.createAppointmentTitle(title: text)
                    stackView.addArrangedSubview(appointmentView)
                }
            }
            
            // Notes Data
            if let note = calendarItem.note, (calendarFilter.noteOn || calendarFilter.showAll()) {
                stackView.addArrangedSubview(self.createDotTitle(color: UIColor.eukNote, title: note))
            }
        }
        
        return cell
    }
	
	private func countValue(count: Int, text: String) -> String {
		"\(count) \(text)"
	}
    
    func createDotTitle(color: UIColor, title: String) -> EUKDotTitle! {
        if let dotView = UINib(nibName: "EUKDotTitle", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as? EUKDotTitle {
            dotView.dotView.backgroundColor = color
            dotView.titleLabel.text = title
            return dotView
        }
        
        return EUKDotTitle()
    }
    
    func createAppointmentTitle(title: String) -> EUKAppointmentView {
        if let appointmentView = UINib(nibName: "EUKAppointmentView", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as? EUKAppointmentView {
            appointmentView.titleLabel.text = title
            
            let attributes: [NSAttributedStringKey: Any] = [
                NSAttributedStringKey.font: UIFont.eukTileSmallFont()! as Any,
                NSAttributedStringKey.foregroundColor: UIColor.eukiMain
            ]
            let linkAttributes: [NSAttributedStringKey: Any] = [
                NSAttributedStringKey.font: UIFont.eukTileSmallFont()! as Any,
                NSAttributedStringKey.foregroundColor: UIColor.eukCoral
            ]
            
            let fullString = title
            let attributedString = NSMutableAttributedString(string: fullString, attributes: attributes)
            appointmentView.titleLabel.attributedText = attributedString
            appointmentView.titleLabel.linkAttributes = linkAttributes
            
            let range = (fullString as NSString).range(of: "(\\d+) ((\\w+[ ,])+ ){2}([a-zA-Z]){2} (\\d){5}", options: NSString.CompareOptions.regularExpression)
            
            if range.location != NSNotFound {
                var address = (fullString as NSString).substring(with: range)
                address = (address as NSString).replacingOccurrences(of: " ", with: "+")
                
                let urlString = "https://www.google.com/maps/search/?api=1&query=\(address)"
                if let url = URL(string: urlString) {
                    appointmentView.titleLabel.addLink(to: url, with: range)
                }
            }
            appointmentView.titleLabel.delegate = self
            
            return appointmentView
        }
        
        return EUKAppointmentView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let calendarItem = self.filteredItems[indexPath.row]
        
        if let dailyLogViewController = EUKDailyLogViewController.initViewController(date: calendarItem.date) {
            self.navigationController?.pushViewController(dailyLogViewController, animated: true)
        }
    }
}

extension EUKCalendarListViewController: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        self.showURL(url: url)
    }
}
