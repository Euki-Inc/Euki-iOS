//
//  CyclePeriodData.swift
//  Euki
//
//  Created by Víctor Chávez on 6/10/23.
//  Copyright © 2023 Ibis. All rights reserved.
//

import UIKit

class CyclePeriodData: NSObject {
	var averageCycleLength: Double?
	var variation: Int?
	var averagePeriodLength: Double?
	var currentDayCycle: Int?
	var maxCycleLength: Int?
	var items: [CyclePeriodItem]
	
	init(averageCycleLength: Double?, variation: Int?, averagePeriodLength: Double?, currentDayCycle: Int?, maxCycleLength: Int?, items: [CyclePeriodItem]) {
		self.averageCycleLength = averageCycleLength
		self.variation = variation
		self.averagePeriodLength = averagePeriodLength
		self.currentDayCycle = currentDayCycle
		self.maxCycleLength = maxCycleLength
		self.items = items
	}
}
