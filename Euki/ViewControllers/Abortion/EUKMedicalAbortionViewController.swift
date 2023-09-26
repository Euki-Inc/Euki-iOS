//
//  EUKMedcalAbortionViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 12/4/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKMedicalAbortionViewController: EUKBasePinCheckViewController {
    static let ViewControllerID = "MedicalAbortion"
    
    @IBOutlet weak var firstDayInfoButton: UIButton!
    @IBOutlet weak var firstDayInfoTextView: EUKTextView!
    @IBOutlet weak var dateLabel: EUKLabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var pregnantTextView: UITextView!
    @IBOutlet weak var pillOptionsButton: UIButton!
    @IBOutlet weak var pillOptionsInfoTextView: EUKTextView!
    @IBOutlet weak var pillOptionsContainerView: UIStackView!
    
    var datePicker: UIDatePicker?
    var weeksPregnant = 0
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - IBActions
    
    override func addBookmarkAction() {
        BookmarksManager.sharedInstance.addBookmark(contentItemId: EUKMedicalAbortionViewController.ViewControllerID)
        self.showBookmarkButton()
    }
    
    override func removeBookmarkAction() {
        BookmarksManager.sharedInstance.removeBookmark(contentItemId: EUKMedicalAbortionViewController.ViewControllerID)
        self.showBookmarkButton()
    }
    
    @IBAction func firstDayAction(_ sender: Any) {
        self.firstDayInfoTextView.isHidden = !self.firstDayInfoTextView.isHidden
        self.firstDayInfoButton.setImage(UIImage(named: self.firstDayInfoTextView.isHidden ? "ButtonInfoBlueOff" : "ButtonInfoBlueOn"), for: .normal)
    }
    
    @IBAction func pickDateAction(_ sender: Any) {
        self.dateTextField.becomeFirstResponder()
    }
    
    @IBAction func pillOptionsAction(_ sender: Any) {
        self.pillOptionsInfoTextView.isHidden = !self.pillOptionsInfoTextView.isHidden
        self.pillOptionsButton.setImage(UIImage(named: self.pillOptionsInfoTextView.isHidden ? "ButtonInfoBlueOff" : "ButtonInfoBlueOn"), for: .normal)
    }
    
    @IBAction func misoprostolAction(_ sender: Any) {
        if self.weeksPregnant <= 12 {
            let contentItem = AbortionContentManager.sharedInstance.abortionMiso12()
            self.pushContentItem(contentItem: contentItem)
        } else {
            self.showAbortionAfter12WeeksAlert()
        }
    }
    
    @IBAction func mifemisoAction(_ sender: Any) {
        if self.weeksPregnant <= 12 {
            let contentItem = AbortionContentManager.sharedInstance.abortionMifeMiso12()
            self.pushContentItem(contentItem: contentItem)
        } else {
            self.showAbortionAfter12WeeksAlert()
        }
    }
    
    @IBAction func dateChanged(_ picker: UIDatePicker) {
        self.dateLabel.alpha = 1.0
        self.dateLabel.text = DateManager.sharedInstance.string(date: picker.date, format: DateManager.sharedInstance.DateLongFormat)
        self.pillOptionsContainerView.isHidden = false
        
        let days = picker.date.daysDiff(date: Date())
        let weeks = days / 7
        self.weeksPregnant = weeks
        
        self.pregnantTextView.text = String(format: "weeks_pregnand_format".localized, weeks)
        self.pregnantTextView.isHidden = false
    }
    
    //MARK: - Private
    
    override func showBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "medicines".localized, style: .plain, target: nil, action: nil)
    }
    
    override func showBookmarkButton() {
        let bookmarkButtonItem = BookmarksManager.sharedInstance.isBookmark(contentItemId: EUKMedicalAbortionViewController.ViewControllerID) ? self.bookmarkButtonOnItem : self.bookmarkButtonOffItem
        self.navigationItem.rightBarButtonItem = bookmarkButtonItem
    }
    
    func setUIElements() {
        self.firstDayInfoTextView.isHidden = true
        self.pregnantTextView.isHidden = true
        self.pillOptionsContainerView.isHidden = true
        self.pillOptionsInfoTextView.isHidden = true
        
        let datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.date = Date()
        datePicker.addTarget(self, action: #selector(EUKMedicalAbortionViewController.dateChanged(_:)), for: .valueChanged)
        self.dateTextField.inputView = datePicker
        self.dateTextField.isHidden = false
        self.dateTextField.delegate = self
        self.datePicker = datePicker
    }
    
    func showAbortionAfter12WeeksAlert() {
        let alertController = UIAlertController(title: nil, message: "abortion_over_12_weeks".localized, preferredStyle: .alert)
        alertController.view.tintColor = UIColor.eukiMain
        let cancelAction = UIAlertAction(title: "cancel".localized.uppercased(), style: .destructive, handler: nil)
        let okAction = UIAlertAction(title: "visit_website".localized, style: .default) { (_) in
            self.showURL(string: "https://www.who.int/publications/i/item/9789240039483")
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func pushContentItem(contentItem: ContentItem?) {
        if let viewController = EUKAbortionInfoViewController.initViewController(), let contentItem = contentItem {
            viewController.contentItem = contentItem
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    class func contentItem() -> ContentItem {
        let contentItem = ContentItem(id: "medical_abortion")
        contentItem.content = "medical_abortion_content"
        return contentItem
    }
    
    //MARK: - Public
    
    class func initViewController() -> UIViewController {
        return UIStoryboard(name: "Abortion", bundle: Bundle.main).instantiateViewController(withIdentifier: self.ViewControllerID)
    }

}

extension EUKMedicalAbortionViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.weeksPregnant > 12 {
            self.showAbortionAfter12WeeksAlert()
        }
    }
}
