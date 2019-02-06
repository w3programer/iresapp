//
//  LoginVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    
    
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var signinBtn: CornerButtons!
    @IBOutlet weak var skip: CornerButtons!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTF.attributedPlaceholder = NSAttributedString(string: "Mobile Number", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.115710564, green: 0.5438727736, blue: 0.5560589433, alpha: 1) ])


    }
    
    @IBAction func sginInBtn(_ sender: Any) {
        
        guard let num = numberTF.text, !num.isEmpty else {
            return Alert.alertPopUp(title: "field empty", msg: "please put your number", vc: self)
        }
        
        
        
       
        
    }
    
    
    @IBAction func skipBtn(_ sender: Any) {
        
        let Sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   Sb.instantiateViewController(withIdentifier: "main")
       // self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true,completion: nil)
        
        
    }
    

 
}
