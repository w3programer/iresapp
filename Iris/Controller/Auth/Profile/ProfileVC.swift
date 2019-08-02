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
    
    
   fileprivate var newName = ""
   fileprivate var newEmail = ""
   fileprivate var newNum = ""
   fileprivate var imge = UIImage()
    
  fileprivate var recName = ""
  fileprivate var recNum = ""
  fileprivate var recEmail = ""

    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateTxt.delegate = self

        self.vis.alpha = 0.0
        self.updateViw.alpha = 0.0
        
        checkIsAUser()
        setUpDesign()
        setUpTableView()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.imageTapped(gesture:)))
        img.addGestureRecognizer(tapGesture)
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            getImage()
        }
    }
    
    
    @IBAction func updateBtn(_ sender: Any) {
        Helper.hudStart()
        guard let na = updateTxt.text, !na.isEmpty else {return}
        if selectedIndex == 0 {
            self.newName = na
        } else if selectedIndex == 1 {
            self.newEmail = na
        } else if selectedIndex == 2 {
            self.newNum = na
        }
        API.updateProfile(token: Helper.getUserToken(), email: newEmail, phone: newNum, name: newName, avatar: imge ) { (error: Error?, success:Bool?) in
            if success == true {
                SVProgressHUD.dismiss()

               self.getUserData()
            } else {
                SVProgressHUD.dismiss()
            }
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        
        self.vis.alpha = 0.0
        self.updateViw.alpha = 0.0
        
    }
    
    
//    func dislayUserInfo() {
//        let phto = (UserDefaults.standard.object(forKey: "photo") as! String)
//            let urlStr = URLs.image+phto
//            let url = URL(string: urlStr)
//            img.kf.indicatorType = .activity
//            img.kf.setImage(with: url)
//    }
    
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
                let nam = json["name"].string
                print(nam!)
                self.recName = nam!
                let nm = json["phone"].string
                print(nm!)
                self.recNum = nm!
                let ema = json["email"].string
                   print(ema!)
                self.recEmail = ema!
                let phto = json["avatar"].string
                let urlStr = URLs.image+phto!
                let urlPh = URL(string: urlStr)
                self.img.kf.indicatorType = .activity
                self.img.kf.setImage(with: urlPh)
              self.tblView.reloadData()
                SVProgressHUD.dismiss()
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
                    self.getUserData()
                } else {
                    
                }
            }
            //img.image = image
        }
    }
    
    
    func checkIsAUser() {
        if Helper.checkToken() == true {
            if API.isConnectedToInternet() {
                Helper.hudStart()
                // dislayUserInfo()
                getUserData()
                SVProgressHUD.dismiss(withDelay: 1.5)
            } else {
                SVProgressHUD.dismiss()
                Alert.alertPopUp(title: General.stringForKey(key: "con"), msg: General.stringForKey(key: "plz"), vc: self)
            }
        } else {
            SVProgressHUD.dismiss()
            Alert.alertPopUp(title: General.stringForKey(key: "notAv"), msg: General.stringForKey(key: "this"), vc: self)
        }
    }
   
    func setUpTableView() {
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
    }
    
    
    func setUpDesign() {
        
    self.navigationController?.navigationBar.setValue(true, forKey:"hidesShadow")
        self.update.layer.borderWidth = 2
        self.update.layer.borderColor = UIColor.white.cgColor
        self.cancel.layer.borderWidth = 2
        self.cancel.layer.borderColor = UIColor.white.cgColor
        self.updateViw.layer.cornerRadius = 15
        self.updateViw.clipsToBounds = true
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
        
        if indexPath.row == 0 {
             cell.titLab.text = recName
        } else if indexPath.row == 1 {
             cell.titLab.text = recEmail
        } else if indexPath.row == 2 {
             cell.titLab.text = recNum
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
            self.selectedIndex = 0
            self.vis.alpha = 1.0
            self.updateViw.alpha = 1.0
            self.vis.transform = CGAffineTransform(scaleX: 0.3, y: 1)
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options:.curveEaseOut, animations: {
                self.vis.transform = .identity
            }, completion: nil)
            self.titLabel.text = General.stringForKey(key: "name")
        } else if indexPath.row == 1 {
            self.selectedIndex = 1
            self.vis.alpha = 1.0
            self.updateViw.alpha = 1.0
            self.vis.transform = CGAffineTransform(scaleX: 0.3, y: 1)
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options:.curveEaseOut, animations: {
                self.vis.transform = .identity
            }, completion: nil)
            self.titLabel.text = General.stringForKey(key: "email")
        } else if indexPath.row == 2 {
            self.selectedIndex = 2
            self.vis.alpha = 1.0
            self.updateViw.alpha = 1.0
            self.vis.transform = CGAffineTransform(scaleX: 0.3, y: 1)
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options:.curveEaseOut, animations: {
                self.vis.transform = .identity
            }, completion: nil)
            self.titLabel.text = General.stringForKey(key: "n")
        }
        
    }
    

    
    
}
extension ProfileVC: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            
        }
        
        return true
    }
    
}
