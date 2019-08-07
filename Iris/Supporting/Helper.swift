//
//  Helper.swift
//  Iris
//
//  Created by mahmoudhajar on 2/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreData

class Helper: NSObject {

    class func restartApp() {
        
        guard let window = UIApplication.shared.keyWindow else {return}
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        if checkUserId() == false {
            vc = sb.instantiateInitialViewController()!
        } else {
            vc = sb.instantiateViewController(withIdentifier: "main")
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionCurlDown, animations: nil, completion: nil)
        
    }
    
    
    
    class func saveUserId(id: Int) {
      let def = UserDefaults.standard
        def.setValue(id, forKey: "id")
          def.synchronize()
        restartApp()
    }
    
    class func checkUserId()->Bool {
        let def = UserDefaults.standard
        return (def.object(forKey: "id") as? Int) != nil
        
    }
    
    class func getUserId() -> Int {
        let def = UserDefaults.standard
        return (def.object(forKey: "id") as! Int)
    }
    
    // Company ID
    
    class func saveCompanyId(id: Int) {
        let def = UserDefaults.standard
        def.setValue(id, forKey: "company_id")
        def.synchronize()
        restartApp()
    }
    
    class func checkCompanyId()->Bool {
        let def = UserDefaults.standard
        return (def.object(forKey: "company_id") as? Int) != nil
        
    }
    
    class func getCompanyId() -> Int {
        let def = UserDefaults.standard
        return (def.object(forKey: "company_id") as! Int)
    }
    
    
    
    
    // USER TYPE
    class func saveUserType(type: String) {
        let def = UserDefaults.standard
        def.setValue(type, forKey: "user_type")
        def.synchronize()
    }
    
    
    class func getUserType() -> String{
        let def = UserDefaults.standard
        return (def.object(forKey: "user_type") as! String)
        
      //  def.synchronize()
    }
    
    
    
    
    
    class func setUserData(token:String,
                            email:String,
                             name:String,
                              phone:String,
                               codePhone:String,
                               logo:String){
        
          let def = UserDefaults.standard
           def.setValue(token, forKey: "token")
            def.setValue(email, forKey: "email")
             def.setValue(name, forKey: "name")
              def.setValue(phone, forKey: "phone")
               def.setValue(codePhone, forKey: "codePhone")
                def.setValue(logo, forKeyPath: "logo")
                def.synchronize()
                 restartApp()
    }
    
    class func deletUserDefaults() {
        
        let def = UserDefaults.standard
        def.removeObject(forKey: "email")
        def.removeObject(forKey: "name")
        def.removeObject(forKey: "logo")
        def.removeObject(forKey: "id")
        def.removeObject(forKey: "token")
        def.removeObject(forKey: "user_type")
        def.removeObject(forKey: "company_id")
        
        UserDefaults.standard.synchronize()
        
        restartApp()
        
    }
    
    
    class func setCompanyData(average_rate:String,
                               company_logo:String,
                                title:String,
                                 company_information:String,
                                  latitude:String,
                                   longitude:String,
                                   city:String,
                                   address:String,
                                   commercial_register_image:String,
                                   accepted:String,
                                   is_avaliable:String,
                                   user_id:String
                                   ){
        
        let def = UserDefaults.standard
        def.setValue(average_rate, forKey: "average_rate")
        def.setValue(title, forKey: "title")
        def.setValue(company_information, forKey: "company_information")
        def.setValue(latitude, forKey: "latitude")
        def.setValue(longitude, forKey: "longitude")
        def.setValue(city, forKeyPath: "city")
        def.setValue(address, forKeyPath: "address")
        def.setValue(commercial_register_image, forKeyPath: "commercial_register_image")
        def.setValue(accepted, forKeyPath: "accepted")
        def.setValue(is_avaliable, forKeyPath: "is_avaliable")
        def.setValue(user_id, forKeyPath: "user_id")

        def.synchronize()
        //restartApp()
    }
    
   class func hudStart() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setForegroundColor(UIColor.darkGray)           //Ring Color
        SVProgressHUD.setBackgroundColor(UIColor.lightGray)        //HUD Color
        SVProgressHUD.setRingThickness(3.0)
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
    
    
    
    //MARK:- SET states bar backgroundColor
    class func statusBar(colr: UIColor ) {
        
        guard let statusBarView = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else {return}
        statusBarView.backgroundColor = colr
        
    }
    
    //Mark:- background Image for navigation
    class func setBackgroundIamgeForNavigation(img:UIImage, vc:UIViewController) {
        vc.navigationController?.navigationBar.setBackgroundImage(img.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        
    }
    
    //Mark:- convert to JSON
//    class func toJSON(object:Any)->String {
//        if let json = try? JSONSerialization.data(withJSONObject: object, options: []) {
//            return  String(data: json, encoding: String.Encoding.utf8)!
//        }
//        return ""
//    }
    
    class func toJSON(object:Any)->String {
        if let json = try? JSONSerialization.data(withJSONObject: object, options: []) {
            return  String(data: json , encoding: String.Encoding.utf8)!
        }
        return ""
    }
    
    
//    class func deleteAllData(_ entity:String) {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//        do {
//            let results = try context.fetch(fetchRequest)
//            for object in results {
//                guard let objectData = object as? NSManagedObject else {continue}
//                context.delete(objectData)
//                try context.save()
//
//            }
//        } catch let error {
//            print("Detele all data in \(entity) error :", error)
//        }
 //   }


    class func showIndicator(viewController: UIViewController ) {
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .gray
        activityIndicator.center = viewController.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        viewController.view.addSubview(activityIndicator)
        
    }




}
