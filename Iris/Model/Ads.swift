//
//  Ads.swift
//  Iris
//
//  Created by mahmoudhajar on 2/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//


/*
 
 {
 "data": [
        {
         "id": 2,
         "name_ar": "عدسه شفاف",
         "name_en": "lens",
         "description_en": "lens",
         "description_ar": "عدسه",
         "price": "90",
         "sale_price": "100",
         "price_after_discount": "0",
         "discount_percentage": "0",
         "is_favorite": 0,
     "images": [
            "main_categories/drop.png",
           "main_categories/Eye-PNG-Pic.png",
          "main_categories/tranpaent.png"
          ],
             "featured": "0",
             "sales": "0",
             "has_sizes": "1",
             "active": "1",
        "brand": {
              "name_ar": "بولس",
              "name_en": "police"
               }
             }
           ],
      "links": {
          "first": "http://iris.creativeshare.co/api/categories/1/products?page=1",
          "last": "http://iris.creativeshare.co/api/categories/1/products?page=1",
          "prev": null,
          "next": null
          },
     "meta": {
           "current_page": 1,
           "from": 1,
           "last_page": 1,
            "path": "http://iris.creativeshare.co/api/categories/1/products",
            "per_page": 10,
             "to": 1,
             "total": 1
            }
          }
 
 

*/



import UIKit
import SwiftyJSON

class Ads: NSObject {
    
    var imaage: String = ""
     var images:[String] = []
      var id:Int = 0
       var name_ar:String = ""
        var name_en:String = ""
        var price:Double = 0.0
       var price_after_discount:Int = 0
      var discount_percentage:Int = 0
     var is_favorite:Int = 0
    var description_ar:String = ""
     var description_en:String = ""
      var featured:Int = 0
       var favorite_id:Int = 0
      var brandNameAr:String = ""
     var brandNameEn:String = ""
    var has_sizes:Int = 0
    
    var dev:[String] = []
     var ax:[String] = []
      var myopia:[String] = []
   
    
    init?(dic:[String:JSON]) {
        
        let photos = dic["images"]?.array
        
        for img in photos! {
          guard let photo = img.imagePath, !photo.isEmpty else {return nil}
            self.images.append(photo)
            print("gooo")
        }   
        for ig in photos! {
            guard let photo = ig.imagePath, !photo.isEmpty else {return nil}
            self.imaage = photo
            print("goooffff")
        }
        
        self.id = (dic["id"]?.int)!
         self.name_ar = (dic["name_ar"]?.string)!
          self.name_en = (dic["name_en"]?.string)!
           self.price = (dic["price"]?.double)!
            self.description_ar = (dic["description_ar"]?.string)!
             self.description_en = (dic["description_en"]?.string)!
        
        // for favorite
        self.is_favorite = (dic["is_favorite"]?.int)!
        if dic["favorite_id"]?.int != nil {
            self.favorite_id = (dic["favorite_id"]?.int)!
        }
        
        // for offers + name_ar , name_en & description
       // if  featured = 0 no offer
       // if featured = 1 offer
        
        self.price_after_discount = (dic["price_after_discount"]?.int)!
        self.discount_percentage = (dic["discount_percentage"]?.int)!
        self.featured = (dic["featured"]?.int)!

        if dic["brand"] != JSON.null {
            self.brandNameAr = dic["brand"]!["name_ar"].string!
            self.brandNameEn = dic["brand"]!["name_en"].string!
        } else {
            
        }
        
        
        
        self.has_sizes = (dic["has_sizes"]?.int)!
        
        let degrees = dic["degrees"]!
        
        let dd = degrees["deviation"].array
         let axi = degrees["axis"].array
          let mp = degrees["myopia"].array
        
        if dd?.isEmpty == false{
            for d in dd! {
                self.dev.append(d.string!)
            }
        }
        
        if axi?.isEmpty == false{
            for d in axi! {
                self.ax.append(d.string!)
            }
        }
        
        if mp?.isEmpty == false{
            for d in mp! {
                self.myopia.append(d.string!)
            }
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    

}
