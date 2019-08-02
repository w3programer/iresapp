//
//  MoreVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/6/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SVProgressHUD

// need twitter , snapchat & instgram

class MoreVC: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lanBtn: UIBarButtonItem!
    
    
    let insta = "iristoresa"
    let snap = "iristore"

    
    var ph = "0530512812"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmProtocls()
        CartVC.shared.desginTableView(tableview: tableView)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

        lanBtn.title = General.stringForKey(key: "arabic")
        self.tabBarController?.tabBar.items?[4].title = General.stringForKey(key: "more")

       // self.navigationItem.title = General.stringForKey(key: "menu")


        
    }
    
    
    @IBAction func languageBtn(_ sender: Any) {
        
        print("language Pressed")
        
        if General.CurrentLanguage() == "ar"
        {
            CheckLanguage.ChangeLanguage(NewLang: "en")
           tableView.semanticContentAttribute = .forceLeftToRight
        } else
        {
            CheckLanguage.ChangeLanguage(NewLang: "ar")
            tableView.semanticContentAttribute = .forceRightToLeft


        }
        Helper.restartApp()
        
    }
    
    
    
    
    @IBAction func snapChatBtn(_ sender: Any) {
        
        let appURL = NSURL(string: "https://snapchat.com/add/\(self.snap)")!
        if UIApplication.shared.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL as URL)
            }
        }
        else {
            let webURL = URL(string: "https://snapchat.com/add/\(self.snap)")!
            UIApplication.shared.open(webURL)

        }
    }
    
    @IBAction func twitterBtn(_ sender: Any) {
        
        
        
        let Username =  "iristore"
        
        let appURL = NSURL(string: "twitter:///user?screen_name=\(Username)")!
        let webURL = NSURL(string: "https://twitter.com/\(Username)")!

        if UIApplication.shared.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL as URL)
            }
        }
        else {
            UIApplication.shared.open(webURL as URL)

            // AlertPopUP(title: General.stringForKey(key: "err"), message: General.stringForKey(key: "installwts"))
            // Whatsapp is not installed
        }
    }
    @IBAction func instgramBtn(_ sender: Any) {
        let appURL = NSURL(string: "instagram://user?username=\(self.insta)")!
        if UIApplication.shared.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL as URL)
            }
        }
        else {
            let webURL = URL(string: "https://instagram.com/\(self.insta)")!
            UIApplication.shared.open(webURL)
            // AlertPopUP(title: General.stringForKey(key: "err"), message: General.stringForKey(key: "installwts"))
            // Whatsapp is not installed
        }
        
    }
    
    
    @IBAction func whatsBtn(_ sender: Any) {
        let appURL = NSURL(string: "https://api.whatsapp.com/send?phone=\(self.ph)")!
        if UIApplication.shared.canOpenURL(appURL as URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL as URL)
            }
        }
        else {
            // AlertPopUP(title: General.stringForKey(key: "err"), message: General.stringForKey(key: "installwts"))
            // Whatsapp is not installed
        }
        
        
        
    }
    
    
    
    func confirmProtocls() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }



}
extension MoreVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoreCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if General.CurrentLanguage() == "en" {
            cell.titleLab.textAlignment = .left
        } else {
            cell.titleLab.textAlignment = .right
        }
        
        
        
        if indexPath.row == 0 {
            cell.titleLab.text = General.stringForKey(key: "fav")
        } else if indexPath.row == 1 {
           cell.titleLab.text = General.stringForKey(key: "sginin")
        } else if indexPath.row == 2 {
            cell.titleLab.text = General.stringForKey(key: "profile")
        } else if indexPath.row == 3 {
            cell.titleLab.text = General.stringForKey(key: "contactus")
        } else if indexPath.row == 4 {
            cell.titleLab.text = General.stringForKey(key: "rules")
        } else if indexPath.row == 5 {
            cell.titleLab.text = General.stringForKey(key: "policy")
        } else if indexPath.row == 6 {
            cell.titleLab.text = General.stringForKey(key: "Q&A")
        } else if indexPath.row == 7 {
            cell.titleLab.text = General.stringForKey(key: "about")
        } else if indexPath.row == 8 {
            cell.titleLab.text = General.stringForKey(key: "logout")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let animation = AnimationFactory.makeFade(duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Helper.checkToken() == true {
            if indexPath.row == 1 {
                return 0
            }
        } else {
            if indexPath.row == 8 {
                return 0
            }
        }
        
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            performSegue(withIdentifier: "fSegue", sender: self)
        } else if indexPath.row == 1 {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        } else if indexPath.row == 2 {
            performSegue(withIdentifier: "ProfileSegue", sender: self)
        } else  if indexPath.row == 3 {
            performSegue(withIdentifier: "ContactSegue", sender: self)
        } else if indexPath.row == 4 {
            performSegue(withIdentifier: "TermsSegue", sender: self)
        } else if indexPath.row == 5 {
            performSegue(withIdentifier: "policySegue", sender: self)
        } else if indexPath.row == 6 {
            performSegue(withIdentifier: "quesSegue", sender: self)
        } else if indexPath.row == 7 {
            performSegue(withIdentifier: "aboutSegue", sender: self)
        } else if indexPath.row == 8 {
            if Helper.checkToken() == true {
                API.logOut(token: Helper.getUserToken()) { (error:Error?, success:Bool?) in
                    if success == true {
                        SVProgressHUD.dismiss()
                    } else {
                        SVProgressHUD.dismiss()
                        Alert.alertPopUp(title: General.stringForKey(key: "con"), msg: General.stringForKey(key: "plsCh" ), vc: self)
                    }
                }
            }
          }
        
    }
        
        
        
        
    
    
    
    
    
    
    

    
}
