//
//  QuestionCell.swift
//  Iris
//
//  Created by mahmoudhajar on 3/24/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {

    @IBOutlet weak var bgViw: UIView!
    @IBOutlet weak var quesLablel: UILabel!
    @IBOutlet weak var ansLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       bgViw.floatView()

    }

   
}
