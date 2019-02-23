//
//  Package.swift
//  Iris
//
//  Created by mahmoudhajar on 2/19/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON

class Package: NSObject {
   
    var sizes:[Int] = []
    
    init?(dic:[String:JSON]) {
      
        let siz = dic["sizes"]?.array
        
        for sz in siz! {
            
            self.sizes.append(sz.int!)
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    

}
