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
    
    var selNameAr = ""
     var selNameEn = ""
      var selDesAr = ""
       var selDesEn = ""
        var selImgs:[String] = []
         var selPrice:Double = 0.0
         var selId = 0
        var selBrandAr = ""
       var selBrandEn = ""
      var selHas_size = 0
     var selImaage = ""
    var selProId = 0
     var selDev:[String] = []
      var selAx:[String] = []
       var selMyo:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Helper.hudStart()
        navigationItem.title = General.stringForKey(key: "fav")
         if API.isConnectedToInternet() {
            if Helper.checkToken() == true  {
                getFavotites(token:Helper.getUserToken(),id:currentPage)
            } else {
                Alert.alertPopUp(title: General.stringForKey(key: "notAv"), msg: General.stringForKey(key: "plsRe"), vc: self)
            }
        } else {
             Alert.alertPopUp(title: General.stringForKey(key: "con"), msg: General.stringForKey(key: "plsCh"), vc: self)
        }
        
        confirmProtocls()
        tableView.tableFooterView = UIView()

        
    }
    
    
    
    @IBAction func unwindTofavv(segue: UIStoryboardSegue) {}

    
    func confirmProtocls() {
        
      self.tableView.delegate = self
      self.tableView.dataSource = self
        
        
    }
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y >= 100 {
//            UIView.animate(withDuration: 2.5) {
//                self.navigationController?.setNavigationBarHidden(true, animated: true)
//            }
//        } else {
//                UIView.animate(withDuration: 2.5) {
//                    self.navigationController?.setNavigationBarHidden(false, animated: true)
//                }
//            }
//        }
    
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
        cell.pics = myFav[indexPath.item]
        cell.title.text = myFav[indexPath.row].name_ar
        cell.rsLab.text = General.stringForKey(key:"rs")
        
        cell.favBtn.setImage(UIImage(named: "lk.png"), for: .normal)
        cell.favBtn.setImage(UIImage(named: "li.png"), for: .selected)
        
        cell.favBtn.addTarget(self, action: #selector(favTapped(sender:)), for: .touchUpInside)
        cell.favBtn.tag = indexPath.row

        
        return cell
        
    }
    
    @objc func favTapped(sender: UIButton) {

            let ID = myFav[sender.tag].favorite_id
            API.disSelectFav(token: Helper.getUserToken(),id:ID) {( error:Error?, success: Bool?) in
                if success == true {

                }
            }
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
        
         selNameAr = myFav[indexPath.row].name_ar
         selNameEn = myFav[indexPath.row].name_en
         selDesAr = myFav[indexPath.row].description_ar
         selDesEn = myFav[indexPath.row].description_en
         selImgs = myFav[indexPath.row].images
         selPrice = myFav[indexPath.row].price
         selId = myFav[indexPath.row].id
         selBrandAr = myFav[indexPath.row].brandNameAr
         selBrandEn = myFav[indexPath.row].brandNameEn
         selHas_size = myFav[indexPath.row].has_sizes
         selImaage = myFav[indexPath.row].imaage
         selProId = myFav[indexPath.row].id
          selDev = myFav[indexPath.row].dev
           selAx = myFav[indexPath.row].ax
            selMyo = myFav[indexPath.row].myopia
        
        if selHas_size == 0 {
            performSegue(withIdentifier: "accSegue", sender: self)
        } else {
            performSegue(withIdentifier: "FavSegue", sender: self)
            }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavSegue" {
            let des = segue.destination as? AdContentVC
                des?.recPage = "fav"
                des?.recContentEn = selDesEn
                des?.recContent = selDesAr
                des?.recProdId = selId
                des?.recPrice = selPrice
                des?.recImgs = selImgs
                des?.recTitle_en = selNameEn
                des?.recTitle = selNameAr
                des?.recProdId = selProId
                des?.recAx = selAx
                des?.recDev = selDev
                des?.recMyop = selMyo
            
        } else if segue.identifier == "accSegue" {
            let ac  = segue.destination as? AccessoriesContentVC
               ac?.recContent = selDesAr
               ac?.recContent_en = selDesEn
               ac?.recImgs = selImgs
               ac?.recProdId = selId
               ac?.recBrand_ar = selBrandAr
               ac?.recBarnd_en = selBrandEn
               ac?.recTitle = selNameAr
               ac?.recTitle_en = selNameEn
               ac?.recProdId = selProId
               ac?.recImaage = selImaage
                ac?.recPrice = selPrice
        }
    }
   
    
}
