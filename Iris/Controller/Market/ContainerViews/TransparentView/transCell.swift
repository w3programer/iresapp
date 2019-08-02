//
//  transCell.swift
//  Iris
//
//  Created by Ghoost on 5/21/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher

class transCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var priceLab: UILabel!
    @IBOutlet weak var rsLab: UILabel!
    
    @IBOutlet weak var fav: CornerButtons!
    @IBOutlet weak var bg: UIView!
    
    
    
    
    var isFavorite: Bool = false {
        didSet {
            fav.isSelected = isFavorite
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        _ = self.isFavorite ? (self.isFavorite = false, self.fav.setImage(UIImage(named: "li"), for: .normal)) : (self.isFavorite = true, self.fav.setImage(UIImage(named: "lk"), for: .selected))

        self.bg.layer.cornerRadius = 10.0
        self.bg.clipsToBounds = true
        
    }
    
    @IBAction func favBtn(_ sender: Any) {
        
        fav.isSelected = !fav.isSelected
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isFavorite = false
    }
    
    
    var pics: Ads? {
        didSet {
            guard let imgs = pics else { return }
            self.img.kf.indicatorType = .activity
            if let url = URL(string:(imgs.imaage)) {
                self.img.kf.setImage(with: url, placeholder: nil, options:[.transition(ImageTransition.fade(0.5))])
            }
        }
    }
    
    
    
}
