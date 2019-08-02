//
//  MyOrder.swift
//  Iris
//
//  Created by mahmoudhajar on 2/20/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON


class MyOrder: NSObject {
    
    var id:Int = 0
    var total:Double = 0.0
     var status:Int = 0
      var updated_at:Int = 0
    
     init?(dic:[String:JSON]) {
        
        self.id = (dic["id"]?.int)!
        self.total = (dic["total"]?.double)!
         self.status = (dic["status"]?.int)!
          self.updated_at = (dic["updated_at"]?.int)!
        

    }
}

class itmList: NSObject {
    
    var name_ar:String = ""
     var name_en:String = ""
      var quantity:Int = 0
       var totalP:Double = 0.0
        var right_amount:Int = 0
         var left_amount:Int = 0
          var images:String = ""
    
    init(name_ar:String, name_en:String, quantity:Int, totalP:Double, right_amount:Int , left_amount:Int, images:String) {
        
        self.name_en = name_en
         self.name_ar = name_ar
          self.quantity = quantity
           self.totalP = totalP
            self.right_amount = right_amount
            self.left_amount = left_amount
             self.images = images
    }
    
}

