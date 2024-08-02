//
//  EUKAppointmentViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/15/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

protocol EUKAppointmentViewControllerDelegate: AnyObject {
    func appointmentCanceled()
    func futurePressed()
    func appointmentAdded(appointment: Appointment)
    func newAppointmentSelected()
}

class EUKAppointmentViewController: UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var futureButton: EUKBaseButton!
    @IBOutlet weak var addButton: EUKBaseButton!
    @IBOutlet weak var topNewButton: EUKBaseButton!
    @IBOutlet weak var bottomButtonsContainerView: UIStackView!
    
    var sectionDelegate: EUKLogSectionDelegate?
    weak var delegate: EUKAppointmentViewControllerDelegate?
    var date: Date?
    var isUniqueAppointment = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
        self.validateFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUIElements()
        self.validateFields()
        self.updateUIElements()
    }

    //MARK: - IBActions
    
    @IBAction func futureAction(_ sender: Any) {
        self.delegate?.futurePressed()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.delegate?.appointmentCanceled()
    }
    
    @IBAction func addAction(_ sender: Any) {
        let appointment = Appointment()
        appointment.title = self.titleField.text
        appointment.date = self.date
        appointment.id = UUID().uuidString
        self.titleField.text = nil
        self.delegate?.appointmentAdded(appointment: appointment)
    }
    
    @IBAction func newAppointmentSelected(_ sender: Any) {
        self.delegate?.newAppointmentSelected()
    }
    
    //MARK: - Private
    
    func setUIElements() {
        self.titleField.delegate = self
        self.titleField.addTarget(self, action: #selector(EUKAppointmentViewController.validateFields), for: .editingChanged)
    }
    
    func updateUIElements() {
        self.topNewButton.isHidden = self.isUniqueAppointment
        self.bottomButtonsContainerView.isHidden = self.isUniqueAppointment
    }
    
    @objc func validateFields() {
        self.addButton.isEnabled = !(self.titleField.text?.isEmpty ?? true)
    }
}

extension EUKAppointmentViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.sectionDelegate?.selectionUpdated()
    }
}
