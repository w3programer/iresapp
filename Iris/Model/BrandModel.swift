//
//  BrandModel.swift
//  Iris
//
//  Created by mahmoudhajar on 4/13/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON


class Trend: NSObject {
    
    var trendId:Int = 0
    var trendNameEn:String = ""
    var trendNameAr:String = ""
    var trendImage:String = ""
    var brandId:String = ""
    
    init?(dic:[String:JSON]) {
        self.trendId = (dic["id"]?.int)!
        self.trendNameAr = (dic["name_ar"]?.string)!
        self.trendNameAr = (dic["name_ar"]?.string)!
        self.brandId = (dic["brand_id"]?.string)!
        guard let ph = dic["image"]?.imagePath, !ph.isEmpty else {return nil}
        self.trendImage = ph
    }
    
    
    
    
    
}
