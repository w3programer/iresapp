//
//  API.swift
//  Iris
//
//  Created by mahmoudhajar on 2/17/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class API: NSObject {
    
    
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    class func login(num: String, completion: @escaping(_ error: Error?, _ success: Bool?)->Void) {
        
        let url = "http://iris.creativeshare.co/api/login"
        
        let header = [
        
            "Accept": "application/json"
        ]
        
        let para =
        [
            "phone":num
        ]
        
        Alamofire.request(url, method: .post, parameters: para, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                print(error)
                completion(error,false)
            case.success(let value):
                print(value)
                let data = JSON(value)
                if (data["login"].int == 1) {
                    let id = data["id"].int
                    let name = data["name"].string
                    let phone = data["phone"].string
                    let email = data["email"].string
                    let photo = data["avatar"].string
                    let token = data["token"].string
                    
                    Helper.setUserData(id: id!, email: email!, name: name!, phone: phone!, photo: photo!)
                    Helper.saveUserToken(token: token!)
                } else {
                    let msg = data["error"].string
                    Helper.showError(title:msg!)
                }
            }
        }
        
        
    }
    
    class func register(email:String, phone: String, name: String, avatar: UIImage ,completion: @escaping(_ error: Error? , _ success: Bool? ) -> Void) {

       // let url = URLs.sginUp
        let url = "http://iris.creativeshare.co/api/sign-up"
        let parameters:[String:Any] = [
        "email": email,
        "phone": phone,
        "name": name,
         ]

        var headers: [String:String]? = nil


        headers =
            [

                //"Content-type": "application/x-www-form-urlencoded",
                "Content-type": "multipart/form-data",
                "Accept": "application/json"
        ]


        print(headers ?? "no headers")

        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if avatar.size.width != 0 {
                multipartFormData.append(avatar.jpegData(compressionQuality: 0.6)!, withName: "avatar", fileName: "avatar.jpeg", mimeType: "image/jpeg")
            }
            
//            if let data = avatar.jpegData(compressionQuality: 0.6)
//               // UIImageJPEGRepresentation(avatar,0.6)
//
//            {
//                multipartFormData.append(data, withName: "storage", fileName: "avatar.jpeg", mimeType: "image/jpeg")
//            }

        },// usingThreshold:UInt64.init(),
           to: url,
           method: .post,
           headers: headers,
           encodingCompletion: { (result) in

            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("Download Progress: \(progress.fractionCompleted)")
                })
//                upload.responseString(completionHandler: { (response) in
//                    print("successs " + response.result.value!)
//                    })
                upload.responseJSON { response in
                    print (response.result.value!)
                    //let json = response.result.value!
                    //  print (json["name"].String)
                }
                break

            case .failure(let encodingError):
                print("the error is  : \(encodingError.localizedDescription)")

                completion(encodingError, false)
                break
            }
        })

    }
    class func updateProfile(token:String,email:String, phone: String, name: String, avatar: UIImage ,completion: @escaping(_ error: Error? , _ success: Bool? ) -> Void) {
        
        let url = "http://iris.creativeshare.co/api/edit-profile"
        let parameters:[String:Any] = [
            "token":token,
            "email": email,
            "phone": phone,
            "name": name,
            ]
        
        var headers: [String:String]? = nil
        
        
        headers =
            [
                
                //"Content-type": "application/x-www-form-urlencoded",
                "Content-type": "multipart/form-data",
                "Accept": "application/json"
        ]
        
        
        print(headers ?? "no headers")
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            multipartFormData.append(avatar.jpegData(compressionQuality: 0.6)!, withName: "avatar", fileName: "avatar.jpeg", mimeType: "image/jpeg")
            
            //            if let data = avatar.jpegData(compressionQuality: 0.6)
            //               // UIImageJPEGRepresentation(avatar,0.6)
            //
            //            {
            //                multipartFormData.append(data, withName: "storage", fileName: "avatar.jpeg", mimeType: "image/jpeg")
            //            }
            
        },// usingThreshold:UInt64.init(),
            to: url,
            method: .post,
            headers: headers,
            encodingCompletion: { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("Download Progress: \(progress.fractionCompleted)")
                    })
                    //                upload.responseString(completionHandler: { (response) in
                    //                    print("successs " + response.result.value!)
                    //                    })
                    upload.responseJSON { response in
                        print (response.result.value!)
                        //let json = response.result.value!
                        //  print (json["name"].String)
                    }
                    break
                    
                case .failure(let encodingError):
                    print("the error is  : \(encodingError.localizedDescription)")
                    
                    completion(encodingError, false)
                    break
                }
        })
        
    }
   
   
    class func logOut(token:String, completion: @escaping(_ error: Error?, _ success: Bool?) -> Void) {
        
        let url = URLs.sginOut
        let parameter = ["token": token]
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case.failure(let err):
                print(err)
                completion(err,false)
            case.success(let value):
                print(value)
                let json = JSON(value)
                if let msg = json["message"].string {
                    Helper.showSuccess(title: msg)
                    Helper.deletUserDefaults()
                }
            }
        }
    }
  
    
    
    class func selectFav(token:String,proId:Int,completion: @escaping(_ error: Error? , _ success: Bool?)->Void) {
        
        let url = URLs.selectFav

        let para:[String:Any] = [
            "token":token,
            "product_id":proId
           ]
        var headers: [String:String]? = nil
                headers =
                    [
                        //"Content-type": "application/x-www-form-urlencoded",
                       // "Content-type": "multipart/form-data",
                        "Accept": "application/json"
                    ]
        
        print(url)
        Alamofire.request(url, method: .post, parameters: para, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
               switch response.result {
                  case.failure(let err):
                    print(err)
                completion(err,false)
                   case.success(let value):
                     print(value)
                
              }
            }
        }
        
    class func disSelectFav(token:String,id:Int,completion: @escaping(_ error: Error? , _ success: Bool?)->Void) {
        
        
        let url = URLs.disSelect+"\(id)"
        
        let para =
        [
            "token":token,
            "_method": "delete"
            
        ]
        
        var headers: [String:String]? = nil
        headers =
            [
                //"Content-type": "application/x-www-form-urlencoded",
                // "Content-type": "multipart/form-data",
                "Accept": "application/json"
        ]
        
        print(url)
        Alamofire.request(url, method: .post, parameters: para, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case.failure(let err):
                print(err)
                completion(err,false)
            case.success(let value):
                print(value)
                
            }
        }
    }
    
    
    
}
