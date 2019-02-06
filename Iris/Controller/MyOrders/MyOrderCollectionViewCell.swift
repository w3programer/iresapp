//
//  MyOrderCollectionViewCell.swift
//  Iris
//
//  Created by mahmoudhajar on 2/5/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class MyOrderCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var titleLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLab.alpha = 0.6
        
    }
    
    func setupCell(text: String) {
        titleLab.text = text
    }
  
    override var isSelected: Bool {
        didSet {
            titleLab.alpha = isSelected ? 1.0 : 0.6
        }
    }
    
}
