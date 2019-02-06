//
//  MoreCell.swift
//  Iris
//
//  Created by mahmoudhajar on 2/6/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class MoreCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var view: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = self.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
