//
//  CartVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/6/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher


class CartVC: UIViewController,NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendOrder: CornerButtons!
 
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var buView: UIView!
    @IBOutlet weak var toView: UIView!
    
    @IBOutlet weak var visal: UIVisualEffectView!
    @IBOutlet weak var emLabel: UILabel!
    
    
    
    
    
    static let shared = CartVC()
    var numberOfItems = 1
    
    
    var prics:[Double] = []
    var final:Double = 0.0
    

    
    //1
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //2
    var prod: [ItemsList] = []

    // 4
    override func viewWillAppear(_ animated: Bool) {
        getData()
      //  getTotal()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        
                if prod.isEmpty == true {
//                    self.buView.alpha = 0
//                     self.toView.alpha = 0
                      self.visal.alpha = 1.0
                } else if prod.isEmpty == false  {
//                    self.buView.alpha = 1.0
//                     self.toView.alpha = 1.0
                      self.visal.alpha = 0
                }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //self.visal.alpha = 0
        
        toView.alpha = 0
        
          confirmProtocols()
           desginTableView(tableview: tableView)
        sendOrder.setTitle(General.stringForKey(key: "com"), for: .normal)
         self.emLabel.text = "🗑" + General.stringForKey(key: "ec")
        self.totalLabel.text = General.stringForKey(key: "tp")
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.update), name: NSNotification.Name(rawValue: "update"), object: nil)
        
        
    }
  
    
    @ objc func update(notif: NSNotification) {
     //   getTotal()
        print("cell updated")
    }
    
    @IBAction func sendOrderBtn(_ sender: Any) {
        if prod.isEmpty == false {
            if Helper.checkToken() == true {
                performSegue(withIdentifier: "OrderSegue", sender: self)
            }
        }
       
    }
    
    
    
    func confirmProtocols() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
    }
    
    func desginTableView(tableview: UITableView) {
        tableview.tableFooterView =  UIView()
          tableview.tableFooterView?.tintColor = UIColor.clear

    }
    
    
    
    func getData() { //5
        do {
            prod = try context.fetch(ItemsList.fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    
    
//    fileprivate func getTotal() {
//        for pr in prod {
//            self.prics.append(Double(pr.total))
//            final = self.prics.reduce(0, +)
//            print("total price", final)
//            self.priceLabel.text = General.stringForKey(key: "rs")+"\(self.prics.reduce(0, +))"
//
//        }
//    }


    
}
extension  CartVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return prod.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartCell
        
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        
        let dta = prod[indexPath.row]
        
        
        cell.getOrignailPrice(price: dta.orPrice,
                              selected_product_id: Int(dta.product_id),
                              orRightAmount: Int(dta.orRightAmout),
                              orLeftAmount: Int(dta.orLeftAmount),
                              totalPrice: Double(dta.total),
                             sameSize: dta.sameSize)
        
        
        if dta.hasSize == 0 || dta.similar == 0 {
            cell.rightAmount.alpha = 0
            cell.leftAmount.alpha = 0
            cell.rightLab.alpha = 0
            cell.leftLab.alpha = 0
        } else  {
            cell.rightAmount.alpha = 1.0
            cell.leftAmount.alpha = 1.0
            cell.rightLab.alpha = 1.0
            cell.leftLab.alpha = 1.0
        }
        
        
        
        
        if dta.left_amount == 0  {
            cell.rightAmount.alpha = 0
            cell.leftAmount.alpha = 0
            cell.rightLab.alpha = 0
            cell.leftLab.alpha = 0
        } else if dta.right_amount == 0 {
            cell.rightAmount.alpha = 0
            cell.leftAmount.alpha = 0
            cell.rightLab.alpha = 0
            cell.leftLab.alpha = 0
        } else {
            cell.rightAmount.alpha = 1.0
            cell.leftAmount.alpha = 1.0
            cell.rightLab.alpha = 1.0
            cell.leftLab.alpha = 1.0
        }
        
        cell.numLab.text = "\(dta.quantity)"
                              
        if General.CurrentLanguage() == "ar" {
            cell.title.text = dta.name_ar
        } else {
            cell.title.text = dta.name_en
        }
        
        if dta.img?.isEmptyStr == false {
            cell.img.kf.indicatorType = .activity
            let url = URL(string: dta.img!)
            cell.img.kf.setImage(with: url )
        }
        cell.priceLab.text = "\(dta.total)"
        
        
        cell.leftAmount.text = "\(dta.left_amount)"
        cell.rightAmount.text =  "\(dta.right_amount)"
        
      cell.rightLab.text = General.stringForKey(key: "rii")
        cell.leftLab.text = General.stringForKey(key: "lee")
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 161.0
    }
    
    
    //6
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ord = prod[indexPath.row]
            context.delete(ord)
            prod.remove(at: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .automatic)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                _ = try context.fetch(ItemsList.fetchRequest())
                try context.save()
                // add notification to update badge value at main screen
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deletedCell"), object: nil)
            }
            catch {
                print("Fetching Failed")
            }
            if prod.count == 0 {
                self.visal.alpha = 1.0
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: General.stringForKey(key: "delet")) { (action, indexPath) in
            self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
            return
        }
        return [deleteButton]
        
    }
    
    
    
}
