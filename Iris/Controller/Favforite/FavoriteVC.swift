//
//  FavoriteVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON



class FavoriteVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var myFav = [Ads]()
    
    var currentPage = 1
    var totalPages = 1
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Helper.hudStart()
        navigationItem.title = General.stringForKey(key: "fav")
        if Helper.checkToken() == true  {
            getFavotites(token:Helper.getUserToken(),id:currentPage)
        } else {
        Alert.alertPopUp(title: General.stringForKey(key: "notAll"), msg: General.stringForKey(key: "this"), vc: self)
        }
        confirmProtocls()
        tableView.tableFooterView = UIView()
        self.tabBarController?.tabBar.items?[3].title = General.stringForKey(key: "fav")

        
    }
    
    
    
    @IBAction func unwindTofavv(segue: UIStoryboardSegue) {}

    
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
    
    func getFavotites(token:String,id: Int) {
        checkPagination()
        API.getFavourites(token: token, pageNo: id) { (error:Error?, data:[Ads]?) in
            if data != nil {
                self.myFav.append(contentsOf: data!)
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
            } else {
                Helper.showError(title: "No products found")
            }
        }
    }
   
    func checkPagination(){
        let url = URLs.favorites
        Alamofire.request( url , method: .get ).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print("terms",error)
                
            case .success(let value):
                let jsonData = JSON(value)
                let json = jsonData["meta"]
                print(json)
                let last = json["last_page"].int
                print(last!)
                self.totalPages = last!
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
        
        cell.price.text = "\(myFav[indexPath.row].price)"
        //cell.pics = myFav[IndexPath(item: 0, section: 0).item]
        cell.pics = myFav[indexPath.item]
        cell.title.text = myFav[indexPath.row].name_ar
        
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
//            let No = myFav[sender.tag].id
//            sender.isSelected = true
//            API.selectFav(token: Helper.getUserToken(), proId: No) { (error:Error?, success:Bool?) in
//                if success! {
//                }
//            }
       // }else {
            let ID = myFav[sender.tag].favorite_id
            sender.isSelected = false
            API.disSelectFav(token: Helper.getUserToken(),id:ID) {( error:Error?, success: Bool?) in
                if success == true {
                    self.getFavotites(token: Helper.getUserToken(), id: self.currentPage)
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row ==  myFav.count - 1 {
            if currentPage < totalPages {
               currentPage += 1
                getFavotites(token: Helper.getUserToken(), id:currentPage )
            }
        }
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "FavSegue", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavSegue" {
            let des = segue.destination as? AdContentVC
                des?.recPage = "fav"
            
        }
    }
   
    
}
