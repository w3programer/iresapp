//
//  ContactUsVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/5/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class ContactUsVC: UIViewController {

    
    
    
    @IBOutlet weak var nameTF: ImageInsideTextField!
    @IBOutlet weak var numberTF: ImageInsideTextField!
    @IBOutlet weak var msgTF: UITextView!
    
    @IBOutlet weak var send: CornerButtons!
    
    
    @IBOutlet weak var namViw: UIView!
    
    @IBOutlet weak var emaViw: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      self.msgTF.layer.cornerRadius = 10.0
      self.nameTF.placeholder = General.stringForKey(key: "name")
      self.nameTF.placeholder = General.stringForKey(key: "email")
      self.send.setTitle(General.stringForKey(key: "send"), for: .normal)

        
    }
    

    @IBAction func sendBtn(_ sender: Any){
        
        guard let name = nameTF.text, !name.isEmpty,
              let number = numberTF.text, !number.isEmpty,
              let msg = msgTF.text, !msg.isEmpty else
        {
            return Alert.alertPopUp(title: "empty fields", msg: "please fill out all fields", vc: self)
        }
        
        API.ContactUS(name: name, phone: Int(number)!, message: msg) { (error:Error?, success:Bool?) in
            if success == true {
                
            } else {
                Helper.showError(title: General.stringForKey(key: "er"))
            }
        }
                   
       
    

        }
    
    
    
    
    
    
    
}
