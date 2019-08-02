//
//  AccessoryCell.swift
//  Iris
//
//  Created by Ghoost on 5/21/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher

class AccessoryCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viw: UIView!
    
    @IBOutlet weak var fav: CornerButtons!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rsLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _ = self.isFavorite ? (self.isFavorite = false, self.fav.setImage(UIImage(named: "li"), for: .normal)) : (self.isFavorite = true, self.fav.setImage(UIImage(named: "lk"), for: .selected))
        
        self.viw.layer.cornerRadius = 10.0
        self.viw.clipsToBounds = true
        
    }
    
    var isFavorite: Bool = false {
        didSet {
            fav.isSelected = isFavorite
        }
    }
    
    @IBAction func favoBtn(_ sender: Any) {
        
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
