//
//  EUKTopSettingsViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 11/26/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import RangeSeekSlider

protocol TopSettingsDelegate: AnyObject {
    func heightUpdated()
}

class EUKTopSettingsViewController: EUKBaseViewController {
    static let ViewControllerID = "TopSettingsViewController"
    
    @IBOutlet weak var recurringSwitch: UISwitch!
    @IBOutlet weak var recurringLabel: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var recurringContainer: UIStackView!
    @IBOutlet weak var recurringRangeSlider: RangeSeekSlider!
    @IBOutlet weak var setPinButton: EUKBaseButton!
    @IBOutlet weak var removePinContainerView: UIStackView!
    
    weak var delegate: TopSettingsDelegate?
    var calculatedHeight: CGFloat = 1000.0
    var recurringCounter = 5

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updatePinOptions()
    }

    //MARK: - IBActions
    
    @IBAction func recurringSwitchAction(_ sender: Any) {
        if self.recurringSwitch.isOn {
            let alertController = self.alertViewController(title: nil, message: "weekly_recurring_info".localized, showCancel: true, okHandler: { [unowned self] (_) in
                LocalDataManager.sharedInstance.saveRecurringDataRemoval(type: .weekly)
                self.updateUIElements()
            }) { [unowned self] (_) in
                self.updateUIElements()
            }
            self.present(alertController, animated: true, completion: nil)
        } else {
            LocalDataManager.sharedInstance.saveRecurringDataRemoval(type: nil)
            self.updateUIElements()
        }
    }
    
    @IBAction func deleteAllAction(_ sender: Any) {
        let alertController = self.alertViewController(title: nil, message: "confirm_delete_all_now".localized, showCancel: true) { [unowned self] (_) in
            self.deleteAll()
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func passwordAction(_ sender: Any) {
    }
    
    @IBAction func removePinAction(_ sender: Any) {
        let alertController = self.alertViewController(title: nil, message: "confirm_remove_pin".localized, showCancel: true) { [unowned self] (_) in
            LocalDataManager.sharedInstance.savePincode(pinCode: nil)
            self.updatePinOptions()
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Private
    
    func setUIElements() {
        self.recurringRangeSlider.maxValue = CGFloat(recurringCounter)
        self.recurringRangeSlider.delegate = self
        self.updateUIElements()
    }
    
    func updateUIElements() {
        self.recurringLabel.text = self.title(type: LocalDataManager.sharedInstance.recurringDataRemoval())
        let recurringType = LocalDataManager.sharedInstance.recurringDataRemoval()
        self.recurringSwitch.isOn = recurringType != nil
        self.recurringContainer.isHidden = !self.recurringSwitch.isOn
        self.mainStackView.layoutIfNeeded()
        self.calculatedHeight = self.mainStackView.frame.height
        self.delegate?.heightUpdated()
        
        self.recurringRangeSlider.selectedMaxValue = CGFloat(recurringType?.rawValue ?? 1)
        self.recurringRangeSlider.maxValue = CGFloat(self.recurringCounter)
    }
    
    func updatePinOptions() {
        let hasPinCode = LocalDataManager.sharedInstance.pinCode() != nil
        let title = (hasPinCode ? "reset_pin" : "set_pin").localized
        self.setPinButton.setTitle(title, for: .normal)
        self.removePinContainerView.isHidden = !hasPinCode
    }
    
    func changeRecurringType(index: Int) {
        let type = LocalDataManager.RecurringType(rawValue: index)
        LocalDataManager.sharedInstance.saveRecurringDataRemoval(type: type)
        self.updateUIElements()
    }
    
    func deleteAll() {
        PrivacyManager.sharedInstance.removeAllData()
    }
    
    func title(index: Int) -> String {
        let type = LocalDataManager.RecurringType(rawValue: index)
        return self.title(type: type)
    }
    
    func title(type: LocalDataManager.RecurringType?) -> String {
        var title = " "
        if let type = type {
            switch type {
            case .weekly:
                title = "weekly".localized
            case .weekly2:
                title = "weekly_2".localized
            case .monthly:
                title = "monthly".localized
            case .monthly3:
                title = "monthly_3".localized
            case .yearly:
                title = "yearly".localized
            }
        }
        return title
    }
    
    //MARK: - Public
    
    class func initViewController() -> EUKTopSettingsViewController? {
        if let viewController = UIStoryboard(name: "Settings", bundle: Bundle.main).instantiateViewController(withIdentifier: self.ViewControllerID) as? EUKTopSettingsViewController {
            return viewController
        }
        return nil
    }
}

extension EUKTopSettingsViewController: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        self.recurringLabel.text = self.title(index: Int(maxValue))
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        let index = Int(slider.selectedMaxValue)
        
        guard let recurringType = LocalDataManager.RecurringType(rawValue: index), let currentRecurringType = LocalDataManager.sharedInstance.recurringDataRemoval() else {
            return
        }
        
        if recurringType == currentRecurringType {
            return
        }
        
        self.changeRecurringType(index: recurringType.rawValue)
    }
}
