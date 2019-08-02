//
//  TrendCell.swift
//  Iris
//
//  Created by mahmoudhajar on 4/13/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher


class TrendCell: UICollectionViewCell {
    
    @IBOutlet weak var trenImg: CircleImage!
    @IBOutlet weak var trendName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.trenImg.layer.borderColor = #colorLiteral(red: 0.115710564, green: 0.5438727736, blue: 0.5560589433, alpha: 1)
         self.trenImg.layer.borderWidth = 1.0
        
    }
    
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//        self.trenImg.layer.cornerRadius = self.trenImg.frame.size.width / 2
//    }
    
    var pics: Trend? {
        didSet {
            guard let imgs = pics else { return }
            self.trenImg.kf.indicatorType = .activity
            if let url = URL(string:(imgs.trendImage)) {
                self.trenImg.kf.setImage(with: url, placeholder: nil, options:[.transition(ImageTransition.fade(0.5))])
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                trendName.backgroundColor = #colorLiteral(red: 0.115710564, green: 0.5438727736, blue: 0.5560589433, alpha: 1)
                trendName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                trendName.layer.cornerRadius = 10.0
                trendName.clipsToBounds = true
            } else {
                trendName.backgroundColor = UIColor.clear
                trendName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
           
                
        }
    }
    
}
