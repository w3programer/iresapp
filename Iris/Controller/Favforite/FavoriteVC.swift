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
    
    
    var myFav = ["77","77","77","77","77","77","77","77","77","77"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        confirmProtocls()
        tableView.tableFooterView = UIView()
  //      OffersVC.shared.hideNavigation()
//     tableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    
    func confirmProtocls() {
        
      self.tableView.delegate = self
      self.tableView.dataSource = self
        
        
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
    

   

}
extension FavoriteVC: UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.price.text = myFav[indexPath.row]
        cell.img.image = UIImage(named: "img.png")
        
        cell.favBtn.setImage(UIImage(named: "lk.png"), for: .normal)
        cell.favBtn.setImage(UIImage(named: "li.png"), for: .selected)
        cell.favBtn.tag = indexPath.row
        cell.favBtn.addTarget(self, action: #selector(favTapped(sender:)), for: .touchUpInside)
        cell.favBtn.isSelected = false

        return cell
        
    }
    
    @objc func favTapped(sender: UIButton) {
        if (sender.isSelected)
        {
            sender.isSelected = false
//        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
//        sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//          })
        }else {
            sender.isSelected = true
//        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
//                sender.isSelected = sender.isSelected
//                sender.transform = .identity
//           })
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 100.0
    }
    
    
    
    
}
