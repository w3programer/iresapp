//
//  MyOrders.swift
//  Iris
//
//  Created by mahmoudhajar on 2/5/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON


class MyOrders: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var colectionView: UICollectionView!
    
    @IBOutlet weak var heightConstrain: NSLayoutConstraint!
    

    fileprivate let menuTitls = [ "old" ,"Current","New"]
    let menuTitles_ar = ["السابقة","الحالي","الجديد"]
    var selectedArray = [MyOrder]()
    var selectedIndex = 0
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    var indicatorView = UIView()
    let indicatorHeight : CGFloat = 3
    
    
    var selectedTotal:Double = 0.0
    var selectedStatus:Int = 0
    var selectedId:Int = 0
    var selectedType = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Helper.hudStart()
         confirmProtocls()
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

       
        self.navigationItem.title = General.stringForKey(key:"orders")
        
        if API.isConnectedToInternet() {
            if Helper.checkToken() == true {
                allOrders(type:"old")
                createSwipGestures()
                indicatorUIView()

                self.colectionView.isUserInteractionEnabled = true
            } else {
              SVProgressHUD.dismiss()
                self.heightConstrain.constant = 0
                 self.colectionView.layoutIfNeeded()
                Alert.alertPopUp(title: General.stringForKey(key:"notAv"), msg: General.stringForKey(key:"plsRe"), vc: self)
            }
        } else {
            SVProgressHUD.dismiss()
        }
        
        
        SVProgressHUD.dismiss(withDelay: 2.0)
    }
    

    func confirmProtocls() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.colectionView.delegate = self
        self.colectionView.dataSource = self
        
    }
    
    
    func indicatorUIView() {
        
        indicatorView.backgroundColor = .white
        indicatorView.frame = CGRect(x: colectionView.bounds.minX, y: colectionView.bounds.maxY - indicatorHeight, width: colectionView.bounds.width / CGFloat(menuTitls.count), height: indicatorHeight)
        colectionView.addSubview(indicatorView)
        
    }
    
    func refreshContent() {
        if selectedIndex == 0 {
            allOrders(type: "old")
            selectedType = "old"
        } else if selectedIndex == 1 {
            allOrders(type: "current")
            selectedType = "current"
        } else {
            allOrders(type: "new")
            selectedType = "new"

        }

        let x = (colectionView.bounds.width / CGFloat(menuTitls.count)) * CGFloat(selectedIndex)
        UIView.animate(withDuration: 0.3) {
            self.indicatorView.frame = CGRect(x: x, y: self.colectionView.bounds.maxY - self.indicatorHeight, width: self.colectionView.bounds.width / CGFloat(self.menuTitls.count), height: self.indicatorHeight)
        }
        

    }
    
    func createSwipGestures() {
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipAction))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipAction))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func swipAction(sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            if selectedIndex < menuTitls.count - 1 {
                selectedIndex += 1
            }
        } else {
            if selectedIndex > 0 {
                selectedIndex -= 1
            }
        }
        selectedIndexPath = IndexPath(item: selectedIndex, section: 0)
        colectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredVertically)
        refreshContent()
    }
    
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y >= 100 {
//            UIView.animate(withDuration: 2.5) {
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//            }
//        } else {
//            UIView.animate(withDuration: 2.5) {
//                self.navigationController?.setNavigationBarHidden(false, animated: true)
//            }
//        }
//    }
    
    
    
    
    func allOrders(type:String) {
        API.getMyOrders(type:type) { (error:Error?, data:[MyOrder]?) in
            if data != nil {
        
                self.selectedArray.removeAll()
                self.selectedArray.append(contentsOf: data!)
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.dismiss()
                print("empty data")
            }
          }
        }
    
    
   
    
    
    
}
extension MyOrders: UITableViewDataSource , UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyOrderTableViewCell
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        
        cell.numLabel.text = "#\(selectedArray[indexPath.row].id)"
         cell.price.text = "\(selectedArray[indexPath.row].total)"
          cell.orderNumLab.text = General.stringForKey(key: "on")
           cell.orderStatusLab.text = General.stringForKey(key: "os")
            cell.totalOrderLab.text = General.stringForKey(key: "ot")
             cell.sarLab.text =  General.stringForKey(key: "rs")
              cell.detailLabel.text = General.stringForKey(key: "md")
        
        let da = Double(selectedArray[indexPath.row].updated_at)
        cell.date.text = "\(da.dateFormatted!)"
        
        if  selectedArray[indexPath.row].status == 0 {
            cell.statusLab.text = General.stringForKey(key: "x")
        } else if selectedArray[indexPath.row].status == 1 {
            cell.statusLab.text = General.stringForKey(key: "y")
        } else if selectedArray[indexPath.row].status == 2 {
            cell.statusLab.text = General.stringForKey(key: "z")
        } else if selectedArray[indexPath.row].status == 3 {
            cell.statusLab.text = General.stringForKey(key: "a")
        }
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTotal = selectedArray[indexPath.row].total
        selectedStatus = selectedArray[indexPath.row].status
        selectedId = selectedArray[indexPath.row].id
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "statusSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "statusSegue" {
         let su = segue.destination as? OrderStatusVC
                su?.recTotal = selectedTotal
                 su?.recStatus = selectedStatus
                  su?.recId = selectedId
                   su?.recType = selectedType
            
        }
    }
    
    
}
extension MyOrders: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = colectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyOrderCollectionViewCell
        
        
        if General.CurrentLanguage() == "en" {
            cell.setupCell(text: menuTitls[indexPath.item])
        } else {
            cell.setupCell(text: menuTitles_ar[indexPath.item])

        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 3 , height: colectionView.bounds.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.item
        refreshContent()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
}
