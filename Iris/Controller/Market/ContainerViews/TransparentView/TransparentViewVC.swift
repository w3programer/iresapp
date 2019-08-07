//
//  TransparentViewVC.swift
//  Iris
//
//  Created by Ghoost on 5/21/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class TransparentViewVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var menuPro = [Ads]()
    var currentPage = 1
    var totalPages = 1
    var url = ""
    var recImgs = [String]()
    var recTitle = ""
    var recTitle_en = ""
    var recContent = ""
    var recContentEn = ""
    var recProdId = 0
    var recBrandAr = ""
    var recBrandEn = ""
    var recPrice:Double = 0.0
    var recHasSize = 0
    var recImaage = ""
    var recAx:[String] = []
    var recDev:[String] = []
    var recMyop:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
         getData(pageNu: currentPage)
          brandPagination(numP: 1)

    }
    
    fileprivate func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    fileprivate func getData(pageNu: Int) {
        if API.isConnectedToInternet() {
            if Helper.checkToken() == false {
                API.sortData(pageNo: pageNu, Id: 1, typ: 1) { (error:Error?, data:[Ads]?) in
                    if data != nil {
                      //  print("Sort Data", data!)
                        self.menuPro.removeAll()
                        self.menuPro.append(contentsOf: data!)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }} else {
                 //        print("no ads found niiiil")
                }}} else {
                API.UserSortData(pageNo:pageNu, Id:1, typ: 1) { (error:Error?, data:[Ads]?) in
                    if data != nil {
                        //print("Sort Data", data!)
                        self.menuPro.removeAll()
                        self.menuPro.append(contentsOf: data!)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    } else {
                     //   print("no ads found niiiil")
                    }}}} else {
       //     print("color no internet")
        }}
    
    
    func brandPagination(numP: Int) {
        if API.isConnectedToInternet() {
            if Helper.checkToken() == true {
                url = URLs.categories+"/\(1)/"+"products?page=\(numP)"+"&token="+Helper.getUserToken()
            } else {
                url = URLs.categories+"/\(1)/"+"products"
            }
          //  print("pagination",url)
            Alamofire.request( url , method: .get ).responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    print("terms",error)
                    
                case .success(let value):
                    let jsonData = JSON(value)
                  //  print(jsonData)
                    let json = jsonData["meta"]
                   // print(json)
                    let last = json["last_page"].int
                  //  print(last!)
                    self.totalPages = last!
                }}}}
    

}
extension TransparentViewVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return menuPro.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tranCell", for: indexPath) as! transCell
        
        if General.CurrentLanguage() == "ar"
        {
            cell.title.text = menuPro[indexPath.row].name_ar
        }else
        {
            cell.title.text = menuPro[indexPath.row].name_en
        }
        
        if Helper.checkToken() == true {
            if menuPro[indexPath.row].is_favorite == 0 {
                cell.fav.setImage(UIImage(named: "li.png"), for: .normal)
            } else {
                cell.fav.setImage(UIImage(named: "lk.png"), for: .selected)
            }
            
            cell.fav.addTarget(self, action: #selector(favTapped(sender:)), for: .touchUpInside)
            cell.fav.tag = indexPath.row
            
            
        } else {
            cell.fav.isHidden = true
        }
        
        cell.pics = menuPro[indexPath.item]
        cell.priceLab.text = "\(menuPro[indexPath.row].price)"
        cell.rsLab.text = General.stringForKey(key: "rs")
        
        cell.layer.cornerRadius = 3.0
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.6
        cell.clipsToBounds = true

        return cell
    }
    
    @objc func favTapped(sender: UIButton) {
        
        let id = menuPro[sender.tag].id
        if menuPro[sender.tag].is_favorite == 0 {
            // do like
            API.selectFav(token: Helper.getUserToken(), proId: id) { (error:Error?, success:Bool?) in
                if success == true {
                } else {
                    }}} else {
            // do dislike
            API.disSelectFav(token: Helper.getUserToken(), id: id) { (error:Error?, success:Bool?) in
                if success == true {
                } else {
                }}}}
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row < menuPro.count {
            if currentPage < totalPages {
                self.currentPage += 1
                   print("pagiation num", currentPage)
                getData(pageNu: currentPage)
            }}}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.recTitle = menuPro[indexPath.row].name_ar
        self.recTitle_en = menuPro[indexPath.row].name_en
        self.recPrice = menuPro[indexPath.row].price
        self.recImgs = menuPro[indexPath.row].images
        self.recContentEn = menuPro[indexPath.row].description_en
        self.recContent = menuPro[indexPath.row].description_ar
        self.recProdId = menuPro[indexPath.row].id
        self.recHasSize = menuPro[indexPath.row].has_sizes
        self.recBrandAr = menuPro[indexPath.row].brandNameAr
        self.recBrandEn = menuPro[indexPath.row].brandNameEn
        self.recImaage = menuPro[indexPath.row].imaage
        self.recAx = menuPro[indexPath.row].ax
        self.recMyop = menuPro[indexPath.row].myopia
        self.recDev = menuPro[indexPath.row].dev
        
        performSegue(withIdentifier: "train", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "train" {
            let co = segue.destination as? AdContentVC
            
            co?.recImaage = recImaage
            co?.recImgs = recImgs
            co?.recPrice = recPrice
            co?.recProdId = recProdId
            co?.recTitle = recTitle
            co?.recTitle_en = recTitle_en
            co?.recContent = recContent
            co?.recContentEn = recContentEn
            co?.recBrandAr = recBrandAr
            co?.recBrandEn = recBrandEn
            co?.recHasSize = recHasSize
            co?.recDev = recDev
            co?.recAx = recAx
            co?.recMyop = recMyop
            co?.recPage = "tran"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        let width = (screenWidth - 20) / 2.0
        return CGSize.init(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    
}
