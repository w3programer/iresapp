//
//  OrderConfirmationVC.swift
//  Iris
//
//  Created by mahmoudhajar on 3/7/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import CoreData
import iOSDropDown


class OrderConfirmationVC: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var numTF: UITextField!
    @IBOutlet weak var noteTv: UITextView!
    @IBOutlet weak var send: CornerButtons!
    @IBOutlet weak var verfiry: UIButton!
    @IBOutlet weak var couponTF: UITextField!
    @IBOutlet weak var couponView: UIView!
    @IBOutlet weak var cashImage: UIImageView!
    
    @IBOutlet weak var payLabel: SpringLabel!
    
    
    
    @IBOutlet weak var dropText: DropDown!
    
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var prod: [ItemsList] = []
    
    
    var arrofobjects  = [[String:Any]]()

    
    var coup = [Coupon]()
    
    var valu = ""
    
    var newPrice = 0
    
    var coo = ""
     var maaail = ""
    
    
    var prics:[Int] = []
    
    var final = 0
    
    var priceAfterDiscount = 0
    
    
    var str:String = ""
    
    var pay:Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.getData()
              self.getTotal()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLoca()
         setData()
        
        self.noteTv.layer.cornerRadius = 12
        self.noteTv.clipsToBounds = true
          couponView.setRoundCorners(20.0)
        
        
        self.cashImage.isUserInteractionEnabled = true
        self.dropText.delegate = self
        
        let tpGesture = UITapGestureRecognizer(target: self, action: #selector(OrderConfirmationVC.imageTapped(gesture:)))
        cashImage.addGestureRecognizer(tpGesture)
        
        
        setUpDropDownMenu()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.segue), name: NSNotification.Name(rawValue: "send"), object: nil)

      
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
        ShowAlert()

        }
    }
    
        @ objc func segue(notif: NSNotification) {
              Helper.deleteAllData("ItemsList")
            performSegue(withIdentifier: "sos", sender: self)
            
        }

    
    

    
    @IBAction func verfiryBtn(_ sender: Any) {
        
        guard let va = couponTF.text, !va.isEmpty else{return}
        
        activeCoupon(code: va)
        
    }
    
    
    @IBAction func sendBtn(_ sender: Any) {
        
        guard let nam = nameTF.text, !nam.isEmpty,
              let ema = emailTF.text, !ema.isEmpty,
              let num = numTF.text, !num.isEmpty,
              let cho = dropText.text, !cho.isEmpty
          else {
                 SVProgressHUD.dismiss()
                return Alert.alertPopUp(title: General.stringForKey(key: "emf"), msg: General.stringForKey(key: "plz"), vc: self)
                }
        
        if let co = couponTF.text , co.isEmptyStr == false {
            self.coo = co
        }
        
        let mail = (UserDefaults.standard.object(forKey: "email") as! String)
        if mail.isEmptyStr == false {
            self.maaail = mail
        }
        
        for item in prod {
            
            arrofobjects.append([
                                 "product_id": item.product_id,
                                 "similar": item.similar,
                                 "right_degree": item.right_degree,
                                 "left_degree": item.left_degree,
                                 "right_amount": item.right_amount,
                                 "left_amount": item.left_amount,
                                 "left_deviation": item.left_deviation,
                                 "right_deviation": item.right_deviation,
                                 "left_axis": item.left_axis,
                                 "right_axis": item.right_axis,
                                 "type": item.type,
                                 "quantity": item.quantity,
                                 "total": item.total
                
                                        ])
                               }
        print("teststst" ,arrofobjects)
        
        let drs = str + ema
        
        let para:[String:Any] = [
            "token": Helper.getUserToken(),
            "name":nam,
            "email": mail,
            "phone": num,
            "address":drs,
            "coupon_code":coo,
            "coupon_value":valu,
            "total_after_discount": priceAfterDiscount,
            "total": final,
            "payment_method":pay,
            "itemsList": arrofobjects
        ]
        
        API.sendOrders(params: para ) { (error:Error?, success:Bool?) in
            if success == true {

            } else {

            }
        }
    }
    
    
    private func getTotal () {
        for pr in prod {
            self.prics.append(Int(pr.total))
            final = self.prics.reduce(0, +)
              print("total price", final)
            
        }
    }

    private func ShowAlert() {
        
        let pickAlert = UIAlertController(title: General.stringForKey(key: "noti"), message: General.stringForKey(key: "pay"), preferredStyle: .alert)
        pickAlert.addAction(UIAlertAction(title: General.stringForKey(key: "OK"), style: .default, handler: { (action) in
            pickAlert.dismiss(animated: true, completion: nil)
            self.cashImage.image = UIImage(named: "gre.png")
             self.pay = 1
        }))
        pickAlert.addAction(UIAlertAction(title: General.stringForKey(key: "Cancel"), style: .cancel, handler: { (action) in
            self.cashImage.image = UIImage(named: "bl.png")
             self.pay = 0
            pickAlert.dismiss(animated: true, completion: nil)
        }))
        self.present(pickAlert, animated: true, completion: nil)
        
        
        
    }
    
    fileprivate func setLoca(){
        self.nameTF.placeholder = General.stringForKey(key: "name")
        self.numTF.placeholder = General.stringForKey(key: "n")
        self.emailTF.placeholder = General.stringForKey(key: "address")
        self.infoLabel.text = General.stringForKey(key: "info")
        self.noteLabel.text = General.stringForKey(key: "note")
        self.payLabel.text = General.stringForKey(key: "pay")
        couponTF.placeholder = General.stringForKey(key: "code")
        self.dropText.placeholder = General.stringForKey(key: "choose")
        self.verfiry.setTitle(General.stringForKey(key: "verfiy"), for: .normal)
        self.send.setTitle(General.stringForKey(key: "so"), for: .normal)
    }
    
    
    fileprivate func setData() {
        
        nameTF.text = (UserDefaults.standard.object(forKey: "name") as! String)
          numTF.text =  (UserDefaults.standard.object(forKey: "phone") as! String)
    }
    
    
    
    
    fileprivate func activeCoupon(code: String) {
        API.getCoupon(code: code) { (error:Error?, data:[Coupon]?) in
            if data != nil {
                for da in data! {
                self.coup.append(da)
                }
                self.valu = self.coup[0].value
                print("coupon", self.valu)
                if self.valu.isEmptyStr == false {
                    self.priceAfterDiscount = (self.final - Int(self.valu)!)
                    print("new value = \(self.priceAfterDiscount)")
                }
            } else {
                
            }
        }
    }
    
    
    func getData() { //5
        
        let fetchRequest : NSFetchRequest<ItemsList> = ItemsList.fetchRequest()
        
        do {
            prod = try context.fetch(fetchRequest) as [ItemsList]
            print("prooota", prod.count)
            
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
                try context.save()

            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    
    
    
    
    
    private func setUpDropDownMenu() -> String {
        dropText.optionArray = ["داخل الرياض","خارج الرياض"]
         dropText.optionIds = [0,1]
        
        dropText.didSelect { (selectedText, index, id) in
            if id == 0 {
                self.str = "داخل الرياض"
            } else if id  == 1 {
                self.str = "خارج الرياض"
            }
        }
      return self.str
    }
    
}
extension OrderConfirmationVC: UITextFieldDelegate {
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == self.dropText){
            return false
        }
        return true
    }
}



