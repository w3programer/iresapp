//
//  MyOrderTableViewCell.swift
//  Iris
//
//  Created by mahmoudhajar on 2/5/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class MyOrderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }

}
