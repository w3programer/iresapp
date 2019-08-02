//
//  SearchVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/7/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD



class SearchVC: UIViewController {

    
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var viw: UIView!
    var filter = [Ads]()
    var txt = ""
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
             var imaage = ""
              var selAx:[String] = []
               var selMyo:[String] = []
                var selDev:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmPrortcols()
      //  navigationItem.prompt = "kmni"
      //  navigationItem.titleView = searchTxt
        
        searchTxt.placeholder = General.stringForKey(key: "type")
        
        self.viw.floatView()
        
    }
    
    
    
    @IBAction func unwindToSearchVC(segue: UIStoryboardSegue) {}


    func confirmPrortcols() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchTxt.delegate = self

    }
    
    
    func startSearching(q: String,pageNO:Int) {
        checkPagination(q:q)
        API.Search(q:q, pageNo: pageNO) { (error:Error?, data:[Ads]?) in
            if data != nil {
                self.filter.removeAll()
                self.filter.append(contentsOf: data!)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
        }
    }
    
    
    func checkPagination(q:String){
        let url = URLs.search+q
        Alamofire.request( url , method: .get ).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print("terms",error)
                
            case .success(let value):
                let jsonData = JSON(value)
                print(jsonData)
                let json = jsonData["meta"]
                print(json)
                let last = json["last_page"].int
                print(last!)
                self.totalPages = last!
            }
        }
    }
    

}
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
        
        cell.layer.cornerRadius = 3.0
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.6
        
        
        let containerView = cell.view!
        
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        
        
        
        
        
        if General.CurrentLanguage() == "ar"
        {
            cell.titleLab.text = filter[indexPath.row].name_ar
        }else
        {
            cell.titleLab.text = filter[indexPath.row].name_en
        }
       cell.pics = filter[indexPath.item]
       cell.priceLab.text = "\(filter[indexPath.row].price)"
        
        cell.favBtn.addTarget(self, action: #selector(favTapped(sender:)), for: .touchUpInside)
        cell.favBtn.tag = indexPath.row
        
        return cell
    }
    
    @objc func favTapped(sender: UIButton) {
        
        let id = filter[sender.tag].id
        if filter[sender.tag].is_favorite == 0 {
            // do like
            API.selectFav(token: Helper.getUserToken(), proId: id) { (error:Error?, success:Bool?) in
                if success == true {
                    
                } else {
                    
                }
            }
        } else {
            // do dislike
            API.disSelectFav(token: Helper.getUserToken(), id: id) { (error:Error?, success:Bool?) in
                if success == true {
                    
                } else {
                    
                }
            }
        }
    }
    
    
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == filter.count - 1 {
            if currentPage < totalPages {
                currentPage += 1
                print("nuuum",currentPage)
                    self.startSearching(q:txt,pageNO:currentPage)
                }
             }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       
            let screenWidth = collectionView.bounds.width
            let width = (screenWidth - 20) / 2.0
            
            
            return CGSize.init(width: width, height: 230)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
            return  4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
            return UIEdgeInsets.zero
            
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        selNameAr = filter[indexPath.row].name_ar
        selNameEn = filter[indexPath.row].name_en
        selDesAr = filter[indexPath.row].description_ar
        selDesEn = filter[indexPath.row].description_en
        selImgs = filter[indexPath.row].images
        selPrice = filter[indexPath.row].price
        selId = filter[indexPath.row].id
        selBrandAr = filter[indexPath.row].brandNameAr
        selBrandEn = filter[indexPath.row].brandNameEn
        imaage = filter[indexPath.row].imaage
        selDev = filter[indexPath.row].dev
        selAx = filter[indexPath.row].ax
        selMyo = filter[indexPath.row].myopia
        
        print(filter[indexPath.row].brandNameAr)
        if filter[indexPath.row].has_sizes == 1 {
            performSegue(withIdentifier: "SearchContent", sender: self)
        } else {
            performSegue(withIdentifier: "AccSearchContentSegue", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SearchContent" {
          let contnt = segue.destination as? AdContentVC
            
            contnt?.recPage = "search"
            contnt?.recImgs = selImgs
            contnt?.recContent = selDesAr
            contnt?.recPrice = selPrice
            contnt?.recContent = selDesAr
            contnt?.recContentEn = selDesEn
            contnt?.recTitle = selNameAr
            contnt?.recTitle_en = selNameEn
            contnt?.recProdId = selId
            contnt?.recImaage = imaage
            contnt?.recDev = selDev
            contnt?.recAx = selAx
            contnt?.recMyop = selMyo
            
        } else if segue.identifier == "AccSearchContentSegue" {
            let acc = segue.destination as? AccessoriesContentVC
                acc?.recImgs = selImgs
                acc?.recPrice = selPrice
                acc?.recProdId = selId
                acc?.recContent_en = selDesEn
                acc?.recContent_ar = selDesAr
                acc?.recBarnd_en = selBrandEn
                acc?.recBrand_ar = selBrandAr
                acc?.recTitle_en = selNameEn
                acc?.recTitle = selNameAr
                acc?.recImaage = imaage
             }
          }
    
}
extension SearchVC: UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.searchTxt.resignFirstResponder()
       
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("good", self.searchTxt.text!)
        Helper.hudStart()
        startSearching(q: self.searchTxt.text!, pageNO: currentPage)
        txt = self.searchTxt.text!
        self.searchTxt.resignFirstResponder()
        
        return true
     }
}
