//
//  specialLenses.swift
//  Iris
//
//  Created by mahmoudhajar on 4/13/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON

class specialLenses: NSObject {

   
    
    var phone:String = ""
     var ar:String = ""
      var en:String = ""
    
    init?(dic:[String:JSON]) {
    
        self.phone = dic["special_lenses"]!["phone"].string!
         self.ar = dic["description"]!["ar"].string!
          self.en = dic["description"]!["en"].string!
    
    
    }
    
}
