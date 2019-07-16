//
//  MyCollectionViewCell.swift
//  Extensions
//
//  Created by Mohamed El Hanafi on 7/16/19.
//  Copyright © 2019 Mohamed El Hanafi. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIImageView!
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.containerView.layer.cornerRadius = 5.0;
        self.containerView.layer.masksToBounds = true; 
    }

}
