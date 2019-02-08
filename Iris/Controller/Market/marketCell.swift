//
//  marketCell.swift
//  Iris
//
//  Created by mahmoudhajar on 2/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher




class marketCell: UICollectionViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var fav: CornerButtons!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.img.layer.cornerRadius = 10.0
        self.view.layer.cornerRadius = 10.0
        self.view.clipsToBounds = true
        self.view.layer.borderColor = UIColor.gray.cgColor
        self.view.layer.borderWidth = 2
        
        

        
    }
    
    
    
//    var pics: Ads? {
//        didSet {
//            guard let imgs = pics else { return }
//            self.img.kf.indicatorType = .activity
//            if let url = URL(string: (imgs.mainImg) ) {
//                self.img.kf.setImage(with: url, placeholder: nil, options:[.transition(ImageTransition.fade(0.5))])
//            }
//        }
//    }
    
    
    

    
    
    
    
    
}
