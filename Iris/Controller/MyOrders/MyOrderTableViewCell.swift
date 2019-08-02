//
//  MyOrderTableViewCell.swift
//  Iris
//
//  Created by mahmoudhajar on 2/5/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher

class MyOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var viw: UIView!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var orderNumLab: UILabel!
    
    @IBOutlet weak var numLabel: UILabel!
    
    @IBOutlet weak var orderStatusLab: UILabel!
    
    
    @IBOutlet weak var statusLab: UILabel!
    
    @IBOutlet weak var totalOrderLab: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var sarLab: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viw.floatView()
        
    }

   

}
