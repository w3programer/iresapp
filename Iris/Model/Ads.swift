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
    
    
    var images:[String] = []
    var id:Int = 0
    var name_ar:String = ""
    var name_en:String = ""
    var price:Int = 0
    var price_after_discount:Int = 0
    var discount_percentage:Int = 0
    var is_favorite:Int = 0
    var description_ar:String = ""
    var featured:Int = 0
    var favorite_id:Int = 0
    
   // var currentPage:Int = 1
    var lastPage:Int = 1
    
    
    init?(dic:[String:JSON]) {
        
        let photos = dic["images"]?.array
        
        for img in photos! {
          guard let photo = img.imagePath, !photo.isEmpty else {return nil}
            self.images.append(photo)
            print("gooo")
        }   
        
        
        self.id = (dic["id"]?.int)!
        self.name_ar = (dic["name_ar"]?.string)!
        self.name_en = (dic["name_en"]?.string)!
        self.price = (dic["price"]?.int)!
        self.description_ar = (dic["description_ar"]?.string)!
        
        
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

        
        
//        if dic["meta"]?["current_page"].int != nil {
//            print("error1")
          //  self.currentPage = (dic["current_page"]?.int)!
//        }else{
//            print("error2")
        
//        }
        
        
//        if dic["meta"]?["last_page"].int != nil {
//            self.lastPage = dic["meta"]!["last_page"].intValue
//        }
//        if dic["last_page"]?.int != nil {
//            self.lastPage = (dic["last_page"]?.int)!
//           print("goooood")
//        } else {
//            print("baaaaaaaad")
//        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    

}
