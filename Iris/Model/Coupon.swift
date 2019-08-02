//
//  Coupon.swift
//  Iris
//
//  Created by Ghoost on 5/19/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON

class Coupon: NSObject {

    
    var id:Int =  1
    var code:String =  ""
    var value:String =  ""
    var active:String =  ""
    
    init?(dic:[String:JSON]) {
        
        self.id = (dic["id"]?.int)!
         self.code = (dic["code"]?.string)!
          self.value = (dic["value"]?.string)!
           self.active = (dic["active"]?.string)!
    }
    
    
    
    
    
    
}
