//
//  MyOrder.swift
//  Iris
//
//  Created by mahmoudhajar on 2/20/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON
/*
{
    "data": [
             {
            "id": 2,
            "total": "100.00",
            "status": 0,
            "updated_at": 1550576784,
             "itemsList": [
                           {
                    "product": {
                        "id": 1,
                        "name_ar": "عدسه ملونة بيضة",
                        "name_en": "lens",
                        "description_en": "lens",
                        "description_ar": "عدسه",
                        "price": 110,
                        "price_after_discount": 0,
                        "discount_percentage": 0,
                     "images": [
                        "main_categories/drop.png",
                        "main_categories/Eye-PNG-Pic.png",
                        "main_categories/tranpaent.png"
                              ],
                        "featured": 0,
                       "is_favorite": 1,
                       "favorite_id": 4,
                       "sales": 0,
                       "has_sizes": 0,
                    "brand": {
                       "name_ar": "بولس",
                       "name_en": "police"
                             }
                          },
                    "similar": 0,
                    "right_degree": "1.50",
                    "left_degree": "1.20",
                    "right_amount": 12,
                    "left_amount": 10,
                    "package": 30,
                    "quantity": 2,
                     "total": 1000
                       }
                     ]
                   },
                {
    "id": 6,
    "total": "100.00",
    "status": 0,
    "updated_at": 1550664608,
    "itemsList": [
    {
    "product": {
    "id": 1,
    "name_ar": "عدسه ملونة بيضة",
    "name_en": "lens",
    "description_en": "lens",
    "description_ar": "عدسه",
    "price": 110,
    "price_after_discount": 0,
    "discount_percentage": 0,
    "images": [
    "main_categories/drop.png",
    "main_categories/Eye-PNG-Pic.png",
    "main_categories/tranpaent.png"
    ],
    "featured": 0,
    "is_favorite": 1,
    "favorite_id": 4,
    "sales": 0,
    "has_sizes": 0,
    "brand": {
    "name_ar": "بولس",
    "name_en": "police"
    }
    },
    "similar": 0,
    "right_degree": "1.50",
    "left_degree": "1.20",
    "right_amount": 12,
    "left_amount": 10,
    "package": 30,
    "quantity": 2,
    "total": 1000
    },
    {
    "product": {
    "id": 2,
    "name_ar": "عدسه شفاف",
    "name_en": "lens",
    "description_en": "lens",
    "description_ar": "عدسه",
    "price": 100,
    "price_after_discount": 0,
    "discount_percentage": 0,
    "images": null,
    "featured": 0,
    "is_favorite": 1,
    "favorite_id": 5,
    "sales": 0,
    "has_sizes": 1,
    "brand": {
    "name_ar": "بولس",
    "name_en": "police"
    }
    },
    "similar": 0,
    "right_degree": "1.50",
    "left_degree": "1.30",
    "right_amount": 12,
    "left_amount": 15,
    "package": 90,
    "quantity": 2,
    "total": 200
    }
    ]
    },
    {
    "id": 7,
    "total": "100.00",
    "status": 0,
    "updated_at": 1550664712,
    "itemsList": [
    {
    "product": {
    "id": 1,
    "name_ar": "عدسه ملونة بيضة",
    "name_en": "lens",
    "description_en": "lens",
    "description_ar": "عدسه",
    "price": 110,
    "price_after_discount": 0,
    "discount_percentage": 0,
    "images": [
    "main_categories/drop.png",
    "main_categories/Eye-PNG-Pic.png",
    "main_categories/tranpaent.png"
    ],
    "featured": 0,
    "is_favorite": 1,
    "favorite_id": 4,
    "sales": 0,
    "has_sizes": 0,
    "brand": {
    "name_ar": "بولس",
    "name_en": "police"
    }
    },
    "similar": 0,
    "right_degree": "1.50",
    "left_degree": "1.20",
    "right_amount": 12,
    "left_amount": 10,
    "package": 30,
    "quantity": 2,
    "total": 1000
    },
    {
    "product": {
    "id": 2,
    "name_ar": "عدسه شفاف",
    "name_en": "lens",
    "description_en": "lens",
    "description_ar": "عدسه",
    "price": 100,
    "price_after_discount": 0,
    "discount_percentage": 0,
    "images": null,
    "featured": 0,
    "is_favorite": 1,
    "favorite_id": 5,
    "sales": 0,
    "has_sizes": 1,
        "brand": {
           "name_ar": "بولس",
            "name_en": "police"
        }
    },
    "similar": 0,
    "right_degree": "1.50",
    "left_degree": "1.30",
    "right_amount": 12,
    "left_amount": 15,
    "package": 90,
    "quantity": 2,
    "total": 200
          }
        ]
        }
    ],
    "links": {
        "first": "http://127.0.0.1:8000/api/order-status?page=1",
        "last": "http://127.0.0.1:8000/api/order-status?page=1",
        "prev": null,
        "next": null
    },
    "meta": {
        "current_page": 1,
        "from": 1,
        "last_page": 1,
        "path": "http://127.0.0.1:8000/api/order-status",
        "per_page": 10,
        "to": 3,
        "total": 3
    }
}

*/

class MyOrder: NSObject {
    
    
    var product_id:Int = 1
    var similar:Int = 0
    var right_degree:Double = 1.0
    var left_degree:Double = 1.0
    var right_amount:Int = 1
    var left_amount:Int = 1
    var package:Int =  1
    var quantity:Int = 1
    var total:Int = 1
    
    
     init?(dic:[String:JSON]) {
        
        self.product_id = (dic["product_id"]?.int)!
        self.similar = (dic["similar"]?.int)!
        self.right_degree = (dic["right_degree"]?.double)!
        self.left_degree = (dic["left_degree"]?.double)!
        self.right_amount = (dic["right_amount"]?.int)!
        self.left_amount = (dic["left_amount"]?.int)!
        self.package = (dic["package"]?.int)!
        self.quantity = (dic["quantity"]?.int)!
        self.total = (dic["total"]?.int)!
        
    }
    
    

}
