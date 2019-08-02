//
//  SignUpVC.swift
//  Iris
//
//  Created by mahmoudhajar on 3/7/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SVProgressHUD


class SignUpVC: UIViewController {

    @IBOutlet weak var imag: CircleImage!
 //   @IBOutlet weak var nameTF: ImageInsideTextField!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: ImageInsideTextField!
    @IBOutlet weak var mobileNumTF: ImageInsideTextField!
    @IBOutlet weak var signUp: CornerButtons!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var nameView: SpringView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var termView: SpringView!
    @IBOutlet weak var termLabel: SpringLabel!
    @IBOutlet weak var chckButn: UIButton!
    @IBOutlet weak var acceptLabel: SpringLabel!
    @IBOutlet weak var personalLabel: UILabel!
    @IBOutlet weak var profileLabel: SpringLabel!
    @IBOutlet weak var stepLabel: SpringLabel!
    
    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var pixelLabel: UILabel!
    
    
    var img = UIImage()
    
    
    var buttonSwtched : Bool = false
    var agre:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        setLoca()
         applyDes()
        
        
    
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpVC.imageTapped(gesture:)))
        imag.addGestureRecognizer(tapGesture)
        
        let tpGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpVC.labTapped(gesture:)))
        termLabel.addGestureRecognizer(tpGesture)
        
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            getImage()
        }
    }
    
    @objc func labTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UILabel) != nil {
            print("terms Tapped")
            performSegue(withIdentifier:"trSegue", sender: self)
        }
    }
    
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        Helper.hudStart()
        
        guard let nam = nameTF.text, !nam.isEmpty,
              let ema = emailTF.text, !ema.isEmpty,
              let  num = mobileNumTF.text, !num.isEmpty
            else {
              SVProgressHUD.dismiss()
                return Alert.alertPopUp(title: General.stringForKey(key: "emf"), msg: General.stringForKey(key: "plz"), vc: self)
                 }
        if agre == 1 {
            if img.size.width != 0 {
                API.register(email: ema, phone: num, name: nam, avatar: img) { (error:Error?, success:Bool?) in
                    if success == true {
                        SVProgressHUD.dismiss()
                    } else {
                        SVProgressHUD.dismiss()
                    }
                }
            } else {
                img = UIImage(named: "profileImage")!
                API.register(email: ema, phone: num, name: nam, avatar: img) { (error:Error?, success:Bool?) in
                    if success == true {
                        SVProgressHUD.dismiss()
                    } else {
                        SVProgressHUD.dismiss()
                    }
                }
            }
            
        } else {
            SVProgressHUD.dismiss()
           Alert.alertPopUp(title: General.stringForKey(key: "noti"), msg: General.stringForKey(key: "selec"), vc: self)
        }
        SVProgressHUD.dismiss(withDelay: 2.0)
        
    }
    
    @IBAction func checkBtn(_ sender: UIButton) {
        
        self.buttonSwtched = !self.buttonSwtched
        
        if self.buttonSwtched {
            
            self.chckButn.setImage(UIImage(named: "chk"), for: .normal)
              self.agre = 1
               
            } else {
            
            
            self.chckButn.setImage(UIImage(named: "ch"), for: .normal)
               self.agre = 0
            
            
            }
        
    }
    
    func setLoca() {
        self.nameTF.placeholder = General.stringForKey(key: "name")
         self.emailTF.placeholder = General.stringForKey(key: "email")
          self.mobileNumTF.placeholder = General.stringForKey(key: "n")
           self.signUp.setTitle(General.stringForKey(key:"sginup"), for: .normal)
          self.stepLabel.text = General.stringForKey(key: "step")
         self.profileLabel.text = General.stringForKey(key: "profile")
        self.acceptLabel.text = General.stringForKey(key: "accept")
         self.uploadLabel.text = General.stringForKey(key: "upPh")
          self.pixelLabel.text = General.stringForKey(key: "pixl")
           self.termLabel.text = General.stringForKey(key: "rules")
            self.personalLabel.text = General.stringForKey(key: "pers")
        
    }
    
    func getImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        let pickAlert = UIAlertController(title: General.stringForKey(key: "Add Picture"), message: General.stringForKey(key: "Select image"), preferredStyle: .alert)
        pickAlert.addAction(UIAlertAction(title: General.stringForKey(key: "take a photo"), style: .default, handler: { (action) in
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }))
        pickAlert.addAction(UIAlertAction(title:General.stringForKey(key: "choose from camera roll"), style: .default, handler: { (action) in
            picker.sourceType = .photoLibrary
            self.present(picker , animated: true, completion: nil)
        }))
        pickAlert.addAction(UIAlertAction(title: General.stringForKey(key: "Cancel"), style: .cancel, handler: { (action) in
            pickAlert.dismiss(animated: true, completion: nil)
        }))
        self.present(pickAlert, animated: true, completion: nil)
        
        picker.delegate = self
        
    }
    
    
    var pickedImg: UIImage? {
        didSet {
            guard let image = pickedImg else {return}
            imag.image = image
            self.img = image
        }
    }
    
    func applyDes() {
        
        self.emailView.setRoundCorners(25.0)
         self.nameView.setRoundCorners(25.0)
          self.phoneView.setRoundCorners(25.0)
        
        self.nameTF.setLeftPaddingPoints(8.0)
         self.mobileNumTF.setLeftPaddingPoints(8.0)
          self.emailTF.setLeftPaddingPoints(8.0)
        
        
    }
   
}
extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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



