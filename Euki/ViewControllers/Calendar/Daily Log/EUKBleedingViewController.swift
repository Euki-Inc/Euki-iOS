//
//  EUKBleedingViewController.swift
//  Euki
//
//  Created by Víctor Chávez on 6/14/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

protocol EUKBleedingViewDelegate: AnyObject {
	func toggleIncludeCycleSummary()
	func sizeChanged(size: BleedingSize?)
}

class EUKBleedingViewController: EUKBaseLogSectionViewController {
	@IBOutlet weak var enableTrackButton: UIButton!
	@IBOutlet weak var enableTrackLabel: UILabel!
	@IBOutlet weak var includeCycleSummaryView: UIView!
	@IBOutlet var clotsButtons: [EUKSelectButton]!
    @IBOutlet var productButtons: [EUKSelectButton]!
	
	weak var delegate: EUKBleedingViewDelegate?
    
    var size: BleedingSize? {
        get {
            if let index = self.selectedIndex() {
                return BleedingSize(rawValue: index)
            }
            return nil
        }
        set {
            self.selectButton(index: newValue?.rawValue)
        }
    }
	
	var clotsCount: [Int] {
		get {
			var countsArray = [Int]()
			for index in 0 ... 1 {
				for button in self.clotsButtons {
					if button.tag - MinButtonTag == index {
						countsArray.append(button.count)
					}
				}
			}
			return countsArray
		}
		set {
			for index in 0 ... 1 {
				for button in self.clotsButtons {
					if button.tag - MinButtonTag == index {
						button.count = newValue[index]
					}
				}
			}
		}
	}
    
    var productsCount: [Int] {
        get {
            var countsArray = [Int]()
            for index in 0 ... 6 {
                for button in self.productButtons {
                    if button.tag - MinButtonTag == index {
                        countsArray.append(button.count)
                    }
                }
            }
            return countsArray
        }
        set {
            for index in 0 ... 6 {
                for button in self.productButtons {
                    if button.tag - MinButtonTag == index {
                        button.count = newValue[index]
                    }
                }
            }
        }
    }
	
	//MARK: - IBActions
	
	@IBAction func includeAction() {
		self.delegate?.toggleIncludeCycleSummary()
	}
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.borderColor = UIColor.eukBleeding
        super.viewDidLoad()
		
		let predictionEnabled = LocalDataManager.sharedInstance.trackPeriodEnabled()
		self.enableTrackButton.isEnabled = predictionEnabled
		self.includeCycleSummaryView.alpha = predictionEnabled ? 1.0 : 0.4
    }
    
    override func setUIElements() {
        super.setUIElements()
		self.clotsButtons.forEach { button in
			button.delegate = self
			button.borderColor = UIColor.eukIris
		}
        self.productButtons.forEach { button in
            button.delegate = self
            button.borderColor = UIColor.eukIris
        }
    }
    
    override func hasData() -> Bool {
        for productCount in self.productsCount {
            if productCount > 0 {
                return true
            }
        }
		for clotCount in self.clotsCount {
			if clotCount > 0 {
				return true
			}
		}
        return self.size != nil
    }
	
	func hasPeriod() -> Bool {
		for clotCount in self.clotsCount {
			if clotCount > 0 {
				return true
			}
		}
		return self.size != nil
	}
	
	override func selectedChanged(button: EUKSelectButton) {
		super.selectedChanged(button: button)
		self.delegate?.sizeChanged(size: self.size)
	}
}
