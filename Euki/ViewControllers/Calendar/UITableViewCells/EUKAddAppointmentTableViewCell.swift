//
//  EUKAddAppointmentTableViewCell.swift
//  Euki
//
//  Created by Víctor Chávez on 2/3/19.
//  Copyright © 2019 Ibis. All rights reserved.
//

import UIKit

class EUKAddAppointmentTableViewCell: UITableViewCell {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var dayTimeField: UITextField!
    @IBOutlet weak var alertField: UITextField!
    @IBOutlet weak var cancelButton: EUKBaseButton!
    @IBOutlet weak var addButton: EUKBaseButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
