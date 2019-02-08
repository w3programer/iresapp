//
//  OffersCell.swift
//  Iris
//
//  Created by mahmoudhajar on 2/4/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class OffersCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var offerLab: UILabel!
    @IBOutlet weak var visual: UIVisualEffectView!
    
    @IBOutlet weak var view: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        self.img.layer.cornerRadius = 10.0
        self.img.clipsToBounds = true
        self.visual.alpha = 0.6
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
