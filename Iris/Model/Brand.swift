//
//  Brand.swift
//  Iris
//
//  Created by mahmoudhajar on 3/24/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//


/*
 
 "id": 4,
 "name_ar": "بيلا",
 "name_en": "Bella",
 "image": "brands/Bwgc3KdruI62C71s19UduR1HA50WC83ZUjZPUOlD.jpeg",
 "trends": [
          {
          "id": 20,
          "name_ar": "GLOW",
           "name_en": "GLOW",
           "image": "trends/iFzS7gdDu7DqlbWC3nMyV7ykFUE6AtFRYrJk4gGF.png",
            "brand_id": "4",
              "created_at": "2019-04-03 11:03:13",
                "updated_at": "2019-04-03 11:04:20"
     },
 
 
 */

import UIKit
import SwiftyJSON



class Brand: NSObject {
    
    
    var id:Int = 0
     var name_ar:String = ""
      var name_en:String = ""
       var image: String = ""
    
    var ids:[Int] = []
    var nameAr:[String] = []
     var nameEn:[String] = []
      var imgs:[String] = []
        var brand_id:[String] = []

    
    init?(dic:[String:JSON]) {
        
        
    guard let photo = dic["image"]?.imagePath, !photo.isEmpty else {return nil}
              self.image = photo
        self.id = (dic["id"]?.int)!
         self.name_ar = (dic["name_ar"]?.string)!
          self.name_en = (dic["name_en"]?.string)!
            //self.brand_id = (dic["brand_id"]?.string)!
        
        
        let trends = dic["trends"]?.array
        
        for ite in trends! {
            
            let i = ite["id"].int
             let ar = ite["name_ar"].string
              let en = ite["name_en"].string
            guard let mg = ite["image"].imagePath, mg.isEmpty else {return}
            
            let brndId = ite["brand_id"].string
            
           self.ids.append(i!)
            self.nameAr.append(ar!)
             self.nameEn.append(en!)
              self.imgs.append(mg)
               self.brand_id.append(brndId!)
            
               print("ids count", ids.count)
                print("nameAr count", nameAr.count)
                 print("nameEn count", nameEn.count)
                  print("imgs count", imgs.count)
                   print("barnd_id", brand_id.count)
             }
          }
       }


class BrandTrends: NSObject {
    
    var name_ar:String = ""
     var name_en:String = ""
      var images:String = ""
       var brandId:String = ""
         var id:Int = 0
    
    init(name_ar:String, name_en:String, images:String, brandId:String, id:Int) {
        
        self.name_en = name_en
         self.name_ar = name_ar
          self.images = images
           self.brandId = brandId
            self.id = id
        
        
    }
    
}
