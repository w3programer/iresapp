//
//  SearchVC.swift
//  Iris
//
//  Created by mahmoudhajar on 2/7/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit



// pagination
class SearchVC: UIViewController {

    
    @IBOutlet weak var searchTxt: ImageInsideTextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filter = [Ads]()
    
    var currentPage = 1
    var totalPages = 1
    
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
        API.Search(q:q, pageNo: pageNO) { (error:Error?, data:[Ads]?) in
            if data != nil {
                self.filter.removeAll()
                self.filter.append(contentsOf: data!)
                self.collectionView.reloadData()
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
        
       cell.pics = filter[IndexPath(item: 0, section: 0).item]
       cell.priceLab.text = "\(filter[indexPath.row].price)"
       cell.titleLab.text = filter[indexPath.row].name_ar
        
        
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth-30)/2
        
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SearchContent", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SearchContent" {
          let contnt = segue.destination as? AdContentVC
            contnt?.recPage = "search"
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
        
        self.searchTxt.resignFirstResponder()
        
        return true
     }
}
