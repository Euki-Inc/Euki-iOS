//
//  EUKCalendarFilterViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/4/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKCalendarFilterViewController: EUKBasePinCheckViewController {
    let FilterCellIdentifier = "FilterCellIdentifier"
    let ButtonsCellIdentifier = "ButtonsCellIdentifier"
    
    enum CellTags: Int {
        case icon = 100,
        title
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var calendarFilter: CalendarFilter?
    var filterItems = [FilterItem]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.setUIElements()
        self.initFilterItems()
    }

    //MARK: - IBActions
    
    @IBAction func clearAction(_ sender: Any) {
        self.filterItems.forEach({ $0.isOn = false })
        self.tableView.reloadData()
        self.showResultsAction(sender)
    }
    
    @IBAction func showResultsAction(_ sender: Any) {
        guard let calendarFilter = self.calendarFilter else {
            return
        }
        
        for filterItem in self.filterItems {
            switch (filterItem.title) {
            case "bleeding":
                calendarFilter.bleedingOn = filterItem.isOn
            case "emotions":
                calendarFilter.emotionsOn = filterItem.isOn
            case "body":
                calendarFilter.bodyOn = filterItem.isOn
            case "sexual_activity":
                calendarFilter.sexualActivityOn = filterItem.isOn
            case "contraception":
                calendarFilter.contraceptionOn = filterItem.isOn
            case "test":
                calendarFilter.testOn = filterItem.isOn
            case "appointment":
                calendarFilter.appointmentOn = filterItem.isOn
            case "note":
                calendarFilter.noteOn = filterItem.isOn
            default:
                print("Options not supported")
            }
        }
        self.performSegue(withIdentifier: self.DoneSegueIdentifier, sender: nil)
    }
	
	@IBAction func cancelAction() {
		self.presentingViewController?.dismiss(animated: true)
	}
    
    //MARK: - Private
	
	func setUIElements() {
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "cancel".localized.uppercased(), style: .plain, target: self, action: #selector(EUKCalendarFilterViewController.cancelAction))
        self.navigationItem.title = "filter".localized
	}
    
    func initFilterItems() {
        guard let calendarFilter = self.calendarFilter else {
            return
        }
        
        self.filterItems = [
            FilterItem(color: UIColor.eukBleeding, title: "bleeding", isOn: calendarFilter.bleedingOn),
            FilterItem(color: UIColor.eukEmotions, title: "emotions", isOn: calendarFilter.emotionsOn),
            FilterItem(color: UIColor.eukBody, title: "body", isOn: calendarFilter.bodyOn),
            FilterItem(color: UIColor.eukSexualActivity, title: "sexual_activity", isOn: calendarFilter.sexualActivityOn),
            FilterItem(color: UIColor.eukContraception, title: "contraception", isOn: calendarFilter.contraceptionOn),
            FilterItem(color: UIColor.eukTest, title: "test", isOn: calendarFilter.testOn),
            FilterItem(color: UIColor.eukAppointment, title: "appointment", isOn: calendarFilter.appointmentOn),
            FilterItem(color: UIColor.eukNote, title: "note", isOn: calendarFilter.noteOn)
        ]
        
        self.tableView.reloadData()
    }
}

extension EUKCalendarFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.filterItems.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: self.FilterCellIdentifier, for: indexPath)
            let filterItem = self.filterItems[indexPath.row]
            
            if let iconImageView = cell.contentView.viewWithTag(CellTags.icon.rawValue) as? UIImageView {
                let imageName = filterItem.isOn ? "IconFilterOn" : "IconFilterOff"
                iconImageView.image = UIImage(named: imageName)
                iconImageView.tintColor = filterItem.color
            }
            if let titleLabel = cell.contentView.viewWithTag(CellTags.title.rawValue) as? UILabel {
                titleLabel.text = filterItem.title.localized
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.ButtonsCellIdentifier, for: indexPath)
        
        if let clearButton = cell.contentView.viewWithTag(100) as? UIButton {
            clearButton.addTarget(self, action: #selector(EUKCalendarFilterViewController.clearAction(_:)), for: .touchUpInside)
        }
        if let showResultsButton = cell.contentView.viewWithTag(101) as? UIButton {
            showResultsButton.addTarget(self, action: #selector(EUKCalendarFilterViewController.showResultsAction(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 55.0
        }
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let filterItem = self.filterItems[indexPath.row]
            filterItem.isOn = !filterItem.isOn
            self.tableView.reloadData()
        }
    }
}
