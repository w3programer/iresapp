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
               // print("slider data",jsonData)
                
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var slide = [Slider]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Slider.init(dict: data) {
                        slide.append(res)
                      //  print("good")
                    }
                }
                completion(nil, slide)
            }
        }
    }
    
    class func offers(pageNo:Int,completion: @escaping(_ error: Error?, _ data: [Ads]?) -> Void) {
        
        let url = URLs.offers+"?page=\(pageNo)"
       // print(url)
        
        Alamofire.request(url, method: .get ).responseJSON { (response) in
            
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
              //  print("all categories",jsonData)
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var cate = [Ads]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        cate.append(res)
                       // print("good")
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
             //   print("category",jsonData)
                
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var cate = [Ads]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        cate.append(res)
                       // print("good")
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
                //print(error.localizedDescription)
            case.success(let value):
                let jsonData = JSON(value)
              //  print("category",jsonData)
                
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var cate = [Ads]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        cate.append(res)
                       // print("good")
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
                //print(error.localizedDescription)
            case.success(let value):
                let jsonData = JSON(value)
               // print("category",jsonData)
                
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var cate = [Ads]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        cate.append(res)
                       // print("good")
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
              //  print("category",jsonData)
                
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var cate = [Ads]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        cate.append(res)
                       // print("good")
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
              //  print("category",jsonData)
                
                guard let dataArray = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var cate = [Ads]()
                for dta in dataArray {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        cate.append(res)
                      //  print("good")
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
               /// print("filter data",jsonData)
                
                guard let dataArr = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var filterdData = [Ads]()
                for dta in dataArr {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        filterdData.append(res)
                      //  print("good")
                    }
                }
                completion(nil, filterdData)
            }
        }
    }

    class func sendOrders(params : [String:Any] , completion: @escaping(_ error:Error?, _ success: Bool?)->Void){


        let url = URL(string:URLs.sendOrder)
           print(url!)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")



        if (!JSONSerialization.isValidJSONObject(params)) {
            print("is not a valid json object")
            return
        }

       // let rr =

         //print(rr)
        request.httpBody = try! JSONSerialization.data(withJSONObject: params)
        

        Alamofire.request(request).responseJSON { response in
            switch response.result {
            case.failure(let error):
                print(error)
            case .success(let value):
                let js = JSON(value)
               // print("send order", js)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "send"), object: nil)

                Helper.showSuccess(title: General.stringForKey(key: "suuu"))
            }
        }
    }
    
    class func getSizesData(completion: @escaping(_ error: Error?, _ data:[Package]?)->Void) {
        
        
        let url = URLs.dgree
        
        Alamofire.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
                
            case.success(let value):
               let js = JSON(value)
                // print(js)
               guard let arr = js.array else {
                completion(nil,nil)
                return
                }
                var dd = [Package]()
                
               for ii in arr {
                if let dec = ii.dictionary, let res = Package.init(dic: dec) {
                    dd.append(res)
                    print("success request package")
                      }
                   }
                completion(nil,dd)
            }
          }
       }
    
    
    
    
    class func getMyOrders(type:String,completion:@escaping(_ error: Error?, _ data:[MyOrder]?)->Void) {
        
        let url = URLs.main+"api/order-status?type="+type+"&token="+Helper.getUserToken()
        
        print(url)
        
        Alamofire.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { (response) in
            
            switch response.response?.statusCode {
            case 404?:
                print("my order code 404")
            case 422?:
                print("my order code 422")
            case 500?:
                 print("my order code 500")
            case 200?:
                switch response.result {
                case.failure(let error):
                    print(error.localizedDescription)
                    
                case.success(let value):
                    let json = JSON(value)
                    //print("my orders",value)
                    guard let dataArr = json["data"].array else{
                        completion(nil , nil)
                        return
                    }
                   // print("my orders count = ",dataArr.count)
                    var mod = [MyOrder]()
                    for dd in dataArr {
                        if let di = dd.dictionary, let res = MyOrder.init(dic: di) {
                            mod.append(res)
                            print("sccess fetch my orders")
                        }
                    }
                    completion(nil,mod)
                    
                }
                
            default: break
                
            }
        }
    }
    
 
    
    
    
    
    
    
    
    
    
    class func getQuestions(pageNo:Int,completion:@escaping(_ error:Error?, _ data:[Question]?)->Void) {
        
        let url = URLs.ques+"\(pageNo)"
         print(url)
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
                //print("filter data",jsonData)
                
                guard let dataArr = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var filterdData = [Question]()
                for dta in dataArr {
                    if let data = dta.dictionary , let res = Question.init(dic: data) {
                        filterdData.append(res)
                        //print("good")
                    }
                }
                completion(nil, filterdData)
            }
        }
    }
    
   
    
    
    
}
