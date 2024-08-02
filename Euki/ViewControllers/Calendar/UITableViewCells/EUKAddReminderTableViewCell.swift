//
//  EUKAddReminderTableViewCell.swift
//  Euki
//
//  Created by Víctor Chávez on 6/4/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKAddReminderTableViewCell: UITableViewCell {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var dayTimeField: UITextField!
    @IBOutlet weak var repeatField: UITextField!
    @IBOutlet weak var cancelButton: EUKBaseButton!
    @IBOutlet weak var addButton: EUKBaseButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
