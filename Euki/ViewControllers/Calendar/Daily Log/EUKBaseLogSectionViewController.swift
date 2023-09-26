//
//  EUKBaseLogSectionViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/14/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit
import MaterialShowcase

protocol EUKLogSectionDelegate: AnyObject {
    func selectionUpdated()
}

class EUKBaseLogSectionViewController: UIViewController, EUKSelectButtonDelegate {
    @IBOutlet weak var countTutorialTargetView: UIView?
	@IBOutlet weak var trackTutorialTargetView: UIView?
	
    @IBOutlet var selectionButtons: [EUKSelectButton]!
    
    weak var sectionDelegate: EUKLogSectionDelegate?
    let MinButtonTag = 100
    var borderColor: UIColor = UIColor.red
    var multiSelection = false

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.verifyTutorial()
    }
    
    //MARK: - Private
    
    func selectedIndex() -> Int? {
        return self.selectedIndex(buttons: self.selectionButtons)
    }
    
    func selectedIndex(buttons: [EUKSelectButton]) -> Int? {
        for button in buttons {
            if button.isSelected {
                return button.tag - self.MinButtonTag
            }
        }
        
        return nil
    }
    
    func selectedIndexes() -> [Int] {
        return self.selectedIndexes(buttons: self.selectionButtons)
    }
    
    func selectedIndexes(buttons: [EUKSelectButton]) -> [Int] {
        var selectedIndexes = [Int]()
        for button in buttons {
            if button.isSelected {
                selectedIndexes.append(button.tag - self.MinButtonTag)
            }
        }
        return selectedIndexes
    }
    
    func selectButton(index: Int?) {
        self.selectButton(index: index, buttons: self.selectionButtons)
    }
    
    func selectButton(index: Int?, buttons: [EUKSelectButton]) {
        for button in buttons {
            if let index = index {
                if button.tag - self.MinButtonTag == index {
                    button.isSelected = true
                    continue
                }
            }
            button.isSelected = false
        }
    }
    
    func selectButtons(indexes: [Int]) {
        self.selectButtons(indexes: indexes, buttons: self.selectionButtons)
    }
    
    func selectButtons(indexes: [Int], buttons: [EUKSelectButton]) {
        for button in buttons {
            button.isSelected = indexes.contains(button.tag - self.MinButtonTag)
        }
    }
    
    func setUIElements() {
        if self.selectionButtons != nil {
            self.selectionButtons.forEach { (button) in
                button.delegate = self
                button.borderColor = UIColor.eukIris
            }
        }
    }
    
    func selectedChanged(button: EUKSelectButton) {
        if self.multiSelection {
            self.sectionDelegate?.selectionUpdated()
            return
        }
        
        if selectionButtons != nil {
            if selectionButtons.contains(button), button.isSelected {
                for sizeButton in self.selectionButtons {
                    if sizeButton != button {
                        sizeButton.isSelected = false
                    }
                }
            }
        }
        self.sectionDelegate?.selectionUpdated()
    }
    
    func verifyTutorial() {
        if let countTutorialTargetView = self.countTutorialTargetView {
            if LocalDataManager.sharedInstance.shouldShowDailyLogTutorial() {
                let showcase = self.createTutorial(title: "track_counter_tutorial_title".localized, content: "track_counter_tutorial_content".localized)
                showcase.setTargetView(view: countTutorialTargetView)
                showcase.targetTintColor = UIColor.eukLightMint
                showcase.backgroundPromptColor = UIColor.eukLightMint
                showcase.targetHolderRadius = 60.0
				showcase.delegate = self
				showcase.tag = 0
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
					showcase.show(completion: nil)
                }
            }
		}
    }
	
	private func verifyTrackTutorial() {
		if let trackTutorialTargetView = self.trackTutorialTargetView {
			if LocalDataManager.sharedInstance.shouldShowTrackBleedingTutorial() {
				let showcase = self.createTutorial(title: "track_bleeding_tutorial_title".localized, content: "track_bleeding_tutorial_content".localized)
				showcase.setTargetView(view: trackTutorialTargetView)
				showcase.targetTintColor = UIColor.eukLightMint
				showcase.backgroundPromptColor = UIColor.eukLightMint
				showcase.targetHolderRadius = 60.0
				showcase.delegate = self
				showcase.tag = 1
				
				trackTutorialTargetView.isHidden = false
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
					showcase.show(completion: nil)
				}
			}
		}
	}
    
    func hasData() -> Bool {
        return !self.selectedIndexes().isEmpty
    }
}

extension EUKBaseLogSectionViewController: MaterialShowcaseDelegate {
	func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget: Bool) {
		if showcase.tag == 0 {
			self.verifyTrackTutorial()
		} else {
			self.trackTutorialTargetView?.isHidden = true
		}
	}
}
