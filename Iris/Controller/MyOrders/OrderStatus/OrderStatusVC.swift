//
//  OrderStatusVC.swift
//  Iris
//
//  Created by Ghoost on 5/18/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class OrderStatusVC: UIViewController {

    
    @IBOutlet weak var orNumLab: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    
    @IBOutlet weak var ordrStatusLab: UILabel!
    @IBOutlet weak var yourOrderLabel: UILabel!
    
    @IBOutlet weak var orderNumLab: UILabel!
    
    
    @IBOutlet weak var progressLab: UILabel!
    
    @IBOutlet weak var collectingLab: UILabel!
    
    @IBOutlet weak var finishedLab: UILabel!
    
    @IBOutlet weak var happyLab: UILabel!
    
    
    @IBOutlet weak var viw: UIView!
    @IBOutlet weak var viiw: UIView!
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var imgS: UIImageView!
    @IBOutlet weak var imgT: UIImageView!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBOutlet weak var orderCoastLab: UILabel!
    @IBOutlet weak var totalLab: UILabel!
    
    
    var orderDa = [MyOrder]()
     var itms = [itmList]()
    
    
    var immg = ""

    
    var recType:String = ""
     var recId:Int = 0
      var recStatus:Int = 0
       var recTotal:Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

      setupTableView()
        displayData()
        
        branches(type: recType, id: recId )
        
        viw.floatView()
         viiw.floatView()

    }
    
    fileprivate func setupTableView() {

      tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
          tableView.tableFooterView?.tintColor = UIColor.clear
           tableView.separatorStyle = .none

    }
    
    
    private func displayData() {
    
        if  recStatus == 0 {
            statusLabel.text = General.stringForKey(key: "x")
            orderStatusLabel.text = General.stringForKey(key: "x")
            self.img.image = UIImage(named: "ww")
            self.imgS.image = UIImage(named: "liist")
            self.imgT.image = UIImage(named: "lll")
        } else if recStatus == 1 {
            statusLabel.text = General.stringForKey(key: "y")
            orderStatusLabel.text = General.stringForKey(key: "y")
            self.img.image = UIImage(named: "w")
            self.imgS.image = UIImage(named: "liist")
            self.imgT.image = UIImage(named: "lll")
        } else if recStatus == 2 {
            statusLabel.text = General.stringForKey(key: "z")
            orderStatusLabel.text = General.stringForKey(key: "z")
            self.img.image = UIImage(named: "ww")
            self.imgS.image = UIImage(named: "list")
            self.imgT.image = UIImage(named: "lll")
        } else if recStatus == 3 {
            statusLabel.text = General.stringForKey(key: "a")
            orderStatusLabel.text = General.stringForKey(key: "a")
            self.img.image = UIImage(named: "ww")
            self.imgS.image = UIImage(named: "liist")
            self.imgT.image = UIImage(named: "kkk")
        }
        
        
        self.orNumLab.text = General.stringForKey(key: "on")
        self.orderNumLab.text = "#\(recId)"
        self.ordrStatusLab.text = General.stringForKey(key: "os")
        self.progressLab.text = General.stringForKey(key: "prog")
          self.collectingLab.text = General.stringForKey(key: "coling")
           self.finishedLab.text = General.stringForKey(key: "fi")
            self.happyLab.text = General.stringForKey(key: "happy")
            self.yourOrderLabel.text = General.stringForKey(key: "ors")
              self.orderCoastLab.text = General.stringForKey(key: "oc")
        
          self.totalLab.text = "\(recTotal)"
        
        
        
    }
  
    
    
    
   private func branches(type:String, id:Int) {
        
        let url = URLs.main+"api/order-status?type="+type+"&token="+Helper.getUserToken()
        //
    Alamofire.request(url, method: .get)
        .responseJSON { response in
            switch response.result
            {
            case .failure( _): break
            case .success(let value):
                self.orderDa.removeAll()
                let json = JSON(value)
                print(json)
                print("daaaaaa \(id)")
                
    if let dataArr = json["data"].array
                {
        for dataArr in dataArr {
          let mainId=dataArr["id"].int
           print("main \(String(describing: mainId))")
        if  id == mainId  {
                            print("ss id \(id)")
            if let dataArr = dataArr["itemsList"].array {
                        print("inside")
                for dataArr in dataArr {
                  let name_ar = dataArr ["name_ar"].string
                    let name_en = dataArr ["name_en"].string
                    let right = dataArr["right_amount"].int
                     let left = dataArr["left_amount"].int
                     let quantity = dataArr["quantity"].int
                       let total = dataArr["total"].double
                     let im = dataArr["images"].array
                    for iii in im! {
                        self.immg = iii.imagePath!
                    }
                                   
                    self.itms.append(itmList.init(name_ar: name_ar!, name_en: name_en!, quantity: quantity!, totalP: total!, right_amount: right!, left_amount: left!,images: self.immg))
                                    
                                }
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                                print("items count", self.itms.count)
                                
                            }
                            
                        }
                    }}
            }
    }
    }
    

}
extension OrderStatusVC: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orrCell", for: indexPath) as! OrderStatusCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.title.text = itms[indexPath.row].name_ar
         cell.am.text = "\(itms[indexPath.row].quantity)"
          cell.leAmount.text = "\(itms[indexPath.row].left_amount)"
           cell.riAmount.text = "\(itms[indexPath.row].right_amount)"
        
        if itms[indexPath.row].images.isEmptyStr == false {
            cell.img.kf.indicatorType = .activity
            let url = URL(string: itms[indexPath.row].images)
            cell.img.kf.setImage(with: url )
        }
        
        cell.priceLab.text = "\(itms[indexPath.row].totalP)"
        
        cell.sarLab.text = General.stringForKey(key: "rs")
        
        
        if itms[indexPath.row].left_amount == itms[indexPath.row].quantity ||
            itms[indexPath.row].left_amount == 0
            {
            cell.rightAmount.alpha = 0
            cell.leftAmount.alpha = 0
            cell.leAmount.alpha = 0
            cell.riAmount.alpha = 0
        } else  {
            cell.rightAmount.alpha = 1.0
            cell.leftAmount.alpha = 1.0
            cell.leAmount.alpha = 1.0
            cell.riAmount.alpha = 1.0
        }
        
        
        
            cell.rightAmount.text = General.stringForKey(key: "rii")
              cell.leftAmount.text = General.stringForKey(key: "lee")
               cell.amount.text = General.stringForKey(key: "quaaa")
            
        
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 130
        
    }
    
    




}
