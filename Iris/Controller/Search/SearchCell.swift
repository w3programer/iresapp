//
//  SearchCell.swift
//  Iris
//
//  Created by mahmoudhajar on 2/7/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var priceLab: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.view.layer.cornerRadius = 10.0
        self.view.layer.borderColor = UIColor.gray.cgColor
        self.view.layer.borderWidth = 2
    }
    
    
}
