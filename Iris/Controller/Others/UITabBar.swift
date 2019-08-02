//
//  UITabBar.swift
//  Zi Elengaz
//
//  Created by mahmoudhajar on 3/22/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class TabBarController: UITabBarController {
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if Helper.checkToken() == true {
//            if API.isConnectedToInternet() {
//                getUnread()
//            }
//        }
        
        
        if General.CurrentLanguage() == "ar" {
            UITabBar.appearance().semanticContentAttribute = .forceLeftToRight
            
        } else {
            UITabBar.appearance().semanticContentAttribute =  .forceRightToLeft
            
        }
        
        self.tabBar.items![0].title = General.stringForKey(key: "market")
        self.tabBar.items![1].title = General.stringForKey(key: "offers")
        self.tabBar.items![2].title = General.stringForKey(key: "myor")
        self.tabBar.items![3].title = General.stringForKey(key: "spe")
        self.tabBar.items![4].title = General.stringForKey(key: "menu")

        self.navigationItem.backBarButtonItem?.title = General.stringForKey(key: "back")
    }
    
    
//    func getUnread() {
//        let url = URLs.main+"Api/getAlerts?user_id=\(Helper.getUserId())&type=unread"
//        print(url)
//        Alamofire.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { (response) in
//            switch response.result {
//            case.failure(let error):
//                print("count error",error)
//            case.success(let value):
//                let js = JSON(value)
//                print(js)
//                let nu = js["count"].int
//                if nu! > 0 {
//                    self.tabBar.items![2].badgeValue = "\(nu!)"
//                }
//                print("count nofificatiion")
//            }
//        }
//
//    }

    
    
}
