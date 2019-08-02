//
//  OffersCell.swift
//  Iris
//
//  Created by mahmoudhajar on 2/4/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher

class OffersCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var offerLab: UILabel!
    @IBOutlet weak var visual: UIVisualEffectView!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var view: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        //view.floatView()
        self.img.layer.cornerRadius = 10.0
        self.img.clipsToBounds = true
        
        
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
