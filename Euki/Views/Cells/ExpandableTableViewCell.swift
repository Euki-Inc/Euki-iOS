//
//  ExpandableTableViewCell.swift
//  Euki
//
//  Created by Víctor Chávez on 3/30/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class ExpandableTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var bottomSeparatorView: UIView!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    var heightConstraint: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
