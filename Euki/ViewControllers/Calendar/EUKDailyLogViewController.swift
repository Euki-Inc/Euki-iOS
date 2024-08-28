//
//  EUKDailyLogViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/4/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKDailyLogViewController: EUKBasePinCheckViewController {
    static let ViewControllerId = "DailyLogViewController"
    let HeaderReusableCellIdentifier = "HeaderReusableCellIdentifier"
    let SelectCollectionViewCell = "SelectCollectionViewCell"
    let TextCollectionViewCell = "TextCollectionViewCell"
    
    enum CellTags: Int {
        case circleView = 100, title, selectButton
    }

    @IBOutlet weak var colletionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noEntriesPastView: UIView!
    @IBOutlet weak var noEntriesFutureView: UIView!
    @IBOutlet weak var futureActionsContainerView: UIView!
    @IBOutlet weak var collectionViewContainerView: UIStackView!
    
    var date: Date?
    var calendarItem: CalendarItem?
    var items = [(FilterItem, Any)]()
    var showTitle = true
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestCalendarItem()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let navViewController = segue.destination as? UINavigationController, let remindersViewController = navViewController.viewControllers.first as? EUKRemindersViewController {
            if let date = self.date {
                let now = Date()
                let hours = Calendar.current.component(.hour, from: now)
                let minutes = Calendar.current.component(.minute, from: now)
                let seconds = Calendar.current.component(.second, from: now)
                let newDate = Calendar.current.date(bySettingHour: hours, minute: minutes, second: seconds, of: date)
                remindersViewController.date = newDate
            }
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func logNowAction(_ sender: Any) {
        if let viewController = EUKTrackViewController.initViewController(date: self.date, calendarItem: self.calendarItem) {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func editAction(_ sender: Any) {
        if let viewController = EUKTrackViewController.initViewController(date: self.date, calendarItem: self.calendarItem) {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func addAppointmetAction(_ sender: Any) {
        if self.calendarItem?.appointments.count ?? 0 == 0{
            if let viewController = EUKFutureAppointmentViewController.initViewController(futureDate: self.date) {
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            }
        } else {
            if let viewController = EUKAppointmentsViewController.initNavViewController(date: self.date) {
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    override func done(segue: UIStoryboardSegue) {
        super.done(segue: segue)
        
        if let trackViewController = segue.source as? EUKTrackViewController {
            self.calendarItem = trackViewController.calendarItem
            self.setUIElements()
        }
    }
    
    //MARK: - Private
    
    func requestCalendarItem() {
        guard let date = self.date else {
            return
        }
        
        CalendarManager.sharedInstance.calendarItem(dateSearch: date) { (calendarItem) in
            self.calendarItem = calendarItem
            self.setUIElements()
        }
    }
    
    func createCollectionItems() {
        guard let calendarItem = self.calendarItem else {
            return
        }
        
        var items = [(FilterItem, Any)]()
        
        for index in 0 ... 7 {
            var filterItem: FilterItem
            var selectItems = [SelectItem]()
            var text: String?
            switch index {
            case 0:
                filterItem = FilterItem(color: UIColor.eukBleeding, title: "bleeding", isOn: false)
                if let bleedingSize = calendarItem.bleedingSize {
                    selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: bleedingSize), title: ConstansManager.sharedInstance.text(for: bleedingSize)))
                }
				for (index, value) in calendarItem.bleedingClotsCounter.enumerated() {
					if value > 0 {
						if let bleedingClot = BleedingClot(rawValue: index) {
							let selectItem = SelectItem(imageName: ConstansManager.sharedInstance.image(for: bleedingClot), title: ConstansManager.sharedInstance.text(for: bleedingClot))
							selectItem.count = value
							selectItems.append(selectItem)
						}
					}
				}
                
                
                let indexes = bleedingProductsUIOrder.compactMap{$0.rawValue}
                for index in indexes{
                    if index < calendarItem.bleedingProductsCounter.count{
                        let value = calendarItem.bleedingProductsCounter[index]
                        if value > 0, let bleedingProduct = BleedingProducts(rawValue: index) {
                            let selectItem = SelectItem(imageName: ConstansManager.sharedInstance.image(for: bleedingProduct), title: ConstansManager.sharedInstance.text(for: bleedingProduct))
                            selectItem.count = value
                            selectItems.append(selectItem)
                        }
                    }
                }
            case 1:
                filterItem = FilterItem(color: UIColor.eukEmotions, title: "emotions", isOn: false)
                for emotion in calendarItem.emotions {
                    selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: emotion), title: ConstansManager.sharedInstance.text(for: emotion)))
                }
            case 2:
                filterItem = FilterItem(color: UIColor.eukBody, title: "body", isOn: false)
                for body in calendarItem.body {
                    if body == .stomachache {
                        selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: body), title: "body_12_break".localized))
                    } else {
                        selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: body), title: ConstansManager.sharedInstance.text(for: body)))
                    }
                }
            case 3:
                filterItem = FilterItem(color: UIColor.eukSexualActivity, title: "sexual_activity", isOn: false)
                for (index, value) in calendarItem.sexualProtectionSTICounter.enumerated() {
                    if value > 0 {
                        if let sexualActivity = SexualProtectionSTI(rawValue: index) {
                            let selectItem = SelectItem(imageName: ConstansManager.sharedInstance.image(for: sexualActivity), title: ConstansManager.sharedInstance.textList(for: sexualActivity))
                            selectItem.count = value
                            selectItems.append(selectItem)
                        }
                    }
                }
                for (index, value) in calendarItem.sexualProtectionPregnancyCounter.enumerated() {
                    if value > 0 {
                        if let sexualActivity = SexualProtectionPregnancy(rawValue: index) {
                            let selectItem = SelectItem(imageName: ConstansManager.sharedInstance.image(for: sexualActivity), title: ConstansManager.sharedInstance.textList(for: sexualActivity))
                            selectItem.count = value
                            selectItems.append(selectItem)
                        }
                    }
                }
                for (index, value) in calendarItem.sexualOtherCounter.enumerated() {
                    if value > 0 {
                        if let sexualActivity = SexualProtectionOther(rawValue: index) {
                            let selectItem = SelectItem(imageName: ConstansManager.sharedInstance.image(for: sexualActivity), title: ConstansManager.sharedInstance.text(for: sexualActivity))
                            selectItem.count = value
                            selectItems.append(selectItem)
                        }
                    }
                }
            case 4:
                filterItem = FilterItem(color: UIColor.eukContraception, title: "contraception", isOn: false)
                if let contraception = calendarItem.contraceptionIud {
                    selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.textList(for: contraception)))
                }
                if let contraception = calendarItem.contraceptionPill {
                    selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.textList(for: contraception)))
                }
                if let contraception = calendarItem.contraceptionRing {
                    selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.textList(for: contraception)))
                }
                if let contraception = calendarItem.contraceptionShot {
                    selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.textList(for: contraception)))
                }
                if let contraception = calendarItem.contraceptionPatch {
                    selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.textList(for: contraception)))
                }
                if let contraception = calendarItem.contraceptionImplant {
                    selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.textList(for: contraception)))
                }
                for contraception in calendarItem.contraceptionDailyOther {
                    selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.text(for: contraception)))
                }
                for contraception in calendarItem.contraceptionLongTermOther {
                    selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: contraception), title: ConstansManager.sharedInstance.text(for: contraception)))
                }
            case 5:
                filterItem = FilterItem(color: UIColor.eukTest, title: "test", isOn: false)
                if let test = calendarItem.testSTI {
                    selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: test), title: ConstansManager.sharedInstance.textList(for: test)))
                }
                if let test = calendarItem.testPregnancy {
                    selectItems.append(SelectItem(imageName: ConstansManager.sharedInstance.image(for: test), title: ConstansManager.sharedInstance.textList(for: test)))
                }
            case 6:
                filterItem = FilterItem(color: UIColor.eukAppointment, title: "appointment", isOn: false)
                
                var appointmentsText = ""
                for appointment in calendarItem.appointments {
                    var text = ""
                    
                    if let title = appointment.title {
                        text = title
                    }
                    if let location = appointment.location {
                        text = "\(text) - \(location)"
                    }
                    if let date = appointment.date, let dateString = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.TimeFormat) {
                        if dateString != "12:00AM" {
                            text = "\(text) (\(dateString))"
                        }
                    }
                    
                    if !appointmentsText.isEmpty {
                        appointmentsText = "\(appointmentsText)\n\n"
                    }
                    appointmentsText = "\(appointmentsText)\(text)"
                }
                
                text = appointmentsText
            case 7:
                filterItem = FilterItem(color: UIColor.eukNote, title: "note", isOn: false)
                if let note = calendarItem.note {
                    text = note
                }
            default:
                filterItem = FilterItem()
            }
            
            if let text = text, !text.isEmpty {
                items.append((filterItem, text))
            } else if selectItems.count > 0 {
                items.append((filterItem, selectItems))
            }
        }
        
        self.items.removeAll()
        self.items.append(contentsOf: items)
        self.colletionView.reloadData()
    }
    
    func setUIElements() {
		self.navigationController?.navigationBar.tintColor = UIColor.eukiAccent
		
        self.dateLabel.isHidden = !self.showTitle
        
        var isFutureDate = false
        
        if let date = self.date, let dateString = DateManager.sharedInstance.string(date: date, format: DateManager.sharedInstance.dddMMMMdd) {
			self.dateLabel.text = dateString.capitalized
            
            if Date().daysDiff(date: date) < 0 || Calendar.current.isDateInToday(date) {
                isFutureDate = false
                self.noEntriesPastView.isHidden = false
                self.noEntriesFutureView.isHidden = true
            } else {
                isFutureDate = true
                self.noEntriesPastView.isHidden = true
                self.noEntriesFutureView.isHidden = false
            }
        }
        
        if self.calendarItem?.hasData() ?? false && !isFutureDate {
            let editNavItem = UIBarButtonItem(title: "edit".localized.uppercased(), style: .done, target: self, action: #selector(EUKDailyLogViewController.editAction(_:)))
			editNavItem.tintColor = UIColor.eukiMain
            self.navigationItem.rightBarButtonItem = editNavItem
        }
        
        self.collectionViewContainerView.isHidden = true
        
        if let calendarItem = self.calendarItem, calendarItem.hasData() {
            self.noEntriesPastView.isHidden = true
            self.noEntriesFutureView.isHidden = true
            self.collectionViewContainerView.isHidden = false
            self.createCollectionItems()
            self.futureActionsContainerView.isHidden = !isFutureDate
        }
    }
    
    //MARK: - Public
    
    class func initViewController(date: Date, showTitle: Bool = true) -> EUKDailyLogViewController? {
        if let dailyViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: EUKDailyLogViewController.ViewControllerId) as? EUKDailyLogViewController {
            dailyViewController.date = date
            dailyViewController.showTitle = showTitle
            dailyViewController.modalPresentationStyle = .fullScreen
            return dailyViewController
        }
        
        return nil
    }

}

extension EUKDailyLogViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let anyObject = self.items[section].1
        if let _ = anyObject as? String {
            return 1
        }
        if let array = anyObject as? [SelectItem] {
            return array.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let anyObject = self.items[indexPath.section].1
        
        if let text = anyObject as? String {
            return self.configureCellText(collectionView, cellForItemAt: indexPath, text: text)
        }
        
        if let selectItems = anyObject as? [SelectItem] {
            let selectItem = selectItems[indexPath.row]
            return self.configureCellSelectItem(collectionView, cellForItemAt: indexPath, selectItem: selectItem)
        }
        
        return UICollectionViewCell()
    }
    
    func configureCellText(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, text: String) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.TextCollectionViewCell, for: indexPath)
        
        if let titleLabel = cell.contentView.viewWithTag(CellTags.title.rawValue) as? UILabel {
            titleLabel.text = text
        }
        
        return cell
    }
    
    func configureCellSelectItem(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, selectItem: SelectItem) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.SelectCollectionViewCell, for: indexPath)
        
        if let selectButton = cell.contentView.viewWithTag(CellTags.selectButton.rawValue) as? EUKSelectButton {
            selectButton.isUserInteractionEnabled = false
            selectButton.image = UIImage(named: selectItem.imageName)
            selectButton.localizedKey = selectItem.title
            selectButton.countLabel.text = "\(selectItem.count)"
            selectButton.countContainerView.isHidden = selectItem.count == 0
            selectButton.borderColor = UIColor.eukGreenClear
            selectButton.button.backgroundColor = UIColor.eukGreenClear
            selectButton.borderContainerView.layer.borderColor = UIColor.eukGreenClear.cgColor
            selectButton.borderContainerView.layer.borderWidth = 0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = colletionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.HeaderReusableCellIdentifier, for: indexPath)
            let filterItem = self.items[indexPath.section].0
            
            if let roundedView = headerView.viewWithTag(CellTags.circleView.rawValue) as? EUKRoundedView {
                roundedView.backgroundColor = filterItem.color
            }
            if let titleLabel = headerView.viewWithTag(CellTags.title.rawValue) as? UILabel {
                titleLabel.text = filterItem.title.localized
            }
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let anyObject = self.items[indexPath.section].1
        if let text = anyObject as? String {
			let cellWidth = collectionView.bounds.width
			
			let label = UILabel()
			label.text = text
			label.numberOfLines = 0
			label.lineBreakMode = .byWordWrapping
			
			let labelSize = label.sizeThatFits(CGSizeMake(cellWidth, CGFloat.greatestFiniteMagnitude))
			let labelHeight = labelSize.height
			
			let cellHeight = labelHeight + 20
			
			return CGSizeMake(cellWidth, cellHeight)
        }
        if let _ = anyObject as? [SelectItem] {
            var size = collectionView.bounds.size
            size.width = size.width / 3
            size.height = size.width
            return size
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.editAction(collectionView)
    }
}
