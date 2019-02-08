//
//  CartCell.swift
//  Iris
//
//  Created by mahmoudhajar on 2/8/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher


class CartCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var secView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minBtn: UIButton!
    @IBOutlet weak var numLab: UILabel!
    @IBOutlet weak var priceLab: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img.layer.cornerRadius = 10.0
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.gray.cgColor
        secView.layer.borderWidth = 1
        secView.layer.borderColor = UIColor.gray.cgColor
        
        
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    

}
