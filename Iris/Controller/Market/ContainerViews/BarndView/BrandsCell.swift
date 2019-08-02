//
//  BrandsCell.swift
//  Iris
//
//  Created by mahmoudhajar on 4/11/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher


class BrandsCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var viewGround: UIView!
    @IBOutlet weak var brandImg: CircleImage!
    @IBOutlet weak var brandName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       // self.viewGround.floatView()
//        self.viewGround.layer.cornerRadius = 10.0
//        self.viewGround.clipsToBounds = true
        
      //  self.viewGround.appStoreView()
        
    }
    
    var pics: Brand? {
        didSet {
            guard let imgs = pics else { return }
            self.brandImg.kf.indicatorType = .activity
            if let url = URL(string:(imgs.image)) {
                self.brandImg.kf.setImage(with: url, placeholder: nil, options:[.transition(ImageTransition.fade(0.5))])
            }
        }
    }
    
    
}
