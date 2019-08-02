//
//  Question.swift
//  Iris
//
//  Created by mahmoudhajar on 3/24/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON

class Question: NSObject {
    
   var q_ar:String = ""
   var q_en:String = ""
   var a_ar:String = ""
   var a_en:String = ""
    
    init?(dic:[String:JSON]) {
       
        self.q_ar = (dic["q_ar"]?.string)!
        self.q_en = (dic["q_en"]?.string)!
        self.a_ar = (dic["a_ar"]?.string)!
        self.a_en = (dic["a_en"]?.string)!

    }

}
