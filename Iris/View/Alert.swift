//
//  Alert.swift
//  Iris
//
//  Created by mahmoudhajar on 2/6/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import Foundation
import UIKit

class Alert {
 
   class func alertPopUp(title: String, msg: String , vc: UIViewController) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: General.stringForKey(key: "OK"), style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    
  
}
