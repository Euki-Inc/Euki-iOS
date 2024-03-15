//
//  EUKDailyLogViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/14/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

protocol EUKLogViewDelegate: NSObject {
	func refreshFilterItems(usedItems: [FilterItem], notUsedItems: [FilterItem])
}

class EUKLogViewController: EUKBasePinCheckViewController {
    let SectionCellIdentifier = "SectionCellIdentifier"
    let EmptyCellIdentifier = "EmptyCellIdentifier"
    let FooterCellIdentifier = "FooterCellIdentifier"
    let AppointmentCellIdentifier = "AppointmentCellIdentifier"
    
    enum CellTags: Int {
        case icon = 100,
        title, button, selectionButton, infoButton
    }
    
    @IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var doneButton: EUKBorderedButton!
	
	weak var delegate: EUKLogViewDelegate?
    
    var items = [FilterItem]()
    var usedItems = [FilterItem]()
    var notUsedItems = [FilterItem]()
    var indexSelected = -1
    
    weak var bleedingViewController: EUKBleedingViewController?
    weak var emotionsViewController: EUKEmotionsViewController?
    weak var bodyViewController: EUKBodyViewController?
    weak var sexualActivityViewController: EUKSexualActivityViewController?
    weak var contraceptionViewController: EUKContraceptionViewController?
    weak var testViewController: EUKTestViewController?
    weak var appointmentViewController: EUKAppointmentViewController?
    weak var noteViewController: EUKNoteViewController?
    
    var date: Date?
    var calendarItem: CalendarItem?
    
    var appointments = [Appointment]()
    var appointmentSelectedIndex = -1
    var removedAppointments = [Appointment]()
    
    var isEditingItems = false
	var shouldShowBleedingAlert = false
	var includeCycleSummary = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        if let date = self.calendarItem?.date {
			self.navigationTitle = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.dddMMMMdd)?.capitalized
        }
        if let date = self.date {
			self.navigationTitle = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.dddMMMMdd)?.capitalized
        }
        if let appointments = self.calendarItem?.appointments {
            self.appointments.removeAll()
            self.appointments.append(contentsOf: appointments)
        }
        super.viewDidLoad()
		self.initItems()
        self.initViewControllers()
		self.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 70.0, right: 0.0)
		
		self.shouldShowBleedingAlert = CalendarManager.sharedInstance.shouldShowIncludeCycleAlert(date: self.calendarItem?.date ?? self.date ?? Date())
		self.includeCycleSummary = self.calendarItem?.includeCycleSummary ?? false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestCalendarItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    //MARK: - IBActions
    
    @IBAction func sectionAction(button: UIButton) {
        guard let index = button.superview?.tag else {
            return
        }
        self.sectionAction(index: index)
    }
    
    @IBAction func changeIsEditing() {
        self.indexSelected = -1
        self.isEditingItems = !self.isEditingItems
        self.updateItems()
        self.tableView.isEditing = self.isEditingItems
        self.tableView.reloadData()
    }
    
    @IBAction func selectionAction(button: UIButton) {
        guard let section = button.superview?.tag else {
            return
        }
        let item = self.items[section]

        if let index = self.usedItems.index(of: item) {
            item.isOn = false
            self.usedItems.remove(at: index)
            self.notUsedItems.insert(item, at: 0)
            self.updateItems()
            self.tableView.reloadData()
        } else if let index = self.notUsedItems.index(of: item) {
            item.isOn = true
            self.notUsedItems.remove(at: index)
            self.usedItems.append(item)
            self.updateItems()
            self.tableView.reloadData()
        }
		
		self.refreshCalendarFilter()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        self.save { calendarItem in
			if calendarItem.hasData() {
				LocalDataManager.sharedInstance.addDailyLogCounter()
			}
			
			if let viewController = self.parent {
				viewController.presentingViewController?.dismiss(animated: true)
			} else {
				self.performSegue(withIdentifier: self.DoneSegueIdentifier, sender: nil)
			}
        }
    }
	
	@IBAction func bleedingInfoAction() {
		let viewController = self.alertViewController(title: nil, message: "bleeding_info".localized, okHandler: nil)
		self.present(viewController, animated: true)
	}
    
    //MARK: - Private
    
    func requestCalendarItem() {
        guard let date = self.date else {
            return
        }
        
        CalendarManager.sharedInstance.calendarItem(dateSearch: date) { (calendarItem) in
            self.calendarItem = calendarItem
            
            if let appointments = self.calendarItem?.appointments {
                self.appointments.removeAll()
                for appointment in appointments {
                    if !self.removedAppointments.contains(where: { (removedAppointment) -> Bool in
                        return removedAppointment.id ?? "" == appointment.id ?? ""
                    }) {
                        self.appointments.append(appointment)
                    }
                }
                self.appointmentSelectedIndex = -1
            }
            
			self.updateDoneButton(calendarItem: calendarItem)
            self.tableView.reloadData()
        }
    }
    
    func initItems() {
		let items = LocalDataManager.sharedInstance.filterItems()
		self.usedItems = items.0
		self.notUsedItems = items.1
		
		self.updateItems()
    }
    
    func updateItems() {
        self.items.removeAll()
        self.items.append(contentsOf: self.usedItems)
        
        if self.isEditingItems {
            self.items.append(contentsOf: self.notUsedItems)
        }
    }
    
    func initViewControllers() {
        if let appointmentViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "AppointmentViewController") as? EUKAppointmentViewController {
            appointmentViewController.delegate = self
            self.appointmentViewController = appointmentViewController
        }
    }
	
	func refreshCalendarFilter() {
		self.delegate?.refreshFilterItems(usedItems: self.usedItems, notUsedItems: self.notUsedItems)
	}
    
    func sectionAction(index: Int) {
        if self.isEditingItems {
            return
        }
        
        var indexPath: IndexPath?
        
        if self.indexSelected == index {
            self.indexSelected = -1
        } else {
            self.indexSelected = index
            indexPath = IndexPath(row: 0, section: index)
        }
        self.tableView.reloadData()
        
        if let indexPath = indexPath {
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func save(responseHandler: @escaping (CalendarItem) -> Void) {
		let calendarItem = self.updatedCalendarItem()
        
        CalendarManager.sharedInstance.saveItem(calendarItem: calendarItem) { [unowned self] (success) in
			if calendarItem.bleedingSize != nil {
				CalendarManager.sharedInstance.updateLatestBleedingTracking(date: calendarItem.date)
			}
            self.calendarItem = calendarItem
            responseHandler(calendarItem)
        }
    }
	
	private func updatedCalendarItem() -> CalendarItem {
		var calendarItem: CalendarItem
		
		if let item = self.calendarItem {
			calendarItem = item
		} else {
			calendarItem = CalendarItem()
		}
		
		calendarItem.includeCycleSummary = self.includeCycleSummary
		
		if (calendarItem.note ?? "").isEmpty {
			calendarItem.note = nil
		}
		
		let calendarItemDate = self.date ?? Date()
		calendarItem.date = calendarItemDate
		if let bleedingViewController = self.bleedingViewController {
			calendarItem.bleedingSize = bleedingViewController.size
			
			if !calendarItem.hasPeriod() {
				calendarItem.includeCycleSummary = false
			}
		}
		if let counters = self.bleedingViewController?.clotsCount {
			calendarItem.bleedingClotsCounter = counters
		}
		if let counters = self.bleedingViewController?.productsCount {
			calendarItem.bleedingProductsCounter = counters
		}
		if let emotionsViewController = self.self.emotionsViewController {
			calendarItem.emotions = emotionsViewController.emotion
		}
		if let bodyViewController = self.bodyViewController {
			calendarItem.body = bodyViewController.body
		}
		if let sexualActivityViewController = self.sexualActivityViewController {
			calendarItem.sexualProtectionSTICounter = sexualActivityViewController.sexualProtectionSTICount
			calendarItem.sexualProtectionPregnancyCounter = sexualActivityViewController.sexualProtectionPregnancyCount
			calendarItem.sexualOtherCounter = sexualActivityViewController.sexualProtectionOtherCount
		}
		if let contraceptionViewController = self.contraceptionViewController {
			calendarItem.contraceptionPill = contraceptionViewController.contraceptionPill
			calendarItem.contraceptionDailyOther = contraceptionViewController.contraceptionDailyOthers
			calendarItem.contraceptionIud = contraceptionViewController.contraceptionIUD
			calendarItem.contraceptionImplant = contraceptionViewController.contraceptionImplant
			calendarItem.contraceptionPatch = contraceptionViewController.contraceptionPatch
			calendarItem.contraceptionRing = contraceptionViewController.contraceptionRing
            calendarItem.contraceptionLongTermOther = contraceptionViewController.contraceptionLongTermOthers
			calendarItem.contraceptionShot = contraceptionViewController.contraceptionShot
		}
		if let testViewController = self.testViewController {
			calendarItem.testSTI = testViewController.testSTI
			calendarItem.testPregnancy = testViewController.testPregnancy
		}
		
		if let appointmentViewController = self.appointmentViewController, appointmentViewController.titleField != nil, !(appointmentViewController.titleField.text ?? "").isEmpty, self.appointments.count == 0 {
			let appointment = Appointment()
			appointment.title = appointmentViewController.titleField.text
			appointment.date = self.date
			calendarItem.appointments = [appointment]
		} else {
			calendarItem.appointments = self.appointments
		}
		
		if let noteViewController = self.noteViewController {
			calendarItem.note = noteViewController.hasData() ? noteViewController.note : nil
		}
		
		var allCategories = [FilterItem]()
		allCategories.append(contentsOf: self.usedItems)
		allCategories.append(contentsOf: self.notUsedItems)
		calendarItem.categories = allCategories
		
		return calendarItem
	}
	
	private func updateDoneButton(calendarItem: CalendarItem?) {
		let count = calendarItem?.dataCount() ?? 0
		self.doneButton.localizedKey = String(format: "done_tracking".localized, count)
	}
    
    //MARK: - Public
    
	class func initLogViewController(date: Date?, calendarItem: CalendarItem?) -> UIViewController? {
        if let logViewContoller = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "LogViewControlller") as? EUKLogViewController {
            logViewContoller.date = date
            logViewContoller.calendarItem = calendarItem
            return logViewContoller
        }
        
        return nil
    }
    
}

extension EUKLogViewController: EUKAppointmentViewControllerDelegate {
    func newAppointmentSelected() {
        let newAppointmentIndex = self.appointments.count + 1
        if self.appointmentSelectedIndex == newAppointmentIndex {
            self.appointmentSelectedIndex = -1
        } else {
            self.appointmentSelectedIndex = newAppointmentIndex
        }
        self.tableView.reloadData()
    }
    
    func appointmentAdded(appointment: Appointment) {
        self.appointments.append(appointment)
        self.appointmentSelectedIndex = -1
        self.tableView.reloadData()
    }
    
    func appointmentCanceled() {
        self.appointmentSelectedIndex = -1
        self.tableView.reloadData()
    }
    
    func futurePressed() {
        if let viewController = EUKFutureAppointmentViewController.initViewController(futureDate: nil) {
			viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
}

extension EUKLogViewController: EUKExistentViewControllerDelegate {
    func appointmentSelected(appointment: Appointment?) {
        guard let appointment = appointment else {
            return
        }
        
        if let index = self.appointments.firstIndex(of: appointment) {
            let fixedIndex = index + 1
            if self.appointmentSelectedIndex == fixedIndex {
                self.appointmentSelectedIndex = -1
            } else {
                self.appointmentSelectedIndex = fixedIndex
            }
        }
        
		self.reloadTableView()
		self.updateDoneButton(calendarItem: self.updatedCalendarItem())
    }
    
    func appointmentSaved(appointment: Appointment?) {
        guard let appointment = appointment else {
            return
        }
        
        let index = self.appointmentSelectedIndex - 1
		
		if index >= 0 && index < self.appointments.count {
			let existentAppointment = self.appointments[index]
			appointment.id = existentAppointment.id
			self.appointments[index] = appointment
		} else {
			self.appointments.append(appointment)
		}
        
        self.appointmentSelectedIndex = -1
		self.reloadTableView()
    }
    
    func appointmentCanceled(appointment: Appointment?) {
        self.appointmentSelectedIndex = -1
		self.reloadTableView()
    }
    
    func appointmentRemoved(appointment: Appointment?) {
        let index = self.appointmentSelectedIndex - 1
        
        let appointment = self.appointments[index]
        if let appointmentId = appointment.id {
            LocalNotificationManager.sharedInstance.deleteNotification(id: appointmentId)
        }
        
        self.appointments.remove(at: index)
        self.appointmentSelectedIndex = -1
		self.reloadTableView()
        self.removedAppointments.append(appointment)
    }
	
	func showBleedingAlert() {
		let alertViewController = self.alertViewController(message: "bleeding_tracking_alert_message".localized, showCancel: true, okHandler: { _ in
			self.toggleIncludeCycleSummary()
		}, okTitle: "bleeding_tracking_alert_confirm".localized, cancelTitle: "bleeding_tracking_alert_cancel".localized)
		self.present(alertViewController, animated: true)
	}
	
	func reloadTableView() {
		self.tableView.reloadData()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			self.updateDoneButton(calendarItem: self.updatedCalendarItem())
		}
	}
}

extension EUKLogViewController: EUKContraceptionViewControllerDelegate {
    func sectionChanged() {
        if let index = self.items.index(where: { (filterItem) -> Bool in
            filterItem.title == "contraception"
        }) {
            let indexPath = IndexPath(row: 1, section: index)
            self.tableView.reloadRows(at: [indexPath], with: .fade)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}

extension EUKLogViewController: EUKLogSectionDelegate {
    func selectionUpdated() {
		self.reloadTableView()
    }
}

extension EUKLogViewController: EUKBleedingViewDelegate {
	func toggleIncludeCycleSummary() {
		self.includeCycleSummary = !self.includeCycleSummary
		self.tableView.reloadData()
	}
	
	func sizeChanged(size: BleedingSize?) {
		if self.includeCycleSummary {
			self.shouldShowBleedingAlert = false
		}
		
		if size != nil && self.shouldShowBleedingAlert {
			self.shouldShowBleedingAlert = false
			self.showBleedingAlert()
		}
	}
}
