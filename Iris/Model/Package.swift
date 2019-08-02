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
   
    var axis:[String] = []
     var deviation:[String] = []
      var myopia:[String] = []
    
    
    init?(dic:[String:JSON]) {
      
        let ax = dic["axis"]?.array
        
        for sz in ax! {
            
            self.axis.append(sz.string!)
        }
        
        let de = dic["deviation"]?.array
        
        for dev in de! {
            self.deviation.append(dev.string!)
        }
        
        
        let mo = dic[""]?.array
        
        for mop in mo! {
            self.myopia.append(mop.string!)
        }
        
    }
    
    
    
    
    
    
    

}
