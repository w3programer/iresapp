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
import Alamofire
import SwiftyJSON

class ProfileVC: UIViewController {

    
    @IBOutlet weak var img: CircleImage!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var vis: UIVisualEffectView!
    @IBOutlet weak var updateViw: UIView!
    @IBOutlet weak var titLabel: UILabel!
    @IBOutlet weak var updateTxt: UITextField!
    @IBOutlet weak var update: CornerButtons!
    @IBOutlet weak var cancel: CornerButtons!
    
    
    
    
   fileprivate var title_en = ["User name","Email","Mobile number"]
   fileprivate var title_ar = ["اسم المستخدم","البريد الألكتروني","رقم الجوال"]
    
    
   fileprivate var newName = ""
   fileprivate var newEmail = ""
   fileprivate var newNum = ""
   fileprivate var imge = UIImage()
    
  fileprivate var recName = ""
  fileprivate var recNum = ""
  fileprivate var recEmail = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

        
        self.vis.alpha = 0.0
        self.updateViw.alpha = 0.0
        
        setUpTableView()
        
        if Helper.checkToken() == true {
            Helper.hudStart()
            dislayUserInfo()
            getUserData()
            SVProgressHUD.dismiss(withDelay: 1.5)
        } else {
            
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.imageTapped(gesture:)))
        img.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            getImage()
        }
    }
    
    
    @IBAction func updateBtn(_ sender: Any) {
        API.updateProfile(token: Helper.getUserToken(), email: newEmail, phone: newNum, name: newName, avatar: imge ) { (error: Error?, success:Bool?) in
            if success == true {
               self.getUserData()
            } else {
                
            }
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        
        self.vis.alpha = 0.0
        self.updateViw.alpha = 0.0
        
    }
    
    
    func dislayUserInfo() {
        let phto = (UserDefaults.standard.object(forKey: "photo") as! String)
            let urlStr = URLs.image+phto
            let url = URL(string: urlStr)
            img.kf.indicatorType = .activity
            img.kf.setImage(with: url)
    }
    
    func getUserData() {
     
        let url = URLs.main+"api/me"
        let para =
            [
                "token":Helper.getUserToken()
             ]
        Alamofire.request(url, method: .post, parameters: para).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                print(error)
            case.success(let value):
                let json = JSON(value)
                    print(json)
                let da = json["data"]
                let nam = da["name"].string
                print(nam!)
                self.recName = nam!
                let nm = da["phone"].string
                print(nm!)
                self.recNum = nm!
                let ema = da["email"].string
                   print(ema!)
                self.recEmail = ema!
              self.tblView.reloadData()
            }
        }
        
        
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
            self.imge = image
            API.updateProfile(token: Helper.getUserToken(), email: newEmail, phone: newNum, name: newName, avatar: imge) { (error:Error?, success:Bool?) in
                if success == true {
                 //  dislayUserInfo()
                } else {
                    
                }
            }
            //img.image = image
        }
    }
    
   
    func setUpTableView() {
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
        
        
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
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        if General.CurrentLanguage() == "en" {
            
            cell.titLab.text = title_en[indexPath.row]
            
        } else {
            
        cell.titLab.text = title_ar[indexPath.row]
            
        }
        
        cell.imge.image = UIImage(named: "m.png")
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let animation = AnimationFactory.makeFade(duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          if indexPath.row == 0 {
            self.vis.alpha = 1.0
            self.updateViw.alpha = 1.0
            if General.CurrentLanguage() == "ar" {
                self.titLabel.text = title_ar[indexPath.row]
            } else {
                self.titLabel.text = title_ar[indexPath.row]
            }
            
            
        } else if indexPath.row == 1 {
            self.vis.alpha = 1.0
            self.updateViw.alpha = 1.0
            if General.CurrentLanguage() == "ar" {
                self.titLabel.text = title_ar[indexPath.row]
            } else {
                self.titLabel.text = title_ar[indexPath.row]
            }
            
            
        } else if indexPath.row == 2 {
            self.vis.alpha = 1.0
            self.updateViw.alpha = 1.0
            if General.CurrentLanguage() == "ar" {
                self.titLabel.text = title_ar[indexPath.row]
            } else {
                self.titLabel.text = title_ar[indexPath.row]
            }
            
            
        }
        
    }
    

    
    
}
