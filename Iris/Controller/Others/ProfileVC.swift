//
//  ProfileVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/5/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    
    @IBOutlet weak var img: CircleImage!
    @IBOutlet weak var nameTF: ImageInsideTextField!
    @IBOutlet weak var numberTF: ImageInsideTextField!
    @IBOutlet weak var emailTF: ImageInsideTextField!
    @IBOutlet weak var cityTF: ImageInsideTextField!
    @IBOutlet weak var update: CornerButtons!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
    }
    

    
    
    @IBAction func updateBtn(_ sender: Any){
        
        guard let name = nameTF.text, !name.isEmpty,
              let number = numberTF.text, !number.isEmpty,
              let email = emailTF.text, !email.isEmpty,
              let city = cityTF.text, !city.isEmpty else {
                return Alert.alertPopUp(title: "fields empty", msg: "please fill al fields", vc: self)
        }
        

        if (email.isValidEmail()) {
            
    
        }else {
            Alert.alertPopUp(title: "not vaild format", msg: "please check your text format", vc: self)
        }
        
    }
    
    
    
    
    
    func disppayLocalization() {
        
        
        
        
    }
   
    
    
    
    //    func confgPickerView()  {
    //        let pickerView = UIPickerView()
    //        pickerView.tag=0
    //        pickerView.delegate = self
    //        cityTF.inputView = pickerView
   //                 }
    
    
}
