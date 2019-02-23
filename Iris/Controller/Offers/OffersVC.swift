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

class OffersVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    fileprivate var rowHeight: CGFloat = 130.0
    
    var offers = [Ads]()
    var pagi = [pagination]()
    
    var curentPage = 1
    var totalPages = 1
    
    
    // sendData
    var selectedImgs = [String]()
    var selectedTitle = ""
    var selectedContent = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        confirmTableViewProtocls()
        tableView.tableFooterView = UIView()
        callData(pageNo: curentPage)
        self.tabBarController?.tabBar.items?[1].title = General.stringForKey(key: "offers")

        
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        if scrollView.contentOffset.y >= 100 {
//        UIView.animate(withDuration: 2.5) {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//           }
//        } else {
//            UIView.animate(withDuration: 2.5) {
//                self.navigationController?.setNavigationBarHidden(false, animated: true)
//            }
//        }
//
//    }
    
    
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


//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//
//    print("scrollViewWillBeginDragging")
//    //isDataLoading = false
//    }
//
//
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("scrollViewDidEndDecelerating")
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//        print("scrollViewDidEndDragging")
//
//        }
    
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
        
        
            cell.title.text = offers[indexPath.row].name_ar
            cell.pics = offers[IndexPath(item: 0, section: 0).item]
            cell.price.text = "\(offers[indexPath.row].price)"
            cell.offerLab.text = "\(offers[indexPath.row].price_after_discount)"
            
        
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == offers.count - 1 {
            //totalPages = pagi[indexPath.row].lastPage
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
        
        performSegue(withIdentifier: "OfferContent", sender: self)

        print(offers[indexPath.row].lastPage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OfferContent" {
            let seg = segue.destination as? AdContentVC
            seg?.recPage = "offer"
            seg?.recImgs = selectedImgs
            seg?.recTitle = selectedTitle
            seg?.recContent = selectedContent
            
        }
    }
    
}
