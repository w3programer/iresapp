//
//  BrandsVC.swift
//  Iris
//
//  Created by Ghoost on 5/21/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BrandsVC: UIViewController {

    @IBOutlet weak var brandCollectionView: UICollectionView!

    var brandData = [Brand]()
    var totalPage:Int = 1
    var currentPage:Int = 1
    var brandsIdSel = 0
    var indx:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        getBrands(pageNum: currentPage )
    }
    

    fileprivate func setCollectionView() {
      self.brandCollectionView.delegate = self
        self.brandCollectionView.dataSource = self
    }
    
    fileprivate func getBrands(pageNum:Int) {
        if API.isConnectedToInternet() {
            API.getBrands(pageNo: pageNum) { (error:Error?, data:[Brand]?) in
                if data != nil {
                    self.brandData.removeAll()
                    self.brandData.append(contentsOf: data!)
                    DispatchQueue.main.async {
                        self.brandCollectionView.reloadData()
                    }
                  //  print("brands data market",data!)
                } else {
                   // print("brands is nill")
                }}
        } else {
            // no internet
        }}
    
    
   

}
extension BrandsVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let brandC = brandCollectionView.dequeueReusableCell(withReuseIdentifier: "brCell", for: indexPath) as! BrandsCell
        brandC.pics = brandData[indexPath.item]
        if General.CurrentLanguage() == "ar" {
            brandC.brandName.text = brandData[indexPath.row].name_ar
        } else {
            brandC.brandName.text = brandData[indexPath.row].name_en
        }
        brandC.layer.cornerRadius = 8.0
        brandC.layer.masksToBounds = false
        brandC.layer.shadowColor = UIColor.lightGray.cgColor
        brandC.layer.shadowOffset = CGSize(width: 0, height: 0)
        brandC.layer.shadowOpacity = 0.6
        //makes the cell round
        let containerView = brandC.viewGround!
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        return brandC
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row < brandData.count - 1 {
            if currentPage < totalPage {
                currentPage += 1
                print("pagiation num", currentPage)
                getBrands(pageNum: currentPage)

            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           self.brandsIdSel = brandData[indexPath.row].id
            self.indx = indexPath.row
        performSegue(withIdentifier: "trSegue", sender: self)

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trSegue" {
          let de = segue.destination as? ModelCV
               de?.recModelId = brandsIdSel
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = brandCollectionView.bounds.width
        let width = (screenWidth - 20) / 2.0
        return CGSize.init(width: width, height: width)
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
