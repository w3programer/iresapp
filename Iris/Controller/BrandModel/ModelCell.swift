//
//  ModelCell.swift
//  Iris
//
//  Created by mahmoudhajar on 3/24/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher

class ModelCell: UICollectionViewCell {
    
    @IBOutlet weak var bgViw: UIView!
    @IBOutlet weak var titLab: UILabel!
    @IBOutlet weak var moImg: UIImageView!
    @IBOutlet weak var priceLab: UILabel!
    @IBOutlet weak var rsLab: UILabel!
    @IBOutlet weak var favoBtn: UIButton!
    
    
    var isFavorite: Bool = false {
        didSet {
            favoBtn.isSelected = isFavorite
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
         _ = self.isFavorite ? (self.isFavorite = false, self.favoBtn.setImage(UIImage(named: "li"), for: .normal)) : (self.isFavorite = true, self.favoBtn.setImage(UIImage(named: "lk"), for: .selected))
        
    }
    
    @IBAction func favBt(_ sender: Any) {
        
        favoBtn.isSelected = !favoBtn.isSelected

        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isFavorite = false
    }

    var pics: Ads? {
        didSet {
            guard let imgs = pics else { return }
            self.moImg.kf.indicatorType = .activity
            if let url = URL(string:(imgs.imaage)) {
                self.moImg.kf.setImage(with: url, placeholder: nil, options:[.transition(ImageTransition.fade(0.5))])
            }
        }
    }
    
    
    
}
