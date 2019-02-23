//
//  pagination.swift
//  Iris
//
//  Created by mahmoudhajar on 2/23/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON


class pagination: NSObject {
    
    var lastPage:Int = 1
    
    init(dic:[String:JSON]) {
        
        
        self.lastPage = (dic["last_page"]?.int)!
        
        
        
    }

}
