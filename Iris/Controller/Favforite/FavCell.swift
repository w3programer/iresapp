//
//  FavCell.swift
//  Iris
//
//  Created by mahmoudhajar on 2/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher


class FavCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img.layer.cornerRadius = 10.0
        img.clipsToBounds = true
        
    }
    
    var pics: Ads? {
        didSet {
            guard let imgs = pics else { return }
            self.img.kf.indicatorType = .activity
            for phots in imgs.images {
                if let url = URL(string:(phots)) {
                    self.img.kf.setImage(with: url, placeholder: nil, options:[.transition(ImageTransition.fade(0.5))])
                }
            }
            
        }
    }

    
    
    
    

}
