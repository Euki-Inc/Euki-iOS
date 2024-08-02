//
//  EUKFutureAppointmentViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 12/9/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKFutureAppointmentViewController: EUKBasePinCheckViewController {
    static let ViewControllerID = "FutureViewController"
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var dayTimeField: UITextField!
    @IBOutlet weak var alertField: UITextField!
    @IBOutlet weak var addButton: EUKBaseButton!
    
    var datePicker: UIDatePicker?
    var alertPicker: UIPickerView?
    var newAppointment = Appointment()
    var futureDate: Date?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
    }
    
    //MARK: - IBActions
    
    @IBAction func addAction(_ sender: Any) {
        self.newAppointment.title = self.titleField.text
        self.newAppointment.location = self.locationField.text
        
        if self.newAppointment.date == nil {
            self.newAppointment.date = Date()
        }
		
		if self.newAppointment.title?.isEmpty ?? true || self.newAppointment.location?.isEmpty ?? true || self.newAppointment.date == nil {
			self.showError(message: "appointment_all_fields")
			return
		}
        
        self.showLoading()
        CalendarManager.sharedInstance.saveItem(appointment: newAppointment) { [unowned self] (success) in
            self.dismissLoading()
            let alertController = self.alertViewController(title: nil, message: "future_appointment_confirmation".localized, okHandler: { [unowned self] (_) in
                self.performSegue(withIdentifier: self.DoneSegueIdentifier, sender: nil)
            })
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func datePickerChanged(datePicker: UIDatePicker) {
        self.newAppointment.date = datePicker.date
        if let dateString = DateManager.sharedInstance.string(date: datePicker.date, format: DateManager.sharedInstance.eeeMMMdyyyyhmma) {
            self.dayTimeField?.text = dateString
        } else {
            self.dayTimeField?.text = nil
        }
    }
	
	@IBAction func doneAction() {
		self.presentingViewController?.dismiss(animated: true)
	}
	
	//MARK: - Private
    
    func setUIElements() {
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done".localized.uppercased(), style: .plain, target: self, action: #selector(EUKFutureAppointmentViewController.doneAction))
		
        let datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(EUKFutureAppointmentViewController.datePickerChanged(datePicker:)), for: .valueChanged)
        dayTimeField.inputView = datePicker
        self.datePicker = datePicker
        
        let alertPicker = UIPickerView()
        alertPicker.delegate = self
        alertPicker.dataSource = self
        alertField.inputView = alertPicker
        self.alertPicker = alertPicker
        
        if let date = self.futureDate {
            newAppointment.date = date
            datePicker.date = date
            self.dayTimeField.text = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.eeeMMMdyyyyhmma)
        }
    }
    
    class func initViewController(futureDate: Date?) -> UIViewController? {
        if let viewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: self.ViewControllerID) as? EUKFutureAppointmentViewController {
            viewController.futureDate = futureDate
            let navViewController = UINavigationController(rootViewController: viewController)
            return navViewController
        }
        return nil
    }

}

extension EUKFutureAppointmentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
		if self.newAppointment.alertOption == nil {
			self.alertField?.text = "none".localized
		}
		
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
            self.newAppointment.alertOption = row
            
            if row == 0 {
                self.alertField?.text = "none".localized
            } else {
                self.alertField?.text = "\(self.title(row: row).localized) \("before".localized)"
            }
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
}
