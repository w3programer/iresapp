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
    
    
    var myFav = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmProtocls()
        
        
        
        
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
        
        return cell
        
    }
    
    
    
    
    
    
    
}
