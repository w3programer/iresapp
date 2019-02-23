//
//  Helper.swift
//  Iris
//
//  Created by mahmoudhajar on 2/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SVProgressHUD

class Helper: NSObject {

    class func restartApp() {
        
        guard let window = UIApplication.shared.keyWindow else {return}
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        if checkToken() == false {
            vc = sb.instantiateInitialViewController()!
        } else {
            vc = sb.instantiateViewController(withIdentifier: "main")
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
    }
    
    class func saveUserToken(token: String) {
      let def = UserDefaults.standard
        def.setValue(token, forKey: "token")
          def.synchronize()
        restartApp()
    }
    
    class func checkToken()->Bool {
        let def = UserDefaults.standard
        return (def.object(forKey: "token") as? String) != nil
        
    }
    
    class func getUserToken() -> String {
        let def = UserDefaults.standard
        return (def.object(forKey: "token") as! String)
    }
    
    class func setUserData(id:Int,email:String,name:String,phone:String,photo:String){
        
        let def = UserDefaults.standard
        def.setValue(id, forKey: "id")
        def.setValue(email, forKey: "email")
        def.setValue(name, forKey: "name")
        def.setValue(phone, forKey: "phone")
        def.setValue(photo, forKey: "photo")
        def.synchronize()
        restartApp()
    }
    
    class func deletUserDefaults() {
        
        let def = UserDefaults.standard
        def.removeObject(forKey: "email")
        def.removeObject(forKey: "name")
        def.removeObject(forKey: "photo")
        def.removeObject(forKey: "id")
        def.removeObject(forKey: "token")
        UserDefaults.standard.synchronize()
        
        restartApp()
        
    }
    
    
   class func hudStart() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setForegroundColor(UIColor.white)           //Ring Color
        SVProgressHUD.setBackgroundColor(UIColor.darkGray)        //HUD Color
        SVProgressHUD.setRingThickness(6.0)
        //SVProgressHUD.setBackgroundLayerColor(UIColor.green)    //Background Color
        SVProgressHUD.show()
    }

    
    class func showSuccess(title:String){
        
        SVProgressHUD.show(UIImage(named: "cor.png")!, status: title)
        SVProgressHUD.setShouldTintImages(false)
        SVProgressHUD.setImageViewSize(CGSize(width: 40, height: 40))
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 20.0))
        SVProgressHUD.dismiss(withDelay: 2.5)
        
    }
    
    class func showError(title:String) {
        
        SVProgressHUD.show(UIImage(named: "er.png")!, status: title)
        SVProgressHUD.setShouldTintImages(false)
        SVProgressHUD.setImageViewSize(CGSize(width: 40, height: 40))
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 20.0))
        SVProgressHUD.dismiss(withDelay: 2.5)
    }
    
}
