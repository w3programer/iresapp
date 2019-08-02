//
//  OffersVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/4/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
//import ImageSlideshow



class OffersVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
   // @IBOutlet weak var sliderShow: ImageSlideshow!
    
    
    
    fileprivate var rowHeight: CGFloat = 130.0
    
    var offers = [Ads]()
    //var pagi = [pagination]()
    
    var curentPage = 1
    var totalPages = 1
    
    

    
    
    // sendData
    var selectedImgs = [String]()
     var selectedTitle = ""
      var selectedContent = ""
       var selectedHasSize = 0
        var selectedId = 0
         var selectedDesAr = ""
          var selectedDesEn = ""
           var selectedBarndAr = ""
            var selectedBrandEn = ""
             var selectedTitle_en = ""
              var selectedImaage = ""
               var selectedPrice:Double = 0.0
                var selectedDev:[String] = []
                 var selectedAx:[String] = []
                  var selectedMypo:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        confirmTableViewProtocls()
        tableView.tableFooterView = UIView()
        callData(pageNo: curentPage)

       
        
        self.navigationItem.title = General.stringForKey(key: "offers")
    }
    

    
   
    
    func confirmTableViewProtocls() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    
    func callData(pageNo:Int) {
        checkPagination()
        API.offers(pageNo: pageNo) { (error:Error?, data:[Ads]?) in
            if data != nil {
                self.offers.append(contentsOf: data!)
                self.tableView.reloadData()
            } else {
                print("no offers found")
             }
           }
        }
    
    @IBAction func unwindToFav(segue: UIStoryboardSegue) {}



    
    func checkPagination(){
        let url = URLs.offers
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
extension OffersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OffersCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        
        if General.CurrentLanguage() == "ar"
        {
            cell.title.text = offers[indexPath.row].name_ar
        }else
        {
            cell.title.text = offers[indexPath.row].name_en
        }
            cell.pics = offers[indexPath.item]
            cell.price.text = "\(offers[indexPath.row].price)"
            cell.offerLab.text = "\(offers[indexPath.row].price_after_discount)"
            
        
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == offers.count - 1 {
              if curentPage < totalPages {
                    curentPage += 1
                  print("nuuum",curentPage)
                self.callData(pageNo: curentPage)
              }
           }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedImgs = offers[indexPath.row].images
         selectedTitle = offers[indexPath.row].name_ar
          selectedContent = offers[indexPath.row].description_ar
           selectedHasSize = offers[indexPath.row].has_sizes
            selectedDesAr = offers[indexPath.row].description_ar
             selectedDesEn = offers[indexPath.row].description_en
              selectedId = offers[indexPath.row].id
               selectedBarndAr = offers[indexPath.row].brandNameAr
               selectedBrandEn = offers[indexPath.row].brandNameEn
              selectedImaage = offers[indexPath.row].imaage
             selectedTitle_en = offers[indexPath.row].name_en
            selectedPrice = offers[indexPath.row].price
           selectedDev = offers[indexPath.row].dev
          selectedAx = offers[indexPath.row].ax
         selectedMypo = offers[indexPath.row].myopia
        
        
        
        if selectedHasSize == 0 {
            performSegue(withIdentifier: "OfferAccSegue", sender: self)
        } else {
            performSegue(withIdentifier: "OfferContent", sender: self)
        }

        
        //print(offers[indexPath.row].lastPage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OfferContent" {
            let seg = segue.destination as? AdContentVC
            seg?.recPage = "offer"
             seg?.recImgs = selectedImgs
              seg?.recTitle = selectedTitle
               seg?.recContent = selectedContent
                seg?.recProdId = selectedId
                 seg?.recContentEn = selectedDesEn
                  seg?.recTitle_en = selectedTitle_en
                   seg?.recImaage = selectedImaage
                    seg?.recPrice = selectedPrice
                     seg?.recDev = selectedDev
                      seg?.recMyop = selectedMypo
                       seg?.recAx = selectedAx
                         seg?.recBrandAr = selectedBarndAr
                          seg?.recBrandEn = selectedBrandEn
            
        } else if segue.identifier == "OfferAccSegue" {
            let access = segue.destination as? AccessoriesContentVC
             access?.recTitle = selectedTitle
              access?.recProdId = selectedId
               access?.recBrand_ar = selectedBarndAr
                access?.recBarnd_en = selectedBrandEn
                 access?.recImgs = selectedImgs
                  access?.recContent = selectedDesAr
                   access?.recContent_en = selectedDesEn
                    access?.recImaage = selectedImaage
                     access?.recTitle_en = selectedTitle_en
                      access?.recPrice = selectedPrice
                       access?.recBarnd_en = selectedBrandEn
                        access?.recBrand_ar = selectedBarndAr
            
        }
    }
    
}
