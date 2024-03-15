//
//  EUKDailyLogViewController+TableView.swift
//  Euki
//
//  Created by Víctor Chávez on 7/6/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

extension EUKLogViewController: UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		return self.items.count + 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section < self.items.count && section == self.indexSelected && self.items[section].title == "appointment" {
			if self.appointments.count == 0 {
				return 2
			}
			return self.appointments.count + 2
		}
		return section == self.indexSelected ? 2 : 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: UITableViewCell
		
		if indexPath.section == self.items.count {
			cell = tableView.dequeueReusableCell(withIdentifier: self.FooterCellIdentifier, for: indexPath)
			
			if let button = cell.contentView.viewWithTag(100) as? UIButton {
				button.setTitle(self.isEditingItems ? "done".localized.uppercased() : "edit_categories".localized.uppercased(), for: .normal)
				button.addTarget(self, action: #selector(EUKLogViewController.changeIsEditing), for: .touchUpInside)
			}
		} else if indexPath.row == 0 {
			cell = tableView.dequeueReusableCell(withIdentifier: self.SectionCellIdentifier, for: indexPath)
			self.configureHeaderCell(cell: cell, indexPath: indexPath)
		} else {
			cell = tableView.dequeueReusableCell(withIdentifier: self.EmptyCellIdentifier, for: indexPath)
			self.configureCell(cell: cell, indexPath: indexPath)
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return 84.0
		}
		if indexPath.section == self.indexSelected {
			return self.rowHeight(indexPath: indexPath)
		}
		return 0.0
	}
	
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == self.items.count {
			return 150.0
		}
		if indexPath.row == 0 {
			return 84.0
		}
		if indexPath.section == self.indexSelected {
			return self.rowHeight(indexPath: indexPath)
		}
		return 0.0
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
		return .none
	}
	
	func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
		return false
	}
	
	func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
		return indexPath.section < self.usedItems.count
	}
	
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		if destinationIndexPath.section >= self.usedItems.count {
			self.tableView.reloadData()
			return
		}
		let movedItem = self.items[sourceIndexPath.section]
		self.usedItems.remove(at: sourceIndexPath.section)
		self.usedItems.insert(movedItem, at: destinationIndexPath.section)
		
		self.delegate?.refreshFilterItems(usedItems: self.usedItems, notUsedItems: self.notUsedItems)
		self.updateItems()
	}
}

extension EUKLogViewController {
	func rowHeight(indexPath: IndexPath) -> CGFloat {
		let section = indexPath.section
		let filterItem = self.items[section]
		if section == self.indexSelected {
			switch (filterItem.title) {
			case "bleeding":
				return self.bleedingViewController?.size != nil ? 810.0 : 760.0
			case "emotions":
				return 420.0
			case "body":
				return 700.0
			case "sexual_activity":
				return 660.0
			case "contraception":
				if let indexSelected = self.contraceptionViewController?.indexSelected {
					return indexSelected == 0 ? 960.0 : 1050.0
				}
				return 168.0
			case "test":
				return 340.0
			case "appointment":
				if indexPath.row == self.appointmentSelectedIndex {
					if indexPath.row - 1 < self.appointments.count {
						return 450.0
					}
					return 557.0
				}
				if self.appointments.count == 0 {
					return 450.0
				}
				return 84.0
			case "note":
				return 100.0
			default:
				return 0.0
			}
		}
		return 0.0
	}
	
	func configureHeaderCell(cell: UITableViewCell, indexPath: IndexPath) {
		let section = indexPath.section
		let filterItem = self.items[section]
		
		let hasData: Bool
		var isBleeding = false
		switch (filterItem.title) {
		case "bleeding":
			hasData = self.bleedingViewController?.hasData() ?? self.calendarItem?.hasBleeding() ?? false
			isBleeding = true
		case "emotions":
			hasData = self.emotionsViewController?.hasData() ?? self.calendarItem?.hasEmotions() ?? false
		case "body":
			hasData = self.bodyViewController?.hasData() ?? self.calendarItem?.hasBody() ?? false
		case "sexual_activity":
			hasData = self.sexualActivityViewController?.hasData() ?? self.calendarItem?.hasSexualActivity() ?? false
		case "contraception":
			hasData = self.contraceptionViewController?.hasData() ?? self.calendarItem?.hasContraception() ?? false
		case "test":
			hasData = self.testViewController?.hasData() ?? self.calendarItem?.hasTest() ?? false
		case "appointment":
			if let appointmentViewController = self.appointmentViewController, appointmentViewController.titleField != nil, !(appointmentViewController.titleField.text ?? "").isEmpty, self.appointments.count == 0 {
				hasData = true
			} else {
				hasData = self.appointments.count > 0
			}
		case "note":
			hasData = self.noteViewController?.hasData() ?? self.calendarItem?.hasNote() ?? false
		default:
			hasData = false
		}
		
		cell.contentView.backgroundColor = filterItem.isOn ? UIColor.white : UIColor.eukGreenClear
		
		if let roundedView = cell.contentView.viewWithTag(CellTags.icon.rawValue) as? EUKRoundedView{
			roundedView.layer.borderColor = filterItem.color.cgColor
			roundedView.layer.borderWidth = 1.0
			roundedView.backgroundColor = hasData ? filterItem.color : UIColor.white
		}
		if let titleLabel = cell.contentView.viewWithTag(CellTags.title.rawValue) as? UILabel {
			titleLabel.text = filterItem.title.localized
		}
		if let button = cell.contentView.viewWithTag(CellTags.button.rawValue) as? UIButton {
			button.superview?.tag = section
			button.addTarget(self, action: #selector(EUKLogViewController.sectionAction(button:)), for: .touchUpInside)
			button.backgroundColor = (self.indexSelected != -1 && self.indexSelected != indexPath.section) ? UIColor.eukCalendarItemDisabledColor : UIColor.clear
		}
		if let selectionButton = cell.contentView.viewWithTag(CellTags.selectionButton.rawValue) as? UIButton {
			selectionButton.superview?.tag = section
			selectionButton.addTarget(self, action: #selector(EUKLogViewController.selectionAction(button:)), for: .touchUpInside)
			let imageName = self.usedItems.contains(filterItem) ? "removeTile" : "addTile"
			selectionButton.setImage(UIImage(named: imageName), for: .normal)
			selectionButton.isHidden = !self.isEditingItems
		}
		if let infoButton = cell.contentView.viewWithTag(CellTags.infoButton.rawValue) as? UIButton {
			infoButton.isHidden = !(isBleeding && self.indexSelected == 0)
			infoButton.addTarget(self, action: #selector(EUKLogViewController.bleedingInfoAction), for: .touchUpInside)
		}
		let borderColor = section == self.indexSelected ? UIColor.white : UIColor.eukiMain
		cell.clearBorders()
		cell.addBorders(edges: [.bottom], color: borderColor, thickness: 1.0)
		if indexPath.section == 0 {
			cell.addBorders(edges: [.top], color: UIColor.eukiMain, thickness: 1.0)
		}
	}
	
	func configureCell(cell: UITableViewCell, indexPath: IndexPath) {
		guard let swipeCell = cell as? MGSwipeTableCell else {
			return
		}
		swipeCell.rightButtons.removeAll()
		
		let filterItem = self.items[indexPath.section]
		switch filterItem.title {
		case "bleeding":
			var shouldSetCalendarValues = false
			if self.bleedingViewController == nil {
				if let bleedingViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "BleedingViewController") as? EUKBleedingViewController {
					bleedingViewController.delegate = self
					bleedingViewController.sectionDelegate = self
					self.bleedingViewController = bleedingViewController
					shouldSetCalendarValues = true
				}
			}
			
			if let bleedingViewController = self.bleedingViewController {
				self.configureChildViewController(childController: bleedingViewController, onView: cell.contentView)
				
				if shouldSetCalendarValues {
					bleedingViewController.size = self.calendarItem?.bleedingSize
					bleedingViewController.clotsCount = self.calendarItem?.bleedingClotsCounter ?? [0, 0]
					bleedingViewController.productsCount = self.calendarItem?.bleedingProductsCounter ?? [0, 0, 0, 0, 0]
				}
				
				let hasPeriod = self.bleedingViewController?.hasPeriod() ?? false
				let imageName = self.includeCycleSummary ? "IconTrackCycleOn" : "IconTrackCycleOff"
				bleedingViewController.enableTrackButton.setImage(UIImage(named: imageName), for: .normal)
				bleedingViewController.includeCycleSummaryView.isHidden = !hasPeriod
			}
		case "emotions":
			var shouldSetCalendarValues = false
			if self.emotionsViewController == nil {
				if let emotionsViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "EmotionsViewController") as? EUKEmotionsViewController {
					emotionsViewController.sectionDelegate = self
					self.emotionsViewController = emotionsViewController
					shouldSetCalendarValues = true
				}
			}
			
			if let emotionsViewController = self.emotionsViewController {
				self.configureChildViewController(childController: emotionsViewController, onView: cell.contentView)
				
				if shouldSetCalendarValues {
					emotionsViewController.emotion = self.calendarItem?.emotions ?? [Emotions]()
				}
			}
		case "body":
			var shouldSetCalendarValues = false
			if self.bodyViewController == nil {
				if let bodyViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "BodyViewController") as? EUKBodyViewController {
					bodyViewController.sectionDelegate = self
					self.bodyViewController = bodyViewController
					shouldSetCalendarValues = true
				}
			}
			
			if let bodyViewController = self.bodyViewController {
				self.configureChildViewController(childController: bodyViewController, onView: cell.contentView)
				
				if shouldSetCalendarValues {
					bodyViewController.body = self.calendarItem?.body ?? [Body]()
				}
			}
		case "sexual_activity":
			var shouldSetCalendarValues = false
			if self.sexualActivityViewController == nil {
				if let sexualActivityViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "SexualActivityViewController") as? EUKSexualActivityViewController {
					sexualActivityViewController.sectionDelegate = self
					self.sexualActivityViewController = sexualActivityViewController
					shouldSetCalendarValues = true
				}
			}
			
			if let sexualActivityViewController = self.sexualActivityViewController {
				self.configureChildViewController(childController: sexualActivityViewController, onView: cell.contentView)
				
				if shouldSetCalendarValues {
					sexualActivityViewController.sexualProtectionSTICount = self.calendarItem?.sexualProtectionSTICounter ?? [0, 0]
					sexualActivityViewController.sexualProtectionPregnancyCount = self.calendarItem?.sexualProtectionPregnancyCounter ?? [0, 0]
					sexualActivityViewController.sexualProtectionOtherCount = self.calendarItem?.sexualOtherCounter ?? [0, 0, 0, 0, 0]
				}
			}
		case "contraception":
			var shouldSetCalendarValues = false
			if self.contraceptionViewController == nil {
				if let contraceptionViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContraceptionViewController") as? EUKContraceptionViewController {
					contraceptionViewController.sectionDelegate = self
					contraceptionViewController.delegate = self
					self.contraceptionViewController = contraceptionViewController
					shouldSetCalendarValues = true
				}
			}
			
			if let contraceptionViewController = self.contraceptionViewController {
				self.configureChildViewController(childController: contraceptionViewController, onView: cell.contentView)
				
				if shouldSetCalendarValues {
					contraceptionViewController.contraceptionPill = self.calendarItem?.contraceptionPill
					contraceptionViewController.contraceptionDailyOthers = self.calendarItem?.contraceptionDailyOther ?? [ContraceptionDailyOther]()
					contraceptionViewController.contraceptionIUD = self.calendarItem?.contraceptionIud
					contraceptionViewController.contraceptionImplant = self.calendarItem?.contraceptionImplant
					contraceptionViewController.contraceptionPatch = self.calendarItem?.contraceptionPatch
					contraceptionViewController.contraceptionRing = self.calendarItem?.contraceptionRing
                    contraceptionViewController.contraceptionLongTermOthers = self.calendarItem?.contraceptionLongTermOther ?? [ContraceptionLongTermOther]()
                    contraceptionViewController.contraceptionShot = self.calendarItem?.contraceptionShot
				}
			}
		case "test":
			var shouldSetCalendarValues = false
			if self.testViewController == nil {
				if let testViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "TestViewController") as? EUKTestViewController {
					testViewController.sectionDelegate = self
					self.testViewController = testViewController
					shouldSetCalendarValues = true
				}
			}
			
			if let testViewController = self.testViewController {
				self.configureChildViewController(childController: testViewController, onView: cell.contentView)
				
				if shouldSetCalendarValues {
					testViewController.testSTI = self.calendarItem?.testSTI
					testViewController.testPregnancy = self.calendarItem?.testPregnancy
				}
			}
		case "appointment":
			if self.appointments.count == 0 && indexPath.row == 1 {
				if let appointmentViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "ExistentAppointmentViewController") as? EUKExistentAppointmentViewController {
					appointmentViewController.appointment = nil
					appointmentViewController.delegate = self
					appointmentViewController.isSelected = true
					appointmentViewController.selectedDate = self.calendarItem?.date ?? self.date
					
					self.configureChildViewController(childController: appointmentViewController, onView: cell.contentView)
				}
				break
			}
			
			if indexPath.row - 1 < self.appointments.count {
				let appointment = self.appointments[indexPath.row - 1]
				let isSelected = self.appointmentSelectedIndex == indexPath.row
				
				if let appointmentViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "ExistentAppointmentViewController") as? EUKExistentAppointmentViewController {
					appointmentViewController.appointment = appointment
					appointmentViewController.delegate = self
					appointmentViewController.isSelected = isSelected
					
					if !isSelected {
						let deleteButton = MGSwipeButton(title: "delete".localized.uppercased(), backgroundColor: UIColor.eukPurpleClear, padding: 30) { [unowned self] (_) -> Bool in
							let alertViewController = UIAlertController(title: nil, message: "delete_appointment".localized, preferredStyle: .alert)
							alertViewController.view.tintColor = UIColor.eukiAccent
							let cancelAction = UIAlertAction(title: "cancel".localized.uppercased(), style: .destructive, handler: nil)
							let deleteAction = UIAlertAction(title: "delete".localized.uppercased(), style: .default, handler: { [unowned self] (_) in
								let index = indexPath.row - 1
								
								let appointment = self.appointments[index]
								if let appointmentId = appointment.id {
									LocalNotificationManager.sharedInstance.deleteNotification(id: appointmentId)
								}
								
								self.appointments.remove(at: index)
								self.reloadTableView()
								self.removedAppointments.append(appointment)
							})
							alertViewController.addAction(cancelAction)
							alertViewController.addAction(deleteAction)
							self.present(alertViewController, animated: true, completion: nil)
							return true
						}
						deleteButton.setTitleColor(UIColor.eukiAccent, for: .normal)
						deleteButton.addBorders(edges: [.right, .left], color: UIColor.eukiMain, thickness: 0.5)
						swipeCell.rightButtons = [deleteButton]
					}
					
					self.configureChildViewController(childController: appointmentViewController, onView: cell.contentView)
				}
			} else {
				if let appointmentViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "ExistentAppointmentViewController") as? EUKExistentAppointmentViewController {
					appointmentViewController.appointment = nil
					appointmentViewController.delegate = self
					appointmentViewController.isSelected = true
					appointmentViewController.isNewAppointment = true
					appointmentViewController.selectedDate = self.calendarItem?.date ?? self.date
					
					self.configureChildViewController(childController: appointmentViewController, onView: cell.contentView)
				}
				break
			}
			if indexPath.row == 1 {
				cell.addBorders(edges: [.top], color: UIColor.eukiMain, thickness: 1.0)
			}
		case "note":
			var shouldSetCalendarValues = false
			if self.noteViewController == nil {
				if let noteViewController = UIStoryboard(name: "Calendar", bundle: Bundle.main).instantiateViewController(withIdentifier: "NoteViewController") as? EUKNoteViewController {
					noteViewController.sectionDelegate = self
					self.noteViewController = noteViewController
					shouldSetCalendarValues = true
				}
			}
			
			if let noteViewController = self.noteViewController {
				self.configureChildViewController(childController: noteViewController, onView: cell.contentView)
				
				if shouldSetCalendarValues {
					noteViewController.note = self.calendarItem?.note
				}
			}
		default:
			print("Option not supported")
		}
		
		cell.clearBorders()
		cell.addBorders(edges: [.bottom], color: UIColor.eukiMain, thickness: 1.0)
	}
	
	func configureAppointmentCell(cell: UITableViewCell, indexPath: IndexPath) {
		cell.addBorders(edges: [.top], color: UIColor.eukiMain, thickness: 1.0)
	}
}
