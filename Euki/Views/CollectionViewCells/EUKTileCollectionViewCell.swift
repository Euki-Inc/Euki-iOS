//
//  EUKTileCollectionViewCell.swift
//  Euki
//
//  Created by Víctor Chávez on 4/7/18.
//  Copyright © 2018 Ibis. All rights reserved.
//

import UIKit

class EUKTileCollectionViewCell: UICollectionViewCell {
    @IBOutlet var marginsConstraints: [NSLayoutConstraint]!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
