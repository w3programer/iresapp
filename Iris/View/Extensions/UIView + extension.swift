//
//  UIView + extension.swift
//  Iris
//
//  Created by mahmoudhajar on 2/5/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundView() {
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
    
}
