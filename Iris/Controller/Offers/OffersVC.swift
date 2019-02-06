//
//  OffersVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/4/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class OffersVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    fileprivate var rowHeight: CGFloat = 130.0
    
    var offers = ["vcrvr","cdc"]
    var imgs = [UIImage(named: "do.png")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        confirmTableViewProtocls()
        
        tableView.tableFooterView = UIView()
        
        
        
    }
    
    
    
    
    func confirmTableViewProtocls() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    
    

}
extension OffersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OffersCell
        
        cell.title.text = offers[indexPath.row]
        cell.img.image = UIImage(named: "img.png")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return rowHeight
    }
    
}
