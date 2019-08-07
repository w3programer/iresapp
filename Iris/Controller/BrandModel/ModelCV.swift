//
//  ModelCV.swift
//  Iris
//
//  Created by mahmoudhajar on 3/24/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD
import Alamofire
import SwiftyJSON

class ModelCV: UIViewController {
    @IBOutlet weak var trendCollectionView: UICollectionView!
    @IBOutlet weak var collectionViw: UICollectionView!
    // pagination
    var currentPage:Int = 1
     var totalPages:Int = 1
    
    var treCurrentPage:Int = 1
    var treTotalPages:Int = 1
    
    var da = [Ads]()
     var tre = [BrandTrends]()
    var recModelId = 1
    var i:Int = 0
    var treSelected:Bool = false
    /// moving data
    var selectedImgs = [String]()
     var selectedTitle = ""
      var selectedTitle_en = ""
       var selectedContent_en = ""
        var selectedContent_ar = ""
         var selectedId = 0
          var selectedHasSize = 0
           var selectedPrice:Double = 0.0
            var selectedName_ar = ""
             var selectedName_en = ""
              var selectedBarndName_ar = ""
                var selectedBarndName_en = ""
                 var selectedImaage = ""
                  var recAx:[String] = []
                   var recDev:[String] = []
                    var recMyop:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          setUpCollection()
        if API.isConnectedToInternet() {
              // self.da.removeAll()
                self.getModelData(id: self.recModelId, nu: self.currentPage)
            //getTree(id: self.recModelId, page: self.currentPage)
            modelPagination(ID: self.recModelId, pag: 1)
            self.treeends(id: recModelId)
        } else {
            Alert.alertPopUp(title: General.stringForKey(key: "con"), msg: General.stringForKey(key: "plsCh"), vc: self)
            SVProgressHUD.dismiss()
        }}
    
    fileprivate func setUpCollection() {
        self.collectionViw.delegate = self
         self.collectionViw.dataSource = self
          self.trendCollectionView.delegate  = self
           self.trendCollectionView.dataSource  = self
      }
    
    fileprivate func getModelData(id:Int,nu: Int) {
        Helper.hudStart()
        API.getBrandModels(id: id, pageNo: nu) { (error:Error?, data:[Ads]?) in
            if data != nil {
                self.da.removeAll()
                    self.da.append(contentsOf: data!)
                    DispatchQueue.main.async {
                    self.collectionViw.reloadData()
                    }
                SVProgressHUD.dismiss()
                //print(data!)
            } else {
                //print("data is empty of brandModel")
                SVProgressHUD.dismiss()
            }
        }
        SVProgressHUD.dismiss(withDelay: 2.0)
    }
    
    fileprivate func modelPagination(ID:Int,pag:Int) {
        let url = URLs.brandModel+"\(ID)"+"?page=\(pag)"
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                print(error)
            case.success(let value):
                let js = JSON(value)
                 // print(js)
                let json = js["meta"]
                //print(json)
                let last = json["last_page"].int
               // print(last!)
                self.totalPages = last!
            }}}
    
    fileprivate func getTree(id:Int, page:Int) {
        Helper.hudStart()
        API.getTrendsModels(id: id, pageNo: page) { (error:Error?, data:[Ads]?) in
            if data != nil {
                self.da.removeAll()
                self.da.append(contentsOf: data!)
                DispatchQueue.main.async {
                    self.collectionViw.reloadData()
                }
                SVProgressHUD.dismiss()
              //  print(data!)
            } else {
                print("data is empty of brandModel")
                SVProgressHUD.dismiss()
            }
        }
        SVProgressHUD.dismiss(withDelay: 1.5)
        }
    
    fileprivate func treePagination(ID:Int,pag:Int) {
        let url = URLs.treendsModel+"\(ID)"+"?page=\(pag)"
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case.failure(let error):
                print(error)
            case.success(let value):
                let js = JSON(value)
               // print(js)
                let json = js["meta"]
                //print(json)
                let last = json["last_page"].int
                //print(last!)
                self.treTotalPages = last!
            }}}
    
    @IBAction func unwindToModel(segue: UIStoryboardSegue) {}
    
    private func treeends(id:Int) {
        
    let url = URLs.barnds+"\(1)"
        //
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                switch response.result
                {
                case .failure( _): break
                case .success(let value):
                    self.da.removeAll()
                    let json = JSON(value)
                  //  print(json)
                  //  print("daaaaaa \(id)")
                    if let dataArr = json["data"].array
                    {
                for dataArr in dataArr {
                     let mainId=dataArr["id"].int
                     // print("main \(String(describing: mainId))")
                    if  id == mainId  {
                       //   print("ss id \(id)")
                        if let dataArr = dataArr["trends"].array {
                               // print("inside")
                            self.tre.removeAll()
                            for dataArr in dataArr {
                                let name_ar = dataArr ["name_ar"].string
                                 let name_en = dataArr ["name_en"].string
                                  let im = dataArr["image"].string
                                   let id = dataArr["brand_id"].string
                                  let iid = dataArr["id"].int
                                self.tre.append(BrandTrends.init(name_ar: name_ar!, name_en: name_en!, images: im ?? "", brandId: id!, id: iid!))
                                    }
                                    DispatchQueue.main.async {
                                        self.trendCollectionView.reloadData()
                                    }
                                 //   print("items count", self.tre.count)
                                    
                                }}}}}}}
    
    
}
extension ModelCV: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViw {
                 return da.count
        } else {
               return tre.count
        }}

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionViw {
          let cell = collectionViw.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! ModelCell
            if da.count > indexPath.row {
                cell.pics = da[indexPath.item]
                if General.CurrentLanguage() == "en" {
                    cell.titLab.text = da[indexPath.row].name_en
                } else {
                    cell.titLab.text = da[indexPath.row].name_ar
                }
                cell.priceLab.text = "\(da[indexPath.row].price)"
                cell.rsLab.text = General.stringForKey(key: "rs")
                if Helper.checkToken() == true {
                    if da[indexPath.row].is_favorite == 0 {
                        cell.favoBtn.setImage(UIImage(named: "li.png"), for: .normal)
                    } else {
                        cell.favoBtn.setImage(UIImage(named: "lk.png"), for: .selected)
                    }}
                cell.floatCell()
                let containerView = cell.bgViw!
                containerView.layer.cornerRadius = 8
                containerView.clipsToBounds = true
            }
//            cell.favoBtn.addTarget(self, action: #selector(favTapped(sender:)), for: .touchUpInside)
//            cell.favoBtn.tag = indexPath.row
            return cell
        } else {
      let tCell = trendCollectionView.dequeueReusableCell(withReuseIdentifier: "trendCell", for: indexPath) as! TrendCell
            if General.CurrentLanguage() == "ar" {
                tCell.trendName.text = tre[indexPath.row].name_ar
            } else {
                tCell.trendName.text = tre[indexPath.row].name_en
            }
            if tre[indexPath.row].images.isEmptyStr == false {
                tCell.trenImg.kf.indicatorType = .activity
                let url = URL(string: URLs.image+tre[indexPath.row].images)
                tCell.trenImg.kf.setImage(with: url )
            }
            return tCell
        }
    }

//    @objc func favTapped(sender: UIButton) {
//
//        let id = da[sender.tag].id
//        if da[sender.tag].is_favorite == 0 {
//            // do like
//            API.selectFav(token: Helper.getUserToken(), proId: id) { (error:Error?, success:Bool?) in
//                if success == true {
//
//                } else {
//
//                }
//            }
//        } else {
//            // do dislike
//            API.disSelectFav(token: Helper.getUserToken(), id: id) { (error:Error?, success:Bool?) in
//                if success == true {
//
//                } else {
//
//                }
//            }
//        }
//    }


    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViw {
            if treSelected == false {
                if indexPath.row == da.count - 1 {
                    if currentPage < totalPages {
                        currentPage += 1
                       // print("pagiation num", currentPage)
                        self.getModelData(id: recModelId, nu: currentPage)
                    }}} else {
                if indexPath.row == tre.count - 1 {
                    if treCurrentPage < treTotalPages {
                        treCurrentPage += 1
                       // print("pagiation num", treCurrentPage)
                   self.getTree(id: self.i, page: treCurrentPage)
                        
                    }}}}
                 }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionViw {
            
            self.selectedTitle = da[indexPath.row].name_ar
             self.selectedPrice = da[indexPath.row].price
              self.selectedImgs = da[indexPath.row].images
               self.selectedContent_en = da[indexPath.row].description_en
                self.selectedContent_ar = da[indexPath.row].description_ar
                self.selectedId = da[indexPath.row].id
               self.selectedHasSize = da[indexPath.row].has_sizes
              self.selectedName_ar = da[indexPath.row].name_ar
             self.selectedName_en = da[indexPath.row].name_en
            self.selectedBarndName_ar = da[indexPath.row].brandNameAr
             self.selectedBarndName_en = da[indexPath.row].brandNameEn
               self.selectedImaage = da[indexPath.row].imaage
                self.recAx = da[indexPath.row].ax
                 self.recMyop = da[indexPath.row].myopia
                  self.recDev = da[indexPath.row].dev
            
            
            if da[indexPath.row].has_sizes == 1 {
                 performSegue(withIdentifier: "modSegue", sender: self)
            } else {
                performSegue(withIdentifier: "modSegue", sender: self)
            }
            
            
        } else {
             self.i = Int(tre[indexPath.row].id)
           // print(i)
            self.da.removeAll()
            getTree(id: i, page: self.currentPage)
            treePagination(ID: i, pag: self.treCurrentPage)
          }
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "modSegue" {
            let dd = segue.destination as? AdContentVC
            dd?.recImgs = selectedImgs
            dd?.recPrice = selectedPrice
            dd?.recTitle = selectedTitle
            dd?.recTitle_en = selectedTitle_en
            dd?.recHasSize = selectedHasSize
            dd?.recContentEn = selectedContent_en
            dd?.recContent = selectedContent_ar
            dd?.recBrandEn = selectedBarndName_en
            dd?.recBrandAr = selectedBarndName_ar
            dd?.recImaage = selectedImaage
            dd?.recAx = recAx
            dd?.recDev = recDev
            dd?.recMyop = recMyop
            dd?.recPage = "mod"
            
            }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.trendCollectionView {
            let yourWidth = trendCollectionView.bounds.width
             let yourHeight = (yourWidth - 10) / 4.0
            
            return CGSize(width: yourHeight, height: 80)
        } else {
            let screenWidth = collectionViw.bounds.width
            let width = (screenWidth - 20) / 2.0

        
            return CGSize.init(width: width, height: 210)
          }
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionViw {
            return  4
        } else {
            return  4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionViw {
            return 4
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.collectionViw {
            return UIEdgeInsets.zero
            
        } else {
            return UIEdgeInsets.zero
            
        }
    }






}
