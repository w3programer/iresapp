//
//  CartVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/6/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendOrder: CornerButtons!
 
    
    static let shared = CartVC()
    var numberOfItems = 1
    
    
    var test = ["cdvvdv","fvfvdf","vfvaf","cd"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
          confirmProtocols()
           desginTableView(tableview: tableView)
        sendOrder.setTitle(General.stringForKey(key: "sendorder"), for: .normal)
    }
    

  
    @IBAction func sendOrderBtn(_ sender: Any) {
        
        
        
        
        
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
    
    
    
    
    
}
extension  CartVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartCell
        
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.img.image = UIImage(named: "img.png")
        cell.numLab.text = "\(numberOfItems)"
        
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
    
    
    
}
