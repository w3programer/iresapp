//
//  SendOrderModel.swift
//  Iris
//
//  Created by Ghoost on 5/12/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

/*
 
 product_id": 1,
 "similar": 0,
 "right_degree": 1.5,
 "left_degree": 1.2,
 "right_amount": 12,
 "left_amount": 10,
 "left_deviation":20,
 "right_deviation":20,
 "left_axis":0.75,
 "right_axis":0.75,
 "type": 0,
 "quantity": 2,
 "total":1000
 
 */

import UIKit

struct personal {
    
    var token:String = ""
     var name:String  = ""
      var email:String =  ""
       var phone:String =  ""
       var coupon_code:String =  ""
      var coupon_value:Int = 0
     var total_after_discount:Int = 0
    var total:Int =  1
    var ItemList = [ItemsList]()
    
    init(token:String, name:String, email:String, phone:String, coupon_code:String, coupon_value:Int, total_after_discount:Int , total:Int , ItemList:[ItemsList]  ) {
        self.token = token
         self.name = name
          self.email = email
            self.phone = phone
             self.coupon_code = coupon_code
             self.coupon_value = coupon_value
            self.total_after_discount = total_after_discount
           self.total = total
          self.ItemList = ItemList
    }
    
}


class Lis {
   var product_id:Int!
    var similar:Int!
     var right_degree:Double!
      var left_degree:Double!
       var right_amount:Int!
        var left_amount:Int!
         var left_deviation:Int!
         var right_deviation:Int!
          var left_axis:Double!
          var right_axis:Double!
           var type:Int!
            var quantity:Int!
             var total:Int!
    
  //  init(){}
    init(product_id:Int,
          similar:Int,
           right_degree:Double,
            left_degree:Double,
             right_amount:Int,
              left_amount:Int,
               left_deviation:Int,
                right_deviation:Int,
                 left_axis:Double,
                  right_axis:Double,
                   type:Int,
                    quantity:Int,
                     total:Int) {
        
      self.product_id = product_id
        self.similar = similar
        self.right_degree = right_degree
         self.left_degree = left_degree
          self.right_amount = right_amount
           self.left_amount = left_amount
            self.right_deviation = right_deviation
             self.left_deviation = left_deviation
              self.left_axis = left_axis
               self.right_axis = right_axis
                self.type = type
                 self.quantity = quantity
                   self.total = total
        
        
        
    }
//    func getDictFormat() -> [String: Any]{
//
//        return ["product_id" : product_id!,
//                 "similar" : similar!,
//                  "right_degree" : right_degree!,
//                   "left_degree" : left_degree!,
//                    "right_amount":right_amount!,
//                     "left_amount":left_amount!,
//                     "right_deviation":right_deviation!,
//                    "left_deviation":left_deviation!,
//                   "left_axis":left_axis!,
//                  "right_axis":right_axis!,
//                 "type":type!,
//                "quantity":quantity!,
//                "total":total!
//              ]
//           }
}
