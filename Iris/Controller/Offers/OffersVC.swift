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
    
    static let shared = OffersVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        confirmTableViewProtocls()
        tableView.tableFooterView = UIView()
        
//        tableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
 
        if scrollView.contentOffset.y >= 100 {
        UIView.animate(withDuration: 2.5) {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
           }
        } else {
            UIView.animate(withDuration: 2.5) {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
        
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
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.title.text = offers[indexPath.row]
        cell.img.image = UIImage(named: "img.png")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return rowHeight
    }
    
}
