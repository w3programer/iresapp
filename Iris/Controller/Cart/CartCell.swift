//
//  CartCell.swift
//  Iris
//
//  Created by mahmoudhajar on 2/8/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData


class CartCell: UITableViewCell {

    
    
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minBtn: UIButton!
    @IBOutlet weak var numLab: UILabel!
    @IBOutlet weak var priceLab: UILabel!
    @IBOutlet weak var rsLabel: UILabel!
    @IBOutlet weak var rightLab: UILabel!
    @IBOutlet weak var leftLab: UILabel!
    @IBOutlet weak var rightAmount: UILabel!
    @IBOutlet weak var leftAmount: UILabel!
    
    
    
    var orignal:Double = 0.0
    var selected_product_id:Int = 0
    var orignalRightAmount = 0
    var orignalLeftAmount = 0
    var totalPrice:Double = 0.0
  
    
    var sameSize:Bool?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img.layer.cornerRadius = 10.0
      
        mainView.floatView()
       
        
        
        
    }

    
  
    @IBAction func plsBtn(_ sender: Any) {
        
        
        
        numLab.text = "\(Int(numLab.text!)! + 1)"
       // rightAmount.text = "\(Int(rightAmount.text!)! + 1)"
       // leftAmount.text = "\(Int(leftAmount.text!)! + 1)"

        
        //priceLab.text = "\(Int(orignal) * Int(numLab.text!)!)"
        if sameSize == false {
            priceLab.text = "\(Double(priceLab.text!)! + totalPrice)"
            rightAmount.text = "\(Int(rightAmount.text!)! + orignalRightAmount)"
            leftAmount.text = "\(Int(leftAmount.text!)! + orignalLeftAmount)"
            
        } else {
            priceLab.text = "\(Double(orignal) * Double(numLab.text!)!)"
        }
        
//        if similar != 0 {
//            priceLab.text = "\(Double(priceLab.text!)! + totalPrice)"
//            rightAmount.text = "\(Int(rightAmount.text!)! + orignalRightAmount)"
//            leftAmount.text = "\(Int(leftAmount.text!)! + orignalLeftAmount)"
//            
//        } else {
//            priceLab.text = "\(Double(orignal) * Double(numLab.text!)!)"
//        }
        //update value in core data
        let fechrequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "ItemsList")
        fechrequest.predicate = NSPredicate(format: "product_id = '\(Int16(selected_product_id) )'")
        do {
            let test = try context.fetch(fechrequest)
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(Int(numLab.text!)!, forKey: "quantity")
            objectUpdate.setValue(Int(rightAmount.text!)!, forKey: "right_amount")
            objectUpdate.setValue(Int(leftAmount.text!)!, forKey: "left_amount")
            objectUpdate.setValue(Double(priceLab.text!)!, forKey: "total")

            do {
                try context.save()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)

            } catch {}
            
        }catch{
        }
        
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
    }
    
    @IBAction func mnBtn(_ sender: Any) {
        
        if Int(numLab.text!)! > 1 {
          numLab.text = String(Int(numLab.text!)! - 1)
        }
       
        
        //if Int(priceLab.text!)! > Int(orignal) {
        if sameSize ==  false {
            if Double(priceLab.text!)! > totalPrice {
                //priceLab.text = "\(Int(priceLab.text!)! - Int(orignal))"
                priceLab.text = "\(Double(priceLab.text!)! - totalPrice)"
                
            }
            if Int(rightAmount.text!)! > orignalRightAmount {
                rightAmount.text = "\(Int(rightAmount.text!)! - orignalRightAmount)"
            }
            if Int(leftAmount.text!)! > orignalLeftAmount {
                leftAmount.text = "\(Int(leftAmount.text!)! - orignalLeftAmount)"
            }
          //  print("has size 1")
        } else {
            if Double(priceLab.text!)! > Double(orignal) {
                priceLab.text = "\(Double(priceLab.text!)! - Double(orignal))"
            }
           // print("has size 2")

        }
        
        
//        if  similar != 0  {
//            if Double(priceLab.text!)! > totalPrice {
//                //priceLab.text = "\(Int(priceLab.text!)! - Int(orignal))"
//                priceLab.text = "\(Double(priceLab.text!)! - totalPrice)"
//                
//            }
//            if Int(rightAmount.text!)! > orignalRightAmount {
//                rightAmount.text = "\(Int(rightAmount.text!)! - orignalRightAmount)"
//            }
//            if Int(leftAmount.text!)! > orignalLeftAmount {
//                leftAmount.text = "\(Int(leftAmount.text!)! - orignalLeftAmount)"
//            }
//        } else {
//            if Double(priceLab.text!)! > Double(orignal) {
//                priceLab.text = "\(Double(priceLab.text!)! - Double(orignal))"
//            }
//        }
//       
       
        
        

        let fechrequest:NSFetchRequest<NSFetchRequestResult> =  NSFetchRequest.init(entityName: "ItemsList")
                    fechrequest.predicate = NSPredicate(format: "product_id = '\(Int16(selected_product_id) )'")
                    do {
                        let test = try context.fetch(fechrequest)
                        let objectUpdate = test[0] as! NSManagedObject
                        objectUpdate.setValue(Int(numLab.text!)!, forKey: "quantity")
                        objectUpdate.setValue(Int(rightAmount.text!)!, forKey: "right_amount")
                        objectUpdate.setValue(Int(leftAmount.text!)!, forKey: "left_amount")
                        objectUpdate.setValue(Double(priceLab.text!)!, forKey: "total")
        
                        do {
                            try context.save()
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
        
                        } catch {}
        
                    }catch{
                    }
        
        
//        if Int(numLab.text!)! > 1 {
//            numLab.text = String(Int(numLab.text!)! - 1)
//            if Int(rightAmount.text!)! > 1 {
//                rightAmount.text = "\(Int(rightAmount.text!)! - 1)"
//            }
//            if Int(leftAmount.text!)! > 1 {
//                leftAmount.text = "\(Int(leftAmount.text!)! - 1)"
//            }
//            priceLab.text = "\(Int(priceLab.text!)! - Int(orignal))"
//            //update value in core data
//            let fechrequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "ItemsList")
//            fechrequest.predicate = NSPredicate(format: "product_id = '\(Int16(selected_product_id) )'")
//            do {
//                let test = try context.fetch(fechrequest)
//                let objectUpdate = test[0] as! NSManagedObject
//                objectUpdate.setValue(Int(numLab.text!)!, forKey: "quantity")
//                objectUpdate.setValue(Int(rightAmount.text!)!, forKey: "right_amount")
//                objectUpdate.setValue(Int(leftAmount.text!)!, forKey: "left_amount")
//                objectUpdate.setValue(Int(priceLab.text!)!, forKey: "total")
//
//                do {
//                    try context.save()
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
//
//                } catch {}
//
//            }catch{
//            }
//
//        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
    }
    
    
    
    
    func getOrignailPrice(price:Double,
                          selected_product_id: Int,
                          orRightAmount:Int,
                          orLeftAmount:Int,
                          totalPrice:Double,
                          sameSize:Bool
                          
                          ) {
        
        self.orignal = price
         self.selected_product_id = selected_product_id
          self.orignalRightAmount = orRightAmount
            self.orignalLeftAmount = orLeftAmount
              self.totalPrice = totalPrice
               self.sameSize = sameSize
        
        
    }
    
    

}
