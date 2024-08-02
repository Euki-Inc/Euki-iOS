//
//  EUKRemindersViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/4/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import UserNotifications

class EUKRemindersViewController: EUKBasePinCheckViewController {
    let NewCellIdentifier = "NewCellIdentifier"
    let AddReminderCellIdentifier = "AddReminderCellIdentifier"
    let SectionHeaderCellIdentifier = "SectionHeaderCellIdentifier"
    let ReminderCellIdentifier = "ReminderCellIdentifier"

    @IBOutlet weak var tableView: UITableView!
    var titleField: UITextField?
    var textField: UITextField?
    var datePicker: UIDatePicker?
    var dateField: UITextField?
    var repeatPicker: UIPickerView?
    var repeatField: UITextField?
    
    var date: Date?
    
    var newItem = ReminderItem()
    var reminderItems = [ReminderItem]()
    
    var createdItem: ReminderItem?
    var editingItem: ReminderItem?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.navigationTitle = "reminders"
        super.viewDidLoad()
		self.setUIElements()
        self.requestItems()
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
        self.newItem.title = self.titleField?.text
        self.newItem.text = self.textField?.text ?? ""
        
		if self.newItem.title?.isEmpty ?? true || self.newItem.text?.isEmpty ?? true || self.newItem.date == nil {
			self.showError(message: "reminder_all_fields")
			return
		}
        
        if let editingItemId = self.editingItem?.id {
            LocalNotificationManager.sharedInstance.deleteNotification(id: editingItemId)
        }
		
		let date = self.newItem.date ?? Date()
		let repeatDays = self.newItem.repeatDays ?? 0
        
        LocalNotificationManager.sharedInstance.createLocalNotification(date: date, repeatDays: repeatDays) { [unowned self] (notificationId) in
            if let notificationId = notificationId {
				if self.createdItem != nil {
					self.reminderItems.append(newItem)
				} else if self.editingItem != nil {
					self.editingItem?.title = self.newItem.title
					self.editingItem?.text = self.newItem.text
					self.editingItem?.date = self.newItem.date
					self.editingItem?.repeatDays = self.newItem.repeatDays
					self.editingItem?.lastAlert = nil
				}
				
                self.newItem.id = notificationId
                self.editingItem?.id = notificationId
                RemindersManager.sharedInstance.saveReminders(reminders: self.reminderItems)
                
                self.editingItem = nil
                self.createdItem = nil
                
                self.tableView.reloadData()
			} else {
				self.showError(message: "no_notifications_enable_error")
			}
        }
    }
	
	@IBAction func doneAction() {
		self.presentingViewController?.dismiss(animated: true)
	}
    
    //MARK: - Private
    
	func setUIElements() {
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done".localized.uppercased(), style: .plain, target: self, action: #selector(EUKRemindersViewController.doneAction))
	}
	
    func requestItems() {
        RemindersManager.sharedInstance.requestReminders { [unowned self] (reminderItems) in
            self.reminderItems = reminderItems
            self.tableView.reloadData()
        }
    }
	
    //MARK: - Public
    
    class func initNavViewController() -> UIViewController {
        let viewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "NavRemindersViewController")
        return viewController
    }
}

extension EUKRemindersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + (self.reminderItems.count == 0 ? 0 : 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? (self.createdItem == nil ? 1 : 2) : self.reminderItems.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.SectionHeaderCellIdentifier) else {
            return nil
        }
        cell.addBorders(edges: [.bottom], color: UIColor.eukiMain, thickness: 0.5)
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: self.NewCellIdentifier, for: indexPath)
                if self.editingItem == nil && self.createdItem != nil {
                    cell.addBorders(edges: [.bottom], color: UIColor.white, thickness: 0.5)
                } else {
                    cell.addBorders(edges: [.bottom], color: UIColor.eukiMain, thickness: 0.5)
                }
                return cell
            }
            
            return self.setupAddReminderCell(tableView:tableView, indexPath:indexPath)
        }
        
        if let editingItem = self.editingItem, let index = self.reminderItems.index(of: editingItem), index == indexPath.row {
            return self.setupAddReminderCell(tableView:tableView, indexPath:indexPath)
        }
        
        return self.setupReminderCell(tableView:tableView, indexPath:indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 65.0
    }
    
    func setupAddReminderCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.AddReminderCellIdentifier, for: indexPath) as? EUKAddReminderTableViewCell else {
            return UITableViewCell()
        }
        
        self.titleField = cell.titleField
        self.textField = cell.textField
        self.dateField = cell.dayTimeField
        self.repeatField = cell.repeatField
        
        cell.titleField.text = self.newItem.title
        cell.textField.text = self.newItem.text
        cell.cancelButton.addTarget(self, action: #selector(EUKRemindersViewController.cancelAction), for: .touchUpInside)
        cell.addButton.addTarget(self, action: #selector(EUKRemindersViewController.addAction), for: .touchUpInside)
        
        let title = (self.createdItem != nil ? "add" : (self.editingItem != nil ? "done" : "")).localized.uppercased()
        cell.addButton.setTitle(title, for: .normal)
        
        if let date = self.newItem.date, let dateString = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.eeeMMMdyyyyhmma) {
            cell.dayTimeField.text = dateString
        } else {
            cell.dayTimeField.text = nil
        }
        
        if let repeatDays = self.newItem.repeatDays {
            if repeatDays == 0 {
                cell.repeatField.text = "none".localized
            } else {
                cell.repeatField.text = String(format: "repeat_format".localized, repeatDays)
            }
        } else {
            cell.repeatField.text = nil
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
        
        if self.repeatPicker == nil {
            let repeatPicker = UIPickerView()
            repeatPicker.delegate = self
            repeatPicker.dataSource = self
            cell.repeatField.inputView = repeatPicker
            self.repeatPicker = repeatPicker
        }
        
        cell.addBorders(edges: [.top], color: indexPath.section == 0 ? UIColor.white : UIColor.eukiMain, thickness: 0.5)
        cell.addBorders(edges: [.bottom], color: UIColor.eukiMain, thickness: 0.5)
        
        return cell
    }
    
    func setupReminderCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.ReminderCellIdentifier, for: indexPath) as? MGSwipeTableCell else {
            return UITableViewCell()
        }
        let reminderItem = self.reminderItems[indexPath.row]
        
        if let titleLabel = cell.contentView.viewWithTag(100) as? UILabel {
            titleLabel.text = reminderItem.title
        }
        
        let deleteButton = MGSwipeButton(title: "delete".localized.uppercased(), backgroundColor: UIColor.eukPurpleClear, padding: 30) { [unowned self] (_) -> Bool in
            let alertViewController = UIAlertController(title: nil, message: "delete_reminder".localized, preferredStyle: .alert)
            alertViewController.view.tintColor = UIColor.eukiAccent
            let cancelAction = UIAlertAction(title: "cancel".localized.uppercased(), style: .destructive, handler: nil)
            let deleteAction = UIAlertAction(title: "delete".localized.uppercased(), style: .default, handler: { [unowned self] (_) in
                let reminder = self.reminderItems[indexPath.row]
                if let reminderId = reminder.id {
                    LocalNotificationManager.sharedInstance.deleteNotification(id: reminderId)
                }
                
                self.reminderItems.remove(at: indexPath.row)
                self.tableView.reloadData()
                RemindersManager.sharedInstance.saveReminders(reminders: self.reminderItems)
            })
            alertViewController.addAction(cancelAction)
            alertViewController.addAction(deleteAction)
            self.present(alertViewController, animated: true, completion: nil)
            return true
        }
        
        deleteButton.setTitleColor(UIColor.eukiAccent, for: .normal)
        deleteButton.addBorders(edges: [.right, .left], color: UIColor.eukiMain, thickness: 0.5)
        cell.rightButtons = [deleteButton]
        
        cell.addBorders(edges: [.top], color: UIColor.eukiMain, thickness: 0.5)
        cell.addBorders(edges: [.bottom], color: indexPath.row == self.reminderItems.count - 1 ? UIColor.eukiMain : UIColor.white, thickness: 0.5)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                self.createdItem = ReminderItem()
                self.editingItem = nil
                let reminderItem = ReminderItem()
                reminderItem.date = self.date
                self.newItem = reminderItem
            }
        } else {
            let reminderItem = self.reminderItems[indexPath.row]
            self.createdItem = nil
            self.editingItem = reminderItem
            
            self.newItem = ReminderItem()
            self.newItem.title = reminderItem.title
            self.newItem.text = reminderItem.text
            self.newItem.date = reminderItem.date
            self.newItem.repeatDays = reminderItem.repeatDays
        }
        
        tableView.reloadData()
    }
}

extension EUKRemindersViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
		if self.newItem.repeatDays == nil {
			self.repeatField?.text = "none".localized
		}
		
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? 31 : 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            if row == 0 {
                return "none".localized
            }
            
            return "\(row)"
        }
        
        return "days".localized.lowercased()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.newItem.repeatDays = row
            
            if row == 0 {
                self.repeatField?.text = "none".localized
            } else {
                self.repeatField?.text = String(format: "repeat_format".localized, row)
            }
        }
    }
}
