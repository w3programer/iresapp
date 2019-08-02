//
//  LoginVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SVProgressHUD


class LoginVC: UIViewController {

    
    
    
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var signinBtn: CornerButtons!
    @IBOutlet weak var skip: CornerButtons!
    @IBOutlet weak var signUP: CornerButtons!
   
    
    
    @IBOutlet weak var nuView: UIView!
    @IBOutlet weak var byLabel: SpringLabel!    
    @IBOutlet weak var termLabel: SpringLabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
//        if General.CurrentLanguage() == "ar"
//        {
//         numberTF.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
//            numberTF.placeholder = General.stringForKey(key: "n")
//
//        }
        setLoca()
          setDes()
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginVC.imageTapped(gesture:)))
        termLabel.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UILabel) != nil {
            performSegue(withIdentifier: "ttSegue", sender: self)
            print("Terms Tapped")
            
        }
    }
    
    @IBAction func sginInBtn(_ sender: Any) {
          Helper.hudStart()
        guard let num = numberTF.text, !num.isEmpty else {
            SVProgressHUD.dismiss()
            Alert.alertPopUp(title: General.stringForKey(key: "emf"), msg: General.stringForKey(key: "mnr"), vc: self)
            return
        }
        
        API.login(num: num) { (error: Error?, success:Bool?) in
            if success == true {
                
            } else {
            }
        }
        SVProgressHUD.dismiss(withDelay: 2.0)
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        UIView.animate(withDuration: 3.0, delay: 0.0, options: .transitionCurlUp, animations: {
            self.performSegue(withIdentifier:"RegisterSegue", sender: self)
        })

    }
    
    
    
    
    @IBAction func skipBtn(_ sender: Any) {
        
        let Sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =   Sb.instantiateViewController(withIdentifier: "main")
        self.present(vc, animated: true,completion: nil)
        
        
    }
    
    
    func setLoca() {
        
        numberTF.placeholder = General.stringForKey(key: "n")
        signinBtn.setTitle(General.stringForKey(key: "sginin"), for: .normal)
        skip.setTitle(General.stringForKey(key: "skip"), for: .normal)
        signUP.setTitle(General.stringForKey(key:"sginup"), for: .normal)
        termLabel.text = General.stringForKey(key: "rules")
        byLabel.text = General.stringForKey(key: "byUsing")
        
    }

    
    func setDes() {
        
        numberTF.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("mobile number", comment: "mobile number"), attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.115710564, green: 0.5438727736, blue: 0.5560589433, alpha: 1) ])
        
        self.skip.layer.borderColor = #colorLiteral(red: 0.115710564, green: 0.5438727736, blue: 0.5560589433, alpha: 1)
         self.skip.layer.borderWidth = 2
          self.signUP.layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
           self.signUP.layer.borderWidth = 2
        nuView.setRoundCorners(25.0)
         self.numberTF.setLeftPaddingPoints(5.0)
        
    }
 
}
