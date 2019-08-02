//
//  CollectionCell + extension.swift
//  Iris
//
//  Created by mahmoudhajar on 4/17/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    func floatCell() {
        self.layer.cornerRadius = 3.0
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.6
    }
  
}
