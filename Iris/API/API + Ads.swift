//
//  API + Ads.swift
//  Iris
//
//  Created by mahmoudhajar on 2/17/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON




extension API {
    
    
    // yes
    class func sliderData(completion: @escaping(_ err: Error?, _ data:[Slider]?) -> Void) {
        
        let url  = URLs.sliderURL
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
                print("slider data",jsonData)
                
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var slide = [Slider]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Slider.init(dict: data) {
                        slide.append(res)
                        print("good")
                    }
                }
                completion(nil, slide)
            }
        }
    }
    
    class func offers(pageNo:Int,completion: @escaping(_ error: Error?, _ data: [Ads]?) -> Void) {
        
        let url = URLs.offers+"?page=\(pageNo)"
        print(url)
        
        Alamofire.request(url, method: .get ).responseJSON { (response) in
            
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
                print("all categories",jsonData)
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var cate = [Ads]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        cate.append(res)
                        print("good")
                    }
                }
               
                completion(nil, cate)
            }
        }
        
        
    }
    
    
    
    // yes
    class func Categories(pageNo:Int,Id:Int,completion: @escaping(_ error: Error?, _ data: [Ads]?) -> Void) {
        
        let url = URLs.categories+"/\(Id)/"+"products?page=\(pageNo)"
            print(url)
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
                print("category",jsonData)
                
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var cate = [Ads]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        cate.append(res)
                        print("good")
                    }
                }
                completion(nil, cate)
            }
        }
    }
    
    
    class func UserCategories(pageNo:Int,Id:Int,completion: @escaping(_ error: Error?, _ data: [Ads]?) -> Void) {
        
        let url = URLs.categories+"/\(Id)/"+"products?page=\(pageNo)"+"&token="+Helper.getUserToken()
        print(url)
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
                print("category",jsonData)
                
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var cate = [Ads]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        cate.append(res)
                        print("good")
                    }
                }
                completion(nil, cate)
            }
        }
    }
    
    
    
    // yes
    class func sortData(pageNo:Int,Id:Int,typ:Int,completion: @escaping(_ error: Error?, _ data: [Ads]?) -> Void) {
        
        let url = URLs.categories+"/\(Id)/"+"products?page=\(pageNo)&type=\(typ)"
        print(url)
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
                print("category",jsonData)
                
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var cate = [Ads]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        cate.append(res)
                        print("good")
                    }
                }
                completion(nil, cate)
            }
        }
    }
    
    class func UserSortData(pageNo:Int,Id:Int,typ:Int,completion: @escaping(_ error: Error?, _ data: [Ads]?) -> Void) {
        
        let url = URLs.categories+"/\(Id)/"+"products?page=\(pageNo)&type=\(typ)"+"&token="+Helper.getUserToken()
        print(url)
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
                print("category",jsonData)
                
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var cate = [Ads]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        cate.append(res)
                        print("good")
                    }
                }
                completion(nil, cate)
            }
        }
    }
    
    
    // yes
    class func getFavourites(token: String,pageNo:Int,completion: @escaping(_ error: Error?, _ data:[Ads]?) -> Void) {
        
        let url = URLs.favorites+token+"&page=\(pageNo)"
        let new = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(url)
       // let header = "Accept:application/json"
        
        Alamofire.request(new!, method: .get).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
                print("category",jsonData)
                
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var cate = [Ads]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        cate.append(res)
                        print("good")
                    }
                }
                completion(nil, cate)
              }
           }
         }
    
    
    // yes
    class func Search(q:String,pageNo:Int,completion: @escaping(_ error: Error?, _ data:[Ads]?) ->Void ) {
        //http://iris.creativeshare.co/api/search-products?q=شفاف
        // +"?page=\(pageNo)"
        
    let url = URLs.search+q+"&page=\(pageNo)"
      let newurl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        Alamofire.request(newurl!, method: .get).responseJSON { (response) in
         
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
                print("filter data",jsonData)
                
                guard let dataArr = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var filterdData = [Ads]()
                for dta in dataArr {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        filterdData.append(res)
                        print("good")
                    }
                }
                completion(nil, filterdData)
            }
        }
    }
    
    
    class func sendOrder(token:String,name:String,email:String,phone:String,total:Int,itemsList:Array<Any>,product_id:Int,similar:Int,right_degree:Double,left_degree:Double,right_amount:Double,left_amount:Double,package:Int,quantity:Int,totalPro:Int,completion:@escaping(_ error:Error?, _ success:Bool?)->Void) {


       let url = URLs.sendOrder
        print(url)
        let parameter: [String:Any] =
                   [
                    "token":token,
                    "name":name,
                    "email":email,
                    "phone":phone,
                    "total":total,
                    "itemsList":
                             [
                             "product_id":product_id,
                             "similar": similar,
                             "right_degree": right_degree,
                             "left_degree": left_degree,
                             "right_amount": right_amount,
                             "left_amount": left_amount,
                             "package": package,
                             "quantity": quantity,
                             "total":totalPro
                         ]
                  ]
        Alamofire.request(url, method: .post, parameters: parameter , encoding: URLEncoding.httpBody ).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
                print("data",jsonData)

//                guard let dataArr = jsonData["itemsList"].array else{
//                    completion(nil , nil)
//                    return
//                }
                //var Dta = [MyOrder]()
//                for dta in dataArr {
//                    if let data = dta.dictionary , let res = MyOrder.init(dic: data) {
//                        Dta.append(res)
//                        print("good")
//                    }
//                }
                //completion(nil, Dta)

            }
        }
    }
    
    
    
    class func getMyOrders(type:String,completion:@escaping(_ error: Error?, _ data:[MyOrder]?)->Void) {
        
        let url = URLs.main+"api/order-status?type="+type+"&token="+Helper.getUserToken()
        
        print(url)
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                print(error)
                
            case.success(let value):
                let json = JSON(value)
                print(value)
                guard let dataArr = json["data"].array else{
                        completion(nil , nil)
                          return
                        }
                  print(dataArr)
//                guard let itemsArr = dataArr["itemsList"].array else{
//                    completion(nil , nil)
//                    return
//                }
//                print("itemsArray",itemsArr)
                
                
            }
        }
        
    }
    
 
    
   
    
    
    
    
}
