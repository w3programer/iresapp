//
//  SearchCell.swift
//  Iris
//
//  Created by mahmoudhajar on 2/7/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher

class SearchCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var priceLab: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var view: UIView!
    
    
    var isFavorite: Bool = false {
        didSet {
            favBtn.isSelected = isFavorite
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      _ = self.isFavorite ? (self.isFavorite = false, self.favBtn.setImage(UIImage(named: "li"), for: .normal)) : (self.isFavorite = true, self.favBtn.setImage(UIImage(named: "lk"), for: .selected))
        
    }
    
    @IBAction func favBt(_ sender: Any) {
        
        favBtn.isSelected = !favBtn.isSelected
        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isFavorite = false
    }
    
    var pics: Ads? {
        didSet {
            guard let imgs = pics else { return }
            self.img.kf.indicatorType = .activity
           // for phots in imgs.images {
                if let url = URL(string:(imgs.imaage)) {
                    self.img.kf.setImage(with: url, placeholder: nil, options:[.transition(ImageTransition.fade(0.5))])
                }
            //}
            
        }
    }
    
    
    
    
}
