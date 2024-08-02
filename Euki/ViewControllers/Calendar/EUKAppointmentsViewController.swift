//
//  EUKAppointmentsViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 2/3/19.
//  Copyright © 2019 Ibis. All rights reserved.
//

import UIKit

class EUKAppointmentsViewController: EUKBasePinCheckViewController {
    static let ViewControllerID = "EUKAppointmentsViewController"
    
    let AppointmentCellIdentifier = "AppointmentCellIdentifier"
    let AddAppointmentCellIdentifier = "AddAppointmentCellIdentifier"
    let NewAppointmentCellIdentifier = "NewAppointmentCellIdentifier"

    @IBOutlet weak var tableView: UITableView!
    
    var titleField: UITextField?
    var locationField: UITextField?
    var datePicker: UIDatePicker?
    var dateField: UITextField?
    var alertPicker: UIPickerView?
    var alertField: UITextField?
    
    var newItem = Appointment()
    var items = [Appointment]()
    
    var createdItem: Appointment?
    var editingItem: Appointment?
    
    var date: Date?
    var calendarItem: CalendarItem?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.setUIElements()
        self.requestItems()
        
        if let date = self.date, let dateString = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.dddMMMMdd) {
            self.navigationItem.title = dateString
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func datePickerChanged(datePicker: UIDatePicker) {
        self.newItem.date = datePicker.date
        
        if let date = self.newItem.date, let dateString = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.eeeMMMdyyyyhmma) {
            self.dateField?.text = dateString
        } else {
            self.dateField?.text = nil
        }
    }
    
    @IBAction func cancelAction() {
        self.createdItem = nil
        self.editingItem = nil
        self.tableView.reloadData()
    }
    
    @IBAction func addAction() {
        guard let calendarItem = calendarItem else {
            return
        }
        
        self.newItem.title = self.titleField?.text
        self.newItem.location = self.locationField?.text
		
		if self.newItem.title?.isEmpty ?? true || self.newItem.location?.isEmpty ?? true || self.newItem.date == nil {
			self.showError(message: "appointment_all_fields")
			return
		}
        
        if self.createdItem != nil {
            self.items.append(self.newItem)
        } else if self.editingItem != nil {
            self.editingItem?.title = self.newItem.title
            self.editingItem?.location = self.newItem.location
            self.editingItem?.date = self.newItem.date
            self.editingItem?.alertOption = self.newItem.alertOption
            self.editingItem?.alertShown = 0
        }
        
        if let editingItemId = self.editingItem?.id {
            LocalNotificationManager.sharedInstance.deleteNotification(id: editingItemId)
        }

        calendarItem.appointments = self.items
        self.showLoading()
        CalendarManager.sharedInstance.saveItem(calendarItem: calendarItem) { (success) in
            self.dismissLoading()
            self.editingItem = nil
            self.createdItem = nil
            self.tableView.reloadData()
            self.requestItems()
        }
    }
	
	@IBAction func doneAction() {
		self.presentingViewController?.dismiss(animated: true)
	}
    
    //MARK: - Private
	
	func setUIElements() {
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done".localized.uppercased(), style: .plain, target: self, action: #selector(EUKAppointmentsViewController.doneAction))
	}
    
    func requestItems() {
        guard let date = self.date else {
            return
        }
        
        CalendarManager.sharedInstance.calendarItem(dateSearch: date) { (calendarItem) in
            self.calendarItem = calendarItem
            self.items.removeAll()
            if let calendarItem = calendarItem {
                self.items.append(contentsOf: calendarItem.appointments)
            }
            self.tableView.reloadData()
        }
    }
    
    func title(row: Int) -> String {
        var title: String
        switch row {
        case 0:
            title = "none".localized
        case 1:
            title = "option_30_mins".localized
        case 2:
            title = "option_1_hr".localized
        case 3:
            title = "option_2_hrs".localized
        case 4:
            title = "option_3_hrs".localized
        case 5:
            title = "option_1_day".localized
        case 6:
            title = "option_2_day".localized
        case 7:
            title = "option_3_day".localized
        default:
            title = ""
        }
        return title
    }
    
    //MARK: - Public
    
    class func initNavViewController(date: Date?) -> UIViewController? {
        if let viewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: self.ViewControllerID) as? EUKAppointmentsViewController {
            viewController.date = date
            let navViewController = UINavigationController(rootViewController: viewController)
            return navViewController
        }
        return nil
    }

}

extension EUKAppointmentsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.createdItem != nil && section == self.items.count {
            return 2
        }
        
        if self.items.count > section {
            if let editingItem = self.editingItem, editingItem == self.items[section] {
                return 2
            }
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if indexPath.row == 0 {
            if indexPath.section < self.items.count {
                cell = self.setupAppointmentCell(tableView: tableView, indexPath: indexPath, appointment: self.items[indexPath.section])
            } else {
                cell = self.setupAddAppointmentCell(tableView: tableView, indexPath: indexPath)
            }
        } else {
            if let createdItem = self.createdItem, indexPath.section == self.items.count {
                cell = self.setupEditAppointmentCell(tableView: tableView, indexPath: indexPath, appointment: createdItem)
            }
            if self.items.count > indexPath.section {
                if let editingItem = self.editingItem, editingItem == self.items[indexPath.section] {
                    cell = self.setupEditAppointmentCell(tableView: tableView, indexPath: indexPath, appointment: editingItem)
                }
            }
            
        }
        
        return cell ?? UITableViewCell()
    }
    
    func setupAppointmentCell(tableView: UITableView, indexPath: IndexPath, appointment: Appointment) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.AppointmentCellIdentifier, for: indexPath) as? MGSwipeTableCell else {
            return UITableViewCell()
        }
        
        if let titleLabel = cell.contentView.viewWithTag(100) as? UILabel {
            titleLabel.text = appointment.title
        }
        
        let deleteButton = MGSwipeButton(title: "delete".localized.uppercased(), backgroundColor: UIColor.eukPurpleClear, padding: 30) { [unowned self] (_) -> Bool in
            let alertViewController = UIAlertController(title: nil, message: "delete_appointment".localized, preferredStyle: .alert)
            alertViewController.view.tintColor = UIColor.eukiAccent
            let cancelAction = UIAlertAction(title: "cancel".localized.uppercased(), style: .destructive, handler: nil)
            let deleteAction = UIAlertAction(title: "delete".localized.uppercased(), style: .default, handler: { [unowned self] (_) in
                self.showLoading()
                if let appointmentId = appointment.id {
                    LocalNotificationManager.sharedInstance.deleteNotification(id: appointmentId)
                }
                
                self.items.remove(at: indexPath.section)
                self.calendarItem?.appointments = self.items
                
                if let calendarItem = self.calendarItem {
                    CalendarManager.sharedInstance.saveItem(calendarItem: calendarItem, responseHandler: { (success) in
                        self.dismissLoading()
                        self.tableView.reloadData()
                    })
                }
            })
            alertViewController.addAction(cancelAction)
            alertViewController.addAction(deleteAction)
            self.present(alertViewController, animated: true, completion: nil)
            return true
        }
        
        deleteButton.setTitleColor(UIColor.eukiAccent, for: .normal)
        deleteButton.addBorders(edges: [.right, .left], color: UIColor.eukiMain, thickness: 0.5)
        cell.rightButtons = [deleteButton]
        
        cell.addBorders(edges: .top, color: UIColor.eukiMain, thickness: 0.5)
        
        return cell
    }
    
    func setupAddAppointmentCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.NewAppointmentCellIdentifier, for: indexPath)
        cell.addBorders(edges: .top, color: UIColor.eukiMain, thickness: 0.5)
        cell.addBorders(edges: .bottom, color: self.createdItem == nil ? UIColor.eukiMain : UIColor.white, thickness: 0.5)
        return cell
    }
    
    func setupEditAppointmentCell(tableView: UITableView, indexPath: IndexPath, appointment: Appointment) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.AddAppointmentCellIdentifier, for: indexPath) as? EUKAddAppointmentTableViewCell else {
            return UITableViewCell()
        }
        
        self.titleField = cell.titleField
        self.locationField = cell.locationField
        self.dateField = cell.dayTimeField
        self.alertField = cell.alertField
        
        cell.titleField.text = self.newItem.title
        cell.locationField.text = self.newItem.location
        cell.cancelButton.addTarget(self, action: #selector(EUKAppointmentsViewController.cancelAction), for: .touchUpInside)
        cell.addButton.addTarget(self, action: #selector(EUKAppointmentsViewController.addAction), for: .touchUpInside)
        
        let title = (self.createdItem != nil ? "add" : (self.editingItem != nil ? "done" : "")).localized.uppercased()
        cell.addButton.setTitle(title, for: .normal)
        
        if let date = self.newItem.date, let dateString = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.eeeMMMdyyyyhmma) {
            cell.dayTimeField.text = dateString
        } else {
            cell.dayTimeField.text = nil
        }
        
        if let alertOption = self.newItem.alertOption {
            if alertOption == 0 {
                cell.alertField.text = "none".localized
            } else {
                cell.alertField.text = "\(self.title(row: alertOption).localized) \("before".localized)"
            }
        } else {
            cell.alertField.text = nil
        }
        
        if self.datePicker == nil {
            let datePicker = UIDatePicker()
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            datePicker.datePickerMode = .dateAndTime
            datePicker.addTarget(self, action: #selector(EUKRemindersViewController.datePickerChanged(datePicker:)), for: .valueChanged)
            cell.dayTimeField.inputView = datePicker
            self.datePicker = datePicker
        }
        
        if self.alertPicker == nil {
            let alertPicker = UIPickerView()
            alertPicker.delegate = self
            alertPicker.dataSource = self
            cell.alertField.inputView = alertPicker
            self.alertPicker = alertPicker
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section < self.items.count {
            let appointment = self.items[indexPath.section]
            self.createdItem = nil
            self.editingItem = appointment
            
            self.newItem = Appointment()
            self.newItem.title = appointment.title
            self.newItem.location = appointment.location
            self.newItem.date = appointment.date
            self.newItem.alertOption = appointment.alertOption
        } else {
            self.createdItem = Appointment()
            self.editingItem = nil
            let appointment = Appointment()
            appointment.alertOption = 0
            appointment.date = self.date
            self.newItem = appointment
        }
        
        tableView.reloadData()
    }
}

extension EUKAppointmentsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? 8 : 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (component == 0 ? self.title(row: row) : "before").localized
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.newItem.alertOption = row
            
            if row == 0 {
                self.alertField?.text = "none".localized
            } else {
                self.alertField?.text = "\(self.title(row: row).localized) \("before".localized)"
            }
        }
    }
}
