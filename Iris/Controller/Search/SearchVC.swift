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

class SearchVC: UIViewController {

    
    @IBOutlet weak var searchTxt: ImageInsideTextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filter = [Ads]()
    var txt = ""
    var currentPage = 1
    var totalPages = 1
    
    var selNameAr = ""
    var selNameEn = ""
    var selDesAr = ""
    var selDesEn = ""
    var selImgs:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmPrortcols()
      //  navigationItem.prompt = "kmni"
      //  navigationItem.titleView = searchTxt
        
        searchTxt.placeholder = General.stringForKey(key: "type")
        
        
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
                self.collectionView.reloadData()
            }
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
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
        
        
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
        cell.favBtn.setImage(UIImage(named: "li.png"), for: .normal)
        cell.favBtn.setImage(UIImage(named: "lk.png"), for: .selected)
        cell.favBtn.isSelected = false
        cell.favBtn.tag = indexPath.row
        
        return cell
    }
    
    @objc func favTapped(sender: UIButton) {
        
        if (sender.isSelected) {
            let no = filter[sender.tag].favorite_id
            API.disSelectFav(token: Helper.getUserToken(), id:no) {( error:Error?, success: Bool?) in
                if success! {
                    sender.isSelected = false
                }
            }
        } else {
            let proID = filter[sender.tag].id
            API.selectFav(token:Helper.getUserToken(), proId:proID) {( error:Error?, success: Bool?) in
                if success! {
                    sender.isSelected = true
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
        
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth-30)/2
        
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        selNameAr = filter[indexPath.row].name_ar
        selNameEn = filter[indexPath.row].name_en
        selDesAr = filter[indexPath.row].description_ar
        selDesEn = filter[indexPath.row].description_en
        selImgs = filter[indexPath.row].images
        print(filter[indexPath.row].brandNameAr)
        
        performSegue(withIdentifier: "SearchContent", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SearchContent" {
          let contnt = segue.destination as? AdContentVC
            contnt?.recPage = "search"
            contnt?.recImgs = selImgs
            contnt?.recContent = selDesAr
            
            
            
            
            
        }
        
    }
    
}
extension SearchVC: UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.searchTxt.resignFirstResponder()
       
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("good", self.searchTxt.text!)
        startSearching(q: self.searchTxt.text!, pageNO: currentPage)
        txt = self.searchTxt.text!
        self.searchTxt.resignFirstResponder()
        
        return true
     }
}
