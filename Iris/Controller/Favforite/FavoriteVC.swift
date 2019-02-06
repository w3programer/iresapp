//
//  FavoriteVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var myFav = ["77","77","77"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmProtocls()
        
        tableView.tableFooterView = UIView()
        
        
        
    }
    
    
    func confirmProtocls() {
        
      self.tableView.delegate = self
      self.tableView.dataSource = self
        
        
    }
    

   

}
extension FavoriteVC: UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavCell
        
        cell.price.text = myFav[indexPath.row]
        cell.img.image = UIImage(named: "img.png")
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 100.0
    }
    
    
    
    
}
