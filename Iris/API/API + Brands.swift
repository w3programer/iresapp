//
//  API + Brands.swift
//  Iris
//
//  Created by mahmoudhajar on 4/4/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD



extension API  {
    
    class func getBrands(pageNo:Int,completion:@escaping(_ error:Error?, _ data:[Brand]?)->Void) {
        let url = URLs.barnds+"\(pageNo)"
       // print("get brands",url)
        Alamofire.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { (response) in
            
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
               // print("Brand data",jsonData)
                
                guard let dataArr = jsonData["data"].array else{
                    completion(nil , nil)
                    return }
                var filterdData = [Brand]()
                for dta in dataArr {
                    if let data = dta.dictionary , let res = Brand.init(dic: data) {
                        filterdData.append(res)
                       // print("Brand")
                    }}
                completion(nil, filterdData)
              }}}
    
    class func getBrandModels(id:Int,pageNo:Int,completion:@escaping(_ error:Error?, _ data:[Ads]?)->Void) {
        
        let url = URLs.brandModel+"\(id)"+"?page=\(pageNo)"
      //  print(url)
        
        Alamofire.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { (response) in
            
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
               // print("Brand data",jsonData)
                guard let dataArr = jsonData["data"].array else{
                    completion(nil , nil)
                    return }
                var filterdData = [Ads]()
                for dta in dataArr {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        filterdData.append(res)
                       // print("Brand")
                    }}
                completion(nil, filterdData)
            }}}
    
    
    class func getTrends(barnId:Int,cuPage:Int,completion:@escaping(_ error:Error?, _ data:[Trend]?)->Void) {
        let url = URLs.trend+"\(cuPage)&barnds_id=\(barnId)"
          // print(url)
        Alamofire.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result  {
            case.failure(let error):
                 completion(error, nil)
                print(error)
            case.success(let value):
                 let js = JSON(value)
                  // print("trends datttta",js)
                 guard let dataArr = js["data"].array else{
                    completion(nil , nil)
                    return }
                 var filterdData = [Trend]()
                 for dta in dataArr {
                    if let data = dta.dictionary , let res = Trend.init(dic: data) {
                        filterdData.append(res)
                        //print("treeeeeeeends")
                    }}
                 completion(nil, filterdData)
            }}}
    
    class func trend(pg:Int,id:Int, compltion:@escaping(_ error:Error?, _ data:[Trend]?)->Void) {
        
        
        let url = URLs.trend+"\(pg)&barnds_id=\(id)"
          // print(url)
        Alamofire.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.response?.statusCode {
//            case 400?:
//                print("trends 400")
//            case 422:
//                print("trends 422")
//            case 500?:
//                print("trends 500")
            case 200?:
                switch response.result {
                case.failure(let error):
                    print(error)
                    compltion(error, nil)
                case .success(let value):
                    let json = JSON(value)
                    if let arr = json["data"].array {
                        for dta in arr {
                            let brndId = dta["id"].int
                            if id == brndId {
                                if let trndData = dta["trends"].array {
                                   // print("inside trend")
                                    var tn = [Trend]()
                                    for dd in trndData {
                                      if let dc = dd.dictionary,
                                        let res = Trend.init(dic: dc) {
                                        tn.append(res)
                                        }}}}}}}
            default:break
            }}}
    
    
    
    
    class func getTrendsModels(id:Int,pageNo:Int,completion:@escaping(_ error:Error?, _ data:[Ads]?)->Void) {
        
        let url = URLs.treendsModel+"\(id)"+"?page=\(pageNo)"
     //   print(url)
        
        Alamofire.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { (response) in
            
            switch response.result {
            case.failure(let error):
                completion(error,nil)
                print(error)
            case.success(let value):
                let jsonData = JSON(value)
               // print("Brand data",jsonData)
                guard let dataArr = jsonData["data"].array else{
                    completion(nil , nil)
                    return
                }
                var filterdData = [Ads]()
                for dta in dataArr {
                    if let data = dta.dictionary , let res = Ads.init(dic: data) {
                        filterdData.append(res)
                       // print("Brand")
                    }}
                completion(nil, filterdData)
            }}}
    
    
}
