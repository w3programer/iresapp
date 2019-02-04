//
//  RoundedUIView.swift
//  Iris
//
//  Created by mahmoudhajar on 2/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class RoundedUIView: UIView {

    override func awakeFromNib() {
    
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
