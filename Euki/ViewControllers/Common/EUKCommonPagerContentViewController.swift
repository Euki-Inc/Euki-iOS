//
//  EUKCommonPagerContentViewController.swift
//  Euki
//
//  Created by Dhekra Rouatbi on 14/3/2024.
//  Copyright © 2024 Ibis. All rights reserved.
//

import Foundation

class EUKCommonPagerContentViewController:EUKBaseViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var imageName : String = ""
    var descriptionText : String = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    private func setupView() {
        self.imageView.image = UIImage(named: imageName)
        self.descriptionLabel.text = descriptionText
    }
}
