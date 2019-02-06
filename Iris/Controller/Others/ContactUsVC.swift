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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      self.msgTF.layer.cornerRadius = 10.0
        
        
        
    }
    

    @IBAction func sendBtn(_ sender: Any){
        
        guard let name = nameTF.text, !name.isEmpty,
              let number = numberTF.text, !number.isEmpty,
              let msg = msgTF.text, !msg.isEmpty else
        {
            return Alert.alertPopUp(title: "empty fields", msg: "please fill out all fields", vc: self)
        }
        
                   print(name)
       
    

        }
    
    
    
    
    
    
    
}
