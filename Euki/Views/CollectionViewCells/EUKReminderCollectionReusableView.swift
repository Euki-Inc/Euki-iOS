//
//  EUKReminderCollectionReusableView.swift
//  Euki
//
//  Created by Víctor Chávez on 12/8/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKReminderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var okButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
