//
//  ViewController.swift
//  Iris
//
//  Created by mahmoudhajar on 2/3/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class MarketVC: UIViewController {

    
   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var recAdded: CornerButtons!
    @IBOutlet weak var bestSeller: CornerButtons!
    @IBOutlet weak var transp: CornerButtons!
    @IBOutlet weak var colorLen: CornerButtons!
    @IBOutlet weak var access: CornerButtons!
    
    
    var menuPro = [Ads]()
    
    // for Pagination
    var currentPage = 1
    var totalPages = 1
    var id = 1
    var transLoad = false
    var colorLoad = false
    var accessLoad = false
   
    
    // Move Selected data
    var selectedImgs = [String]()
    var selectedTitle = ""
    var selectedContent_en = ""
    var selectedContent_ar = ""
    var selectedId = 0
    var selectedHasSize = 0
    var selectedPrice = 0
    var selectedName_ar = ""
    var selectedName_en = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoca()
        getCategory(pageNO: currentPage, id: 1)
         confrimProtocls()
          displayElementsDesgin()
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

        
    
    }


    @IBAction func searchBtn(_ sender: Any) {
        
        performSegue(withIdentifier:"SearchSegue", sender: self)
       }
    
    @IBAction func myProBtn(_ sender: Any) {
        
        performSegue(withIdentifier: "CartSegue", sender: self)
        
    }
    
    @IBAction func transparentBtn(_ sender: Any) {
        
        getCategory(pageNO: 1, id: 1)
        self.id = 1
    }
    
    @IBAction func colorBtn(_ sender: Any) {
        
        getCategory(pageNO: 1, id: 2)
        self.id = 2
    }
    
    @IBAction func accessBtn(_ sender: Any) {
        
        getCategory(pageNO: 1, id: 3)
        self.id = 3
    }
    
    
    
    
    
    @IBAction func recAddBtn(_ sender: Any) {
        // type = 1
        sortData(id: id, pageNo: currentPage, typ: 1)
        
        
    }
    
    
    @IBAction func bestSellerBtn(_ sender: Any) {
        
        // type = 2

        sortData(id: id, pageNo: currentPage, typ: 2)

        
    }
    
    
    @IBAction func unwindToMarket(segue: UIStoryboardSegue) {}

    
    func displayElementsDesgin() {
        
        transp.alignText()
        colorLen.alignText()
        access.alignText()
        recAdded.alignText()
        bestSeller.alignText()
        
    }
    
    
    func confrimProtocls() {
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
       
        
    }
    
    
    
   
    
    
    
    func getCategory(pageNO: Int, id: Int) {
        setPagination(id:id)
        if id == 1  {
            transLoad = true
            colorLoad = false
            accessLoad = false
        } else if id == 2 {
            transLoad = false
            colorLoad = true
            accessLoad = false
        } else {
            transLoad = false
            colorLoad = false
            accessLoad = true
        }
        if Helper.checkToken() == false {
            
            API.Categories(pageNo: pageNO , Id: id ) { (error: Error?, data:[Ads]?) in
                if data != nil {
                    print("MarketVC data",data!)
                    self.menuPro.removeAll()
                    self.menuPro.append(contentsOf: data!)
                    self.collectionView.reloadData()
                } else {
                    print("no ads found niiiil")
                }
            }
        } else {
            API.UserCategories(pageNo: pageNO, Id: id) { (error:Error?, data:[Ads]?) in
                if data != nil {
                    print("MarketVC data",data!)
                    self.menuPro.removeAll()
                    self.menuPro.append(contentsOf: data!)
                    self.collectionView.reloadData()
                } else {
                    print("no ads found niiiil")
                }
            }
        }
        
        
        }
    
    func sortData(id:Int,pageNo:Int,typ:Int) {
        setPagination(id:id)
        if Helper.checkToken() == false {
            API.sortData(pageNo: pageNo, Id: id, typ: typ) { (error:Error?, data:[Ads]?) in
                if data != nil {
                    print("Sort Data", data!)
                    self.menuPro.removeAll()
                    self.menuPro.append(contentsOf: data!)
                    self.collectionView.reloadData()
                } else {
                    print("no ads found niiiil")
                    
                }
            }
        } else {
            API.UserSortData(pageNo:pageNo, Id:id, typ: typ) { (error:Error?, data:[Ads]?) in
                if data != nil {
                    print("Sort Data", data!)
                    self.menuPro.removeAll()
                    self.menuPro.append(contentsOf: data!)
                    self.collectionView.reloadData()
                } else {
                    print("no ads found niiiil")
                }
            }
        }
        
    }
    
    
    
    fileprivate func setLoca() {
        navigationItem.title = General.stringForKey(key: "iris")
        recAdded.setTitle(General.stringForKey(key: "rec"), for: .normal)
        bestSeller.setTitle(General.stringForKey(key: "best"), for: .normal)
        transp.setTitle(General.stringForKey(key: "Pellucid lenses"), for: .normal)
        colorLen.setTitle(General.stringForKey(key: "colorLenses"), for: .normal)
        access.setTitle(General.stringForKey(key: "accessories"), for: .normal)
        self.tabBarController?.tabBar.items?[0].title = General.stringForKey(key: "market")
        
    }
    
    func setPagination(id:Int) {
        let url = URLs.categories+"/\(id)/"+"products"
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
extension MarketVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return menuPro.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! marketCell
        
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
                cell.fav.setImage(UIImage(named: "lk.png"), for: .selected)
            } else {
                cell.fav.setImage(UIImage(named: "lk.png"), for: .normal)
                cell.fav.setImage(UIImage(named: "li.png"), for: .selected)
            }
            
            cell.fav.addTarget(self, action: #selector(favTapped(sender:)), for: .touchUpInside)
            cell.fav.isSelected = false
            cell.fav.tag = indexPath.row
        } else {
            cell.fav.isHidden = true
        }
        
            //cell.pics = menuPro[IndexPath(item: 0, section: 0).item]
              cell.pics = menuPro[indexPath.item]
            cell.price.text = "\(menuPro[indexPath.row].price)"
       
            return cell
        
        
    }
    
    @objc func favTapped(sender: UIButton) {
        collectionView.reloadData()
        if (sender.isSelected) {
            let id = menuPro[sender.tag].favorite_id
           // let favBtn = collectionView.cellForItem(at: sender.tag) as! marketCell
            API.disSelectFav(token:Helper.getUserToken(),id:id) { (error:Error?, success:Bool?) in
                if success! {
                    sender.isSelected = false
                    
                  //  favBtn.
                }
            }
        } else {
            let no = menuPro[sender.tag].id
            print(no)
            API.selectFav(token:Helper.getUserToken(), proId: no) { (error:Error?, success:Bool?) in
                if success == true {
                    sender.isSelected = true
                }
            }
        }
    
    }
    
    
   
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        

        if indexPath.row == menuPro.count - 1 { //
            //totalPages = menuPro[indexPath.row].lastPage
            if  currentPage < totalPages {
                if colorLoad == false && accessLoad == false {
                    currentPage += 1
                    print("near call")
                    getCategory(pageNO: currentPage, id: 1)
                }
                else if colorLoad == false && accessLoad == false {
                    currentPage += 1
                    print("fresh call")
                    print("pageNo  \(currentPage)")
                    getCategory(pageNO: currentPage, id: 2)
                }
                else{
                    currentPage += 1
                    print("get near call")
                 getCategory(pageNO: currentPage, id: 3)
                    
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedTitle = menuPro[indexPath.row].name_ar
        self.selectedImgs = menuPro[indexPath.row].images
        self.selectedContent_en = menuPro[indexPath.row].description_ar
        self.selectedId = menuPro[indexPath.row].id
        self.selectedHasSize = menuPro[indexPath.row].has_sizes
        self.selectedName_ar = menuPro[indexPath.row].name_ar
        self.selectedName_en = menuPro[indexPath.row].name_en
        

        performSegue(withIdentifier: "ContentSegue", sender: self)
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ContentSegue" {
            let conVC = segue.destination as? AdContentVC
            conVC?.recPage = "market"
            conVC?.recContent = selectedContent_ar
            conVC?.recTitle = selectedName_ar
            conVC?.recImgs = selectedImgs
            conVC?.recHasSize = selectedHasSize
        }
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth-30)/2
        
        return CGSize.init(width: width, height: width)
    }
    
}

