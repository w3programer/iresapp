//
//  OrderStatusCell.swift
//  Iris
//
//  Created by Ghoost on 5/22/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher

class OrderStatusCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rightAmount: UILabel!
    @IBOutlet weak var leftAmount: UILabel!
    @IBOutlet weak var riAmount: UILabel!
    @IBOutlet weak var leAmount: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var am: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    @IBOutlet weak var priceLab: UILabel!
    
    @IBOutlet weak var sarLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.floatView()
        
    }

    //    var pics: itmList? {
    //        didSet {
    //            guard let imgs = pics else { return }
    //            self.img.kf.indicatorType = .activity
    //            if let url = URL(string:(imgs)) {
    //                self.img.kf.setImage(with: url, placeholder: nil, options:[.transition(ImageTransition.fade(0.5))])
    //            }
    //        }
    //    }

}
