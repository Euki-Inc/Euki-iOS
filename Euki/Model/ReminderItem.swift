//
//  ReminderItem.swift
//  Euki
//
//  Created by Víctor Chávez on 6/4/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class ReminderItem: NSObject {
    var id: String?
    var title: String?
    var text: String?
    var date: Date?
    var repeatDays: Int?
    var lastAlert: Date?
}
