//
//  EUKExistentAppointmentViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 12/10/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

protocol EUKExistentViewControllerDelegate: AnyObject {
    func appointmentCanceled(appointment: Appointment?)
    func appointmentSaved(appointment: Appointment?)
    func appointmentSelected(appointment: Appointment?)
	func newAppointmentSelected()
	func futurePressed()
}

class EUKExistentAppointmentViewController: EUKBaseViewController {
	@IBOutlet weak var futureButton: EUKBaseButton!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var titleButton: UIButton!
	@IBOutlet weak var newTitleButton: UIButton!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var dayTimeField: UITextField!
    @IBOutlet weak var alertField: UITextField!
    @IBOutlet weak var addButton: EUKBaseButton!
    
    weak var delegate: EUKExistentViewControllerDelegate?
    var datePicker: UIDatePicker?
    var alertPicker: UIPickerView?
    
	var selectedDate: Date?
    var appointment: Appointment?
    var newAppointment = Appointment()
    var isSelected = false
	var isNewAppointment = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUIElements()
    }
    
    //MARK: - IBActions
    
    @IBAction func cancelAction(_ sender: Any) {
        self.delegate?.appointmentCanceled(appointment: self.appointment)
    }
    
    @IBAction func addAction(_ sender: Any) {
        let appointment = self.appointment ?? Appointment()
        appointment.title = self.titleField.text
        appointment.location = self.locationField.text
        appointment.date = DateManager.sharedInstance.date(self.dayTimeField.text ?? "", DateManager.sharedInstance.eeeMMMdyyyyhmma)
        appointment.alertOption = self.newAppointment.alertOption
        appointment.alertShown = nil
		
		if appointment.title?.isEmpty ?? true || appointment.location?.isEmpty ?? true || appointment.date == nil {
			self.showError(message: "appointment_all_fields")
			return
		}
		
        self.appointment = appointment
        self.delegate?.appointmentSaved(appointment: self.appointment)
    }
    
    @IBAction func datePickerChanged(datePicker: UIDatePicker) {
        self.newAppointment.date = datePicker.date
        if let dateString = DateManager.sharedInstance.string(date: datePicker.date, format: DateManager.sharedInstance.eeeMMMdyyyyhmma) {
            self.dayTimeField?.text = dateString
        } else {
            self.dayTimeField?.text = nil
        }
    }
    
    @IBAction func appointmentSelected(_ sender: Any) {
		self.isSelected = !self.isSelected
		self.titleButton.isHidden = self.isSelected
        self.separatorView.isHidden = !self.isSelected
        self.delegate?.appointmentSelected(appointment: self.appointment)
    }
	
	@IBAction func newAppointmentSelected(_ sender: Any) {
		self.delegate?.newAppointmentSelected()
	}
	
	@IBAction func futureAction(_ sender: Any) {
		self.delegate?.futurePressed()
	}
    
    //MARK: - Private
    
    func setUIElements() {
		self.newTitleButton.isHidden = !self.isNewAppointment
		
		self.titleButton.setTitle(self.appointment?.title, for: .normal)
		self.titleButton.isHidden = self.isSelected
		
		if self.isNewAppointment {
			self.separatorView.isHidden = true
		} else {
			self.separatorView.isHidden = !self.isSelected
		}
        
        let datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(EUKExistentAppointmentViewController.datePickerChanged(datePicker:)), for: .valueChanged)
        dayTimeField.inputView = datePicker
        self.datePicker = datePicker
        
        let alertPicker = UIPickerView()
        alertPicker.delegate = self
        alertPicker.dataSource = self
        alertField.inputView = alertPicker
        self.alertPicker = alertPicker
        
        self.titleField.text = self.appointment?.title
        self.locationField.text = self.appointment?.location
		
		let date = self.appointment?.date ?? self.selectedDate ?? Date()
		datePicker.date = date
		self.dayTimeField.text = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.eeeMMMdyyyyhmma)
        
        if let index = self.appointment?.alertOption {
            alertPicker.selectRow(index, inComponent: 0, animated: true)
            
            if index == 0 {
                self.alertField.text = "none".localized
            } else {
                self.alertField.text = "\(self.title(row: index).localized) \("before".localized)"
            }
        }
    }
}

extension EUKExistentAppointmentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
