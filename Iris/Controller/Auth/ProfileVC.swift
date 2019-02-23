//
//  ProfileVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/5/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD

class ProfileVC: UIViewController {

    
    @IBOutlet weak var img: CircleImage!
    @IBOutlet weak var nameTF: ImageInsideTextField!
    @IBOutlet weak var numberTF: ImageInsideTextField!
    @IBOutlet weak var emailTF: ImageInsideTextField!
    @IBOutlet weak var update: CornerButtons!
    
    
    var imge = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.imageTapped(gesture:)))
        img.addGestureRecognizer(tapGesture)
       
        Helper.hudStart()
        SVProgressHUD.dismiss(withDelay: 1.5)
        dislayUserInfo()
        
        setLoca()
        
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            getImage()
        }
    }


    
    
    @IBAction func updateBtn(_ sender: Any){
        Helper.hudStart()
        if Helper.checkToken() == false {
        guard let name = nameTF.text, !name.isEmpty,
              let number = numberTF.text, !number.isEmpty,
              let email = emailTF.text, !email.isEmpty else {
                SVProgressHUD.dismiss()
                return Alert.alertPopUp(title: "fields empty", msg: "please fill al fields", vc: self)
        }
        if (email.isValidEmail()) {
            API.register(email: email, phone: number, name: name, avatar: imge) { (error:Error?, success:Bool?) in
                if success == true {
                  print("cscs")
                    SVProgressHUD.dismiss()
                } else {
                    SVProgressHUD.dismiss()
                    print("errorrrr")
                }
            }
        }else {
            Alert.alertPopUp(title: "not vaild format", msg: "please check your mail format", vc: self)
            SVProgressHUD.dismiss()

        }
        } else {
            
            API.updateProfile(token: Helper.getUserToken(), email: emailTF.text!, phone: nameTF.text!, name: nameTF.text!, avatar: img.image!) { (error:Error?, success:Bool?) in
                if success == true {
                    SVProgressHUD.dismiss()
                } else {
                    Helper.showError(title: "Error!!.please try again later")
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    
    
    
   fileprivate func dislayUserInfo() {
        if Helper.checkToken() == true {
            //self.navigationController?.navigationItem.title = "Update profile"
            navigationItem.title = General.stringForKey(key: "profile")
            update.setTitle(General.stringForKey(key: "update"), for: .normal)
            self.nameTF.text = (UserDefaults.standard.object(forKey: "name") as! String)
            self.numberTF.text = (UserDefaults.standard.object(forKey: "phone") as! String)
            self.emailTF.text = (UserDefaults.standard.object(forKey: "email") as! String)
            let phto = (UserDefaults.standard.object(forKey: "photo") as! String)
            let urlStr = URLs.image+phto
            let url = URL(string: urlStr)
            img.kf.indicatorType = .activity
            img.kf.setImage(with: url)
        } else {
              navigationItem.title = General.stringForKey(key: "sginup")
            self.nameTF.text = General.stringForKey(key: "name")
            self.numberTF.text = General.stringForKey(key: "n")
            self.emailTF.text = General.stringForKey(key: "email")
            self.update.setTitle(General.stringForKey(key: "sginup"), for: .normal)
            self.img.image = UIImage(named: "profileImage.png")
       }
    }
    
 
   
    
    func getImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        let pickAlert = UIAlertController(title: "Add Picture", message: "please select", preferredStyle: .alert)
        pickAlert.addAction(UIAlertAction(title: "take a photo", style: .default, handler: { (action) in
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }))
        pickAlert.addAction(UIAlertAction(title: "choose from camera roll", style: .default, handler: { (action) in
            picker.sourceType = .photoLibrary
            self.present(picker , animated: true, completion: nil)
        }))
        pickAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            pickAlert.dismiss(animated: true, completion: nil)
        }))
        self.present(pickAlert, animated: true, completion: nil)
        
        picker.delegate = self
        
    }
    
    
    var pickedImg: UIImage? {
        didSet {
            guard let image = pickedImg else {return}
            img.image = image
            self.imge = image
        }
    }
    
   
    func setLoca() {
       nameTF.placeholder = General.stringForKey(key: "name")
       emailTF.placeholder = General.stringForKey(key: "email")
       numberTF.placeholder = General.stringForKey(key: "n")
        if Helper.checkToken() == true {
            update.setTitle(General.stringForKey(key: "update"), for: .normal)
        } else {
            update.setTitle(General.stringForKey(key: "send"), for: .normal)
        }
        
        
    }
    
    
}
extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imgEdited = info[.editedImage] as? UIImage {
            self.pickedImg = imgEdited
        } else if let orignalImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.pickedImg = orignalImg
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

