//
//  CartVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/6/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import CoreData



class CartVC: UIViewController,NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendOrder: CornerButtons!
 
    
    static let shared = CartVC()
    var numberOfItems = 1
    
    
    var test = ["cdvvdv","fvfvdf","vfvaf","cd"]
    
    
    var controller:NSFetchedResultsController<ItemsList>!
    //var context:NSManagedObjectContext?

    
    // set coreData to tableView
    
    //1
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //2
    var prod: [ItemsList] = []

    // 4
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

          confirmProtocols()
           desginTableView(tableview: tableView)
        sendOrder.setTitle(General.stringForKey(key: "sendorder"), for: .normal)
    }
    

  
    @IBAction func sendOrderBtn(_ sender: Any) {
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: prod, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                print(JSONString)
            }
            let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: [String:Any]]
            print(json!)
            
        } catch {
            print("err")
        }
        //let json = try JSONSerialization.jsonObject(with: prod!, options: []) as? [String : AnyObject]
        //let jsonDecoder = JSONEncoder()
       // let jsonData = jsonDecoder.encode(prod)

        //let  jsonData = try! JSONEncoder.encode(ItemsList) as? [String:[String:Any]]
       // encode(ItemsList)
        
          //     print(jsonData)
           // let jsonString = String(data: jsonData, encoding: .utf8)
           //      print(jsonString)

        
       
        
        
        
    }
    
    
    
    func confirmProtocols() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
    }
    
    func desginTableView(tableview: UITableView) {
        tableview.tableFooterView =  UIView()
//        tableview.separatorInset = .zero
//        tableview.contentInset = .zero
    }
    
    
    
    func getData() { //5
        do {
            prod = try context.fetch(ItemsList.fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    
    
    
//    func setData() {
//
//        let fetchRequest:NSFetchRequest<ItemsList>=ItemsList.fetchRequest()
//        controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil , cacheName: nil)
//        controller.delegate = self
//        do {
//             try controller.performFetch()
//        }catch {
//            print("error looad from dataBase")
//        }
//    }
    
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//
//    }
    
}
extension  CartVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return prod.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartCell
        
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.img.image = UIImage(named: "img.png")
        cell.numLab.text = "\(numberOfItems)"
        
        let dta = prod[indexPath.row]
        
        let totl = "\(dta.total)"
            cell.priceLab.text = totl
        let s = dta.package
        cell.title.text = "\(s)"
        
        
        cell.plusBtn.addTarget(self, action: #selector(plusTapped(sender:)), for: .touchUpInside)
        cell.minBtn.addTarget(self, action: #selector(minTapped(sender:)), for: .touchUpInside)
        cell.plusBtn.tag = indexPath.row
        cell.minBtn.tag = indexPath.row
        
        
        
        return cell
    }
    
    @objc func plusTapped (sender: UIButton) {
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
         let selectedRow = tableView.cellForRow(at: selectedIndex) as! CartCell 
            print(selectedRow)
            selectedRow.numLab.text = "\(numberOfItems += 1)"
            print("numberOfItems",numberOfItems)
        
       
        
        
    }
    
    @objc func minTapped(sender: UIButton) {
        if numberOfItems == 1 {
            let selectedIndex = IndexPath(row: sender.tag, section: 0)
               print(selectedIndex)
           let selectedRow = tableView.cellForRow(at: selectedIndex) as! CartCell
            selectedRow.minBtn.isUserInteractionEnabled = false
            selectedRow.minBtn.alpha = 0.5
        } else if numberOfItems > 1 {
            let selectedIndex = IndexPath(row: sender.tag, section: 0)
            print(selectedIndex)
            let selectedRow = tableView.cellForRow(at: selectedIndex) as! CartCell
            selectedRow.minBtn.isUserInteractionEnabled = true
            selectedRow.minBtn.alpha = 1
            numberOfItems -= 1
            print(numberOfItems)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 125.0
    }
    
    
    //6
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ord = prod[indexPath.row]
            context.delete(ord)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                _ = try context.fetch(ItemsList.fetchRequest())
            }
            catch {
                print("Fetching Failed")
            }
        }
        tableView.reloadData()
    }
    
    
}
