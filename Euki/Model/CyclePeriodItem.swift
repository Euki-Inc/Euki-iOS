//
//  CyclePeriodItem.swift
//  Euki
//
//  Created by Víctor Chávez on 6/10/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class CyclePeriodItem: NSObject {
	var initialDate: Date
	var endDate: Date
	var duration: Int
	
	init(initialDate: Date, endDate: Date, duration: Int) {
		self.initialDate = initialDate
		self.endDate = endDate
		self.duration = duration
	}
}
